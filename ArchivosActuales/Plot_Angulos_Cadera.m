function [] = Plot_Angulos_Cadera(Angulos,FrameRHS,FrameRHS2,FrameRTO,...
    FrameLHS,FrameLHS2,FrameLTO)
PorcentajeRTO = round((FrameRTO-FrameRHS)*100/(FrameRHS2-FrameRHS));
PorcentajeLTO = round((FrameLTO-FrameLHS)*100/(FrameLHS2-FrameLHS));

%%%%Derecha
[Angulos.Alfa_HJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Alfa_HJC_D(FrameRHS:FrameRHS2));
subplot(3,1,1)
plot(abscisa_nueva,Angulos.Alfa_HJC_D_Normalizada,'b')
hold on;
[vector_Porcentaje,t_porcentaje] = MostrarApoyo(Angulos.Alfa_HJC_D_Normalizada,PorcentajeRTO);
plot(t_porcentaje,vector_Porcentaje,'b')
hold on;

%%%Izquierda
[Angulos.Alfa_HJC_I_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Alfa_HJC_I(FrameLHS:FrameLHS2));
plot(abscisa_nueva,Angulos.Alfa_HJC_I_Normalizada,'r')
hold on;
[vector_Porcentaje,t_porcentaje] = MostrarApoyo(Angulos.Alfa_HJC_I_Normalizada,PorcentajeLTO);
plot(t_porcentaje,vector_Porcentaje,'r')
hold on;

title('Alfa HJC Normalizada, flexión(+) / extensión (-)')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

%%%%Derecha
[Angulos.Beta_HJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Beta_HJC_D(FrameRHS:FrameRHS2));
subplot(3,1,2)
plot(abscisa_nueva,Angulos.Beta_HJC_D_Normalizada,'b')
hold on;
[vector_Porcentaje,t_porcentaje] = MostrarApoyo(Angulos.Beta_HJC_D_Normalizada,PorcentajeRTO);
plot(t_porcentaje,vector_Porcentaje,'b')
hold on;

%%%Izquierda
[Angulos.Beta_HJC_I_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Beta_HJC_I(FrameLHS:FrameLHS2));
plot(abscisa_nueva,Angulos.Beta_HJC_I_Normalizada,'r')
[vector_Porcentaje,t_porcentaje] = MostrarApoyo(Angulos.Beta_HJC_I_Normalizada,PorcentajeLTO);
plot(t_porcentaje,vector_Porcentaje,'r')
hold on;

title('Beta HJC Normalizada, Abducción(+) / Aducción (-)')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

%%%%Derecha
[Angulos.Gamma_HJC_D_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Gamma_HJC_D(FrameRHS:FrameRHS2));
subplot(3,1,3)
plot(abscisa_nueva,Angulos.Gamma_HJC_D_Normalizada,'b')
hold on;
[vector_Porcentaje,t_porcentaje] = MostrarApoyo(Angulos.Gamma_HJC_D_Normalizada,PorcentajeRTO);
plot(t_porcentaje,vector_Porcentaje,'b')
hold on;

%%%Izquierda
[Angulos.Gamma_HJC_I_Normalizada,abscisa_nueva] = MostrarCiclos(Angulos.Gamma_HJC_I(FrameLHS:FrameLHS2));
plot(abscisa_nueva,Angulos.Gamma_HJC_I_Normalizada,'r')
[vector_Porcentaje,t_porcentaje] = MostrarApoyo(Angulos.Gamma_HJC_I_Normalizada,PorcentajeLTO);
plot(t_porcentaje,vector_Porcentaje,'r')
hold on;

title('Gamma HJC Normalizada, rotación int.(+) / rotación ext.(-)')
xlabel('Porcentaje (%)','FontSize',11,'FontName','Arial')
ylabel('Angulo [°]','FontSize',11,'FontName','Arial')

end