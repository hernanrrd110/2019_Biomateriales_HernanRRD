function [] = Plot_Angulos_Cadera(Angulos,FrameRHS,FrameRHS2,FrameLHS,FrameLHS2)
%%%%Derecha
[Angulos.Alfa_HJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Alfa_HJC_D(FrameRHS:FrameRHS2));
subplot(3,1,1)
plot(abscisa_nueva,Angulos.Alfa_HJC_D_Normalizada)
hold on;

%%%Izquierda
[Angulos.Alfa_HJC_I_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Alfa_HJC_I(FrameLHS:FrameLHS2));
plot(abscisa_nueva,Angulos.Alfa_HJC_I_Normalizada)

title('Alfa HJC Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

%%%%Derecha
[Angulos.Beta_HJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Beta_HJC_D(FrameRHS:FrameRHS2));
subplot(3,1,2)
plot(abscisa_nueva,Angulos.Beta_HJC_D_Normalizada)
hold on;

%%%Izquierda
[Angulos.Beta_HJC_I_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Beta_HJC_I(FrameLHS:FrameLHS2));
plot(abscisa_nueva,Angulos.Beta_HJC_I_Normalizada)

title('Beta HJC Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

%%%%Derecha
[Angulos.Gamma_HJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Gamma_HJC_D(FrameRHS:FrameRHS2));
subplot(3,1,3)
plot(abscisa_nueva,Angulos.Gamma_HJC_D_Normalizada)
hold on;

%%%Izquierda
[Angulos.Gamma_HJC_I_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Gamma_HJC_I(FrameLHS:FrameLHS2));
plot(abscisa_nueva,Angulos.Gamma_HJC_I_Normalizada)

title('Gamma HJC Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

end