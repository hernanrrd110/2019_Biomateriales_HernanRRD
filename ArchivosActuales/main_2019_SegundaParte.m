
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