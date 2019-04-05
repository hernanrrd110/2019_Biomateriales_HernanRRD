clear all;
close all;
clc;

Ubact=cd;
[Archivo, Ubc3d] = uigetfile('*.c3d');
cd(Ubc3d)
[DatosMarcadores, infoCinematica,Plataformas,infoDinamica,Antropometria,Eventos,h]=leer_c3d(Archivo);
cd(Ubact)

%%%%Opcionalmente podrían generar estructuras de datos para el posterior
%%%%procesamiento
Datos.Pasada.Marcadores.Crudos=DatosMarcadores;
Datos.Pasada.Plataformas(1).Crudos = Plataformas(1);
Datos.Pasada.Plataformas(2).Crudos = Plataformas(2);
Datos.info.Cinematica=infoCinematica;
Datos.info.Dinamica=infoDinamica;

Datos.antropometria=Antropometria;
Datos.eventos=Eventos;

%%%%%%%%Cálculos Ciclo

%%%%%%Frecuencia de muestreo de 340
fm = 340;

%%%Pie derecho (ciclo)
FrameRHS = round(Datos.eventos.Derecho_RHS(1)*fm);
FrameRTO = round(Datos.eventos.Derecho_RTO*fm);
%%%Pie izquierdo (ciclo)
FrameLHS = round(Datos.eventos.Izquierdo_LHS(1)*fm);
FrameLTO = round(Datos.eventos.Izquierdo_LTO*fm);

%%
%........................ Cálculos de Ejes PELVIS  ........................

close all;
clc;

%%%% Asis derecha
P7 = Datos.Pasada.Marcadores.Crudos.r_asis;
%%%% Asis izquierda
P14 = Datos.Pasada.Marcadores.Crudos.l_asis;
%%%% Sacro
P15 = Datos.Pasada.Marcadores.Crudos.sacrum;

Datos.Vectores.U_Pelvis = zeros(length(P7),3);
Datos.Vectores.V_Pelvis = zeros(length(P7),3);
Datos.Vectores.W_Pelvis = zeros(length(P7),3);
Datos.PArticulares.CaderaD = zeros(length(P7),3);
Datos.PArticulares.CaderaI = zeros(length(P7),3);
A2 = Datos.antropometria.children.LONGITUD_ASIS.info.values*0.01;

for i=1:length(Datos.Vectores.U_Pelvis)
    %%%%Versor en dirección Y
    Datos.Vectores.V_Pelvis(i,:) = P14(i,:)-P7(i,:);
    Datos.Vectores.V_Pelvis(i,:) = Datos.Vectores.V_Pelvis(i,:)/norm(Datos.Vectores.V_Pelvis(i,:));

    %%%%Versor en dirección Z
    Datos.Vectores.W_Pelvis(i,:) = cross(P7(i,:)-P15(i,:),P14(i,:)-P15(i,:));
    Datos.Vectores.W_Pelvis(i,:) = Datos.Vectores.W_Pelvis(i,:)/norm(Datos.Vectores.W_Pelvis(i,:));

    %%%%Versor en dirección X
    Datos.Vectores.U_Pelvis(i,:) = cross(Datos.Vectores.V_Pelvis(i,:),Datos.Vectores.W_Pelvis(i,:));
    Datos.Vectores.U_Pelvis(i,:) = Datos.Vectores.U_Pelvis(i,:)/norm(Datos.Vectores.U_Pelvis(i,:));

    %%%Cálculo punto cadera derecha

    Datos.PArticulares.CaderaD(i,:) = P15(i,:)+0.598*A2*Datos.Vectores.U_Pelvis(i,:)-0.344*A2*Datos.Vectores.V_Pelvis(i,:)-0.290*A2*Datos.Vectores.W_Pelvis(i,:);
    Datos.PArticulares.CaderaI(i,:) = P15(i,:)+0.598*A2*Datos.Vectores.U_Pelvis(i,:)+0.344*A2*Datos.Vectores.V_Pelvis(i,:)-0.290*A2*Datos.Vectores.W_Pelvis(i,:);
end

Frame1 = FrameRHS;
Frame2 = FrameLTO;

figure1 = figure ('Color',[1 1 1]);
Paso = 18;
Consecutivo = false;
Plot_Vectores(Datos.Pasada.Marcadores.Crudos.sacrum,Datos.Vectores.U_Pelvis/10,Datos.Vectores.V_Pelvis/40,Datos.Vectores.W_Pelvis/10,Paso,Frame1,Frame2,Consecutivo)

Plot_Marcadores_Tiempo(Datos.Pasada.Marcadores.Crudos.sacrum,Frame1,Frame2);
Plot_Marcadores_Tiempo(Datos.Pasada.Marcadores.Crudos.r_knee_1,Frame1,Frame2);
Plot_Marcadores_Tiempo(Datos.Pasada.Marcadores.Crudos.l_knee_1,Frame1,Frame2);
Plot_Marcadores_Tiempo(Datos.Pasada.Marcadores.Crudos.r_asis,Frame1,Frame2);
Plot_Marcadores_Tiempo(Datos.Pasada.Marcadores.Crudos.l_asis,Frame1,Frame2);
Plot_Marcadores_Tiempo(Datos.PArticulares.CaderaD,Frame1,Frame2);
Plot_Marcadores_Tiempo(Datos.PArticulares.CaderaI,Frame1,Frame2);

grid on;
xlabel('Eje X[m]')
ylabel('Eje Y[m]')
zlabel('Eje Z[m]')


%%
%%%%%%%%%%%%%%%%%%%%% Cálculos de Ejes PIE DERECHO   %%%%%%%%%%%%%%%%%%%%%%

close all;
clc;
%%%% Metatarciano Derecho
P1 = Datos.Pasada.Marcadores.Crudos.r_met;
%%%% Tobillo Derecho
P2 = Datos.Pasada.Marcadores.Crudos.r_heel;
%%%% Maleolo Derecho
P3 = Datos.Pasada.Marcadores.Crudos.r_mall;

%%%%Inicialización de matrices
Datos.Vectores.U_PieD = zeros(length(P1),3);
Datos.Vectores.V_PieD = zeros(length(P1),3);
Datos.Vectores.W_PieD = zeros(length(P1),3);
Datos.PArticulares.PuntaD = zeros(length(P1),3);
Datos.PArticulares.TobilloD = zeros(length(P1),3);

A13 = Datos.antropometria.children.LONGITUD_PIE_DERECHO.info.values*0.01;
A15 = Datos.antropometria.children.ALTURA_MALEOLOS_DERECHO.info.values*0.01;
A17 = Datos.antropometria.children.ANCHO_MALEOLOS_DERECHO.info.values*0.01;
A19 = Datos.antropometria.children.ANCHO_PIE_DERECHO.info.values*0.01;

for i=1:length(Datos.Vectores.U_PieD)
    
%%%%Versor en dirección Y
    Datos.Vectores.U_PieD(i,:) = P1(i,:)-P2(i,:);
    Datos.Vectores.U_PieD(i,:) = Datos.Vectores.U_PieD(i,:)/norm(Datos.Vectores.U_PieD(i,:));

    %%%%Versor en dirección Z
    Datos.Vectores.W_PieD(i,:) = cross((P1(i,:)-P3(i,:)),(P2(i,:)-P3(i,:)));
    Datos.Vectores.W_PieD(i,:) = Datos.Vectores.W_PieD(i,:)/norm(Datos.Vectores.W_PieD(i,:));

    %%%%Versor en dirección X
    Datos.Vectores.V_PieD(i,:) = cross(Datos.Vectores.W_PieD(i,:),Datos.Vectores.U_PieD(i,:));
    Datos.Vectores.V_PieD(i,:) = Datos.Vectores.V_PieD(i,:)/norm(Datos.Vectores.V_PieD(i,:));

    %%% Cálculo punto cadera derecha
    
    %%% R.Ankle
    Datos.PArticulares.TobilloD(i,:) = P3(i,:)+0.016*A13*Datos.Vectores.U_PieD(i,:)+0.392*A15*Datos.Vectores.V_PieD(i,:)+0.478*A17*Datos.Vectores.W_PieD(i,:);
    %%% R.Toe
    Datos.PArticulares.PuntaD(i,:) = P3(i,:)+0.752*A13*Datos.Vectores.U_PieD(i,:)+1.074*A15*Datos.Vectores.V_PieD(i,:)-0.187*A19*Datos.Vectores.W_PieD(i,:);
end

figure2 = figure ('Color',[1 1 1]);
xlabel('Eje X[m]')
ylabel('Eje Y[m]')
zlabel('Eje Z[m]')

Paso = 18;
Consecutivo = false;
Plot_Vectores(Datos.PArticulares.TobilloD, Datos.Vectores.U_PieD/10,Datos.Vectores.V_PieD/40,Datos.Vectores.W_PieD/10, Paso, FrameRHS, FrameRTO, Consecutivo)


%%
%%%%%%%%%%%%%%%%%%%%% Cálculos de Ejes PIERNA DERECHO   %%%%%%%%%%%%%%%%%%%%%%%

close all;
clc;

%%%% Maleolo Derecho
P3 = Datos.Pasada.Marcadores.Crudos.r_mall;
%%%% Metatarciano Derecho
P4 = Datos.Pasada.Marcadores.Crudos.r_bar_2;
%%%% Tobillo Derecho
P5 = Datos.Pasada.Marcadores.Crudos.r_knee_1;

%%%%Inicialización de matrices
Datos.Vectores.U_PiernaD = zeros(length(P4),3);
Datos.Vectores.V_PiernaD = zeros(length(P4),3);
Datos.Vectores.W_PiernaD = zeros(length(P4),3);
Datos.PArticulares.RodillaD = zeros(length(P4),3);

A11 = Datos.antropometria.children.DIAMETRO_RODILLA_DERECHA.info.values*0.01;

for i=FrameRHS:FrameRTO
%%%%Versor en dirección Y
    Datos.Vectores.V_PiernaD(i,:) = P3(i,:)-P5(i,:);
    Datos.Vectores.V_PiernaD(i,:) = Datos.Vectores.V_PiernaD(i,:)/norm(Datos.Vectores.V_PiernaD(i,:));

    %%%%Versor en dirección Z
    Datos.Vectores.U_PiernaD(i,:) = cross((P4(i,:)-P5(i,:)),(P3(i,:)-P5(i,:)));
    Datos.Vectores.U_PiernaD(i,:) = Datos.Vectores.U_PiernaD(i,:)/norm(Datos.Vectores.U_PiernaD(i,:));

    %%%%Versor en dirección X
    Datos.Vectores.W_PiernaD(i,:) = cross(Datos.Vectores.U_PiernaD(i,:),Datos.Vectores.V_PiernaD(i,:));
    Datos.Vectores.W_PiernaD(i,:) = Datos.Vectores.W_PiernaD(i,:)/norm(Datos.Vectores.W_PiernaD(i,:));
    
    %%% Rodilla Derecha
    Datos.PArticulares.RodillaD(i,:) = P5(i,:)+0.500*A11*Datos.Vectores.W_PiernaD(i,:);
    
end

figure4 = figure ('Color',[1 1 1]);
xlabel('Eje X[m]')
ylabel('Eje Y[m]')
zlabel('Eje Z[m]')

Paso = 18;
Consecutivo = true;
Plot_Vectores(Datos.PArticulares.RodillaD,Datos.Vectores.U_PiernaD,Datos.Vectores.V_PiernaD,Datos.Vectores.W_PiernaD,Paso,FrameRHS,FrameLTO,Consecutivo)


%%
%%%%%%%%%%%%%%%%%%%%% Cálculos de Ejes PIE IZQUIERDO   %%%%%%%%%%%%%%%%%%%%%%%

close all;
clc;

%%%% Metatarciano Izquierdo
P8 = Datos.Pasada.Marcadores.Crudos.l_met;
%%%% Tobillo Izquierdo
P9 = Datos.Pasada.Marcadores.Crudos.l_heel;
%%%% Maleolo Izquierdo
P10 = Datos.Pasada.Marcadores.Crudos.l_mall;

%%%%Inicialización de matrices
Datos.Vectores.U_PieIU_PieI = zeros(length(P8),3);
Datos.Vectores.U_PieIV_PieI = zeros(length(P8),3);
Datos.Vectores.U_PieIW_PieI = zeros(length(P8),3);
Datos.PArticulares.PuntaI = zeros(length(P8),3);
Datos.PArticulares.TobilloI = zeros(length(P8),3);

A14 = Datos.antropometria.children.LONGITUD_PIE_IZQUIERDO.info.values*0.01;
A16 = Datos.antropometria.children.ALTURA_MALEOLOS_IZQUIERDO.info.values*0.01;
A18 = Datos.antropometria.children.ANCHO_MALEOLOS_IZQUIERDO.info.values*0.01;
A20 = Datos.antropometria.children.ANCHO_PIE_IZQUIERDO.info.values*0.01;

for i=FrameRHS:FrameRTO
    %Versor en dirección Y
    Datos.Vectores.U_PieI(i,:) = P8(i,:)-P9(i,:);
    Datos.Vectores.U_PieI(i,:) = Datos.Vectores.U_PieI(i,:)/norm(Datos.Vectores.U_PieI(i,:));

    %%%%Versor en dirección Z
    Datos.Vectores.W_PieI(i,:) = cross((P8(i,:)-P10(i,:)),(P9(i,:)-P10(i,:)));
    Datos.Vectores.W_PieI(i,:) = Datos.Vectores.W_PieI(i,:)/norm(Datos.Vectores.W_PieI(i,:));

    %%%%Versor en dirección X
    Datos.Vectores.V_PieI(i,:) = cross(Datos.Vectores.W_PieI(i,:),Datos.Vectores.U_PieI(i,:));
    Datos.Vectores.V_PieI(i,:) = Datos.Vectores.V_PieI(i,:)/norm(Datos.Vectores.V_PieI(i,:));

    %%% Cálculo punto cadera derecha
    %%%% Si el chico camina con una componente x decreciente, la componente u y v 
    %%%% se modifican
    
    %%% R.Ankle
    Datos.PArticulares.TobilloI(i,:) = P10(i,:)+0.016*A14*Datos.Vectores.U_PieI(i,:)+0.392*A16*Datos.Vectores.V_PieI(i,:)-0.478*A18*Datos.Vectores.W_PieI(i,:);
    %%% R.Toe
    Datos.PArticulares.PuntaI(i,:) = P10(i,:)+0.752*A14*Datos.Vectores.U_PieI(i,:)+1.074*A16*Datos.Vectores.V_PieI(i,:)+0.187*A20*Datos.Vectores.W_PieI(i,:);
end

Paso = 18;
Consecutivo = true;
Plot_Vectores(P10,Datos.Vectores.U_PieI,Datos.Vectores.V_PieI,Datos.Vectores.W_PieI,Paso,FrameRHS,FrameRTO,Consecutivo)



