function [Puntos,Angulos,Vectores,Datos,FramesEventos,Inercia,Antropometria,Cinematica,Matrices]  = Inicializacion_SegundaParte()

load('Datos_PrimeraParte.mat');
Puntos = Datos_PrimeraParte.Puntos;
Antropometria = Datos_PrimeraParte.Longitud;
Vectores = Datos_PrimeraParte.Vectores;
Angulos = Datos_PrimeraParte.Angulos;
FramesEventos = Datos_PrimeraParte.FramesEventos;
fm = Datos.info.Cinematica.frequency;

% ..................... Momentos de inercia y Masa ........................

Altura = Datos.antropometria.children.ALTURA.info.values; % en Cm
MasaTotal = Datos.antropometria.children.PESO.info.values;% en Kg

%%% Masa de Segmentos
Inercia.Masa.Muslo = -2.649 + 0.1463*MasaTotal + 0.0137*Altura;
Inercia.Masa.Pierna = -1.592 + 0.0362*MasaTotal + 0.0121*Altura;
Inercia.Masa.Pie = -0.829 + 0.0077*MasaTotal + 0.0073*Altura;
%%% en Kg*m^2

Inercia.Momento.XX_Muslo = (-13.5 + 11.3*MasaTotal - 2.28*Altura)/10000;
Inercia.Momento.YY_Muslo = (-3557 + 31.7*MasaTotal + 18.61*Altura)/10000;
Inercia.Momento.ZZ_Muslo = (-3690 + 32.02*MasaTotal+ 19.24*Altura)/10000;

Inercia.Momento.XX_Pierna = (70.5 + 1.134*MasaTotal + 0.3*Altura)/10000;
Inercia.Momento.YY_Pierna = (-1105 + 4.59*MasaTotal + 6.63*Altura)/10000;
Inercia.Momento.ZZ_Pierna = (-1152 + 4.594*MasaTotal + 6.815*Altura)/10000;

Inercia.Momento.XX_Pie = (-15.48 + 0.144*MasaTotal + 0.088*Altura)/10000;
Inercia.Momento.YY_Pie = (-100 + 0.480*MasaTotal + 0.626*Altura)/10000;
Inercia.Momento.ZZ_Pie = (-97.09 + 0.414*MasaTotal + 0.614*Altura)/10000;

Matrices.Inercia_Muslo = [Inercia.Momento.XX_Muslo 0 0;0 Inercia.Momento.YY_Muslo 0;0 0 Inercia.Momento.ZZ_Muslo];
Matrices.Inercia_Pierna = [Inercia.Momento.XX_Pierna 0 0;0 Inercia.Momento.YY_Pierna 0;0 0 Inercia.Momento.ZZ_Pierna];
Matrices.Inercia_Pie = [Inercia.Momento.XX_Pie 0 0;0 Inercia.Momento.YY_Pie 0;0 0 Inercia.Momento.ZZ_Pie];

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

Vectores.LN_PiernaD = zeros(size(Vectores.I_PiernaD));
Vectores.LN_PiernaI = zeros(size(Vectores.I_PiernaI));

Vectores.LN_PieD = zeros(size(Vectores.I_PieD));
Vectores.LN_PieI = zeros(size(Vectores.I_PieI));

%............................. Angulos ....................................

% ------------------------ Muslo
Angulos.AlfaMusloD = zeros(length(Vectores.LN_MusloD),1);
Angulos.BetaMusloD = zeros(length(Vectores.LN_MusloD),1);
Angulos.GammaMusloD = zeros(length(Vectores.LN_MusloD),1);

Angulos.AlfaMusloI = zeros(length(Vectores.LN_MusloD),1);
Angulos.BetaMusloI = zeros(length(Vectores.LN_MusloD),1);
Angulos.GammaMusloI = zeros(length(Vectores.LN_MusloD),1);

% ------------------------ Pierna

Angulos.AlfaPiernaD = zeros(length(Vectores.LN_PiernaD),1);
Angulos.BetaPiernaD = zeros(length(Vectores.LN_PiernaD),1);
Angulos.GammaPiernaD = zeros(length(Vectores.LN_PiernaD),1);

Angulos.AlfaPiernaI = zeros(length(Vectores.LN_PiernaD),1);
Angulos.BetaPiernaI = zeros(length(Vectores.LN_PiernaD),1);
Angulos.GammaPiernaI = zeros(length(Vectores.LN_PiernaD),1);

% ------------------------ Pie

Angulos.AlfaPieD = zeros(length(Vectores.LN_PieD),1);
Angulos.BetaPieD = zeros(length(Vectores.LN_PieD),1);
Angulos.GammaPieD = zeros(length(Vectores.LN_PieD),1);

Angulos.AlfaPieI = zeros(length(Vectores.LN_PieD),1);
Angulos.BetaPieI = zeros(length(Vectores.LN_PieD),1);
Angulos.GammaPieI = zeros(length(Vectores.LN_PieD),1);

%............................. Cinematica .................................

Cinematica.MusloD.V_lineal = zeros(size(Puntos.CM.MusloD));
Cinematica.MusloI.V_lineal = zeros(size(Puntos.CM.MusloI));


end
