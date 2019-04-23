function [] = Plot_Angulos_Rodilla(Angulos) 

[Angulos.Alfa_KJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Alfa_KJC_D);
subplot(3,1,1)
plot(abscisa_nueva,Angulos.Alfa_KJC_D_Normalizada)

title('Alfa KJC Derecho Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

[Angulos.Beta_KJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Beta_KJC_D);
subplot(3,1,2)
plot(abscisa_nueva,Angulos.Beta_KJC_D_Normalizada)

title('Beta KJC Derecho Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

[Angulos.Gamma_KJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Gamma_KJC_D);
subplot(3,1,3)
plot(abscisa_nueva,Angulos.Gamma_KJC_D_Normalizada)

title('Gamma KJC Derecho Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

end