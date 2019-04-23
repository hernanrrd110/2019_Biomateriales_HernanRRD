function [] = Plot_Angulos_Pie(Angulos,FrameRHS,FrameRHS2,FrameLHS,FrameLHS2) 

%%%%Derecha
[Angulos.Alfa_AJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Alfa_AJC_D(FrameRHS:FrameRHS2));
subplot(3,1,1)
plot(abscisa_nueva,Angulos.Alfa_AJC_D_Normalizada)
hold on;

%%%Izquierda
[Angulos.Alfa_AJC_I_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Alfa_AJC_I(FrameLHS:FrameLHS2));
plot(abscisa_nueva,Angulos.Alfa_AJC_I_Normalizada);

title('Alfa AJC Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

%%%%Derecha
[Angulos.Beta_AJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Beta_AJC_D(FrameRHS:FrameRHS2));
subplot(3,1,2)
plot(abscisa_nueva,Angulos.Beta_AJC_D_Normalizada)
hold on;

%%%Izquierda
[Angulos.Beta_AJC_I_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Beta_AJC_I(FrameLHS:FrameLHS2));
plot(abscisa_nueva,Angulos.Beta_AJC_I_Normalizada);

title('Beta AJC Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

%%%%Derecha
[Angulos.Gamma_AJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Gamma_AJC_I(FrameRHS:FrameRHS2));
subplot(3,1,3)
plot(abscisa_nueva,Angulos.Gamma_AJC_D_Normalizada)
hold on;

%%%Izquierda
[Angulos.Gamma_AJC_I_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Gamma_AJC_I(FrameLHS:FrameLHS2));
plot(abscisa_nueva,Angulos.Gamma_AJC_I_Normalizada);

title('Gamma AJC Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

end