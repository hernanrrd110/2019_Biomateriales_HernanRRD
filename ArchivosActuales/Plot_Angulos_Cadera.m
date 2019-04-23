function [] = Plot_Angulos_Cadera(Angulos) 
[Angulos.Alfa_HJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Alfa_HJC_D);
subplot(3,1,1)
plot(abscisa_nueva,Angulos.Alfa_HJC_D_Normalizada)

title('Alfa HJC Derecho Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

[Angulos.Beta_HJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Beta_HJC_D);
subplot(3,1,2)
plot(abscisa_nueva,Angulos.Beta_HJC_D_Normalizada)

title('Beta HJC Derecho Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

[Angulos.Gamma_HJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Gamma_HJC_D);
subplot(3,1,3)
plot(abscisa_nueva,Angulos.Gamma_HJC_D_Normalizada)

title('Gamma HJC Derecho Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

end