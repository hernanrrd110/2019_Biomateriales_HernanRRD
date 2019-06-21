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
    [Angulos.AlfaMusloD(i)]  = asind( dot(cross (-Vectores.I_Global,Vectores.LN_MusloD(i,:)) ,Vectores.K_Global) );

    [Angulos.AlfaMusloI(i)]  = asind( dot(cross (-Vectores.I_Global,Vectores.LN_MusloI(i,:)) ,Vectores.K_Global) );
    
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

%% .......................... GRAFICAS EULER Muslo
% ................ Graficas Muslo
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
% %% ................ Graficas Euler Pierna
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
% %% ................ Graficas Euler Pie
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

% -------------- Matrices de Rotacion Global a Local

for i = 1:length(Matrices.Rotacion.MusloD)
    Matrices.Rotacion.MusloD(:,:,i) = Matrices.Alfa_MusloD(:,:,i)*...
         Matrices.Beta_MusloD(:,:,i)* Matrices.Gamma_MusloD(:,:,i);
    Matrices.Rotacion.MusloD(:,:,i) = Matrices.Alfa_MusloD(:,:,i)*...
         Matrices.Beta_MusloD(:,:,i)* Matrices.Gamma_MusloD(:,:,i);
end

for i = 1:length(Matrices.Rotacion.MusloI)
    Matrices.Rotacion.MusloI(:,:,i) = Matrices.Alfa_MusloI(:,:,i)*...
         Matrices.Beta_MusloI(:,:,i)* Matrices.Gamma_MusloI(:,:,i);
    Matrices.Rotacion.MusloI(:,:,i) = Matrices.Alfa_MusloI(:,:,i)*...
         Matrices.Beta_MusloI(:,:,i)* Matrices.Gamma_MusloI(:,:,i);
end


% % ---- Graficas
% figure()
% subplot(1,2,1)
% plot(Cinematica.MusloI.V_angular(FrameLHS:FrameLHS2,1),'r'); grid on; hold on;
% plot(Cinematica.MusloI.V_angular(FrameLHS:FrameLHS2,2),'g'); grid on; hold on;
% plot(Cinematica.MusloI.V_angular(FrameLHS:FrameLHS2,3),'b'); grid on;
% title('Velocidades Angulares Muslo izquierdo')
% legend('Eje i','Eje j','Eje k')
% subplot(1,2,2)
% plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,1),'r'); grid on; hold on;
% plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,2),'g'); grid on; hold on;
% plot(Cinematica.MusloD.V_angular(FrameRHS:FrameRHS2,3),'b'); grid on;
% title('Velocidades Angulares Muslo derecho')
% legend('Eje i','Eje j','Eje k')

%% ..................... Calculos Matrices Pierna .........................

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

for i = 1:length(Matrices.Rotacion.PiernaD)
    Matrices.Rotacion.PiernaD(:,:,i) = Matrices.Alfa_PiernaD(:,:,i)*...
         Matrices.Beta_PiernaD(:,:,i)* Matrices.Gamma_PiernaD(:,:,i);
    Matrices.Rotacion.PiernaD(:,:,i) = Matrices.Alfa_PiernaD(:,:,i)*...
         Matrices.Beta_PiernaD(:,:,i)* Matrices.Gamma_PiernaD(:,:,i);
end

for i = 1:length(Matrices.Rotacion.PiernaI)
    Matrices.Rotacion.PiernaI(:,:,i) = Matrices.Alfa_PiernaI(:,:,i)*...
         Matrices.Beta_PiernaI(:,:,i)* Matrices.Gamma_PiernaI(:,:,i);
    Matrices.Rotacion.PiernaI(:,:,i) = Matrices.Alfa_PiernaI(:,:,i)*...
         Matrices.Beta_PiernaI(:,:,i)* Matrices.Gamma_PiernaI(:,:,i);
end

% % ---------- Graficas
% figure();
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

for i = 1:length(Matrices.Rotacion.PieD)
    Matrices.Rotacion.PieD(:,:,i) = Matrices.Alfa_PieD(:,:,i)*...
         Matrices.Beta_PieD(:,:,i)* Matrices.Gamma_PieD(:,:,i);
    Matrices.Rotacion.PieD(:,:,i) = Matrices.Alfa_PieD(:,:,i)*...
         Matrices.Beta_PieD(:,:,i)* Matrices.Gamma_PieD(:,:,i);
end

for i = 1:length(Matrices.Rotacion.PieI)
    Matrices.Rotacion.PieI(:,:,i) = Matrices.Alfa_PieI(:,:,i)*...
         Matrices.Beta_PieI(:,:,i)* Matrices.Gamma_PieI(:,:,i);
    Matrices.Rotacion.PieI(:,:,i) = Matrices.Alfa_PieI(:,:,i)*...
         Matrices.Beta_PieI(:,:,i)* Matrices.Gamma_PieI(:,:,i);
end

% % -------- Graficas
% figure();
% subplot(1,2,1)
% plot(Cinematica.PieI.V_angular(FrameLHS:FrameLHS2,1),'r'); grid on;  hold on;
% plot(Cinematica.PieI.V_angular(FrameLHS:FrameLHS2,2),'g'); grid on; hold on;
% plot(Cinematica.PieI.V_angular(FrameLHS:FrameLHS2,3),'b'); grid on;
% title('Pie izquierda')
% legend('Eje i','Eje j','Eje k')
% subplot(1,2,2)
% plot(Cinematica.PieD.V_angular(FrameRHS:FrameRHS2,1),'r'); grid on;  hold on;
% plot(Cinematica.PieD.V_angular(FrameRHS:FrameRHS2,2),'g'); grid on; hold on;
% plot(Cinematica.PieD.V_angular(FrameRHS:FrameRHS2,3),'b'); grid on;
% title('Pie derecha')
% legend('Eje i','Eje j','Eje k')


%% ........................ Momentos Angulares ............................

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

Puntos.PlateD = Datos.Pasada.Marcadores.Crudos.rGr(PrimerFrame:UltimoFrame,:);
Puntos.PlateD(:,3) = 0; 
Puntos.PlateI = Datos.Pasada.Marcadores.Crudos.lGr(PrimerFrame:UltimoFrame,:);
Puntos.PlateI(:,3) = 0; 

%% .............. Calculo de Fuerzas y Momentos Para Pie .................

Dinamica.PieD.F_Tobillo(:,1) = Dinamica.PieD.F_neto(:,1) - Dinamica.F_PlateD(:,1); 
Dinamica.PieD.F_Tobillo(:,2) = Dinamica.PieD.F_neto(:,2) - Dinamica.F_PlateD(:,2); 
Dinamica.PieD.F_Tobillo(:,3) = Dinamica.PieD.F_neto(:,3) + Inercia.Masa.Pie*9.8 - Dinamica.F_PlateD(:,3);

Dinamica.PieI.F_Tobillo(:,1) = Dinamica.PieD.F_neto(:,1) - Dinamica.F_PlateD(:,1); 
Dinamica.PieI.F_Tobillo(:,2) = Dinamica.PieD.F_neto(:,2) - Dinamica.F_PlateI(:,2); 
Dinamica.PieI.F_Tobillo(:,3) = Dinamica.PieD.F_neto(:,3) + Inercia.Masa.Pie*9.8 - Dinamica.F_PlateD(:,3);

% Brazos de Momento

Dinamica.PieD.BrazoProx = Puntos.Articu.TobilloD - Puntos.CM.PieD;
Dinamica.PieI.BrazoProx = Puntos.Articu.TobilloI - Puntos.CM.PieI;

Dinamica.PieD.BrazoDist = Puntos.PlateD - Puntos.CM.PieD;
Dinamica.PieI.BrazoDist = Puntos.PlateI - Puntos.CM.PieI;

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

Dinamica.PieD.F_TobilloPrxDis = zeros(length(Dinamica.PieD.F_Tobillo),1);
Dinamica.PieD.F_TobilloMedLat = zeros(length(Dinamica.PieD.F_Tobillo),1);
Dinamica.PieD.F_TobilloAntPos = zeros(length(Dinamica.PieD.F_Tobillo),1);

Dinamica.PieI.F_TobilloPrxDis = zeros(length(Dinamica.PieI.F_Tobillo),1);
Dinamica.PieI.F_TobilloMedLat = zeros(length(Dinamica.PieI.F_Tobillo),1);
Dinamica.PieI.F_TobilloAntPos = zeros(length(Dinamica.PieI.F_Tobillo),1);

for i=1:length(Dinamica.PieD.F_Tobillo)
    
    Dinamica.PieD.F_TobilloProxDist(i) = dot(Dinamica.PieD.F_Tobillo(i,:),Vectores.I_PieD(i,:));
    Dinamica.PieD.F_TobilloMedLat(i) = dot(Dinamica.PieD.F_Tobillo(i,:),Vectores.K_PiernaD(i,:));
    Dinamica.PieD.F_TobilloAntPos(i) = dot(Dinamica.PieD.F_Tobillo(i,:),Vectores.L_AJC_D(i,:));

    Dinamica.PieI.F_TobilloProxDist(i) = dot(Dinamica.PieI.F_Tobillo(i,:),Vectores.I_PieI(i,:));
    Dinamica.PieI.F_TobilloMedLat(i) = dot(Dinamica.PieI.F_Tobillo(i,:),Vectores.K_PiernaI(i,:));
    Dinamica.PieI.F_TobilloAntPos(i) = dot(Dinamica.PieI.F_Tobillo(i,:),Vectores.L_AJC_I(i,:));

end

Dinamica.PieD.M_TobilloInvEve = zeros(length(Dinamica.PieD.M_Tobillo),1);
Dinamica.PieD.M_TobilloPlaDor = zeros(length(Dinamica.PieD.M_Tobillo),1);
Dinamica.PieD.M_TobilloVarVal = zeros(length(Dinamica.PieD.M_Tobillo),1);

Dinamica.PieI.M_TobilloInvEve = zeros(length(Dinamica.PieI.M_Tobillo),1);
Dinamica.PieI.M_TobilloPlaDor = zeros(length(Dinamica.PieI.M_Tobillo),1);
Dinamica.PieI.M_TobilloVarVal = zeros(length(Dinamica.PieI.M_Tobillo),1);

for i=1:length(Dinamica.PieD.M_Tobillo)

    Dinamica.PieD.M_TobilloInvEve(i) = dot(Dinamica.PieD.M_Tobillo(i,:),Vectores.I_PieD(i,:));
    Dinamica.PieD.M_TobilloPlaDor(i) = dot(Dinamica.PieD.M_Tobillo(i,:),Vectores.K_PiernaD(i,:));
    Dinamica.PieD.M_TobilloVarVal(i) = dot(Dinamica.PieD.M_Tobillo(i,:),Vectores.L_AJC_D(i,:));

    Dinamica.PieI.M_TobilloInvEve(i) = dot(Dinamica.PieI.M_Tobillo(i,:),Vectores.I_PieI(i,:));
    Dinamica.PieI.M_TobilloPlaDor(i) = dot(Dinamica.PieI.M_Tobillo(i,:),Vectores.K_PiernaI(i,:));
    Dinamica.PieI.M_TobilloVarVal(i) = dot(Dinamica.PieI.M_Tobillo(i,:),Vectores.L_AJC_I(i,:));
    
end

% ---------- Graficacion

% - Momentos
figure('Name','Momentos Pies','NumberTitle','off');
subplot(2,1,1);
plot(Dinamica.PieI.M_TobilloInvEve(FrameLHS:FrameLHS2),'r'); hold on;
plot(Dinamica.PieI.M_TobilloPlaDor(FrameLHS:FrameLHS2),'g'); hold on;
plot(Dinamica.PieI.M_TobilloVarVal(FrameLHS:FrameLHS2),'b'); 
title('Momentos Pie Izq Inversión-Eversión, Flex Plantar-Dorsal, Varo-Valgo');
legend('Inversión-Eversión', 'Flex Plantar-Dorsal', 'Varo-Valgo');
subplot(2,1,2);
plot(Dinamica.PieD.M_TobilloInvEve(FrameRHS:FrameRHS2),'r'); hold on;
plot(Dinamica.PieD.M_TobilloPlaDor(FrameRHS:FrameRHS2),'b'); hold on;
plot(Dinamica.PieD.M_TobilloAntPos(FrameRHS:FrameRHS2),'b'); 
title('Momentos Pie Der Inversión-Eversión, Flex Plantar-Dorsal, Varo-Valgo');
legend('Inversión-Eversión', 'Flex Plantar-Dorsal', 'Varo-Valgo');

% - Fuerzas
figure('Name','Fuerzas Pies','NumberTitle','off');
subplot(2,1,1);
plot(Dinamica.PieI.F_TobilloPrxDis(FrameLHS:FrameLHS2),'r'); hold on;
plot(Dinamica.PieI.F_TobilloMedLat(FrameLHS:FrameLHS2),'g'); hold on;
plot(Dinamica.PieI.F_TobilloAntPos(FrameLHS:FrameLHS2),'b'); 
title('Fuerzas Pie Izq Proximal-Distal, Medial-Lateral, Anterior-Posterior');
legend('Proximal-Distal', 'Medial-Lateral', 'Anterior-Posterior');
subplot(2,1,2);
plot(Dinamica.PieD.F_TobilloPrxDis(FrameRHS:FrameRHS2),'r'); hold on;
plot(Dinamica.PieD.F_TobilloMedLat(FrameRHS:FrameRHS2),'g'); hold on;
plot(Dinamica.PieD.F_TobilloAntPos(FrameRHS:FrameRHS2),'b'); 
title('Fuerzas Pie Der Proximal-Distal, Medial-Lateral, Anterior-Posterior');
legend('Proximal-Distal', 'Medial-Lateral', 'Anterior-Posterior');


%% ............. Calculo de Fuerzas y Momentos Para Pierna ................

Dinamica.PiernaD.F_Rodilla(:,1) = Dinamica.PiernaD.F_neto(:,1) + Dinamica.PieD.F_Tobillo(:,1);
Dinamica.PiernaD.F_Rodilla(:,2) = Dinamica.PiernaD.F_neto(:,2) + Dinamica.PieD.F_Tobillo(:,2);
Dinamica.PiernaD.F_Rodilla(:,3) = Dinamica.PiernaD.F_neto(:,2) + Inercia.Masa.Pierna*9.8 + Dinamica.PieD.F_Tobillo(:,2);

Dinamica.PiernaI.F_Rodilla(:,1) = Dinamica.PiernaI.F_neto(:,1) + Dinamica.PieI.F_Tobillo(:,1);
Dinamica.PiernaI.F_Rodilla(:,2) = Dinamica.PiernaI.F_neto(:,2) + Dinamica.PieI.F_Tobillo(:,2);
Dinamica.PiernaI.F_Rodilla(:,3) = Dinamica.PiernaI.F_neto(:,3) + Inercia.Masa.Pierna*9.8 + Dinamica.PieI.F_Tobillo(:,3);

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

    % Calculo de Momento en tobillo
    Dinamica.PiernaD.M_Rodilla(i,:) = Dinamica.PiernaD.M_neto(i,:)...
        - ( Matrices.Rotacion.PiernaD(:,:,i)*(Dinamica.PiernaD.M_Residual(i,:))' )';
    Dinamica.PiernaI.M_Rodilla(i,:) = Dinamica.PiernaI.M_neto(i,:)...
        - ( Matrices.Rotacion.PiernaI(:,:,i)*(Dinamica.PiernaI.M_Residual(i,:))')';
    
    % Pasaje de Local a Global
    Dinamica.PiernaD.M_Rodilla(i,:) = ( (Matrices.Rotacion.PiernaD(:,:,i))' * (Dinamica.PiernaD.M_Rodilla(i,:))' )';
    Dinamica.PiernaI.M_Rodilla(i,:) = ( (Matrices.Rotacion.PiernaI(:,:,i))' * (Dinamica.PiernaI.M_Rodilla(i,:))' )';

end







