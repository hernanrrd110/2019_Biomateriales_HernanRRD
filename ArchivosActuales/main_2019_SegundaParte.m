
%% -------------------------- Carga de datos -----------------------------
clear all; close all; clc;

[Puntos,Angulos,Vectores,Datos,FramesEventos,...
    Inercia,Antropometria,Cinematica]  = Inicializacion_SegundaParte();

FrameRHS = FramesEventos.FrameRHS;
FrameRHS2 = FramesEventos.FrameRHS2;
FrameRTO = FramesEventos.FrameRTO;

FrameLHS = FramesEventos.FrameLHS;
FrameLHS2 = FramesEventos.FrameLHS2;
FrameLTO = FramesEventos.FrameLTO;

fm = Datos.info.Cinematica.frequency;

%% .................. Calculos de Angulos Euler ...........................

% Inicializaciones


for i=1:length(Vectores.LN_MusloD)
    
    %-------------------------- Calculo Muslo
    Vectores.LN_MusloD(i,:) = cross(Vectores.K_MusloD(i,:),Vectores.K_Global);
    Vectores.LN_MusloD(i,:) = Vectores.LN_MusloD(i,:)/norm(Vectores.LN_MusloD(i,:));
    Vectores.LN_MusloI(i,:) = cross(Vectores.K_MusloI(i,:),Vectores.K_Global);
    Vectores.LN_MusloI(i,:) = Vectores.LN_MusloI(i,:)/norm(Vectores.LN_MusloI(i,:));
    
    % Alfas
    
    [Angulos.AlfaMusloD(i)]  = Angulos_Coseno(Vectores.I_Global,...
        Vectores.LN_MusloD(i,:),Vectores.J_Global);
    
    [Angulos.AlfaMusloI(i)]  = Angulos_Coseno(Vectores.I_Global,...
        Vectores.LN_MusloI(i,:),Vectores.J_Global);
    
    % Betas
    
    Angulos.BetaMusloD(i) = acosd(dot(Vectores.K_Global,Vectores.K_MusloD(i,:)));
    Angulos.BetaMusloI(i) = acosd(dot(Vectores.K_Global,Vectores.K_MusloI(i,:)));
    
    % Gammas
    
    [Angulos.GammaMusloD(i)]  = Angulos_Coseno(Vectores.I_MusloD(i,:),...
        Vectores.LN_MusloD(i,:),Vectores.J_MusloD(i,:));
   
    [Angulos.GammaMusloI(i)]  = Angulos_Coseno(Vectores.I_MusloI(i,:),...
        Vectores.LN_MusloI(i,:),Vectores.J_MusloI(i,:));
    
    %-------------------------- Calculo Pierna
    
    Vectores.LN_PiernaD(i,:) = cross(Vectores.K_PiernaD(i,:),Vectores.K_Global);
    Vectores.LN_PiernaD(i,:) = Vectores.LN_PiernaD(i,:)/norm(Vectores.LN_PiernaD(i,:));
    Vectores.LN_PiernaI(i,:) = cross(Vectores.K_PiernaI(i,:),Vectores.K_Global);
    Vectores.LN_PiernaI(i,:) = Vectores.LN_PiernaI(i,:)/norm(Vectores.LN_PiernaI(i,:));
    
        % Alfas
    
    [Angulos.AlfaPiernaD(i)]  = Angulos_Coseno(Vectores.I_Global,...
        Vectores.LN_PiernaD(i,:),Vectores.J_Global);
    
    [Angulos.AlfaPiernaI(i)]  = Angulos_Coseno(Vectores.I_Global,...
        Vectores.LN_PiernaI(i,:),Vectores.J_Global);
    
    % Betas
    
    Angulos.BetaPiernaD(i) = acosd(dot(Vectores.K_Global,Vectores.K_PiernaD(i,:)));
    Angulos.BetaPiernaI(i) = acosd(dot(Vectores.K_Global,Vectores.K_PiernaI(i,:)));
    
    % Gammas
    
    [Angulos.GammaPiernaD(i)]  = Angulos_Coseno(Vectores.I_PiernaD(i,:),...
        Vectores.LN_PiernaD(i,:),Vectores.J_PiernaD(i,:));
   
    [Angulos.GammaPiernaI(i)]  = Angulos_Coseno(Vectores.I_PiernaI(i,:),...
        Vectores.LN_PiernaI(i,:),Vectores.J_PiernaI(i,:));
    
    %-------------------------- Calculo Pie
    
    Vectores.LN_PieD(i,:) = cross(Vectores.K_PieD(i,:),Vectores.K_Global);
    Vectores.LN_PieD(i,:) = Vectores.LN_PieD(i,:)/norm(Vectores.LN_PieD(i,:));
    Vectores.LN_PieI(i,:) = cross(Vectores.K_PieI(i,:),Vectores.K_Global);
    Vectores.LN_PieI(i,:) = Vectores.LN_PieI(i,:)/norm(Vectores.LN_PieI(i,:));
    
        % Alfas
    
    [Angulos.AlfaPieD(i)]  = Angulos_Coseno(Vectores.I_Global,...
        Vectores.LN_PieD(i,:),Vectores.J_Global);
    
    [Angulos.AlfaPieI(i)]  = Angulos_Coseno(Vectores.I_Global,...
        Vectores.LN_PieI(i,:),Vectores.J_Global);
    
    % Betas
    
    Angulos.BetaPieD(i) = acosd(dot(Vectores.K_Global,Vectores.K_PieD(i,:)));
    Angulos.BetaPieI(i) = acosd(dot(Vectores.K_Global,Vectores.K_PieI(i,:)));
    
    % Gammas
    
    Angulos.GammaPieD(i) = asind(dot(cross(Vectores.LN_PieD(i,:),Vectores.I_PieD(i,:)),...
        Vectores.K_PieD(i,:)));
    
    Angulos.GammaPieI(i)  = asind(dot(cross(Vectores.LN_PieI(i,:),Vectores.I_PieI(i,:)),...
        Vectores.K_PieI(i,:)));
end

%% .......................... GRAFICAS EULER
%................ Graficas Muslo

subplot(3,1,1);
plot(Angulos.AlfaMusloD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.AlfaMusloI(FrameLHS:FrameLHS2)); hold on;

subplot(3,1,2);
plot(Angulos.BetaMusloD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.BetaMusloI(FrameLHS:FrameLHS2)); hold on;

subplot(3,1,3);
plot(Angulos.GammaMusloD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.GammaMusloI(FrameLHS:FrameLHS2)); 

%% ................ Graficas Pierna

subplot(3,1,1);
plot(Angulos.AlfaPiernaD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.AlfaPiernaI(FrameLHS:FrameLHS2)); hold on;

subplot(3,1,2);
plot(Angulos.BetaPiernaD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.BetaPiernaI(FrameLHS:FrameLHS2)); hold on;

subplot(3,1,3);
plot(Angulos.GammaPiernaD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.GammaPiernaI(FrameLHS:FrameLHS2));

%% ................ Graficas Pie

subplot(3,1,1);
plot(Angulos.AlfaPieD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.AlfaPieI(FrameLHS:FrameLHS2)); hold on;

subplot(3,1,2);
plot(Angulos.BetaPieD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.BetaPieI(FrameLHS:FrameLHS2)); hold on;

subplot(3,1,3);
plot(Angulos.GammaPieD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.GammaPieI(FrameLHS:FrameLHS2));

%% .................. Calculo de Velocidades y Aceleraciones lineales

tm = 1/fm;

for i=2:(length(Cinematica.MusloD.V)-1)
    
    Cinematica.MusloD.V(i,1) = (Puntos.CM.MusloD(i+1,1) - Puntos.CM.MusloD(i-1,1))/(2*tm);
    Cinematica.MusloD.V(i,2) = (Puntos.CM.MusloD(i+1,2) - Puntos.CM.MusloD(i-1,2))/(2*tm);
    Cinematica.MusloD.V(i,3) = (Puntos.CM.MusloD(i+1,3) - Puntos.CM.MusloD(i-1,3))/(2*tm);
    
    Cinematica.MusloI.V(i,1) = (Puntos.CM.MusloI(i+1,1) - Puntos.CM.MusloI(i-1,1))/(2*tm);
    Cinematica.MusloI.V(i,2) = (Puntos.CM.MusloI(i+1,2) - Puntos.CM.MusloI(i-1,2))/(2*tm);
    Cinematica.MusloI.V(i,3) = (Puntos.CM.MusloI(i+1,3) - Puntos.CM.MusloI(i-1,3))/(2*tm);

end

plot(Cinematica.MusloD.V(FrameRHS:FrameRHS2)); grid on; hold on;









