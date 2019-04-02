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
%%%%%%%%%%%%%%%%%%%%% Cálculos de Ejes PELVIS  %%%%%%%%%%%%%%%%%%%%%%%

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
PCaderaD = zeros(length(P7),3);
PCaderaI = zeros(length(P7),3);
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

    PCaderaD(i,:) = P15(i,:)+0.598*A2*Datos.Vectores.U_Pelvis(i,:)-0.344*A2*Datos.Vectores.V_Pelvis(i,:)-0.290*A2*Datos.Vectores.W_Pelvis(i,:);
    PCaderaI(i,:) = P15(i,:)+0.598*A2*Datos.Vectores.U_Pelvis(i,:)+0.344*A2*Datos.Vectores.V_Pelvis(i,:)-0.290*A2*Datos.Vectores.W_Pelvis(i,:);
    
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
Plot_Marcadores_Tiempo(PCaderaD,Frame1,Frame2);
Plot_Marcadores_Tiempo(PCaderaI,Frame1,Frame2);

grid on;
xlabel('Eje X[m]')
ylabel('Eje Y[m]')
zlabel('Eje Z[m]')


%%
%%%%%%%%%%%%%%%%%%%%% Cálculos de Ejes PIE DERECHO   %%%%%%%%%%%%%%%%%%%%%%%

close all;
clc;
%%%% Metatarciano Derecho
P1 = Datos.Pasada.Marcadores.Crudos.r_met;
%%%% Tobillo Derecho
P2 = Datos.Pasada.Marcadores.Crudos.r_heel;
%%%% Maleolo Derecho
P3 = Datos.Pasada.Marcadores.Crudos.r_mall;

%%%%Inicialización de matrices
U_PieD = zeros(length(P1),3);
V_PieD = zeros(length(P1),3);
W_PieD = zeros(length(P1),3);
PPuntaD = zeros(length(P1),3);
PTobilloD = zeros(length(P1),3);


A13 = Datos.antropometria.children.LONGITUD_PIE_DERECHO.info.values*0.01;
A15 = Datos.antropometria.children.ALTURA_MALEOLOS_DERECHO.info.values*0.01;
A17 = Datos.antropometria.children.ANCHO_MALEOLOS_DERECHO.info.values*0.01;
A19 = Datos.antropometria.children.ANCHO_PIE_DERECHO.info.values*0.01;


for i=1:length(U_PieD)
%%%%Versor en dirección Y
    U_PieD(i,:) = P1(i,:)-P2(i,:);
    U_PieD(i,:) = U_PieD(i,:)/norm(U_PieD(i,:));

    %%%%Versor en dirección Z
    W_PieD(i,:) = cross((P1(i,:)-P3(i,:)),(P2(i,:)-P3(i,:)));
    W_PieD(i,:) = W_PieD(i,:)/norm(W_PieD(i,:));

    %%%%Versor en dirección X
    V_PieD(i,:) = cross(W_PieD(i,:),U_PieD(i,:));
    V_PieD(i,:) = V_PieD(i,:)/norm(V_PieD(i,:));

    %%% Cálculo punto cadera derecha
    %%%% Si el chico camina con una componente x decreciente, la componente u y v 
    %%%% se modifican
    
    %%% R.Ankle
    PTobilloD(i,:) = P3(i,:)+0.016*A13*U_PieD(i,:)+0.392*A15*V_PieD(i,:)+0.478*A17*W_PieD(i,:);
    %%% R.Toe
    PPuntaD(i,:) = P3(i,:)+0.752*A13*U_PieD(i,:)+1.074*A15*V_PieD(i,:)-0.187*A19*W_PieD(i,:);
    
end

figure2 = figure ('Color',[1 1 1]);
xlabel('Eje X[m]')
ylabel('Eje Y[m]')
zlabel('Eje Z[m]')

Paso = 18;
Consecutivo = false;
Plot_Vectores(PTobilloD,U_PieD,V_PieD,W_PieD,Paso,FrameRHS,FrameRTO,Consecutivo)


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
U_PiernaD = zeros(length(P4),3);
V_PiernaD = zeros(length(P4),3);
W_PiernaD = zeros(length(P4),3);
PRodillaD = zeros(length(P4),3);

A11 = Datos.antropometria.children.DIAMETRO_RODILLA_DERECHA.info.values*0.01;

for i=FrameRHS:FrameRTO
%%%%Versor en dirección Y
    V_PiernaD(i,:) = P3(i,:)-P5(i,:);
    V_PiernaD(i,:) = V_PiernaD(i,:)/norm(V_PiernaD(i,:));

    %%%%Versor en dirección Z
    U_PiernaD(i,:) = cross((P4(i,:)-P5(i,:)),(P3(i,:)-P5(i,:)));
    U_PiernaD(i,:) = U_PiernaD(i,:)/norm(U_PiernaD(i,:));

    %%%%Versor en dirección X
    W_PiernaD(i,:) = cross(U_PiernaD(i,:),V_PiernaD(i,:));
    W_PiernaD(i,:) = W_PiernaD(i,:)/norm(W_PiernaD(i,:));

    
    %%% R.Ankle
    PRodillaD(i,:) = P5(i,:)+0.500*A11*W_PiernaD(i,:);
    %%% R.Toe
    
end

figure4 = figure ('Color',[1 1 1]);
xlabel('Eje X[m]')
ylabel('Eje Y[m]')
zlabel('Eje Z[m]')

Paso = 18;
Consecutivo = false;
Plot_Vectores(P5,U_PiernaD,V_PiernaD,W_PiernaD,Paso,FrameRHS,FrameRTO,Consecutivo)


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
U_PieI = zeros(length(P8),3);
V_PieI = zeros(length(P8),3);
W_PieI = zeros(length(P8),3);
PPuntaI = zeros(length(P8),3);
PTobilloI = zeros(length(P8),3);

A14 = Datos.antropometria.children.LONGITUD_PIE_IZQUIERDO.info.values*0.01;
A16 = Datos.antropometria.children.ALTURA_MALEOLOS_IZQUIERDO.info.values*0.01;
A18 = Datos.antropometria.children.ANCHO_MALEOLOS_IZQUIERDO.info.values*0.01;
A20 = Datos.antropometria.children.ANCHO_PIE_IZQUIERDO.info.values*0.01;


for i=FrameRHS:FrameRTO
%%%%Versor en dirección Y
    U_PieI(i,:) = P8(i,:)-P9(i,:);
    U_PieI(i,:) = U_PieI(i,:)/norm(U_PieI(i,:));

    %%%%Versor en dirección Z
    W_PieI(i,:) = cross((P8(i,:)-P10(i,:)),(P9(i,:)-P10(i,:)));
    W_PieI(i,:) = W_PieI(i,:)/norm(W_PieI(i,:));

    %%%%Versor en dirección X
    V_PieI(i,:) = cross(W_PieI(i,:),U_PieI(i,:));
    V_PieI(i,:) = V_PieI(i,:)/norm(V_PieI(i,:));

    %%% Cálculo punto cadera derecha
    %%%% Si el chico camina con una componente x decreciente, la componente u y v 
    %%%% se modifican
    
    %%% R.Ankle
    PTobilloI(i,:) = P10(i,:)+0.016*A14*U_PieI(i,:)+0.392*A16*V_PieI(i,:)-0.478*A18*W_PieI(i,:);
    %%% R.Toe
    PPuntaI(i,:) = P10(i,:)+0.752*A14*U_PieI(i,:)+1.074*A16*V_PieI(i,:)+0.187*A20*W_PieI(i,:);
    
end

Paso = 18;
Consecutivo = true;
Plot_Vectores(P10,U_PieI,V_PieI,W_PieI,Paso,FrameRHS,FrameRTO,Consecutivo)



