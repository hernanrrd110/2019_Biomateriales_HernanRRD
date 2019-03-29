clear all;
close all;
clc;
%cd('/home/marco3407/marco3407@gmail.com/UNER/BiomecÃ¡nica/Tp Laboratorio 2/2019/Archivos c3d')
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

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Pibito de 177 cm de Altura

color1 = 'r';
color2 = 'b';
color3 = 'g';
color4 = 'h';

% %%
% %%%%%%%%%%%%%%%%%%%% Marcador Sacro en el tiempo %%%%%%%%%%%%%%%%%%%%%%%
% figure1 = figure ('Color',[1 1 1]);
% plot3(DatosMarcadores.sacrum(:,1),DatosMarcadores.sacrum(:,2),DatosMarcadores.sacrum(:,3));
% hold on;
% %%%%% Marcador Rodilla D en el tiempo
% plot3(DatosMarcadores.r_knee_1(:,1),DatosMarcadores.r_knee_1(:,2),DatosMarcadores.r_knee_1(:,3),color1,'linewidth',2);
% hold on;
% grid on;
% xlabel('Eje X[m]')
% ylabel('Eje Y[m]')
% zlabel('Eje Z[m]')
% %%%%% Marcador Rodilla L en el tiempo
% plot3(DatosMarcadores.l_asis(:,1),DatosMarcadores.l_asis(:,2),DatosMarcadores.l_asis(:,3),color2);
% hold on;
% %%%%% Marcador ASIS D en el tiempo
% plot3(DatosMarcadores.r_asis(:,1),DatosMarcadores.r_asis(:,2),DatosMarcadores.r_asis(:,3),color3);
% hold on;
% %%%%% Marcador ASIS L en el tiempo
% plot3(DatosMarcadores.l_knee_1(:,1),DatosMarcadores.l_knee_1(:,2),DatosMarcadores.l_knee_1(:,3),color4,'linewidth',2);

%%
%%%%%%%%Cálculos Ciclo

%%%%%%Frecuencia de muestreo de 340
fm = 340;

%%%Pie derecho (ciclo)
FrameRHS = round(Eventos.Derecho_RHS(1)*fm);
FrameRTO = round(Eventos.Derecho_RTO*fm);
%%%Pie izquierdo (ciclo)
FrameLHS = round(Eventos.Izquierdo_LHS(1)*fm);
FrameLTO = round(Eventos.Izquierdo_LTO*fm);

%%
%%%%%%%%%%%%%%%%%%%%% Cálculos de Ejes PELVIS en el instante 2023 (más o menos a la mitad)  %%%%%%%%%%%%%%%%%%%%%%%

close all;
clc;
%%%% Asis derecha
P7 = DatosMarcadores.r_asis;
%%%% Asis izquierda
P14 = DatosMarcadores.l_asis;
%%%% Sacro
P15 = DatosMarcadores.sacrum;
U_Pelvis = zeros(length(P7),3);
V_Pelvis = zeros(length(P7),3);
W_Pelvis = zeros(length(P7),3);
PCaderaD = zeros(length(P7),3);
PCaderaI = zeros(length(P7),3);
A2 = 0;


for i=FrameRHS:FrameRTO
%%%%Versor en dirección Y

    V_Pelvis(i,:) = P14(i,:)-P7(i,:);
    V_Pelvis(i,:) = V_Pelvis(i,:)/norm(V_Pelvis(i,:));

    %%%%Versor en dirección Z
    W_Pelvis(i,:) = cross(P7(i,:)-P15(i,:),P14(i,:)-P15(i,:));
    W_Pelvis(i,:) = W_Pelvis(i,:)/norm(W_Pelvis(i,:));

    %%%%Versor en dirección X
    U_Pelvis(i,:) = cross(V_Pelvis(i,:),W_Pelvis(i,:));
    U_Pelvis(i,:) = U_Pelvis(i,:)/norm(U_Pelvis(i,:));

    %%%Cálculo punto cadera derecha
    %%%% El chico camina con una componente x decreciente, la componente u y v 
    %%%% se modifican

    A2 = norm(P14(i,:)-P7(i,:));
    PCaderaD(i,:) = P15(i,:)+0.598*A2*U_Pelvis(i,:)-0.344*A2*V_Pelvis(i,:)-0.290*A2*W_Pelvis(i,:);
    PCaderaI(i,:) = P15(i,:)+0.598*A2*U_Pelvis(i,:)+0.344*A2*V_Pelvis(i,:)-0.290*A2*W_Pelvis(i,:);
    
end

for i=FrameRHS:20:FrameRTO
    
    quiver3(P15(i,1),P15(i,2),P15(i,3),U_Pelvis(i,1)/10,U_Pelvis(i,2)/10,U_Pelvis(i,3)/10,color1);
    hold on;
    quiver3(P15(i,1),P15(i,2),P15(i,3),V_Pelvis(i,1)/30,V_Pelvis(i,2)/30,V_Pelvis(i,3)/30,color2);
    hold on;
    quiver3(P15(i,1),P15(i,2),P15(i,3),W_Pelvis(i,1)/10,W_Pelvis(i,2)/10,W_Pelvis(i,3)/10,color3);
    hold on;

    
end


%%
close all;
clc;
%%%% Asis derecha
P1 = DatosMarcadores.r_asis;
%%%% Asis izquierda
P2 = DatosMarcadores.l_asis;
%%%% Sacro
P3 = DatosMarcadores.sacrum;
U_PieD = zeros(length(P1),3);
V_PieD = zeros(length(P1),3);
W_PieD = zeros(length(P1),3);
PPuntaD = zeros(length(P1),3);
PTobilloD = zeros(length(P1),3);
A13 = 0;
A15 = 0;
A17 = 0;
A19 = 0;


for i=FrameRHS:FrameRTO
%%%%Versor en dirección Y
    U_PieD(i,:) = P1(i,:)-P2(i,:);
    U_PieD(i,:) = U_PieD(i,:)/norm(U_PieD(i,:));


    %%%%Versor en dirección Z
    V_PieD(i,:) = cross(P1(i,:)-P3(i,:),P2(i,:)-P3(i,:));
    V_PieD(i,:) = W_PieD(i,:)/norm(W_PieD(i,:));

    %%%%Versor en dirección X
    W_PieD(i,:) = cross(U(i,:),V_PieD(i,:));
    W_PieD(i,:) = W_PieD(i,:)/norm(W_PieD(i,:));

    %%%Cálculo punto cadera derecha
    %%%% El chico camina con una componente x decreciente, la componente u y v 
    %%%% se modifican

    A15 = norm(P2(i,:)-P1(i,:));
    PCaderaD(i,:) = P3(i,:)+0.598*A15*U_PieD(i,:)-0.344*A15*V_PieD(i,:)-0.290*A15*W_PieD(i,:);
    PCaderaI(i,:) = P3(i,:)+0.598*A15*U_PieD(i,:)+0.344*A15*V_PieD(i,:)-0.290*A15*W_PieD(i,:);
    
end

for i=FrameRHS:20:FrameRTO
    
    quiver3(P3(i,1),P3(i,2),P3(i,3),U_PieD(i,1)/10,U_PieD(i,2)/10,U_PieD(i,3)/10,color1);
    hold on;
    quiver3(P3(i,1),P3(i,2),P3(i,3),V_PieD(i,1)/30,V_PieD(i,2)/30,V_PieD(i,3)/30,color2);
    hold on;
    quiver3(P3(i,1),P3(i,2),P3(i,3),W_PieD(i,1)/10,W_PieD(i,2)/10,W_PieD(i,3)/10,color3);
    hold on;

    
end

%%
%%%%%%%%GRAFICACIÓN PUNTOS
figure2 = figure('Color',[1 1 1]);

%%%%% Marcador ASIS D 
scatter3(DatosMarcadores.r_asis(FrameRHS,1),DatosMarcadores.r_asis(FrameRHS,2),DatosMarcadores.r_asis(FrameRHS,3),'h','b','linewidth',10);
hold on;
%%%%% Marcador ASIS L 
scatter3(DatosMarcadores.l_asis(FrameRHS,1),DatosMarcadores.l_asis(FrameRHS,2),DatosMarcadores.l_asis(FrameRHS,3),'h','b','linewidth',10);
hold on;
%%%%% Marcador ASIS L 
scatter3(DatosMarcadores.sacrum(FrameRHS,1),DatosMarcadores.sacrum(FrameRHS,2),DatosMarcadores.sacrum(FrameRHS,3),'h','g','linewidth',10);
hold on;
%%%%% Marcador Cadera Derecha
scatter3(PCaderaD(FrameRHS,1),PCaderaD(FrameRHS,2),PCaderaD(FrameRHS,3),'h','r','linewidth',10);
hold on;
%%%%% Marcador Cadera Izquierda
scatter3(PCaderaI(FrameRHS,1),PCaderaI(FrameRHS,2),PCaderaI(FrameRHS,3),'h','r','linewidth',10);
hold on;

grid on;
xlabel('Eje X[m]')
ylabel('Eje Y[m]')
zlabel('Eje Z[m]')




