
%% -------------------------- Carga de datos -----------------------------
clear all; close all; clc;


load('Datos_PrimeraParte.mat');
Puntos = Datos_PrimeraParte.Puntos;
Longitud = Datos_PrimeraParte.Longitud;
Vectores = Datos_PrimeraParte.Vectores;
Angulos = Datos_PrimeraParte.Angulos;
FrameEventos = Datos_PrimeraParte.FramesEventos;
fm = Datos.info.Cinematica.frequency;

clear Datos_PrimeraParte;

% ........................Momentos de inercia........................

Altura = Datos.antropometria.children.ALTURA.info.values; % en Cm
Masa = Datos.antropometria.children.PESO.info.values;% en Kg

%%% en Kg*m^2
Inercia.Flex_Ext_Muslo = (-3557 + 31.7*Masa + 18.61*Altura)/10000;
Inercia.Aduc_Abduc_Muslo = (3690 + 32.02*Masa+ 19.24*Altura)/10000;
Inercia.Rotacion_Muslo = (-13.5 + 11.3*Masa - 2.28*Altura)/10000;

Inercia.Flex_Ext_Pierna = (-1105 + 4.59*Masa + 6.63*Altura)/10000;
Inercia.Aduc_Abduc_Pierna = (-1152 + 4.594*Masa + 6.815*Altura)/10000;
Inercia.Rotacion_Pierna = (70.5 + 1.134*Masa + 0.3*Altura)/10000;

Inercia.Flex_Ext_Pie = (-100 + 0.480*Masa + 0.626*Altura)/10000;
Inercia.Aduc_Abduc_Pie = (-97.09 + 0.414*Masa + 0.614*Altura)/10000;
Inercia.Rotacion_Pie = (-15.48 + 0.144*Masa + 0.088*Altura)/10000;

%% .................. Calculo de Velocidades y Aceleraciones lineales

Cinematica.MusloD.V = zeros(size(Puntos.CM.MusloD));
Cinematica.MusloI.V = zeros(size(Puntos.CM.MusloI));
tm = 1/fm;
for i=2:(length(Cinematica.MusloD.V)-1)
    
    Cinematica.MusloD.V(i,1) = (Puntos.CM.MusloD(i+1,1) - Puntos.CM.MusloD(i-1,1))/(2*tm);
    Cinematica.MusloD.V(i,2) = (Puntos.CM.MusloD(i+1,2) - Puntos.CM.MusloD(i-1,2))/(2*tm);
    Cinematica.MusloD.V(i,3) = (Puntos.CM.MusloD(i+1,3) - Puntos.CM.MusloD(i-1,3))/(2*tm);
    
    Cinematica.MusloI.V(i,1) = (Puntos.CM.MusloI(i+1,1) - Puntos.CM.MusloI(i-1,1))/(2*tm);
    Cinematica.MusloI.V(i,2) = (Puntos.CM.MusloI(i+1,2) - Puntos.CM.MusloI(i-1,2))/(2*tm);
    Cinematica.MusloI.V(i,3) = (Puntos.CM.MusloI(i+1,3) - Puntos.CM.MusloI(i-1,3))/(2*tm);
end

%% ..................Calculos de Angulos Euler
Vectores.I_Global = [1 0 0];
Vectores.J_Global = [0 1 0];
Vectores.K_Global = [0 0 1];

Vectores.LN_MusloD = zeros(size(Vectores.I_MusloD));
Vectores.LN_MusloI = zeros(size(Vectores.I_MusloI));

for i=1:length(Vectores.LN_MusloD)
    
    %.................... Calculos Muslos
    Vectores.LN_MusloD(i,:) = cross(Vectores.K_Global,Vectores.K_MusloD(i,:));
    Vectores.LN_MusloD(i,:) = Vectores.LN_MusloD(i,:)/norm(Vectores.LN_MusloD(i,:));
    Vectores.LN_MusloI(i,:) = cross(Vectores.K_Global,Vectores.K_MusloI(i,:));
    Vectores.LN_MusloD(i,:) = Vectores.LN_MusloI(i,:)/norm(Vectores.LN_MusloI(i,:));
    % Alfas
    
    Polaridad = dot(Vectores.J_Global,Vectores.LN_MusloD(i,:))/...
        abs(dot(Vectores.J_Global,Vectores.LN_MusloD(i,:)));
    
    Angulos.AlfaMusloD(i,:) = acosd(dot(Vectores.I_Global,Vectores.LN_MusloD(i,:)))*Polaridad;
    
    Polaridad = dot(Vectores.J_Global,Vectores.LN_MusloI(i,:))/...
        abs(dot(Vectores.J_Global,Vectores.LN_MusloI(i,:)));
    Angulos.AlfaMusloI(i,:) = acosd(dot(Vectores.I_Global,Vectores.LN_MusloI(i,:)))*Polaridad;
    
    % Betas
    
    Angulos.BetaMusloD(i,:) = acosd(dot(Vectores.K_Global,Vectores.K_MusloD(i,:)));
    Angulos.BetaMusloI(i,:) = acosd(dot(Vectores.K_Global,Vectores.K_MusloI(i,:)));
    
    % Gammas
    
    Polaridad = dot(Vectores.J_MusloD(i,:),Vectores.LN_MusloD(i,:))/...
        abs(dot(Vectores.J_MusloD(i,:),Vectores.LN_MusloD(i,:)));
    Angulos.GammaMusloD(i,:) = acosd(dot(Vectores.I_MusloD(i,:),Vectores.LN_MusloD(i,:)))*Polaridad;
    
    Polaridad = dot(Vectores.J_MusloI(i,:),Vectores.LN_MusloI(i,:))/...
        abs(dot(Vectores.J_MusloI(i,:),Vectores.LN_MusloI(i,:)));
    Angulos.GammaMusloI(i,:) = acosd(dot(Vectores.I_MusloI(i,:),Vectores.LN_MusloI(i,:)))*Polaridad;

end












