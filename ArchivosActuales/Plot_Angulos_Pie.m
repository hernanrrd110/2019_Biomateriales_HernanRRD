function [] = Plot_Angulos_Pie(Angulos) 

[Angulos.Alfa_AJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Alfa_AJC_D);
subplot(3,1,1)
plot(abscisa_nueva,Angulos.Alfa_AJC_D_Normalizada)

title('Alfa AJC Derecho Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

[Angulos.Beta_AJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Beta_AJC_D);
subplot(3,1,2)
plot(abscisa_nueva,Angulos.Beta_AJC_D_Normalizada)

title('Beta AJC Derecho Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

[Angulos.Gamma_AJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Gamma_AJC_D);
subplot(3,1,3)
plot(abscisa_nueva,Angulos.Gamma_AJC_D_Normalizada)

title('Gamma AJC Derecho Normalizada')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')
end