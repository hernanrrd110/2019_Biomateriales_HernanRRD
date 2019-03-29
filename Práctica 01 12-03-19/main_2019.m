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
Datos.Pasada.Plataformas(1).Crudos=Plataformas(1);
Datos.Pasada.Plataformas(2).Crudos=Plataformas(2);
Datos.info.Cinematica=infoCinematica;
Datos.info.Dinamica=infoDinamica;

Datos.antropometria=Antropometria;
Datos.eventos=Eventos;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Pibito de 177 cm de Altura
close all;
clc;

color1 = 'r';
color2 = 'b';
color3 = 'g';
color4 = 'h';


%%%%%%%%%%%%%%%%%%%% Marcador Sacro en el tiempo %%%%%%%%%%%%%%%%%%%%%%%
figure1 = figure ('Color',[1 1 1]);
plot3(DatosMarcadores.sacrum(:,1),DatosMarcadores.sacrum(:,2),DatosMarcadores.sacrum(:,3));
hold on;
%%%%% Marcador Rodilla D en el tiempo
plot3(DatosMarcadores.r_knee_1(:,1),DatosMarcadores.r_knee_1(:,2),DatosMarcadores.r_knee_1(:,3),color1,'linewidth',10);
hold on;
grid on;
xlabel('Eje X[m]')
ylabel('Eje Y[m]')
zlabel('Eje Z[m]')
%%%%% Marcador Rodilla L en el tiempo
plot3(DatosMarcadores.l_asis(:,1),DatosMarcadores.l_asis(:,2),DatosMarcadores.l_asis(:,3),color2);
hold on;
%%%%% Marcador ASIS D en el tiempo
plot3(DatosMarcadores.r_asis(:,1),DatosMarcadores.r_asis(:,2),DatosMarcadores.r_asis(:,3),color3);
hold on;
%%%%% Marcador ASIS L en el tiempo
plot3(DatosMarcadores.l_knee_1(:,1),DatosMarcadores.l_knee_1(:,2),DatosMarcadores.l_knee_1(:,3),color4,'linewidth',10);


%%%%%%%%%%%%%%%%%%%%% Cálculos de Ejes en el instante 2023 (más o menos a la mitad)  %%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%Cálculos

%%%% Asis derecha
P7 = [DatosMarcadores.r_asis(2023,1),DatosMarcadores.r_asis(2023,2),DatosMarcadores.r_asis(2023,3)];
%%%% Asis izquierda
P14 = [DatosMarcadores.l_asis(2023,1),DatosMarcadores.l_asis(2023,2),DatosMarcadores.l_asis(2023,3)];
%%%% Sacro
P15 = [DatosMarcadores.sacrum(2023,1),DatosMarcadores.sacrum(2023,2),DatosMarcadores.sacrum(2023,3)];


%%%%Versor en dirección Y
V = P14-P7;
V = V/norm(V);

%%%%Versor en dirección Z
W = cross(P7-P15,P14-P15);
W = W/norm(W);

%%%%Versor en dirección X
U = cross(V,W);
U = U/norm(U);

%%%Cálculo punto cadera derecha
%%%% El chico camina con una componente x decreciente, la componente u y v 
%%%% se modifican

A2 = norm(P14-P7);
PCaderaD = P15+0.598*A2*U-0.344*A2*V-0.290*A2*W;
PCaderaI = P15+0.598*A2*U+0.344*A2*V-0.290*A2*W;



%%%%%%%%GRAFICACIÓN PUNTOS
figure2 = figure('Color',[1 1 1]);
%%%%% Marcador ASIS D 
scatter3(DatosMarcadores.r_asis(2023,1),DatosMarcadores.r_asis(2023,2),DatosMarcadores.r_asis(2023,3),'linewidth',10);
hold on;
%%%%% Marcador ASIS L 
scatter3(DatosMarcadores.l_knee_1(2023,1),DatosMarcadores.l_knee_1(2023,2),DatosMarcadores.l_knee_1(2023,3),'linewidth',10);
hold on;
%%%%% Marcador ASIS L 
scatter3(DatosMarcadores.sacrum(2023,1),DatosMarcadores.sacrum(2023,2),DatosMarcadores.sacrum(2023,3));
hold on;
%%%%% Marcador Cadera Derecha
scatter3(PCaderaD(1),PCaderaD(2),PCaderaD(3),'h','r''linewidth',10);
hold on;
%%%%% Marcador Cadera Izquierda
scatter3(PCaderaI(1),PCaderaI(2),PCaderaI(3),'h','r','linewidth',10);
hold on;

grid on;
xlabel('Eje X[m]')
ylabel('Eje Y[m]')
zlabel('Eje Z[m]')





