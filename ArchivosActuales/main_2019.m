clear all;
close all;
clc;

[DatosMarcadores,infoCinematica,Plataformas,infoDinamica,Antropometria,Eventos,h,Datos] = lectura_c3d();

%%%%%%%%Cálculos Ciclo
%%%%%%Frecuencia de muestreo de 340
fm = Datos.info.Cinematica.frequency;

%%%Pie derecho (ciclo)
FrameRHS = round(Datos.eventos.Derecho_RHS(1)*fm);
FrameRTO = round(Datos.eventos.Derecho_RTO*fm);
%%%Pie izquierdo (ciclo)
FrameLHS = round(Datos.eventos.Izquierdo_LHS(1)*fm);
FrameLTO = round(Datos.eventos.Izquierdo_LTO*fm);

Puntos.Articu.CaderaD=0;
Puntos.P07 = 0;
Longitud.P07 = 0;
Vectores.U_Pelvis=0;

[Puntos,Longitud,Datos,Vectores] = Inicializacion(Puntos,Longitud,Datos,Vectores);


%%
%........................ Cálculos de Ejes PELVIS  ........................

close all;
clc;

for i=1:length(Vectores.U_Pelvis)
    %%%%Versor en dirección Y
    Vectores.V_Pelvis(i,:) = Puntos.P14(i,:)-Puntos.P07(i,:);
    Vectores.V_Pelvis(i,:) = Vectores.V_Pelvis(i,:)/norm(Vectores.V_Pelvis(i,:));

    %%%%Versor en dirección Z
    Vectores.W_Pelvis(i,:) = cross(Puntos.P07(i,:)-Puntos.P15(i,:),Puntos.P14(i,:)-Puntos.P15(i,:));
    Vectores.W_Pelvis(i,:) = Vectores.W_Pelvis(i,:)/norm(Vectores.W_Pelvis(i,:));

    %%%%Versor en dirección X
    Vectores.U_Pelvis(i,:) = cross(Vectores.V_Pelvis(i,:),Vectores.W_Pelvis(i,:));
    Vectores.U_Pelvis(i,:) = Vectores.U_Pelvis(i,:)/norm(Vectores.U_Pelvis(i,:));

    %%%Cálculo punto cadera derecha

    Puntos.Articu.CaderaD(i,:) = Puntos.P15(i,:)...
        +0.598*Longitud.A02*Vectores.U_Pelvis(i,:)...
        -0.344*Longitud.A02*Vectores.V_Pelvis(i,:)...
        -0.290*Longitud.A02*Vectores.W_Pelvis(i,:);
    
    Puntos.Articu.CaderaI(i,:) = Puntos.P15(i,:)...
        +0.598*Longitud.A02*Vectores.U_Pelvis(i,:)...
        +0.344*Longitud.A02*Vectores.V_Pelvis(i,:)...
        -0.290*Longitud.A02*Vectores.W_Pelvis(i,:);
end


Frame1 = FrameRHS;
Frame2 = FrameLTO;

% figure1 = figure ('Color',[1 1 1]);
% Paso = 18;
% Consecutivo = false;
% Plot_Vectores(Puntos.P15,Vectores.U_Pelvis/10,Vectores.V_Pelvis/40,Vectores.W_Pelvis/10,Paso,Frame1,Frame2,Consecutivo)
% 
% Plot_Marcadores_Tiempo(Puntos.P15,Frame1,Frame2);%Sacro
% Plot_Marcadores_Tiempo(Puntos.P05,Frame1,Frame2);%RodillaD
% Plot_Marcadores_Tiempo(Puntos.P12,Frame1,Frame2);%RodillaI
% Plot_Marcadores_Tiempo(Puntos.P07,Frame1,Frame2);%AsisD
% Plot_Marcadores_Tiempo(Puntos.P14,Frame1,Frame2);%AsisI
% Plot_Marcadores_Tiempo(Puntos.Articu.CaderaD,Frame1,Frame2);
% Plot_Marcadores_Tiempo(Puntos.Articu.CaderaI,Frame1,Frame2);
% 
% grid on;
% xlabel('Eje X[m]')
% ylabel('Eje Y[m]')
% zlabel('Eje Z[m]')

%%
%....................... CALCULOS PIERNA DERECHA ..........................

close all;
clc;

for i=1:length(Vectores.U_PiernaD)
    
    Vectores.V_PiernaD(i,:) = Puntos.P03(i,:)-Puntos.P05(i,:);
    Vectores.V_PiernaD(i,:) = Vectores.V_PiernaD(i,:)/norm(Vectores.V_PiernaD(i,:));

    VectorAux1 = (Puntos.P04(i,:)-Puntos.P05(i,:));
    VectorAux2 = (Puntos.P03(i,:)-Puntos.P05(i,:));
    Vectores.U_PiernaD(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.U_PiernaD(i,:) = Vectores.U_PiernaD(i,:)/norm(Vectores.U_PiernaD(i,:));

    Vectores.W_PiernaD(i,:) = cross(Vectores.U_PiernaD(i,:),Vectores.V_PiernaD(i,:));
    Vectores.W_PiernaD(i,:) = Vectores.W_PiernaD(i,:)/norm(Vectores.W_PiernaD(i,:));
    
    %%% Rodilla Derecha
    Puntos.Articu.RodillaD(i,:) = Puntos.P05(i,:)+0.500*Longitud.A11*Vectores.W_PiernaD(i,:);
    
    %...................SISTEMA LOCAL MUSLO DERECHO
    
    Vectores.I_MusloD(i,:) = Puntos.Articu.CaderaD(i,:)-Puntos.Articu.RodillaD(i,:);
    Vectores.I_MusloD(i,:) = Vectores.I_MusloD(i,:)/(norm(Vectores.I_MusloD(i,:)));
    
    VectorAux1 = (Puntos.P06(i,:)-Puntos.Articu.CaderaD(i,:));
    VectorAux2 = (Puntos.Articu.RodillaD(i,:)-Puntos.Articu.CaderaD(i,:));
    Vectores.J_MusloD(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.J_MusloD(i,:) = Vectores.J_MusloD(i,:)/(norm(Vectores.J_MusloD(i,:)));
    
    Vectores.K_MusloD(i,:) = cross (Vectores.I_MusloD(i,:),Vectores.J_MusloD(i,:));
    
    
end

figure2 = figure ('Color',[1 1 1]);
xlabel('Eje X[m]')
ylabel('Eje Y[m]')
zlabel('Eje Z[m]')

% Paso = 25;
% Consecutivo = true;
% Plot_Vectores(Puntos.Articu.RodillaD,...
%     Vectores.U_PiernaD/20,Vectores.V_PiernaD/20,Vectores.W_PiernaD/20,...
%     Paso,FrameRHS,FrameLTO,Consecutivo)
% 
% Plot_Marcadores_Tiempo(Puntos.P03,Frame1,Frame2,[1 0 0]);%maleolo
% Plot_Marcadores_Tiempo(Puntos.P04,Frame1,Frame2,[0 1 0]);%barra2
% Plot_Marcadores_Tiempo(Puntos.P05,Frame1,Frame2,'b');%Epicondilo
% 
% axis equal;

%%
%..................... Cálculos de Ejes PIE DERECHO   .....................

close all;
clc;

for i=1:length(Vectores.U_PieD)
    
    Vectores.U_PieD(i,:) = Puntos.P01(i,:)-Puntos.P02(i,:);
    Vectores.U_PieD(i,:) = Vectores.U_PieD(i,:)/norm(Vectores.U_PieD(i,:));
    
    Vectores.W_PieD(i,:) = cross((Puntos.P01(i,:)-Puntos.P03(i,:)),(Puntos.P02(i,:)-Puntos.P03(i,:)));
    Vectores.W_PieD(i,:) = Vectores.W_PieD(i,:)/norm(Vectores.W_PieD(i,:));
    
    Vectores.V_PieD(i,:) = cross(Vectores.W_PieD(i,:),Vectores.U_PieD(i,:));
    Vectores.V_PieD(i,:) = Vectores.V_PieD(i,:)/norm(Vectores.V_PieD(i,:));

    %%% Cálculo Tobillo y Punta
    
    %%% R.Ankle
    Puntos.Articu.TobilloD(i,:) = Puntos.P03(i,:)...
        +0.016*Longitud.A13*Vectores.U_PieD(i,:)...
        +0.392*Longitud.A15*Vectores.V_PieD(i,:)...
        +0.478*Longitud.A17*Vectores.W_PieD(i,:);
    %%% R.Toe
    Puntos.Articu.PuntaD(i,:) = Puntos.P03(i,:)...
        +0.752*Longitud.A13*Vectores.U_PieD(i,:)...
        +1.074*Longitud.A15*Vectores.V_PieD(i,:)...
        -0.187*Longitud.A19*Vectores.W_PieD(i,:);
end

% figure3 = figure ('Color',[1 1 1]);
% xlabel('Eje X[m]')
% ylabel('Eje Y[m]')
% zlabel('Eje Z[m]')
% 
% Paso = 25;
% Consecutivo = false;
% Plot_Vectores(Puntos.Articu.TobilloD,...
%     Vectores.U_PieD/10,Vectores.V_PieD/10,Vectores.W_PieD/10,...
%     Paso, Frame1, Frame2, Consecutivo)
% 
% Plot_Marcadores_Tiempo(Puntos.P01,Frame1,Frame2,'r');%metatarciano
% Plot_Marcadores_Tiempo(Puntos.P02,Frame1,Frame2,'g');%talon
% Plot_Marcadores_Tiempo(Puntos.P03,Frame1,Frame2,'b');%maleolo
% 
% axis equal;


%%
%..................... CALCULO EJES PIERNA IZQUIERDA  .....................
close all;
clc;

for i=1:length(Vectores.U_PiernaI)
    Vectores.V_PiernaI(i,:) = Puntos.P10(i,:)-Puntos.P12(i,:);
    Vectores.V_PiernaI(i,:) = Vectores.V_PiernaI(i,:)/norm(Vectores.V_PiernaI(i,:));

    Vectores.U_PiernaI(i,:) = cross((Puntos.P10(i,:)-Puntos.P12(i,:)),(Puntos.P11(i,:)-Puntos.P12(i,:)));
    Vectores.U_PiernaI(i,:) = Vectores.U_PiernaI(i,:)/norm(Vectores.U_PiernaI(i,:));
    
    Vectores.W_PiernaI(i,:) = cross(Vectores.U_PiernaI(i,:),Vectores.V_PiernaI(i,:));
    Vectores.W_PiernaI(i,:) = Vectores.W_PiernaI(i,:)/norm(Vectores.W_PiernaI(i,:));
    
    %%% Rodilla Izquierda
    Puntos.Articu.RodillaI(i,:) = Puntos.P12(i,:)-0.500*Longitud.A11*Vectores.W_PiernaI(i,:);
    
end

% figure4 = figure ('Color',[1 1 1]);
% xlabel('Eje X[m]')
% ylabel('Eje Y[m]')
% zlabel('Eje Z[m]')
% 
% Paso = 18;
% Consecutivo = false;
% Plot_Vectores(Puntos.Articu.RodillaI,...
%     Vectores.U_PiernaI/20,Vectores.V_PiernaI/20,Vectores.W_PiernaI/20,...
%     Paso,FrameRHS,FrameLTO,Consecutivo)
% 
% Plot_Marcadores_Tiempo(Puntos.P10,Frame1,Frame2,'r');%maleolo
% Plot_Marcadores_Tiempo(Puntos.P11,Frame1,Frame2,'g');%bar2
% Plot_Marcadores_Tiempo(Puntos.P12,Frame1,Frame2,'b');%rodilla
% 
% axis equal;

%%
%........................ CALCULOS PIE IZQUIERDO .........................

close all;
clc;

for i=1:length(Vectores.U_PieI)
    Vectores.U_PieI(i,:) = Puntos.P08(i,:)-Puntos.P09(i,:);
    Vectores.U_PieI(i,:) = Vectores.U_PieI(i,:)/norm(Vectores.U_PieI(i,:));

    Vectores.W_PieI(i,:) = cross((Puntos.P08(i,:)-Puntos.P10(i,:)),(Puntos.P09(i,:)-Puntos.P10(i,:)));
    Vectores.W_PieI(i,:) = Vectores.W_PieI(i,:)/norm(Vectores.W_PieI(i,:));

    Vectores.V_PieI(i,:) = cross(Vectores.W_PieI(i,:),Vectores.U_PieI(i,:));
    Vectores.V_PieI(i,:) = Vectores.V_PieI(i,:)/norm(Vectores.V_PieI(i,:));
    
    %%% R.Ankle
    Puntos.Articu.TobilloI(i,:) = Puntos.P10(i,:)...
        +0.016*Longitud.A14*Vectores.U_PieI(i,:)...
        + 0.392*Longitud.A16*Vectores.V_PieI(i,:)...
        -0.478*Longitud.A18*Vectores.W_PieI(i,:);
    
    %%% R.Toe
    Puntos.Articu.PuntaI(i,:) = Puntos.P10(i,:)...
        +0.752*Longitud.A14*Vectores.U_PieI(i,:)...
        +1.074*Longitud.A16*Vectores.V_PieI(i,:)...
        +0.187*Longitud.A20*Vectores.W_PieI(i,:);
end

% figure5 = figure ('Color',[1 1 1]);
% xlabel('Eje X[m]')
% ylabel('Eje Y[m]')
% zlabel('Eje Z[m]')
% 
% Paso = 25;
% Consecutivo = false;
% Plot_Vectores(Puntos.P08,...
%     Vectores.U_PieI/15,Vectores.V_PieI/15,Vectores.W_PieI/15,...
%     Paso,FrameRHS,FrameLTO,Consecutivo)
% 
% Plot_Marcadores_Tiempo(Puntos.P08,Frame1,Frame2,'r');%metatarciano
% Plot_Marcadores_Tiempo(Puntos.P09,Frame1,Frame2,'g');%talon
% Plot_Marcadores_Tiempo(Puntos.P10,Frame1,Frame2,'b');%maleolo

axis equal;
%%
%........................ CALCULOS SISTEMAS LOCALES .......................

for i=1:length(Vectores.U_PieD)
    
    %...................SISTEMA LOCAL MUSLO DERECHO
    
    Vectores.I_MusloD(i,:) = Puntos.Articu.CaderaD(i,:)-Puntos.Articu.RodillaD(i,:);
    Vectores.I_MusloD(i,:) = Vectores.I_MusloD(i,:)/(norm(Vectores.I_MusloD(i,:)));
    
    VectorAux1 = (Puntos.P06(i,:)-Puntos.Articu.CaderaD(i,:));
    VectorAux2 = (Puntos.Articu.RodillaD(i,:)-Puntos.Articu.CaderaD(i,:));
    Vectores.J_MusloD(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.J_MusloD(i,:) = Vectores.J_MusloD(i,:)/(norm(Vectores.J_MusloD(i,:)));
    
    Vectores.K_MusloD(i,:) = cross (Vectores.I_MusloD(i,:),Vectores.J_MusloD(i,:));
    
    %...................SISTEMA LOCAL PIERNA DERECHO
    
    Vectores.I_PiernaD(i,:) = Puntos.Articu.RodillaD(i,:)-Puntos.Articu.TobilloD(i,:);
    Vectores.I_PiernaD(i,:) = Vectores.I_PiernaD(i,:)/(norm(Vectores.I_PiernaD(i,:)));
    
    VectorAux1 = (Puntos.P05(i,:)-Puntos.Articu.RodillaD(i,:));
    VectorAux2 = (Puntos.Articu.TobilloD(i,:)-Puntos.Articu.RodillaD(i,:));
    Vectores.J_PiernaD(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.J_PiernaD(i,:) = Vectores.J_PiernaD(i,:)/(norm(Vectores.J_PiernaD(i,:)));
    
    Vectores.K_PiernaD(i,:) = cross (Vectores.I_PiernaD(i,:),Vectores.J_PiernaD(i,:));
    
    %...................SISTEMA LOCAL PIE DERECHO
    
    Vectores.I_PieD(i,:) = Puntos.P02(i,:)-Puntos.Articu.PuntaD(i,:);
    Vectores.I_PieD(i,:) = Vectores.I_PieD(i,:)/(norm(Vectores.I_PieD(i,:)));
    
    VectorAux1 = (Puntos.Articu.TobilloD(i,:)-Puntos.P02(i,:));
    VectorAux2 = (Puntos.Articu.PuntaD(i,:)-Puntos.P02(i,:));
    Vectores.K_PieD(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.K_PieD(i,:) = Vectores.K_PieD(i,:)/(norm(Vectores.K_PieD(i,:)));
    
    Vectores.J_PieD(i,:) = cross (Vectores.K_PieD(i,:),Vectores.I_PieD(i,:));
    
    %...................SISTEMA LOCAL MUSLO IZQUIERDO
    
    Vectores.I_MusloI(i,:) = Puntos.Articu.CaderaI(i,:)-Puntos.Articu.RodillaI(i,:);
    Vectores.I_MusloI(i,:) = Vectores.I_MusloI(i,:)/(norm(Vectores.I_MusloI(i,:)));
    
    VectorAux1 =(Puntos.Articu.RodillaI(i,:)-Puntos.Articu.CaderaI(i,:));
    VectorAux2 =(Puntos.P13(i,:)-Puntos.Articu.CaderaI(i,:));
    Vectores.J_MusloI(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.J_MusloI(i,:) = Vectores.J_MusloI(i,:)/(norm(Vectores.J_MusloI(i,:)));
    
    Vectores.K_MusloI(i,:) = cross (Vectores.I_MusloI(i,:),Vectores.J_MusloI(i,:));
    
    %...................SISTEMA LOCAL PIERNA IZQUIERDA
    
    Vectores.I_PiernaI(i,:) = Puntos.Articu.RodillaI(i,:)-Puntos.Articu.TobilloI(i,:);
    Vectores.I_PiernaI(i,:) = Vectores.I_PiernaI(i,:)/(norm(Vectores.I_PiernaI(i,:)));
    
    VectorAux1 = (Puntos.Articu.TobilloI(i,:)-Puntos.Articu.RodillaI(i,:));
    VectorAux2 = (Puntos.P12(i,:)-Puntos.Articu.RodillaI(i,:));
    Vectores.J_PiernaI(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.J_PiernaI(i,:) = Vectores.J_PiernaI(i,:)/(norm(Vectores.J_PiernaI(i,:)));
    
    Vectores.K_PiernaI(i,:) = cross (Vectores.I_PiernaI(i,:),Vectores.J_PiernaI(i,:));
    
    %...................SISTEMA LOCAL PIE IZQUIERDO
    
    Vectores.I_PieI(i,:) = Puntos.P09(i,:)-Puntos.Articu.PuntaI(i,:);
    Vectores.I_PieI(i,:) = Vectores.I_PieI(i,:)/(norm(Vectores.I_PieI(i,:)));
    
    VectorAux1 = (Puntos.Articu.TobilloI(i,:)-Puntos.P09(i,:));
    VectorAux2 = (Puntos.Articu.PuntaI(i,:)-Puntos.P09(i,:));
    Vectores.K_PieI(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.K_PieI(i,:) = Vectores.K_PieI(i,:)/(norm(Vectores.K_PieI(i,:)));
    
    Vectores.J_PieI(i,:) = cross(Vectores.K_PieD(i,:),Vectores.I_PieI(i,:));
    
end

%............................. CENTROS DE MASA ............................

%...................MUSLO DERECHO
Puntos.CM.MusloD = Puntos.Articu.CaderaD + 0.39*(Puntos.Articu.RodillaD-Puntos.Articu.CaderaD);

%...................MUSLO IZQUIERDO
Puntos.CM.MusloI = Puntos.Articu.CaderaI + 0.39*(Puntos.Articu.RodillaI-Puntos.Articu.CaderaI);

%...................PANTORRILLA DERECHA
Puntos.CM.PantorrillaD = Puntos.Articu.RodillaD + 0.42*(Puntos.Articu.TobilloD-Puntos.Articu.RodillaD);

%...................PANTORRILLA IZQUIERDA
Puntos.CM.PantorrillaI = Puntos.Articu.RodillaI + 0.42*(Puntos.Articu.TobilloI-Puntos.Articu.RodillaI);

%...................PIE DERECHO
Puntos.CM.PieD = Puntos.P02 + 0.44*(Puntos.Articu.PuntaD-Puntos.P02);

%...................PIE IZQUIERDO
Puntos.CM.PieI = Puntos.P09 + 0.44*(Puntos.Articu.PuntaI-Puntos.P09);

Frame1 = FrameRHS;
Frame2 = FrameLTO;
Paso = 44;
Consecutivo = false;
Escala = 1/10;

figure6 = figure ('Color',[1 1 1]);
xlabel('Eje X[m]')
ylabel('Eje Y[m]')
zlabel('Eje Z[m]')

%%%%%%%%PARTE DERECHA

Plot_Vectores(Puntos.CM.MusloD,...
    Vectores.I_MusloD*Escala,Vectores.J_MusloD*Escala,Vectores.K_MusloD*Escala,...
    Paso,Frame1,Frame2,Consecutivo)

Plot_Vectores(Puntos.CM.PantorrillaD,...
    Vectores.I_PiernaD*Escala,Vectores.J_PiernaD*Escala,Vectores.K_PiernaD*Escala,...
    Paso,Frame1,Frame2,Consecutivo)

Plot_Vectores(Puntos.CM.PieD,...
    Vectores.I_PieD*Escala,Vectores.J_PieD*Escala,Vectores.K_PieD*Escala,...
    Paso,Frame1,Frame2,Consecutivo)

Plot_Vectores(Puntos.P15,...
    Vectores.U_Pelvis*Escala,Vectores.V_Pelvis*Escala,Vectores.W_Pelvis*Escala,...
    Paso,Frame1,Frame2,Consecutivo)

Plot_Marcadores_Tiempo(Puntos.P15,Frame1,Frame2,'r');%Sacro
Plot_Marcadores_Tiempo(Puntos.P07,Frame1,Frame2,'r');%AsisD
Plot_Marcadores_Tiempo(Puntos.Articu.CaderaD,Frame1,Frame2,'r');

Plot_Marcadores_Tiempo(Puntos.Articu.RodillaD,Frame1,Frame2,'g');%Rodilla

Plot_Marcadores_Tiempo(Puntos.Articu.PuntaD,Frame1,Frame2,'b');%metatarciano
Plot_Marcadores_Tiempo(Puntos.P02,Frame1,Frame2,'b');%talon

axis equal;
%%
%%%%%%%%PARTE IZQUIERDA

Plot_Vectores(Puntos.CM.MusloI,...
    Vectores.I_MusloI*Escala,Vectores.J_MusloI*Escala,Vectores.K_MusloI*Escala,...
    Paso,Frame1,Frame2,Consecutivo)

Plot_Vectores(Puntos.CM.PantorrillaI,...
    Vectores.I_PiernaI*Escala,Vectores.J_PiernaI*Escala,Vectores.K_PiernaI*Escala,...
    Paso,Frame1,Frame2,Consecutivo)

Plot_Vectores(Puntos.CM.PieI,...
    Vectores.I_PieI*Escala,Vectores.J_PieI*Escala,Vectores.K_PieI*Escala,...
    Paso,Frame1,Frame2,Consecutivo)

Plot_Vectores(Puntos.P15,...
    Vectores.U_Pelvis*Escala,Vectores.V_Pelvis*Escala,Vectores.W_Pelvis*Escala,...
    Paso,Frame1,Frame2,Consecutivo)

Plot_Marcadores_Tiempo(Puntos.P14,Frame1,Frame2,'r');%AsisI
Plot_Marcadores_Tiempo(Puntos.Articu.CaderaI,Frame1,Frame2,'r');

Plot_Marcadores_Tiempo(Puntos.Articu.RodillaI,Frame1,Frame2,'g');%Rodilla

Plot_Marcadores_Tiempo(Puntos.Articu.PuntaI,Frame1,Frame2,'b');%Punta
Plot_Marcadores_Tiempo(Puntos.P09,Frame1,Frame2,'b');%talon

axis equal;


%%
%%%%% Filtrado

[Punto_Filtrado] = FiltroPB(Puntos.P05,fm,Frame1,Frame2);






