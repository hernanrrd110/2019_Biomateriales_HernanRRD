
%% -------------------------- Carga de datos -----------------------------
clear all; close all; clc;

load('Datos_PrimeraParte.mat');
Puntos = Datos_PrimeraParte.Puntos;
Longitud = Datos_PrimeraParte.Longitud;
Vectores = Datos_PrimeraParte.Vectores;
Angulos = Datos_PrimeraParte.Angulos;
FrameEventos = Datos_PrimeraParte.FramesEventos;

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


















%%%% ------ Muslos

% % Flexion Extension
% Inercia.Flex_Ext_MusloD = 0.00762*Longitud.A1*Longitud.A3^2 ...
%     + 0.076*Longitud.A5^2 + 0.01153;
% Inercia.Flex_Ext_MusloI = 0.00762*Longitud.A1*Longitud.A4^2 ...
%     + 0.076*Longitud.A6^2 + 0.01153;
% % Aduccion Abduccion
% Inercia.Aduc_Abduc_MusloD = 0.00762*Longitud.A1*Longitud.A3^2 ...
%     + 0.076*Longitud.A5^2 + 0.01186;
% Inercia.Aduc_Abduc_MusloI = 0.00762*Longitud.A1*Longitud.A4^2 ...
%     + 0.076*Longitud.A6^2 + 0.01186;
% %Rotacion interna externa
% Inercia.Rotacion_MusloD = 0.00151*Longitud.A1*Longitud.A5^2 + 0.00305;
% Inercia.Rotacion_MusloI = 0.00151*Longitud.A1*Longitud.A6^2 + 0.00305;
% 
% %%%% ------ Piernas
% 
% % Flexion Extension
% Inercia.Flex_Ext_PiernaD = 0.00347*Longitud.A1*Longitud.A7^2 ...
%     + 0.076*Longitud.A9^2 + 0.00511;
% Inercia.Flex_Ext_PiernaI = 0.00347*Longitud.A1*Longitud.A8^2 ...
%     + 0.076*Longitud.A10^2 + 0.00511;
% % Aduccion Abduccion
% Inercia.Aduc_Abduc_PiernaD = 0.00387*Longitud.A1*Longitud.A7^2 ...
%     + 0.076*Longitud.A9^2 + 0.00138;
% Inercia.Aduc_Abduc_PiernaI = 0.00387*Longitud.A1*Longitud.A8^2 ...
%     + 0.076*Longitud.A10^2 + 0.00138;
% % Rotacion Interna Externa
% Inercia.Rotacion_PiernaD = 0.00041*Longitud.A1*Longitud*A9^2 + 0.00012;
% Inercia.Rotacion_PiernaI = 0.00041*Longitud.A1*Longitud*A10^2 + 0.00012;
% 
% %%%% ------ Pie
% % Flexion Extension
% Inercia.Flex_Ext_PieD = 0.00023*4*Longitud.A1*Longitud.A15^2 ...
%     + 3*Longitud.A13^2 + 0.00022;
% Inercia.Flex_Ext_PieI = 0.00023*4*Longitud.A1*Longitud.A16^2 ...
%     + 3*Longitud.A14^2 + 0.00022;
% Inercia.Aduc_Abduc_PieD = 0.00021*4*Longitud.A1*Longitud.A19^2 ...
%     + 3*Longitud.A13^2 + 0.00067;
% Inercia.Aduc_Abduc_PieI = 0.00021*4*Longitud.A1*Longitud.A20^2 ...
%     + 3*Longitud.A13^2 + 0.00067;
% Inercia.Rotacion_PieD = 0.00141*Longitud.A1*Longitud*A15^2 ...
%     + Longitud.A19^2 - 0.00008;
% Inercia.Rotacion_PieI = 0.00141*Longitud.A1*Longitud*A16^2 ...
%     + Longitud.A20^2 - 0.00008;