function [Puntos,Angulos,Vectores,Datos,FramesEventos,Inercia,Antropometria,Cinematica]  = Inicializacion_SegundaParte()

load('Datos_PrimeraParte.mat');
Puntos = Datos_PrimeraParte.Puntos;
Antropometria = Datos_PrimeraParte.Longitud;
Vectores = Datos_PrimeraParte.Vectores;
Angulos = Datos_PrimeraParte.Angulos;
FramesEventos = Datos_PrimeraParte.FramesEventos;
fm = Datos.info.Cinematica.frequency;

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

%............................... Puntos ...................................

    Puntos.CM.MusloD = FiltroPB(Puntos.CM.MusloD,fm,...
        FramesEventos.FrameRHS,FramesEventos.FrameLHS2);
    Puntos.CM.MusloI = FiltroPB(Puntos.CM.MusloI,fm,...
        FramesEventos.FrameRHS,FramesEventos.FrameLHS2);
    Puntos.CM.PantorrillaD = FiltroPB(Puntos.CM.PantorrillaD,fm,...
        FramesEventos.FrameRHS,FramesEventos.FrameLTO);
    Puntos.CM.PantorrillaI = FiltroPB(Puntos.CM.PantorrillaI,fm,...
        FramesEventos.FrameRHS,FramesEventos.FrameLHS2);
    Puntos.CM.PieD = FiltroPB(Puntos.CM.PieD,fm,...
        FramesEventos.FrameRHS,FramesEventos.FrameLTO);
    Puntos.CM.PieI = FiltroPB(Puntos.CM.PieI,fm,...
        FramesEventos.FrameRHS,FramesEventos.FrameLHS2);

%............................. Vectores ...................................

Vectores.I_Global = [1 0 0];
Vectores.J_Global = [0 1 0];
Vectores.K_Global = [0 0 1];

Vectores.LN_MusloD = zeros(size(Vectores.I_MusloD));
Vectores.LN_MusloI = zeros(size(Vectores.I_MusloI));

%............................. Angulos ....................................

% -------------- Muslo
Angulos.AlfaMusloD = zeros(length(Vectores.LN_MusloD),1);
Angulos.BetaMusloD = zeros(length(Vectores.LN_MusloD),1);
Angulos.GammaMusloD = zeros(length(Vectores.LN_MusloD),1);

Angulos.AlfaMusloI = zeros(length(Vectores.LN_MusloD),1);
Angulos.BetaMusloI = zeros(length(Vectores.LN_MusloD),1);
Angulos.GammaMusloI = zeros(length(Vectores.LN_MusloD),1);

%............................. Cinematica .................................

Cinematica.MusloD.V = zeros(size(Puntos.CM.MusloD));
Cinematica.MusloI.V = zeros(size(Puntos.CM.MusloI));


end
