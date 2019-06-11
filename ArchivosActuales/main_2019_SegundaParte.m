
%% -------------------------- Carga de datos -----------------------------
clear all; close all; clc;

[Puntos,Angulos,Vectores,Datos,FrameEventos,...
    Inercia,Antropometria,Cinematica,Matrices]  = Inicializacion_SegundaParte();
PrimerFrame = FrameEventos.PrimerFrame ;
UltimoFrame = FrameEventos.UltimoFrame ;
FrameRHS = FrameEventos.FrameRHS;
FrameRHS2 = FrameEventos.FrameRHS2;
FrameRTO = FrameEventos.FrameRTO;

FrameLHS = FrameEventos.FrameLHS;
FrameLHS2 = FrameEventos.FrameLHS2;
FrameLTO = FrameEventos.FrameLTO;

fm = Datos.info.Cinematica.frequency;

%% .................. Calculos de Angulos Euler ...........................


for i=1:length(Vectores.LN_MusloD)
    
    %-------------------------- Calculo Muslo
    
    Vectores.LN_MusloD(i,:) = cross(Vectores.K_Global,Vectores.K_MusloD(i,:));
    Vectores.LN_MusloD(i,:) = Vectores.LN_MusloD(i,:)/norm(Vectores.LN_MusloD(i,:));
    Vectores.LN_MusloI(i,:) = cross(Vectores.K_Global,Vectores.K_MusloI(i,:));
    Vectores.LN_MusloI(i,:) = Vectores.LN_MusloI(i,:)/norm(Vectores.LN_MusloI(i,:));
    
    % Alfas
    
%     [Angulos.AlfaMusloD(i)]  = Angulos_Coseno(Vectores.I_Global,...
%         Vectores.LN_MusloD(i,:),Vectores.J_Global);
%     
%     [Angulos.AlfaMusloI(i)]  = Angulos_Coseno(Vectores.I_Global,...
%         Vectores.LN_MusloI(i,:),Vectores.J_Global);
    
    [Angulos.AlfaMusloD(i)]  = asind( dot(cross (Vectores.I_Global,Vectores.LN_MusloD(i,:)) ,Vectores.K_Global) );

    [Angulos.AlfaMusloI(i)]  = asind( dot(cross (Vectores.I_Global,Vectores.LN_MusloI(i,:)) ,Vectores.K_Global) );
    
    % Betas
    
    Angulos.BetaMusloD(i) = - acosd(dot(Vectores.K_Global,Vectores.K_MusloD(i,:)));
    Angulos.BetaMusloI(i) = - acosd(dot(Vectores.K_Global,Vectores.K_MusloI(i,:)));
    
    % Gammas
    
    [Angulos.GammaMusloD(i)]  = Angulos_Coseno(Vectores.I_MusloD(i,:),...
        Vectores.LN_MusloD(i,:),-Vectores.J_MusloD(i,:));
   
    [Angulos.GammaMusloI(i)]  = Angulos_Coseno(Vectores.I_MusloI(i,:),...
        Vectores.LN_MusloI(i,:),-Vectores.J_MusloI(i,:));
    
    %-------------------------- Calculo Pierna
    
    Vectores.LN_PiernaD(i,:) = cross(Vectores.K_Global,Vectores.K_PiernaD(i,:));
    Vectores.LN_PiernaD(i,:) = Vectores.LN_PiernaD(i,:)/norm(Vectores.LN_PiernaD(i,:));
    Vectores.LN_PiernaI(i,:) = cross(Vectores.K_Global,Vectores.K_PiernaI(i,:));
    Vectores.LN_PiernaI(i,:) = Vectores.LN_PiernaI(i,:)/norm(Vectores.LN_PiernaI(i,:));
    
        % Alfas
    
%     [Angulos.AlfaPiernaD(i)]  = Angulos_Coseno(Vectores.I_Global,...
%         Vectores.LN_PiernaD(i,:),Vectores.J_Global);
%     
%     [Angulos.AlfaPiernaI(i)]  = Angulos_Coseno(Vectores.I_Global,...
%         Vectores.LN_PiernaI(i,:),Vectores.J_Global);
    
      [Angulos.AlfaPiernaD(i)]  = asind( dot(cross (Vectores.I_Global,Vectores.LN_PiernaD(i,:)) ,Vectores.K_Global) );
      [Angulos.AlfaPiernaI(i)]  = asind( dot(cross (Vectores.I_Global,Vectores.LN_PiernaI(i,:)) ,Vectores.K_Global) );
    
    % Betas
    
    Angulos.BetaPiernaD(i) = - acosd(dot(Vectores.K_Global,Vectores.K_PiernaD(i,:)));
    Angulos.BetaPiernaI(i) = - acosd(dot(Vectores.K_Global,Vectores.K_PiernaI(i,:)));
    
    % Gammas
    
    [Angulos.GammaPiernaD(i)]  = Angulos_Coseno(Vectores.I_PiernaD(i,:),...
        Vectores.LN_PiernaD(i,:),-Vectores.J_PiernaD(i,:));
   
    [Angulos.GammaPiernaI(i)]  = Angulos_Coseno(Vectores.I_PiernaI(i,:),...
        Vectores.LN_PiernaI(i,:),-Vectores.J_PiernaI(i,:));
    
    %-------------------------- Calculo Pie
    
    Vectores.LN_PieD(i,:) = cross(Vectores.K_Global,Vectores.K_PieD(i,:));
    Vectores.LN_PieD(i,:) = Vectores.LN_PieD(i,:)/norm(Vectores.LN_PieD(i,:));
    Vectores.LN_PieI(i,:) = cross(Vectores.K_Global,Vectores.K_PieI(i,:));
    Vectores.LN_PieI(i,:) = Vectores.LN_PieI(i,:)/norm(Vectores.LN_PieI(i,:));
    
    % Alfas
    
%     [Angulos.AlfaPieD(i)]  = Angulos_Coseno(Vectores.I_Global,...
%         Vectores.LN_PieD(i,:),Vectores.J_Global);
%     
%     [Angulos.AlfaPieI(i)]  = Angulos_Coseno(Vectores.I_Global,...
%         Vectores.LN_PieI(i,:),Vectores.J_Global);

    [Angulos.AlfaPieD(i)]  = asind( dot(cross (Vectores.I_Global,Vectores.LN_PieD(i,:)) ,Vectores.K_Global) );
    [Angulos.AlfaPieI(i)]  = asind( dot(cross (Vectores.I_Global,Vectores.LN_PieI(i,:)) ,Vectores.K_Global) );

    
    % Betas
    
    Angulos.BetaPieD(i) = - acosd(dot(Vectores.K_Global,Vectores.K_PieD(i,:)));
    Angulos.BetaPieI(i) = - acosd(dot(Vectores.K_Global,Vectores.K_PieI(i,:)));
    
    % Gammas
    
    Angulos.GammaPieD(i) = asind(dot(cross(Vectores.LN_PieD(i,:),Vectores.I_PieD(i,:)),...
        -Vectores.K_PieD(i,:)));
    
    Angulos.GammaPieI(i)  = asind(dot(cross(Vectores.LN_PieI(i,:),Vectores.I_PieI(i,:)),...
        -Vectores.K_PieI(i,:)));
end

% ........... Derivadas Primera y Segunda de Angulos de Euler .............

%........... Derivadas Primeras

% Muslo 

Angulos.AlfaMusloD_Derivada = Derivada_Vector(Angulos.AlfaMusloD, fm);
Angulos.AlfaMusloI_Derivada = Derivada_Vector(Angulos.AlfaMusloI,fm);

Angulos.BetaMusloD_Derivada = Derivada_Vector(Angulos.BetaMusloD,fm);
Angulos.BetaMusloI_Derivada = Derivada_Vector(Angulos.BetaMusloI,fm);

Angulos.GammaMusloD_Derivada = Derivada_Vector(Angulos.GammaMusloD,fm);
Angulos.GammaMusloI_Derivada = Derivada_Vector(Angulos.GammaMusloI,fm);

% Pierna

Angulos.AlfaPiernaD_Derivada = Derivada_Vector(Angulos.AlfaPiernaD, fm);
Angulos.AlfaPiernaI_Derivada = Derivada_Vector(Angulos.AlfaPiernaI,fm);

Angulos.BetaPiernaD_Derivada = Derivada_Vector(Angulos.BetaPiernaD,fm);
Angulos.BetaPiernaI_Derivada = Derivada_Vector(Angulos.BetaPiernaI,fm);

Angulos.GammaPiernaD_Derivada = Derivada_Vector(Angulos.GammaPiernaD,fm);
Angulos.GammaPiernaI_Derivada = Derivada_Vector(Angulos.GammaPiernaI,fm);

% Pie

Angulos.AlfaPieD_Derivada = Derivada_Vector(Angulos.AlfaPieD, fm);
Angulos.AlfaPieI_Derivada = Derivada_Vector(Angulos.AlfaPieI,fm);

Angulos.BetaPieD_Derivada = Derivada_Vector(Angulos.BetaPieD,fm);
Angulos.BetaPieI_Derivada = Derivada_Vector(Angulos.BetaPieI,fm);

Angulos.GammaPieD_Derivada = Derivada_Vector(Angulos.GammaPieD,fm);
Angulos.GammaPieI_Derivada = Derivada_Vector(Angulos.GammaPieI,fm);

%% ................... Calculos Velocidades Angulares .....................
% Muslo
Matrices.Alfa_MusloD = zeros(3,3,length(Angulos.AlfaMusloD_Derivada));
Matrices.Beta_MusloD = zeros(3,3,length(Angulos.BetaMusloD_Derivada));
Matrices.Gamma_MusloD = zeros(3,3,length(Angulos.GammaMusloD_Derivada));

Matrices.Alfa_MusloI = zeros(3,3,length(Angulos.AlfaMusloI_Derivada));
Matrices.Beta_MusloI = zeros(3,3,length(Angulos.BetaMusloI_Derivada));
Matrices.Gamma_MusloI = zeros(3,3,length(Angulos.GammaMusloI_Derivada));

for i = 1:length(Angulos.AlfaMusloD_Derivada)
    
    %Alfa
    
    Matrices.Alfa_MusloD(1,1,i) = cosd(Angulos.AlfaMusloD(i));
    Matrices.Alfa_MusloD(2,2,i) = cosd(Angulos.AlfaMusloD(i));
    Matrices.Alfa_MusloD(1,2,i) = sind(Angulos.AlfaMusloD(i));
    Matrices.Alfa_MusloD(2,1,i) = - sind(Angulos.AlfaMusloD(i));
    Matrices.Alfa_MusloD(3,3,i) = 1;
    
    Matrices.Alfa_MusloI(1,1,i) = cosd(Angulos.AlfaMusloI(i));
    Matrices.Alfa_MusloI(2,2,i) = cosd(Angulos.AlfaMusloI(i));
    Matrices.Alfa_MusloI(1,2,i) = sind(Angulos.AlfaMusloI(i));
    Matrices.Alfa_MusloI(2,1,i) = - sind(Angulos.AlfaMusloI(i));
    Matrices.Alfa_MusloI(3,3,i) = 1;
    
    %Beta
    Matrices.Beta_MusloD(1,1,i) = 1;
    Matrices.Beta_MusloD(2,2,i) = cosd(Angulos.BetaMusloD(i));
    Matrices.Beta_MusloD(3,3,i) = cosd(Angulos.BetaMusloD(i));
    Matrices.Beta_MusloD(2,3,i) = sind(Angulos.BetaMusloD(i));
    Matrices.Beta_MusloD(3,2,i) = - sind(Angulos.BetaMusloD(i));
    
    Matrices.Beta_MusloI(1,1,i) = 1;
    Matrices.Beta_MusloI(2,2,i) = cosd(Angulos.BetaMusloI(i));
    Matrices.Beta_MusloI(3,3,i) = cosd(Angulos.BetaMusloI(i));
    Matrices.Beta_MusloI(2,3,i) = sind(Angulos.BetaMusloI(i));
    Matrices.Beta_MusloI(3,2,i) = - sind(Angulos.BetaMusloI(i));
    
    %Gamma
    
    Matrices.Gamma_MusloD(1,1,i) = cosd(Angulos.GammaMusloD(i));
    Matrices.Gamma_MusloD(2,2,i) = cosd(Angulos.GammaMusloD(i));
    Matrices.Gamma_MusloD(1,2,i) = - sind(Angulos.GammaMusloD(i));
    Matrices.Gamma_MusloD(2,1,i) = sind(Angulos.GammaMusloD(i));
    Matrices.Gamma_MusloD(3,3,i) = 1;
    
    Matrices.Gamma_MusloI(1,1,i) = cosd(Angulos.GammaMusloI(i));
    Matrices.Gamma_MusloI(2,2,i) = cosd(Angulos.GammaMusloI(i));
    Matrices.Gamma_MusloI(1,2,i) = sind(Angulos.GammaMusloI(i));
    Matrices.Gamma_MusloI(2,1,i) = - sind(Angulos.GammaMusloI(i));
    Matrices.Gamma_MusloI(3,3,i) = 1;
    
end

Cinematica.MusloD.V_angular = zeros(length(Angulos.AlfaMusloD_Derivada),3);
Cinematica.MusloI.V_angular = zeros(length(Angulos.AlfaMusloI_Derivada),3);

for i = 1:length(Angulos.AlfaMusloD_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaMusloD_Derivada(i)];
    VectorBeta = [Angulos.BetaMusloD_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaMusloD_Derivada(i)];
    
    VectorAlfa = Matrices.Beta_MusloD(:,:,i) * (VectorAlfa');
    VectorAlfa = ( Matrices.Gamma_MusloD(:,:,i) * (VectorAlfa) )';
    
    VectorBeta = ( Matrices.Gamma_MusloD(:,:,i) *(VectorBeta') )';
    
    Cinematica.MusloD.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
    
end

for i = 1:length(Angulos.AlfaMusloI_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaMusloI_Derivada(i)];
    VectorBeta = [Angulos.BetaMusloI_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaMusloI_Derivada(i)];
    
    VectorAlfa = Matrices.Beta_MusloI(:,:,i) * (VectorAlfa');
    VectorAlfa = ( Matrices.Gamma_MusloI(:,:,i) * (VectorAlfa) )';
    
    VectorBeta = ( Matrices.Gamma_MusloI(:,:,i) *(VectorBeta') )';
    
    Cinematica.MusloI.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
    
end

subplot(1,2,1)
plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,1),'r'); grid on; hold on;
plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,2),'g'); grid on; hold on;
plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,3),'b'); grid on;
subplot(1,2,2)
plot(Cinematica.MusloI.V_angular(FrameLHS:FrameLHS2,1),'r'); grid on; hold on;
plot(Cinematica.MusloI.V_angular(FrameLHS:FrameLHS2,2),'g'); grid on; hold on;
plot(Cinematica.MusloI.V_angular(FrameLHS:FrameLHS2,3),'b'); grid on;

Matrices.Rotacion.MusloD = zeros(size(Matrices.Alfa_MusloD));
for i = 1:length(Matrices.Rotacion.MusloD)
    Matrices.Rotacion.MusloD(:,:,i) = Matrices.Alfa_MusloD(:,:,i)*...
         Matrices.Beta_MusloD(:,:,i)* Matrices.Gamma_MusloD(:,:,i);
    Matrices.Rotacion.MusloD(:,:,i) = Matrices.Alfa_MusloD(:,:,i)*...
         Matrices.Beta_MusloD(:,:,i)* Matrices.Gamma_MusloD(:,:,i);
end

Matrices.Rotacion.MusloI = zeros(size(Matrices.Alfa_MusloI));
for i = 1:length(Matrices.Rotacion.MusloI)
    Matrices.Rotacion.MusloI(:,:,i) = Matrices.Alfa_MusloI(:,:,i)*...
         Matrices.Beta_MusloI(:,:,i)* Matrices.Gamma_MusloI(:,:,i);
    Matrices.Rotacion.MusloI(:,:,i) = Matrices.Alfa_MusloI(:,:,i)*...
         Matrices.Beta_MusloI(:,:,i)* Matrices.Gamma_MusloI(:,:,i);
end

%% ..................... Calculos Matrices Pierna .........................
 
Matrices.Alfa_PiernaD = zeros(3,3,length(Angulos.AlfaPiernaD_Derivada));
Matrices.Beta_PiernaD = zeros(3,3,length(Angulos.BetaPiernaD_Derivada));
Matrices.Gamma_PiernaD = zeros(3,3,length(Angulos.GammaPiernaD_Derivada));

Matrices.Alfa_PiernaI = zeros(3,3,length(Angulos.AlfaPiernaI_Derivada));
Matrices.Beta_PiernaI = zeros(3,3,length(Angulos.BetaPiernaI_Derivada));
Matrices.Gamma_PiernaI = zeros(3,3,length(Angulos.GammaPiernaI_Derivada));

for i = 1:length(Angulos.AlfaPiernaD_Derivada)
    
    %Alfa
    Matrices.Alfa_PiernaD(1,1,i) = cosd(Angulos.AlfaPiernaD(i));
    Matrices.Alfa_PiernaD(2,2,i) = cosd(Angulos.AlfaPiernaD(i));
    Matrices.Alfa_PiernaD(1,2,i) = sind(Angulos.AlfaPiernaD(i));
    Matrices.Alfa_PiernaD(2,1,i) = - sind(Angulos.AlfaPiernaD(i));
    Matrices.Alfa_PiernaD(3,3,i) = 1;
    
    Matrices.Alfa_PiernaI(1,1,i) = cosd(Angulos.AlfaPiernaI(i));
    Matrices.Alfa_PiernaI(2,2,i) = cosd(Angulos.AlfaPiernaI(i));
    Matrices.Alfa_PiernaI(1,2,i) = sind(Angulos.AlfaPiernaI(i));
    Matrices.Alfa_PiernaI(2,1,i) = - sind(Angulos.AlfaPiernaI(i));
    Matrices.Alfa_PiernaI(3,3,i) = 1;
    
    %Beta
    Matrices.Beta_PiernaD(1,1,i) = 1;
    Matrices.Beta_PiernaD(2,2,i) = cosd(Angulos.BetaPiernaD(i));
    Matrices.Beta_PiernaD(3,3,i) = cosd(Angulos.BetaPiernaD(i));
    Matrices.Beta_PiernaD(2,3,i) = sind(Angulos.BetaPiernaD(i));
    Matrices.Beta_PiernaD(3,2,i) = - sind(Angulos.BetaPiernaD(i));
    
    Matrices.Beta_PiernaI(1,1,i) = 1;
    Matrices.Beta_PiernaI(2,2,i) = cosd(Angulos.BetaPiernaI(i));
    Matrices.Beta_PiernaI(3,3,i) = cosd(Angulos.BetaPiernaI(i));
    Matrices.Beta_PiernaI(2,3,i) = sind(Angulos.BetaPiernaI(i));
    Matrices.Beta_PiernaI(3,2,i) = - sind(Angulos.BetaPiernaI(i));
    
    %Gamma
    
    Matrices.Gamma_PiernaD(1,1,i) = cosd(Angulos.GammaPiernaD(i));
    Matrices.Gamma_PiernaD(2,2,i) = cosd(Angulos.GammaPiernaD(i));
    Matrices.Gamma_PiernaD(1,2,i) = sind(Angulos.GammaPiernaD(i));
    Matrices.Gamma_PiernaD(2,1,i) = - sind(Angulos.GammaPiernaD(i));
    Matrices.Gamma_PiernaD(3,3,i) = 1;
    
    Matrices.Gamma_PiernaI(1,1,i) = cosd(Angulos.GammaPiernaI(i));
    Matrices.Gamma_PiernaI(2,2,i) = cosd(Angulos.GammaPiernaI(i));
    Matrices.Gamma_PiernaI(1,2,i) = sind(Angulos.GammaPiernaI(i));
    Matrices.Gamma_PiernaI(2,1,i) = - sind(Angulos.GammaPiernaI(i));
    Matrices.Gamma_PiernaI(3,3,i) = 1;
    
end

Cinematica.PiernaD.V_angular = zeros(length(Angulos.AlfaPiernaD_Derivada),3);
Cinematica.PiernaI.V_angular = zeros(length(Angulos.AlfaPiernaI_Derivada),3);

for i = 1:length(Angulos.AlfaPiernaD_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaPiernaD_Derivada(i)];
    VectorBeta = [Angulos.BetaPiernaD_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaPiernaD_Derivada(i)];
    
    VectorAlfa = Matrices.Beta_PiernaD(:,:,i) * (VectorAlfa');
    VectorAlfa = ( Matrices.Gamma_PiernaD(:,:,i) * (VectorAlfa) )';
    
    VectorBeta = ( Matrices.Gamma_PiernaD(:,:,i) *(VectorBeta') )';
    
    Cinematica.PiernaD.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
  
end

for i = 1:length(Angulos.AlfaPiernaI_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaPiernaI_Derivada(i)];
    VectorBeta = [Angulos.BetaPiernaI_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaPiernaI_Derivada(i)];
    
    VectorAlfa = Matrices.Beta_PiernaI(:,:,i) * (VectorAlfa');
    VectorAlfa = ( Matrices.Gamma_PiernaI(:,:,i) * (VectorAlfa) )';
    
    VectorBeta = ( Matrices.Gamma_PiernaI(:,:,i) *(VectorBeta') )';
    
    Cinematica.PiernaI.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
    
end

figure();
subplot(1,2,1)
plot(Cinematica.PiernaD.V_angular(FrameRHS:FrameRHS2,1),'r'); grid on; hold on;
plot(Cinematica.PiernaD.V_angular(FrameRHS:FrameRHS2,2),'g'); grid on; hold on;
plot(Cinematica.PiernaD.V_angular(FrameRHS:FrameRHS2,3)),'b'; grid on;
subplot(1,2,2)
plot(Cinematica.PiernaI.V_angular(FrameLHS:FrameLHS2,1),'r'); grid on; hold on;
plot(Cinematica.PiernaI.V_angular(FrameLHS:FrameLHS2,2),'g'); grid on; hold on;
plot(Cinematica.PiernaI.V_angular(FrameLHS:FrameLHS2,3),'b'); grid on;

Matrices.Rotacion.PiernaD = zeros(size(Matrices.Alfa_PiernaD));
for i = 1:length(Matrices.Rotacion.PiernaD)
    Matrices.Rotacion.PiernaD(:,:,i) = Matrices.Alfa_PiernaD(:,:,i)*...
         Matrices.Beta_PiernaD(:,:,i)* Matrices.Gamma_PiernaD(:,:,i);
    Matrices.Rotacion.PiernaD(:,:,i) = Matrices.Alfa_PiernaD(:,:,i)*...
         Matrices.Beta_PiernaD(:,:,i)* Matrices.Gamma_PiernaD(:,:,i);
end

Matrices.Rotacion.PiernaI = zeros(size(Matrices.Alfa_PiernaI));
for i = 1:length(Matrices.Rotacion.PiernaI)
    Matrices.Rotacion.PiernaI(:,:,i) = Matrices.Alfa_PiernaI(:,:,i)*...
         Matrices.Beta_PiernaI(:,:,i)* Matrices.Gamma_PiernaI(:,:,i);
    Matrices.Rotacion.PiernaI(:,:,i) = Matrices.Alfa_PiernaI(:,:,i)*...
         Matrices.Beta_PiernaI(:,:,i)* Matrices.Gamma_PiernaI(:,:,i);
end

%% ..................... Calculos Matrices Pie ............................

Matrices.Alfa_PieD = zeros(3,3,length(Angulos.AlfaPieD_Derivada));
Matrices.Beta_PieD = zeros(3,3,length(Angulos.BetaPieD_Derivada));
Matrices.Gamma_PieD = zeros(3,3,length(Angulos.GammaPieD_Derivada));

Matrices.Alfa_PieI = zeros(3,3,length(Angulos.AlfaPieI_Derivada));
Matrices.Beta_PieI = zeros(3,3,length(Angulos.BetaPieI_Derivada));
Matrices.Gamma_PieI = zeros(3,3,length(Angulos.GammaPieI_Derivada));

for i = 1:length(Angulos.AlfaPieD_Derivada)
    %Alfa
    Matrices.Alfa_PieD(1,1,i) = cosd(Angulos.AlfaPieD(i));
    Matrices.Alfa_PieD(2,2,i) = cosd(Angulos.AlfaPieD(i));
    Matrices.Alfa_PieD(1,2,i) = sind(Angulos.AlfaPieD(i));
    Matrices.Alfa_PieD(2,1,i) = - sind(Angulos.AlfaPieD(i));
    Matrices.Alfa_PieD(3,3,i) = 1;
    
    Matrices.Alfa_PieI(1,1,i) = cosd(Angulos.AlfaPieI(i));
    Matrices.Alfa_PieI(2,2,i) = cosd(Angulos.AlfaPieI(i));
    Matrices.Alfa_PieI(1,2,i) = sind(Angulos.AlfaPieI(i));
    Matrices.Alfa_PieI(2,1,i) = - sind(Angulos.AlfaPieI(i));
    Matrices.Alfa_PieI(3,3,i) = 1;
    
    %Beta
    
    Matrices.Beta_PieD(1,1,i) = 1;
    Matrices.Beta_PieD(2,2,i) = cosd(Angulos.BetaPieD(i));
    Matrices.Beta_PieD(3,3,i) = cosd(Angulos.BetaPieD(i));
    Matrices.Beta_PieD(2,3,i) = sind(Angulos.BetaPieD(i));
    Matrices.Beta_PieD(3,2,i) = - sind(Angulos.BetaPieD(i));
    
    Matrices.Beta_PieI(1,1,i) = 1;
    Matrices.Beta_PieI(2,2,i) = cosd(Angulos.BetaPieI(i));
    Matrices.Beta_PieI(3,3,i) = cosd(Angulos.BetaPieI(i));
    Matrices.Beta_PieI(2,3,i) = sind(Angulos.BetaPieI(i));
    Matrices.Beta_PieI(3,2,i) = - sind(Angulos.BetaPieI(i));
    
    %Gamma
    
    Matrices.Gamma_PieD(1,1,i) = cosd(Angulos.GammaPieD(i));
    Matrices.Gamma_PieD(2,2,i) = cosd(Angulos.GammaPieD(i));
    Matrices.Gamma_PieD(1,2,i) = sind(Angulos.GammaPieD(i));
    Matrices.Gamma_PieD(2,1,i) = - sind(Angulos.GammaPieD(i));
    Matrices.Gamma_PieD(3,3,i) = 1;
    
    Matrices.Gamma_PieI(1,1,i) = cosd(Angulos.GammaPieI(i));
    Matrices.Gamma_PieI(2,2,i) = cosd(Angulos.GammaPieI(i));
    Matrices.Gamma_PieI(1,2,i) = sind(Angulos.GammaPieI(i));
    Matrices.Gamma_PieI(2,1,i) = - sind(Angulos.GammaPieI(i));
    Matrices.Gamma_PieI(3,3,i) = 1;
    
end

Cinematica.PieD.V_angular = zeros(length(Angulos.AlfaPieD_Derivada),3);
Cinematica.PieI.V_angular = zeros(length(Angulos.AlfaPieI_Derivada),3);

for i = 1:length(Angulos.AlfaPieD_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaPieD_Derivada(i)];
    VectorBeta = [Angulos.BetaPieD_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaPieD_Derivada(i)];
    
    VectorAlfa = Matrices.Beta_PieD(:,:,i) * (VectorAlfa');
    VectorAlfa = ( Matrices.Gamma_PieD(:,:,i) * (VectorAlfa) )';
    
    VectorBeta = ( Matrices.Gamma_PieD(:,:,i) *(VectorBeta') )';
    
    Cinematica.PieD.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
    
end

for i = 1:length(Angulos.AlfaPieI_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaPieI_Derivada(i)];
    VectorBeta = [Angulos.BetaPieI_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaPieI_Derivada(i)];
    
    VectorAlfa = Matrices.Beta_PieI(:,:,i) * (VectorAlfa');
    VectorAlfa = ( Matrices.Gamma_PieI(:,:,i) * (VectorAlfa) )';
    
    VectorBeta = ( Matrices.Gamma_PieI(:,:,i) *(VectorBeta') )';
    
    Cinematica.PieI.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
    
end

Matrices.Rotacion.PieD = zeros(size(Matrices.Alfa_PieD));
for i = 1:length(Matrices.Rotacion.PieD)
    Matrices.Rotacion.PieD(:,:,i) = Matrices.Alfa_PieD(:,:,i)*...
         Matrices.Beta_PieD(:,:,i)* Matrices.Gamma_PieD(:,:,i);
    Matrices.Rotacion.PieD(:,:,i) = Matrices.Alfa_PieD(:,:,i)*...
         Matrices.Beta_PieD(:,:,i)* Matrices.Gamma_PieD(:,:,i);
end

Matrices.Rotacion.PieI = zeros(size(Matrices.Alfa_PieI));
for i = 1:length(Matrices.Rotacion.PieI)
    Matrices.Rotacion.PieI(:,:,i) = Matrices.Alfa_PieI(:,:,i)*...
         Matrices.Beta_PieI(:,:,i)* Matrices.Gamma_PieI(:,:,i);
    Matrices.Rotacion.PieI(:,:,i) = Matrices.Alfa_PieI(:,:,i)*...
         Matrices.Beta_PieI(:,:,i)* Matrices.Gamma_PieI(:,:,i);
end

subplot(1,2,1)
plot(Cinematica.PieI.V_angular(FrameLHS:FrameLHS2,1),'r'); grid on;  hold on;
plot(Cinematica.PieI.V_angular(FrameLHS:FrameLHS2,2),'g'); grid on; hold on;
plot(Cinematica.PieI.V_angular(FrameLHS:FrameLHS2,3),'b'); grid on;
title('izquierda')
subplot(1,2,2)
plot(Cinematica.PieD.V_angular(FrameRHS:FrameRHS2,1),'r'); grid on;  hold on;
plot(Cinematica.PieD.V_angular(FrameRHS:FrameRHS2,2),'g'); grid on; hold on;
plot(Cinematica.PieD.V_angular(FrameRHS:FrameRHS2,3),'b'); grid on;
title('derecha')

%% ........................ Momentos Angulares ............................

Dinamica.MusloD.H = zeros(size(Cinematica.MusloD.V_angular));
Dinamica.MusloI.H = zeros(size(Cinematica.MusloI.V_angular));
Dinamica.PiernaD.H = zeros(size(Cinematica.PiernaD.V_angular));
Dinamica.PiernaI.H = zeros(size(Cinematica.PiernaI.V_angular));
Dinamica.PieD.H = zeros(size(Cinematica.PieD.V_angular));
Dinamica.PieI.H = zeros(size(Cinematica.PieI.V_angular));

for i = 1:length(Dinamica.MusloD.H)
    
    Dinamica.MusloD.H(i,:) = (Matrices.Inercia_Muslo*(Cinematica.MusloD.V_angular(i,:))')';
    Dinamica.MusloI.H(i,:) = (Matrices.Inercia_Muslo*(Cinematica.MusloI.V_angular(i,:))')';

    Dinamica.PiernaD.H(i,:) = (Matrices.Inercia_Pierna*(Cinematica.PiernaD.V_angular(i,:))')';
    Dinamica.PiernaI.H(i,:) = (Matrices.Inercia_Pierna*(Cinematica.PiernaI.V_angular(i,:))')';

    Dinamica.PieD.H(i,:) = (Matrices.Inercia_Pie*(Cinematica.PieD.V_angular(i,:))')';
    Dinamica.PieI.H(i,:) = (Matrices.Inercia_Pie*(Cinematica.PieI.V_angular(i,:))')';
    
end

% Calculos de fuerzas netas

Dinamica.MusloD.M_neto = Derivada_Vector(Dinamica.MusloD.H, fm);
Dinamica.MusloI.M_neto = Derivada_Vector(Dinamica.MusloI.H, fm);

Dinamica.PiernaD.M_neto = Derivada_Vector(Dinamica.PiernaD.H, fm);
Dinamica.PiernaI.M_neto = Derivada_Vector(Dinamica.PiernaI.H, fm);

Dinamica.PieD.M_neto = Derivada_Vector(Dinamica.PieD.H, fm);
Dinamica.PieI.M_neto = Derivada_Vector(Dinamica.PieI.H, fm);


%% .................. Calculo de Velocidades y Aceleraciones lineales

% Velocidades Lineales 
Cinematica.MusloD.V_lineal = Derivada_Vector(Puntos.CM.MusloD, fm);
Cinematica.MusloI.V_lineal = Derivada_Vector(Puntos.CM.MusloI, fm);

Cinematica.PiernaD.V_lineal = Derivada_Vector(Puntos.CM.PantorrillaD, fm);
Cinematica.PiernaI.V_lineal = Derivada_Vector(Puntos.CM.PantorrillaI, fm);

Cinematica.PieD.V_lineal = Derivada_Vector(Puntos.CM.PieD, fm);
Cinematica.PieI.V_lineal = Derivada_Vector(Puntos.CM.PieI, fm);

% Aceleraciones Lineales

Cinematica.MusloD.A_lineal = Derivada_Vector(Cinematica.MusloD.V_lineal, fm);
Cinematica.MusloI.A_lineal = Derivada_Vector(Cinematica.MusloI.V_lineal, fm);

Cinematica.PiernaD.A_lineal = Derivada_Vector(Cinematica.PiernaD.V_lineal, fm);
Cinematica.PiernaI.A_lineal = Derivada_Vector(Cinematica.PiernaI.V_lineal, fm);

Cinematica.PieD.A_lineal = Derivada_Vector(Cinematica.PieD.V_lineal, fm);
Cinematica.PieI.A_lineal = Derivada_Vector(Cinematica.PieI.V_lineal, fm);

% plot(Cinematica.MusloD.V_lineal(FrameRHS:FrameRHS2,1)); grid on; hold on;
% plot(Cinematica.MusloD.A_lineal(FrameRHS:FrameRHS2,1)/5); grid on; hold on;

% Calculos de fuerzas netas

Dinamica.MusloD.F_neto = Inercia.Masa.Muslo * Cinematica.MusloD.A_lineal;
Dinamica.MusloI.F_neto = Inercia.Masa.Muslo * Cinematica.MusloI.A_lineal;

Dinamica.PiernaD.F_neto = Inercia.Masa.Pierna * Cinematica.PiernaD.A_lineal;
Dinamica.PiernaI.F_neto = Inercia.Masa.Pierna * Cinematica.PiernaI.A_lineal;

Dinamica.PieD.F_neto = Inercia.Masa.Pie * Cinematica.PieD.A_lineal;
Dinamica.PieI.F_neto = Inercia.Masa.Pie * Cinematica.PieD.A_lineal;

%% Fuerzas y Momentos de Plataformas

Dinamica.F_PlateD = zeros(length(Datos.Pasada.Plataformas(1).Crudos.channels.Fx1)/3,3);
Dinamica.F_PlateI = zeros(length(Datos.Pasada.Plataformas(2).Crudos.channels.Fx2)/3,3);

j = 1;
% Esta invertido las direcciones de X e Y
for i = 1:length(Dinamica.F_PlateD)
    Dinamica.F_PlateD(i,1) = (Datos.Pasada.Plataformas(1).Crudos.channels.Fy1(j)+...
        Datos.Pasada.Plataformas(1).Crudos.channels.Fy1(j+1)+...
        Datos.Pasada.Plataformas(1).Crudos.channels.Fy1(j+2))/3;
    Dinamica.F_PlateD(i,2) = (Datos.Pasada.Plataformas(1).Crudos.channels.Fx1(j)+...
        Datos.Pasada.Plataformas(1).Crudos.channels.Fx1(j+1)+...
        Datos.Pasada.Plataformas(1).Crudos.channels.Fx1(j+2))/3;
    Dinamica.F_PlateD(i,3) = (Datos.Pasada.Plataformas(1).Crudos.channels.Fz1(j)+...
        Datos.Pasada.Plataformas(1).Crudos.channels.Fz1(j+1)+...
        Datos.Pasada.Plataformas(1).Crudos.channels.Fz1(j+2))/3;
    j = j +3;
end

j = 1;
for i = 1:length(Dinamica.F_PlateI)
    Dinamica.F_PlateI(i,1) = (Datos.Pasada.Plataformas(2).Crudos.channels.Fy2(j)+...
        Datos.Pasada.Plataformas(2).Crudos.channels.Fy2(j+1)+...
        Datos.Pasada.Plataformas(2).Crudos.channels.Fy2(j+2))/3;
    Dinamica.F_PlateI(i,2) = (Datos.Pasada.Plataformas(2).Crudos.channels.Fx2(j)+...
        Datos.Pasada.Plataformas(2).Crudos.channels.Fx2(j+1)+...
        Datos.Pasada.Plataformas(2).Crudos.channels.Fx2(j+2))/3;
    Dinamica.F_PlateI(i,3) = (Datos.Pasada.Plataformas(2).Crudos.channels.Fz2(j)+...
        Datos.Pasada.Plataformas(2).Crudos.channels.Fz2(j+1)+...
        Datos.Pasada.Plataformas(2).Crudos.channels.Fz2(j+2))/3;
    j = j +3;
end

Dinamica.F_PlateD = Dinamica.F_PlateD(round(Datos.eventos.Derecho_RHS(1)*fm)-FrameRHS:...
    round(Datos.eventos.Derecho_RHS(1)*fm)-FrameRHS+length(Dinamica.PieD.F_neto)-1,:);
Dinamica.F_PlateI = Dinamica.F_PlateI(round(Datos.eventos.Derecho_RHS(1)*fm)-FrameRHS:...
    round(Datos.eventos.Derecho_RHS(1)*fm)-FrameRHS+length(Dinamica.PieD.F_neto)-1,:);

%% .............. Calculo de Fuerzas y Momentos Para Pie .................

Dinamica.PieD.F_Tobillo(:,1) = Dinamica.PieD.F_neto(:,1) - Dinamica.F_Plate(:,1); 
Dinamica.PieD.F_Tobillo(:,2) = Dinamica.PieD.F_neto(:,2) - Dinamica.F_Plate(:,2); 
Dinamica.PieD.F_Tobillo(:,3) = Dinamica.PieD.F_neto(:,3) + Inercia.Masa.Pie*9.8 - Dinamica.F_Plate(:,3);








%% .......................... GRAFICAS EULER

................ Graficas Muslo
subplot(3,1,1);
plot(Angulos.AlfaMusloD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.AlfaMusloI(FrameLHS:FrameLHS2)); hold on;
title('Angulo Alfa/fi Muslo');


subplot(3,1,2);
plot(Angulos.BetaMusloD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.BetaMusloI(FrameLHS:FrameLHS2)); hold on;
title('Angulo Beta/tita Muslo ');


subplot(3,1,3);
plot(Angulos.GammaMusloD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.GammaMusloI(FrameLHS:FrameLHS2)); 
title('Angulo Gamma/psi Muslo ');

%% ................ Graficas Pierna

figure()
subplot(3,1,1);
plot(Angulos.AlfaPiernaD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.AlfaPiernaI(FrameLHS:FrameLHS2)); hold on;
title('Angulo Alfa/fi Pierna');

subplot(3,1,2);
plot(Angulos.BetaPiernaD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.BetaPiernaI(FrameLHS:FrameLHS2)); hold on;
title('Angulo Beta/tita Pierna');

subplot(3,1,3);
plot(Angulos.GammaPiernaD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.GammaPiernaI(FrameLHS:FrameLHS2)); 
title('Angulo Gamma/psi Pierna');

%% ................ Graficas Pie
figure()
subplot(3,1,1);
plot(Angulos.AlfaPieD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.AlfaPieI(FrameLHS:FrameLHS2)); hold on;
title('Angulo Alfa/fi Pie');

subplot(3,1,2);
plot(Angulos.BetaPieD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.BetaPieI(FrameLHS:FrameLHS2)); hold on;
title('Angulo Beta/tita Pie');

subplot(3,1,3);
plot(Angulos.GammaPieD(FrameRHS:FrameRHS2)); grid on; hold on;
plot(Angulos.GammaPieI(FrameLHS:FrameLHS2));
title('Angulo Gamma/psi Pie');












