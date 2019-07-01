%% -------------------------- Carga de datos -----------------------------
clear all; close all; clc;

[Puntos,Angulos,Vectores,Datos,FrameEventos,...
    Inercia,Antropometria,Cinematica,Dinamica,Matrices]  = Inicializacion_SegundaParte();
PrimerFrame = FrameEventos.PrimerFrame ;
UltimoFrame = FrameEventos.UltimoFrame ;
FrameRHS = FrameEventos.FrameRHS;
FrameRHS2 = FrameEventos.FrameRHS2;
FrameRTO = FrameEventos.FrameRTO;

FrameLHS = FrameEventos.FrameLHS;
FrameLHS2 = FrameEventos.FrameLHS2;
FrameLTO = FrameEventos.FrameLTO;

fm = Datos.info.Cinematica.frequency;

Altura = Datos.antropometria.children.ALTURA.info.values; % en Cm
MasaTotal = Datos.antropometria.children.PESO.info.values;% en Kg

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
    % Cambiar Angulos
    
    [Angulos.AlfaMusloD(i)]  = asind( dot(cross (Vectores.LN_MusloD(i,:),Vectores.I_Global) ,Vectores.K_Global) );

    [Angulos.AlfaMusloI(i)]  = asind( dot(cross (Vectores.LN_MusloI(i,:),Vectores.I_Global),Vectores.K_Global) );
    
    % Betas
    
    Angulos.BetaMusloD(i) = acosd(dot(Vectores.K_Global,Vectores.K_MusloD(i,:)));
    Angulos.BetaMusloI(i) = acosd(dot(Vectores.K_Global,Vectores.K_MusloI(i,:)));
    
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
    % Cambiado de polaridad
    
      [Angulos.AlfaPiernaD(i)]  = asind( dot(cross (-Vectores.I_Global,Vectores.LN_PiernaD(i,:)) ,Vectores.K_Global) );
      [Angulos.AlfaPiernaI(i)]  = asind( dot(cross (-Vectores.I_Global,Vectores.LN_PiernaI(i,:)) ,Vectores.K_Global) );
    
    % Betas
    
    Angulos.BetaPiernaD(i) = acosd(dot(Vectores.K_Global,Vectores.K_PiernaD(i,:)));
    Angulos.BetaPiernaI(i) = acosd(dot(Vectores.K_Global,Vectores.K_PiernaI(i,:)));
    
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

% cambiado
    [Angulos.AlfaPieD(i)]  = asind( dot(cross (-Vectores.I_Global,Vectores.LN_PieD(i,:)) ,Vectores.K_Global) );
    [Angulos.AlfaPieI(i)]  = asind( dot(cross (-Vectores.I_Global,Vectores.LN_PieI(i,:)) ,Vectores.K_Global) );
    
    % Betas
    
    Angulos.BetaPieD(i) = acosd(dot(Vectores.K_Global,Vectores.K_PieD(i,:)));
    Angulos.BetaPieI(i) = acosd(dot(Vectores.K_Global,Vectores.K_PieI(i,:)));
    
    % Gammas
    % Hay que cambiar la polaridad
    Angulos.GammaPieD(i) = asind(dot(cross(Vectores.LN_PieD(i,:),Vectores.I_PieD(i,:)),...
        Vectores.K_PieD(i,:)));
    
    Angulos.GammaPieI(i)  = asind(dot(cross(Vectores.LN_PieI(i,:),Vectores.I_PieI(i,:)),...
        Vectores.K_PieI(i,:)));
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

%% .......................... GRAFICAS EULER 
% %................ Graficas Muslo
% subplot(3,1,1);
% plot(Angulos.AlfaMusloD(FrameRHS:FrameRHS2)); grid on; hold on;
% plot(Angulos.AlfaMusloI(FrameLHS:FrameLHS2)); hold on;
% title('Angulo Alfa/fi Muslo');
% legend('Ciclo Derecho','Ciclo Izquierdo')
% subplot(3,1,2);
% plot(Angulos.BetaMusloD(FrameRHS:FrameRHS2)); grid on; hold on;
% plot(Angulos.BetaMusloI(FrameLHS:FrameLHS2)); hold on;
% title('Angulo Beta/tita Muslo ');
% legend('Ciclo Derecho','Ciclo Izquierdo')
% subplot(3,1,3);
% plot(Angulos.GammaMusloD(FrameRHS:FrameRHS2)); grid on; hold on;
% plot(Angulos.GammaMusloI(FrameLHS:FrameLHS2)); 
% title('Angulo Gamma/psi Muslo ');
% legend('Ciclo Derecho','Ciclo Izquierdo')
% 
% % ................ Graficas Euler Pierna
% 
% figure()
% subplot(3,1,1);
% plot(Angulos.AlfaPiernaD(FrameRHS:FrameRHS2)); grid on; hold on;
% plot(Angulos.AlfaPiernaI(FrameLHS:FrameLHS2)); hold on;
% title('Angulo Alfa/fi Pierna');
% legend('Ciclo Derecho','Ciclo Izquierdo')
% subplot(3,1,2);
% plot(Angulos.BetaPiernaD(FrameRHS:FrameRHS2)); grid on; hold on;
% plot(Angulos.BetaPiernaI(FrameLHS:FrameLHS2)); hold on;
% title('Angulo Beta/tita Pierna');
% legend('Ciclo Derecho','Ciclo Izquierdo')
% subplot(3,1,3);
% plot(Angulos.GammaPiernaD(FrameRHS:FrameRHS2)); grid on; hold on;
% plot(Angulos.GammaPiernaI(FrameLHS:FrameLHS2)); 
% title('Angulo Gamma/psi Pierna');
% legend('Ciclo Derecho','Ciclo Izquierdo')
% 
% % ................ Graficas Euler Pie
% 
% figure()
% subplot(3,1,1);
% plot(Angulos.AlfaPieD(FrameRHS:FrameRHS2)); grid on; hold on;
% plot(Angulos.AlfaPieI(FrameLHS:FrameLHS2)); hold on;
% title('Angulo Alfa/fi Pie');
% legend('Ciclo Derecho','Ciclo Izquierdo')
% 
% subplot(3,1,2);
% plot(Angulos.BetaPieD(FrameRHS:FrameRHS2)); grid on; hold on;
% plot(Angulos.BetaPieI(FrameLHS:FrameLHS2)); hold on;
% title('Angulo Beta/tita Pie');
% legend('Ciclo Derecho','Ciclo Izquierdo')
% 
% subplot(3,1,3);
% plot(Angulos.GammaPieD(FrameRHS:FrameRHS2)); grid on; hold on;
% plot(Angulos.GammaPieI(FrameLHS:FrameLHS2));
% title('Angulo Gamma/psi Pie');
% legend('Ciclo Derecho','Ciclo Izquierdo')

%% ................... Calculos Velocidades Angulares .....................
% Muslo

for i = 1:length(Angulos.AlfaMusloD_Derivada)
    %Gamma
    
    Matrices.Gamma_MusloD(1,1,i) = cosd(Angulos.GammaMusloD(i));
    Matrices.Gamma_MusloD(2,2,i) = cosd(Angulos.GammaMusloD(i));
    Matrices.Gamma_MusloD(1,2,i) = sind(Angulos.GammaMusloD(i));
    Matrices.Gamma_MusloD(2,1,i) = - sind(Angulos.GammaMusloD(i));
    Matrices.Gamma_MusloD(3,3,i) = 1;
    
    Matrices.Gamma_MusloI(1,1,i) = cosd(Angulos.GammaMusloI(i));
    Matrices.Gamma_MusloI(2,2,i) = cosd(Angulos.GammaMusloI(i));
    Matrices.Gamma_MusloI(1,2,i) = sind(Angulos.GammaMusloI(i));
    Matrices.Gamma_MusloI(2,1,i) = - sind(Angulos.GammaMusloI(i));
    Matrices.Gamma_MusloI(3,3,i) = 1;
    
end

for i = 1:length(Matrices.Rotacion.MusloD)
    
    Matrices.Rotacion.MusloD(1,:,i) = Vectores.I_MusloD(i,:);
    Matrices.Rotacion.MusloD(2,:,i) = Vectores.J_MusloD(i,:);
    Matrices.Rotacion.MusloD(3,:,i) = Vectores.K_MusloD(i,:);
    
    Matrices.Rotacion.MusloI(1,:,i) = Vectores.I_MusloI(i,:);
    Matrices.Rotacion.MusloI(2,:,i) = Vectores.J_MusloI(i,:);
    Matrices.Rotacion.MusloI(3,:,i) = Vectores.K_MusloI(i,:);
    
end

for i = 1:length(Angulos.AlfaMusloD_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaMusloD_Derivada(i)];
    VectorBeta = [Angulos.BetaMusloD_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaMusloD_Derivada(i)];
    
    VectorAlfa = (Matrices.Rotacion.MusloD(:,:,i) * (VectorAlfa'))';
    
    VectorBeta = ( Matrices.Gamma_MusloD(:,:,i) *(VectorBeta') )';
    
    Cinematica.MusloD.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
    
end

for i = 1:length(Angulos.AlfaMusloI_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaMusloI_Derivada(i)];
    VectorBeta = [Angulos.BetaMusloI_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaMusloI_Derivada(i)];
    
    VectorAlfa = (Matrices.Rotacion.MusloI(:,:,i) * (VectorAlfa'))';
    
    VectorBeta = ( Matrices.Gamma_MusloI(:,:,i) *(VectorBeta') )';
    
    Cinematica.MusloI.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
    
end

% ---- Graficas
% figure('Name','Vel Ang Muslos','NumberTitle','off')
% subplot(1,2,1)
% plot(Cinematica.MusloI.V_angular(FrameLHS:FrameLHS2,1),'r'); grid on; hold on;
% plot(Cinematica.MusloI.V_angular(FrameLHS:FrameLHS2,2),'g'); grid on; hold on;
% plot(Cinematica.MusloI.V_angular(FrameLHS:FrameLHS2,3),'b'); grid on;
% title('Vel Ang Muslo izquierdo')
% legend('Eje i','Eje j','Eje k')
% subplot(1,2,2)
% plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,1),'r'); grid on; hold on;
% plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,2),'g'); grid on; hold on;
% plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,3),'b'); grid on;
% title('Vel Ang Muslo derecho')
% legend('Eje i','Eje j','Eje k')

%% ..................... Calculos Matrices Pierna .........................

for i = 1:length(Angulos.AlfaPiernaD_Derivada)
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

for i = 1:length(Matrices.Rotacion.PiernaD)
    
    Matrices.Rotacion.PiernaD(1,:,i) = Vectores.I_PiernaD(i,:);
    Matrices.Rotacion.PiernaD(2,:,i) = Vectores.J_PiernaD(i,:);
    Matrices.Rotacion.PiernaD(3,:,i) = Vectores.K_PiernaD(i,:);
    
    Matrices.Rotacion.PiernaI(1,:,i) = Vectores.I_PiernaI(i,:);
    Matrices.Rotacion.PiernaI(2,:,i) = Vectores.J_PiernaI(i,:);
    Matrices.Rotacion.PiernaI(3,:,i) = Vectores.K_PiernaI(i,:);
    
end

for i = 1:length(Angulos.AlfaPiernaD_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaPiernaD_Derivada(i)];
    VectorBeta = [Angulos.BetaPiernaD_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaPiernaD_Derivada(i)];

    VectorAlfa = ( Matrices.Rotacion.PiernaD(:,:,i) * (VectorAlfa)' )';
    
    VectorBeta = ( Matrices.Gamma_PiernaD(:,:,i) *(VectorBeta') )';
    
    Cinematica.PiernaD.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
  
end

for i = 1:length(Angulos.AlfaPiernaI_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaPiernaI_Derivada(i)];
    VectorBeta = [Angulos.BetaPiernaI_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaPiernaI_Derivada(i)];
    
    VectorAlfa = ( Matrices.Rotacion.PiernaI(:,:,i) * (VectorAlfa)' )';
    
    VectorBeta = ( Matrices.Gamma_PiernaI(:,:,i) *(VectorBeta') )';
    
    Cinematica.PiernaI.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
    
end

%---------- Graficas
% figure('Name','Vel Angulares Piernas','NumberTitle','off');
% subplot(1,2,1)
% plot(Cinematica.PiernaI.V_angular(FrameLHS:FrameLHS2,1),'r'); grid on; hold on;
% plot(Cinematica.PiernaI.V_angular(FrameLHS:FrameLHS2,2),'g'); grid on; hold on;
% plot(Cinematica.PiernaI.V_angular(FrameLHS:FrameLHS2,3),'b'); grid on;
% title('Pierna izquierda')
% legend('Eje i','Eje j','Eje k')
% subplot(1,2,2)
% plot(Cinematica.PiernaD.V_angular(FrameRHS:FrameRHS2,1),'r'); grid on; hold on;
% plot(Cinematica.PiernaD.V_angular(FrameRHS:FrameRHS2,2),'g'); grid on; hold on;
% plot(Cinematica.PiernaD.V_angular(FrameRHS:FrameRHS2,3),'b'); grid on;
% title('Pierna derecha')
% legend('Eje i','Eje j','Eje k')

%% ..................... Calculos Matrices Pie ............................

for i = 1:length(Matrices.Rotacion.PieD)
    
    Matrices.Rotacion.PieD(1,:,i) = Vectores.I_PieD(i,:);
    Matrices.Rotacion.PieD(2,:,i) = Vectores.J_PieD(i,:);
    Matrices.Rotacion.PieD(3,:,i) = Vectores.K_PieD(i,:);
    
    Matrices.Rotacion.PieI(1,:,i) = Vectores.I_PieI(i,:);
    Matrices.Rotacion.PieI(2,:,i) = Vectores.J_PieI(i,:);
    Matrices.Rotacion.PieI(3,:,i) = Vectores.K_PieI(i,:);
    
end

for i = 1:length(Angulos.AlfaPieD_Derivada)
    
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

for i = 1:length(Angulos.AlfaPieD_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaPieD_Derivada(i)];
    VectorBeta = [Angulos.BetaPieD_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaPieD_Derivada(i)];
    
    VectorAlfa = ( Matrices.Rotacion.PieD(:,:,i) * (VectorAlfa)' )';
    
    VectorBeta = ( Matrices.Gamma_PieD(:,:,i) *(VectorBeta') )';
    
    Cinematica.PieD.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
    
end

for i = 1:length(Angulos.AlfaPieI_Derivada)
    
    VectorAlfa = [0 0 Angulos.AlfaPieI_Derivada(i)];
    VectorBeta = [Angulos.BetaPieI_Derivada(i) 0 0];
    VectorGamma = [0 0 Angulos.GammaPieI_Derivada(i)];
    
    
    VectorAlfa = ( Matrices.Rotacion.PieI(:,:,i) * (VectorAlfa)' )';
    
    VectorBeta = ( Matrices.Gamma_PieI(:,:,i) *(VectorBeta') )';
    
    Cinematica.PieI.V_angular(i,:) = VectorAlfa + VectorBeta + VectorGamma;
    
end

% -------- Graficas

figure('Name','Vel Angulares Pies','NumberTitle','off');
subplot(1,2,1)
plot(Cinematica.PieI.V_angular(FrameLHS:FrameLHS2,1),'r'); grid on;  hold on;
plot(Cinematica.PieI.V_angular(FrameLHS:FrameLHS2,2),'g'); grid on; hold on;
plot(Cinematica.PieI.V_angular(FrameLHS:FrameLHS2,3),'b'); grid on;
title('Pie izquierdo')
legend('Eje i','Eje j','Eje k')
subplot(1,2,2)
plot(Cinematica.PieD.V_angular(FrameRHS:FrameRHS2,1),'r'); grid on;  hold on;
plot(Cinematica.PieD.V_angular(FrameRHS:FrameRHS2,2),'g'); grid on; hold on;
plot(Cinematica.PieD.V_angular(FrameRHS:FrameRHS2,3),'b'); grid on;
title('Pie derecho')
legend('Eje i','Eje j','Eje k')


%% ........................ Momentos Angulares ............................

for i = 1:length(Dinamica.MusloD.H)
    
    Dinamica.MusloD.H(i,:) = (Matrices.Inercia_Muslo*(Cinematica.MusloD.V_angular(i,:)*pi/180)')';
    Dinamica.MusloI.H(i,:) = (Matrices.Inercia_Muslo*(Cinematica.MusloI.V_angular(i,:)*pi/180)')';

    Dinamica.PiernaD.H(i,:) = (Matrices.Inercia_Pierna*(Cinematica.PiernaD.V_angular(i,:)*pi/180)')';
    Dinamica.PiernaI.H(i,:) = (Matrices.Inercia_Pierna*(Cinematica.PiernaI.V_angular(i,:)*pi/180)')';

    Dinamica.PieD.H(i,:) = (Matrices.Inercia_Pie*(Cinematica.PieD.V_angular(i,:)*pi/180)')';
    Dinamica.PieI.H(i,:) = (Matrices.Inercia_Pie*(Cinematica.PieI.V_angular(i,:)*pi/180)')';
    
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
Dinamica.PieI.F_neto = Inercia.Masa.Pie * Cinematica.PieI.A_lineal;

%% Fuerzas Momentos y Puntos de Presion de Plataformas

Dinamica.F_PlateD = zeros(length(Datos.Pasada.Plataformas(1).Crudos.channels.Fx1)/3,3);
Dinamica.F_PlateI = zeros(length(Datos.Pasada.Plataformas(2).Crudos.channels.Fx2)/3,3);
Dinamica.M_PlateD = zeros(length(Datos.Pasada.Plataformas(1).Crudos.channels.Fx1)/3,3);
Dinamica.M_PlateI = zeros(length(Datos.Pasada.Plataformas(2).Crudos.channels.Fx2)/3,3);

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

j = 1;
for i = 1:length(Dinamica.M_PlateD)
    Dinamica.M_PlateD(i,1) = 0;
    Dinamica.M_PlateD(i,2) = 0;
    Dinamica.M_PlateD(i,3) = (Datos.Pasada.Plataformas(1).Crudos.channels.Mz1(j)+...
        Datos.Pasada.Plataformas(1).Crudos.channels.Mz1(j+1)+...
        Datos.Pasada.Plataformas(1).Crudos.channels.Mz1(j+2))/3;
    j = j +3;
end

j = 1;
for i = 1:length(Dinamica.M_PlateI)
    Dinamica.M_PlateI(i,1) = 0;
    Dinamica.M_PlateI(i,2) = 0;
    Dinamica.M_PlateI(i,3) = (Datos.Pasada.Plataformas(2).Crudos.channels.Mz2(j)+...
        Datos.Pasada.Plataformas(2).Crudos.channels.Mz2(j+1)+...
        Datos.Pasada.Plataformas(2).Crudos.channels.Mz2(j+2))/3;
    j = j +3;
end

% Acotamos a los registros sin NaN
% Se invierte los momentos de las placas por ser momentos de accion del pie
% sobre el piso, y se divide por 1000 para pasar de Nmm a Nm

Dinamica.M_PlateD = -Dinamica.M_PlateD(PrimerFrame:UltimoFrame,:)/1000; 
Dinamica.M_PlateI = -Dinamica.M_PlateI(PrimerFrame:UltimoFrame,:)/1000; 
Dinamica.F_PlateD = Dinamica.F_PlateD(PrimerFrame:UltimoFrame,:);
Dinamica.F_PlateI = Dinamica.F_PlateI(PrimerFrame:UltimoFrame,:);
Dinamica.F_PlateD(:,3) = -Dinamica.F_PlateD(:,3);
Dinamica.F_PlateI(:,3) = -Dinamica.F_PlateI(:,3);

Puntos.PlateD = Datos.Pasada.Marcadores.Crudos.rGr(PrimerFrame:UltimoFrame,:);
% Puntos.PlateD(:,2) = Puntos.PlateD(:,2) + 0.02; % Correcion por corrimiento
Puntos.PlateD(:,3) = 0; 
Puntos.PlateI = Datos.Pasada.Marcadores.Crudos.lGr(PrimerFrame:UltimoFrame,:);
% Puntos.PlateI(:,2) = Puntos.PlateI(:,2) + 0.02; % Correcion por corrimiento
Puntos.PlateI(:,3) = 0; 

for i=1:length(Puntos.PlateD)
    if((isnan(Puntos.PlateD(i,1))) == true)
        Puntos.PlateD(i,:) = [0 0 0];
    end
    if((isnan(Puntos.PlateI(i,1))) == true)
        Puntos.PlateI(i,:) = [0 0 0];
    end
end

% Dinamica.F_PlateD = FiltroPB(Dinamica.F_PlateD,fm,FrameRHS,FrameLHS2);
% Dinamica.F_PlateI = FiltroPB(Dinamica.F_PlateI,fm,FrameRHS,FrameLHS2);

figure('Name','Reaccion de Placas');
subplot(1,2,1)
plot(Dinamica.F_PlateI(FrameLHS:FrameLHS2,1),'r'); hold on;
plot(Dinamica.F_PlateI(FrameLHS:FrameLHS2,2),'g'); hold on;
plot(Dinamica.F_PlateI(FrameLHS:FrameLHS2,3),'b'); 
legend('x','y','z');
title('Reaccion izquierdo');
subplot(1,2,2)
plot(Dinamica.F_PlateD(FrameRHS:FrameRHS2,1),'r'); hold on;
plot(Dinamica.F_PlateD(FrameRHS:FrameRHS2,2),'g'); hold on;
plot(Dinamica.F_PlateD(FrameRHS:FrameRHS2,3),'b'); 
legend('x','y','z');
title('Reaccion derecho');

%% .............. Calculo de Fuerzas y Momentos Para Pie .................

Dinamica.PieD.F_Tobillo(:,1) = Dinamica.PieD.F_neto(:,1) - Dinamica.F_PlateD(:,1); 
Dinamica.PieD.F_Tobillo(:,2) = Dinamica.PieD.F_neto(:,2) - Dinamica.F_PlateD(:,2); 
Dinamica.PieD.F_Tobillo(:,3) = Dinamica.PieD.F_neto(:,3) + Inercia.Masa.Pie*9.81 - Dinamica.F_PlateD(:,3);

Dinamica.PieI.F_Tobillo(:,1) = Dinamica.PieI.F_neto(:,1) - Dinamica.F_PlateI(:,1); 
Dinamica.PieI.F_Tobillo(:,2) = Dinamica.PieI.F_neto(:,2) - Dinamica.F_PlateI(:,2); 
Dinamica.PieI.F_Tobillo(:,3) = Dinamica.PieI.F_neto(:,3) + Inercia.Masa.Pie*9.81 - Dinamica.F_PlateI(:,3);

% Brazos de Momento

Dinamica.PieD.BrazoProx = Puntos.Articu.TobilloD - Puntos.CM.PieD;
Dinamica.PieI.BrazoProx = Puntos.Articu.TobilloI - Puntos.CM.PieI;

Dinamica.PieD.BrazoDist = Puntos.PlateD - Puntos.CM.PieD;
Dinamica.PieI.BrazoDist = Puntos.PlateI - Puntos.CM.PieI;
% 
% Dinamica.PieD.BrazoDist = FiltroPB(Dinamica.PieD.BrazoDist,fm,FrameRHS,FrameRHS2);
% Dinamica.PieI.BrazoDist = FiltroPB(Dinamica.PieI.BrazoDist,fm,FrameLHS,FrameLHS2);
% Momento Residual

Dinamica.PieD.M_Residual = zeros(size(Dinamica.PieD.F_Tobillo));
Dinamica.PieI.M_Residual = zeros(size(Dinamica.PieI.F_Tobillo));

for i=1:length(Dinamica.PieD.M_Residual)
    
    % Calculo de momento residual
    Dinamica.PieD.M_Residual(i,:) = Dinamica.M_PlateD(i,:) + ...
        cross(Dinamica.PieD.BrazoProx(i,:),Dinamica.PieD.F_Tobillo(i,:))+ ...
        cross(Dinamica.PieD.BrazoDist(i,:),Dinamica.F_PlateD(i,:));

    Dinamica.PieI.M_Residual(i,:) = Dinamica.M_PlateI(i,:) + ...
        cross(Dinamica.PieI.BrazoProx(i,:),Dinamica.PieI.F_Tobillo(i,:))+ ...
        cross(Dinamica.PieI.BrazoDist(i,:),Dinamica.F_PlateI(i,:));

    % calculo de Momento en tobillo
    Dinamica.PieD.M_Tobillo(i,:) = Dinamica.PieD.M_neto(i,:) - ( Matrices.Rotacion.PieD(:,:,i)*(Dinamica.PieD.M_Residual(i,:))' )';
    Dinamica.PieI.M_Tobillo(i,:) = Dinamica.PieI.M_neto(i,:) - ( Matrices.Rotacion.PieI(:,:,i)*(Dinamica.PieI.M_Residual(i,:))')';
    
    %Pasaje de Local a Global
    
    Dinamica.PieD.M_Tobillo(i,:) = ( (Matrices.Rotacion.PieD(:,:,i))' * (Dinamica.PieD.M_Tobillo(i,:))' )';
    Dinamica.PieI.M_Tobillo(i,:) = ( (Matrices.Rotacion.PieI(:,:,i))' * (Dinamica.PieI.M_Tobillo(i,:))' )';

end

% --- Fuerzas Pie

Dinamica.PieD.F_TobilloPrxDis = zeros(length(Dinamica.PieD.F_Tobillo),1);
Dinamica.PieD.F_TobilloMedLat = zeros(length(Dinamica.PieD.F_Tobillo),1);
Dinamica.PieD.F_TobilloAntPos = zeros(length(Dinamica.PieD.F_Tobillo),1);

Dinamica.PieI.F_TobilloPrxDis = zeros(length(Dinamica.PieI.F_Tobillo),1);
Dinamica.PieI.F_TobilloMedLat = zeros(length(Dinamica.PieI.F_Tobillo),1);
Dinamica.PieI.F_TobilloAntPos = zeros(length(Dinamica.PieI.F_Tobillo),1);

for i=1:length(Dinamica.PieD.F_Tobillo)
    
    Dinamica.PieD.F_TobilloPrxDis(i) = dot(Dinamica.PieD.F_Tobillo(i,:),Vectores.I_PieD(i,:));
    Dinamica.PieD.F_TobilloMedLat(i) = dot(Dinamica.PieD.F_Tobillo(i,:),Vectores.K_PiernaD(i,:));
    Dinamica.PieD.F_TobilloAntPos(i) = dot(Dinamica.PieD.F_Tobillo(i,:),Vectores.L_AJC_D(i,:));

    Dinamica.PieI.F_TobilloPrxDis(i) = dot(Dinamica.PieI.F_Tobillo(i,:),Vectores.I_PieI(i,:));
    Dinamica.PieI.F_TobilloMedLat(i) = - dot(Dinamica.PieI.F_Tobillo(i,:),Vectores.K_PiernaI(i,:));
    Dinamica.PieI.F_TobilloAntPos(i) = dot(Dinamica.PieI.F_Tobillo(i,:),Vectores.L_AJC_I(i,:));

end

% --- Momentos Pie

Dinamica.PieD.M_TobilloInvEve = zeros(length(Dinamica.PieD.M_Tobillo),1);
Dinamica.PieD.M_TobilloPlaDor = zeros(length(Dinamica.PieD.M_Tobillo),1);
Dinamica.PieD.M_TobilloVarVal = zeros(length(Dinamica.PieD.M_Tobillo),1);

Dinamica.PieI.M_TobilloInvEve = zeros(length(Dinamica.PieI.M_Tobillo),1);
Dinamica.PieI.M_TobilloPlaDor = zeros(length(Dinamica.PieI.M_Tobillo),1);
Dinamica.PieI.M_TobilloVarVal = zeros(length(Dinamica.PieI.M_Tobillo),1);

for i=1:length(Dinamica.PieD.M_Tobillo)

    Dinamica.PieD.M_TobilloInvEve(i) = dot(Dinamica.PieD.M_Tobillo(i,:),Vectores.I_PieD(i,:));
    Dinamica.PieD.M_TobilloPlaDor(i) = dot(Dinamica.PieD.M_Tobillo(i,:),Vectores.K_PiernaD(i,:));
    Dinamica.PieD.M_TobilloVarVal(i) = - dot(Dinamica.PieD.M_Tobillo(i,:),Vectores.L_AJC_D(i,:));

    Dinamica.PieI.M_TobilloInvEve(i) = - dot(Dinamica.PieI.M_Tobillo(i,:),Vectores.I_PieI(i,:));
    Dinamica.PieI.M_TobilloPlaDor(i) = dot(Dinamica.PieI.M_Tobillo(i,:),Vectores.K_PiernaI(i,:));
    Dinamica.PieI.M_TobilloVarVal(i) = dot(Dinamica.PieI.M_Tobillo(i,:),Vectores.L_AJC_I(i,:));
    
end

PorcentajeRTO = round((FrameRTO-FrameRHS)*100/(FrameRHS2-FrameRHS));
PorcentajeLTO = round((FrameLTO-FrameLHS)*100/(FrameLHS2-FrameLHS));

% ---------- Graficacion

% - Momentos
figure('Name','Momentos Pies en Tobillo','NumberTitle','off');
subplot(1,3,1);
[Muestra, ciclo] = MostrarCiclos(Dinamica.PieI.M_TobilloPlaDor(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.PieD.M_TobilloPlaDor(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
legend('Izquierda', 'Derecha');
title('M Tobillo Plant/Dorsal');
ylabel('Momento [Nm/Kg]')
xlabel('Ciclo [%]')

subplot(1,3,2);
[Muestra, ciclo] = MostrarCiclos(Dinamica.PieI.M_TobilloInvEve(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.PieD.M_TobilloInvEve(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('M Tobillo Inv/Eve');
legend('Izquierda', 'Derecha');
ylabel('Momento [Nm/Kg]')
xlabel('Ciclo [%]')

subplot(1,3,3);
[Muestra, ciclo] = MostrarCiclos(Dinamica.PieI.M_TobilloVarVal(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.PieD.M_TobilloVarVal(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('M Tobillo Varo/Valgo');
legend('Izquierda', 'Derecha');
ylabel('Momento [Nm/Kg]')
xlabel('Ciclo [%]')

% - Fuerzas
figure('Name','Fuerzas Pies en Tobillo','NumberTitle','off');
subplot(1,3,1);
[Muestra, ciclo] = MostrarCiclos(Dinamica.PieI.F_TobilloPrxDis(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.PieD.F_TobilloPrxDis(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('F Tobillo Prx/Dis');
legend('Izquierda', 'Derecha');
ylabel('Fuerzas [N/Kg]')
xlabel('Ciclo [%]')

subplot(1,3,2);
[Muestra, ciclo] = MostrarCiclos(Dinamica.PieI.F_TobilloMedLat(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.PieD.F_TobilloMedLat(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('F Tobillo Med/Lat');
legend('Izquierda', 'Derecha');
ylabel('Fuerzas [N/Kg]')
xlabel('Ciclo [%]')

subplot(1,3,3);
[Muestra, ciclo] = MostrarCiclos(Dinamica.PieI.F_TobilloAntPos(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.PieD.F_TobilloAntPos(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('F Tobillo Ant/Pos');
legend('Izquierda', 'Derecha');
ylabel('Fuerzas [N/Kg]')
xlabel('Ciclo [%]')

% Progresión Interna, Progresion externa = Varo Valgo

%% ............. Calculo de Fuerzas y Momentos Para Pierna ................

Dinamica.PiernaD.F_Rodilla(:,1) = Dinamica.PiernaD.F_neto(:,1) + Dinamica.PieD.F_Tobillo(:,1);
Dinamica.PiernaD.F_Rodilla(:,2) = Dinamica.PiernaD.F_neto(:,2) + Dinamica.PieD.F_Tobillo(:,2);
Dinamica.PiernaD.F_Rodilla(:,3) = Dinamica.PiernaD.F_neto(:,3) + Inercia.Masa.Pierna*9.81 + Dinamica.PieD.F_Tobillo(:,3);

Dinamica.PiernaI.F_Rodilla(:,1) = Dinamica.PiernaI.F_neto(:,1) + Dinamica.PieI.F_Tobillo(:,1);
Dinamica.PiernaI.F_Rodilla(:,2) = Dinamica.PiernaI.F_neto(:,2) + Dinamica.PieI.F_Tobillo(:,2);
Dinamica.PiernaI.F_Rodilla(:,3) = Dinamica.PiernaI.F_neto(:,3) + Inercia.Masa.Pierna*9.81 + Dinamica.PieI.F_Tobillo(:,3);

% Brazos de Momento

Dinamica.PiernaD.BrazoProx = Puntos.Articu.RodillaD - Puntos.CM.PantorrillaD;
Dinamica.PiernaI.BrazoProx = Puntos.Articu.RodillaI - Puntos.CM.PantorrillaI;

Dinamica.PiernaD.BrazoDist = Puntos.Articu.TobilloD - Puntos.CM.PantorrillaD;
Dinamica.PiernaI.BrazoDist = Puntos.Articu.TobilloI - Puntos.CM.PantorrillaI;

% Momento Residual

Dinamica.PiernaD.M_Residual = zeros(size(Dinamica.PiernaD.F_Rodilla));
Dinamica.PiernaI.M_Residual = zeros(size(Dinamica.PiernaI.F_Rodilla));

for i=1:length(Dinamica.PiernaD.M_Residual)
    
    % Calculo de momento residual
    Dinamica.PiernaD.M_Residual(i,:) = - Dinamica.PieD.M_Tobillo(i,:) ...
        + cross(Dinamica.PiernaD.BrazoProx(i,:),Dinamica.PiernaD.F_Rodilla(i,:)) ...
        - cross(Dinamica.PiernaD.BrazoDist(i,:),Dinamica.PieD.F_Tobillo(i,:));

    Dinamica.PiernaI.M_Residual(i,:) = - Dinamica.PieI.M_Tobillo(i,:) ...
        + cross(Dinamica.PiernaI.BrazoProx(i,:),Dinamica.PiernaI.F_Rodilla(i,:)) ...
        - cross(Dinamica.PiernaI.BrazoDist(i,:),Dinamica.PieI.F_Tobillo(i,:));

    % Calculo de Momento en Rodilla
    Dinamica.PiernaD.M_Rodilla(i,:) = Dinamica.PiernaD.M_neto(i,:)...
        - ( Matrices.Rotacion.PiernaD(:,:,i)*(Dinamica.PiernaD.M_Residual(i,:))' )';
    Dinamica.PiernaI.M_Rodilla(i,:) = Dinamica.PiernaI.M_neto(i,:)...
        - ( Matrices.Rotacion.PiernaI(:,:,i)*(Dinamica.PiernaI.M_Residual(i,:))')';
    
    % Pasaje de Local a Global
    Dinamica.PiernaD.M_Rodilla(i,:) = ( (Matrices.Rotacion.PiernaD(:,:,i))' * (Dinamica.PiernaD.M_Rodilla(i,:))' )';
    Dinamica.PiernaI.M_Rodilla(i,:) = ( (Matrices.Rotacion.PiernaI(:,:,i))' * (Dinamica.PiernaI.M_Rodilla(i,:))' )';

end

% Fuerzas Pierna

Dinamica.PiernaD.F_RodillaPrxDis = zeros(length(Dinamica.PiernaD.F_Rodilla),1);
Dinamica.PiernaD.F_RodillaMedLat = zeros(length(Dinamica.PiernaD.F_Rodilla),1);
Dinamica.PiernaD.F_RodillaAntPos = zeros(length(Dinamica.PiernaD.F_Rodilla),1);

Dinamica.PiernaI.F_RodillaPrxDis = zeros(length(Dinamica.PiernaI.F_Rodilla),1);
Dinamica.PiernaI.F_RodillaMedLat = zeros(length(Dinamica.PiernaI.F_Rodilla),1);
Dinamica.PiernaI.F_RodillaAntPos = zeros(length(Dinamica.PiernaI.F_Rodilla),1);


for i=1:length(Dinamica.PiernaD.F_Rodilla)
    
    Dinamica.PiernaD.F_RodillaPrxDis(i) = dot(Dinamica.PiernaD.F_Rodilla(i,:),Vectores.I_PiernaD(i,:));
    Dinamica.PiernaD.F_RodillaMedLat(i) = dot(Dinamica.PiernaD.F_Rodilla(i,:),Vectores.K_MusloD(i,:));
    Dinamica.PiernaD.F_RodillaAntPos(i) = dot(Dinamica.PiernaD.F_Rodilla(i,:),Vectores.L_KJC_D(i,:));

    Dinamica.PiernaI.F_RodillaPrxDis(i) = dot(Dinamica.PiernaI.F_Rodilla(i,:),Vectores.I_PiernaI(i,:));
    Dinamica.PiernaI.F_RodillaMedLat(i) = - dot(Dinamica.PiernaI.F_Rodilla(i,:),Vectores.K_MusloI(i,:));
    Dinamica.PiernaI.F_RodillaAntPos(i) = dot(Dinamica.PiernaI.F_Rodilla(i,:),Vectores.L_KJC_I(i,:));

end

% Momentos Pierna

Dinamica.PiernaD.M_RodillaIntExt = zeros(length(Dinamica.PiernaD.M_Rodilla),1);
Dinamica.PiernaD.M_RodillaFlxExt = zeros(length(Dinamica.PiernaD.M_Rodilla),1);
Dinamica.PiernaD.M_RodillaAbdAdd = zeros(length(Dinamica.PiernaD.M_Rodilla),1);

Dinamica.PiernaI.M_RodillaIntExt = zeros(length(Dinamica.PiernaI.M_Rodilla),1);
Dinamica.PiernaI.M_RodillaFlxExt = zeros(length(Dinamica.PiernaI.M_Rodilla),1);
Dinamica.PiernaI.M_RodillaAbdAdd = zeros(length(Dinamica.PiernaI.M_Rodilla),1);

for i=1:length(Dinamica.PiernaD.M_Rodilla)

    Dinamica.PiernaD.M_RodillaIntExt(i) = dot(Dinamica.PiernaD.M_Rodilla(i,:),Vectores.I_PiernaD(i,:));
    Dinamica.PiernaD.M_RodillaFlxExt(i) = dot(Dinamica.PiernaD.M_Rodilla(i,:),Vectores.K_MusloD(i,:));
    Dinamica.PiernaD.M_RodillaAbdAdd(i) = - dot(Dinamica.PiernaD.M_Rodilla(i,:),Vectores.L_KJC_D(i,:));

    Dinamica.PiernaI.M_RodillaIntExt(i) = - dot(Dinamica.PiernaI.M_Rodilla(i,:),Vectores.I_PiernaI(i,:));
    Dinamica.PiernaI.M_RodillaFlxExt(i) = dot(Dinamica.PiernaI.M_Rodilla(i,:),Vectores.K_MusloI(i,:));
    Dinamica.PiernaI.M_RodillaAbdAdd(i) = dot(Dinamica.PiernaI.M_Rodilla(i,:),Vectores.L_KJC_I(i,:));
    
end

% ---------- Graficacion

% - Momentos
figure('Name','Momentos Rodilla','NumberTitle','off');
subplot(1,3,1);
[Muestra, ciclo] = MostrarCiclos(Dinamica.PiernaI.M_RodillaFlxExt(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.PiernaD.M_RodillaFlxExt(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('M Rodilla Flex(+)/Ext(-)');
legend('Izquierda','Derecha');
ylabel('Momento [Nm/Kg]')
xlabel('Ciclo [%]')

subplot(1,3,2);
[Muestra, ciclo] = MostrarCiclos(Dinamica.PiernaI.M_RodillaAbdAdd(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.PiernaD.M_RodillaAbdAdd(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('M Rodilla Abd(+)/Add(-)');
legend('Izquierda','Derecha');
ylabel('Momento [Nm/Kg]')
xlabel('Ciclo [%]')

subplot(1,3,3);
[Muestra, ciclo] = MostrarCiclos(Dinamica.PiernaI.M_RodillaIntExt(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.PiernaD.M_RodillaIntExt(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on; 
title('M Rodilla Int(+)/Ext(-)');
legend('Izquierda','Derecha');
ylabel('Momento [Nm/Kg]')
xlabel('Ciclo [%]')

% - Fuerzas
figure('Name','Fuerzas Rodilla','NumberTitle','off');
subplot(1,3,1);
[Muestra, ciclo] = MostrarCiclos(Dinamica.PiernaI.F_RodillaPrxDis(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.PiernaD.F_RodillaPrxDis(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('F Rodilla Prox(+)/Dist(-)');
legend('Izquierda','Derecha');
ylabel('Fuerzas [N/Kg]')
xlabel('Ciclo [%]')

subplot(1,3,2);
[Muestra, ciclo] = MostrarCiclos(Dinamica.PiernaI.F_RodillaMedLat(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.PiernaD.F_RodillaMedLat(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('F Rodilla Med(+)/Lat(-)');
legend('Izquierda','Derecha');
ylabel('Fuerzas [N/Kg]')
xlabel('Ciclo [%]')

subplot(1,3,3);
[Muestra, ciclo] = MostrarCiclos(Dinamica.PiernaI.F_RodillaAntPos(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.PiernaD.F_RodillaAntPos(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('F Rodilla Ant(+)/Pos(-)');
legend('Izquierda','Derecha');
ylabel('Fuerzas [N/Kg]')
xlabel('Ciclo [%]')

%% ............. Calculo de Fuerzas y Momentos Para Muslo ................

Dinamica.MusloD.F_Cadera(:,1) = Dinamica.MusloD.F_neto(:,1) + Dinamica.PiernaD.F_Rodilla(:,1);
Dinamica.MusloD.F_Cadera(:,2) = Dinamica.MusloD.F_neto(:,2) + Dinamica.PiernaD.F_Rodilla(:,2);
Dinamica.MusloD.F_Cadera(:,3) = Dinamica.MusloD.F_neto(:,3) + Inercia.Masa.Muslo*9.81 + Dinamica.PiernaD.F_Rodilla(:,3);

Dinamica.MusloI.F_Cadera(:,1) = Dinamica.MusloI.F_neto(:,1) + Dinamica.PiernaI.F_Rodilla(:,1);
Dinamica.MusloI.F_Cadera(:,2) = Dinamica.MusloI.F_neto(:,2) + Dinamica.PiernaI.F_Rodilla(:,2);
Dinamica.MusloI.F_Cadera(:,3) = Dinamica.MusloI.F_neto(:,3) + Inercia.Masa.Muslo*9.81 + Dinamica.PiernaI.F_Rodilla(:,3);

% Brazos de Momento

Dinamica.MusloD.BrazoProx = Puntos.Articu.CaderaD - Puntos.CM.MusloD;
Dinamica.MusloI.BrazoProx = Puntos.Articu.CaderaI - Puntos.CM.MusloI;

Dinamica.MusloD.BrazoDist = Puntos.Articu.RodillaD - Puntos.CM.MusloD;
Dinamica.MusloI.BrazoDist = Puntos.Articu.RodillaI - Puntos.CM.MusloI;

% Momento Residual

Dinamica.MusloD.M_Residual = zeros(size(Dinamica.MusloD.F_Cadera));
Dinamica.MusloI.M_Residual = zeros(size(Dinamica.MusloI.F_Cadera));

for i=1:length(Dinamica.MusloD.M_Residual)
    
    % Calculo de momento residual
    Dinamica.MusloD.M_Residual(i,:) = - Dinamica.PiernaD.M_Rodilla(i,:) ...
        + cross(Dinamica.MusloD.BrazoProx(i,:),Dinamica.MusloD.F_Cadera(i,:)) ...
        - cross(Dinamica.MusloD.BrazoDist(i,:),Dinamica.PiernaD.F_Rodilla(i,:));

    Dinamica.MusloI.M_Residual(i,:) = - Dinamica.PiernaI.M_Rodilla(i,:) ...
        + cross(Dinamica.MusloI.BrazoProx(i,:),Dinamica.MusloI.F_Cadera(i,:)) ...
        - cross(Dinamica.MusloI.BrazoDist(i,:),Dinamica.PiernaI.F_Rodilla(i,:));

    % Calculo de Momento en Cadera
    Dinamica.MusloD.M_Cadera(i,:) = Dinamica.MusloD.M_neto(i,:)...
        - ( Matrices.Rotacion.MusloD(:,:,i)*(Dinamica.MusloD.M_Residual(i,:))' )';
    Dinamica.MusloI.M_Cadera(i,:) = Dinamica.MusloI.M_neto(i,:)...
        - ( Matrices.Rotacion.MusloI(:,:,i)*(Dinamica.MusloI.M_Residual(i,:))')';
    
    % Pasaje de Local a Global
    Dinamica.MusloD.M_Cadera(i,:) = ( (Matrices.Rotacion.MusloD(:,:,i))' * (Dinamica.MusloD.M_Cadera(i,:))' )';
    Dinamica.MusloI.M_Cadera(i,:) = ( (Matrices.Rotacion.MusloI(:,:,i))' * (Dinamica.MusloI.M_Cadera(i,:))' )';

end

% Fuerzas Muslo

Dinamica.MusloD.F_CaderaPrxDis = zeros(length(Dinamica.MusloD.F_Cadera),1);
Dinamica.MusloD.F_CaderaMedLat = zeros(length(Dinamica.MusloD.F_Cadera),1);
Dinamica.MusloD.F_CaderaAntPos = zeros(length(Dinamica.MusloD.F_Cadera),1);

Dinamica.MusloI.F_CaderaPrxDis = zeros(length(Dinamica.MusloI.F_Cadera),1);
Dinamica.MusloI.F_CaderaMedLat = zeros(length(Dinamica.MusloI.F_Cadera),1);
Dinamica.MusloI.F_CaderaAntPos = zeros(length(Dinamica.MusloI.F_Cadera),1);

for i=1:length(Dinamica.MusloD.F_Cadera)
    
    Dinamica.MusloD.F_CaderaPrxDis(i) = dot(Dinamica.MusloD.F_Cadera(i,:),Vectores.I_MusloD(i,:));
    Dinamica.MusloD.F_CaderaMedLat(i) = dot(Dinamica.MusloD.F_Cadera(i,:),Vectores.K_Pelvis(i,:));
    Dinamica.MusloD.F_CaderaAntPos(i) = dot(Dinamica.MusloD.F_Cadera(i,:),Vectores.L_HJC_D(i,:));
    
    Dinamica.MusloI.F_CaderaPrxDis(i) = dot(Dinamica.MusloI.F_Cadera(i,:),Vectores.I_MusloI(i,:));
    Dinamica.MusloI.F_CaderaMedLat(i) = - dot(Dinamica.MusloI.F_Cadera(i,:),Vectores.K_Pelvis(i,:));
    Dinamica.MusloI.F_CaderaAntPos(i) = dot(Dinamica.MusloI.F_Cadera(i,:),Vectores.L_HJC_I(i,:));

end

% Momentos Muslo

Dinamica.MusloD.M_CaderaIntExt = zeros(length(Dinamica.MusloD.M_Cadera),1);
Dinamica.MusloD.M_CaderaFlxExt = zeros(length(Dinamica.MusloD.M_Cadera),1);
Dinamica.MusloD.M_CaderaAbdAdd = zeros(length(Dinamica.MusloD.M_Cadera),1);

Dinamica.MusloI.M_CaderaIntExt = zeros(length(Dinamica.MusloI.M_Cadera),1);
Dinamica.MusloI.M_CaderaFlxExt = zeros(length(Dinamica.MusloI.M_Cadera),1);
Dinamica.MusloI.M_CaderaAbdAdd = zeros(length(Dinamica.MusloI.M_Cadera),1);

for i=1:length(Dinamica.MusloD.M_Cadera)

    Dinamica.MusloD.M_CaderaIntExt(i) = dot(Dinamica.MusloD.M_Cadera(i,:),Vectores.I_MusloD(i,:));
    Dinamica.MusloD.M_CaderaFlxExt(i) = - dot(Dinamica.MusloD.M_Cadera(i,:),Vectores.K_Pelvis(i,:));
    Dinamica.MusloD.M_CaderaAbdAdd(i) = - dot(Dinamica.MusloD.M_Cadera(i,:),Vectores.L_HJC_D(i,:));

    Dinamica.MusloI.M_CaderaIntExt(i) = - dot(Dinamica.MusloI.M_Cadera(i,:),Vectores.I_MusloI(i,:));
    Dinamica.MusloI.M_CaderaFlxExt(i) = - dot(Dinamica.MusloI.M_Cadera(i,:),Vectores.K_Pelvis(i,:));
    Dinamica.MusloI.M_CaderaAbdAdd(i) = dot(Dinamica.MusloI.M_Cadera(i,:),Vectores.L_HJC_I(i,:));
    
end

% -------------- Graficacion 
% - Momentos

figure('Name','Momentos Cadera','NumberTitle','off');
subplot(1,3,1);
[Muestra, ciclo] = MostrarCiclos(Dinamica.MusloI.M_CaderaFlxExt(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.MusloD.M_CaderaFlxExt(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('M Cadera Flex(+)/Ext(-)');
legend('Izquierda','Derecha');
ylabel('Momento [Nm/Kg]')
xlabel('Ciclo [%]')

subplot(1,3,2);
[Muestra, ciclo] = MostrarCiclos(Dinamica.MusloI.M_CaderaAbdAdd(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.MusloD.M_CaderaAbdAdd(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('M Cadera Abd(+)/Add(-)');
legend('Izquierda','Derecha');
ylabel('Momento [Nm/Kg]')
xlabel('Ciclo [%]')

subplot(1,3,3);
[Muestra, ciclo] = MostrarCiclos(Dinamica.MusloI.M_CaderaIntExt(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.MusloD.M_CaderaIntExt(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('M Cadera Int(+)/Ext(-)');
legend('Izquierda','Derecha');
ylabel('Momento [Nm/Kg]')
xlabel('Ciclo [%]')

% - Fuerzas
figure('Name','Fuerzas CADERA','NumberTitle','off');
subplot(1,3,1);
[Muestra, ciclo] = MostrarCiclos(Dinamica.MusloI.F_CaderaPrxDis(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.MusloD.F_CaderaPrxDis(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('F Cadera Prox(+)/Dist(-)');
legend('Izquierda','Derecha');
ylabel('Fuerzas [N/Kg]')
xlabel('Ciclo [%]')

subplot(1,3,2);
[Muestra, ciclo] = MostrarCiclos(Dinamica.MusloI.F_CaderaMedLat(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.MusloD.F_CaderaMedLat(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('F Cadera Med(+)/Lat(-)');
legend('Izquierda','Derecha');
ylabel('Fuerzas [N/Kg]')
xlabel('Ciclo [%]')

subplot(1,3,3);
[Muestra, ciclo] = MostrarCiclos(Dinamica.MusloI.F_CaderaAntPos(FrameLHS:FrameLHS2)/MasaTotal);
plot(ciclo,Muestra,'r'); hold on;
[Muestra, ciclo] = MostrarCiclos(Dinamica.MusloD.F_CaderaAntPos(FrameRHS:FrameRHS2)/MasaTotal);
plot(ciclo,Muestra,'b'); grid on;
title('F Cadera Ant(+)/Post(-)');
legend('Izquierda','Derecha');
ylabel('Fuerzas [N/Kg]')
xlabel('Ciclo [%]')


%% ............. Calculo de Potencia para tobillo ................

Dinamica.PieD.P_Trf_angular_Tobillo = zeros(length(Dinamica.PieD.F_Tobillo),1);
Dinamica.PieD.P_Gen_angular_Tobillo = zeros(length(Dinamica.PieD.F_Tobillo),1);
Dinamica.PieD.P_Trf_lineal_Tobillo =  zeros(length(Dinamica.PieD.F_Tobillo),1);
Polaridad = zeros(length(Dinamica.PieD.F_Tobillo),1);
Velocidad_PieD = zeros(size(Cinematica.PieD.V_angular));
Velocidad_PiernaD = zeros(size(Cinematica.PieD.V_angular));

for i=1:length(Dinamica.PieD.F_Tobillo)
    Velocidad_PieD(i,:) = ((Matrices.Rotacion.PieD(:,:,i))'*(Cinematica.PieD.V_angular(i,:))')';
    Velocidad_PieD(i,:) = Velocidad_PieD(i,:)*pi/180;
    Velocidad_PiernaD(i,:) = ((Matrices.Rotacion.PiernaD(:,:,i))'*(Cinematica.PiernaD.V_angular(i,:))')';
    Velocidad_PiernaD(i,:) = Velocidad_PiernaD(i,:)*pi/180;
    Polaridad(i) = dot(Velocidad_PieD(i,:),Velocidad_PiernaD(i,:));
    Polaridad(i) = Polaridad(i)/abs(Polaridad(i));

    if(Polaridad(i)==1)
        Dinamica.PieD.P_Trf_angular_Tobillo(i) = dot(Dinamica.PieD.M_Tobillo(i,:),Velocidad_PieD(i,:));
    else
        Dinamica.PieD.P_Trf_angular_Tobillo(i) = 0;
    end
    Resta = Velocidad_PieD(i,:) - Velocidad_PiernaD(i,:);
    Dinamica.PieD.P_Gen_angular_Tobillo(i) = dot(Dinamica.PieD.M_Tobillo(i,:),Resta);
    Dinamica.PieD.P_Trf_lineal_Tobillo(i) = dot(Dinamica.PieD.F_Tobillo(i,:),...
        Cinematica.PieD.V_lineal(i,:));
    
end

figure();
plot(Dinamica.PieD.P_Trf_angular_Tobillo(FrameRHS:FrameRHS2),'r'); hold on;
grid on;
title('Potencia Transferida');
ylabel('Potencia [W]')
xlabel('Frames')     
        
[Muestra, ciclo] = MostrarCiclos( Dinamica.PieD.P_Gen_angular_Tobillo(FrameRHS:FrameRHS2));
figure();
plot(ciclo,Muestra,'b'); grid on;
title('Potencia Generada');
ylabel('Potencia [W]')
xlabel('Ciclo [%]')     
        
        
