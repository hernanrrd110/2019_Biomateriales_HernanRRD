function [] = Plot_Angulos_Rodilla(Angulos,FrameRHS,FrameRHS2,FrameLHS,FrameLHS2) 

%%%%Derecha
[Angulos.Alfa_KJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Alfa_KJC_D(FrameRHS:FrameRHS2));
subplot(3,1,1)
plot(abscisa_nueva,Angulos.Alfa_KJC_D_Normalizada)
hold on;
%%%Izquierda
[Angulos.Alfa_KJC_I_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Alfa_KJC_I(FrameLHS:FrameLHS2));
plot(abscisa_nueva,Angulos.Alfa_KJC_I_Normalizada)

title('Alfa KJC Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

%%%%Derecha
[Angulos.Beta_KJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Beta_KJC_D(FrameRHS:FrameRHS2));
subplot(3,1,2)
plot(abscisa_nueva,Angulos.Beta_KJC_D_Normalizada)
hold on;

%%%Izquierda
[Angulos.Beta_KJC_I_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Beta_KJC_I(FrameLHS:FrameLHS2));
plot(abscisa_nueva,Angulos.Beta_KJC_I_Normalizada)

title('Beta KJC Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

%%%%Derecha
[Angulos.Gamma_KJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Gamma_KJC_D(FrameRHS:FrameRHS2));
subplot(3,1,3)
plot(abscisa_nueva,Angulos.Gamma_KJC_D_Normalizada)
hold on;

%%%Izquierda
[Angulos.Gamma_KJC_I_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Gamma_KJC_I(FrameLHS:FrameLHS2));
plot(abscisa_nueva,Angulos.Gamma_KJC_I_Normalizada)

title('Gamma KJC Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

end