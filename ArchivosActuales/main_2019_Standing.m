clear all;
close all;
clc;

[DatosMarcadores,infoCinematica,Plataformas,infoDinamica,Antropometria,Eventos,h,Datos] = lectura_c3d();

%%%%%%%%Cálculos Ciclo
%%%%%%Frecuencia de muestreo de 340
fm = Datos.info.Cinematica.frequency;
Puntos.Articu.CaderaD = 0;
Puntos.P05 = 0;
Longitud.P07 = 0;
Vectores.U_Pelvis = 0;

Frame1 = 1;
Frame2 = 800;

[Puntos,Longitud,Datos,Vectores] = Inicializacion(Puntos,Longitud,Datos,Vectores,Frame1,Frame2);


%%
%........................ Cálculos de Ejes PELVIS  ........................

close all;
clc;

for i=1:length(Vectores.U_Pelvis)
    %%%%Versor en dirección Y
    Vectores.V_Pelvis(i,:) = Puntos.P14(i,:)-Puntos.P07(i,:);
    Vectores.V_Pelvis(i,:) = Vectores.V_Pelvis(i,:)/norm(Vectores.V_Pelvis(i,:));

    %%%%Versor en dirección Z
    Vectores.W_Pelvis(i,:) = cross(Puntos.P07(i,:)-Puntos.P15(i,:),Puntos.P14(i,:)-Puntos.P15(i,:));
    Vectores.W_Pelvis(i,:) = Vectores.W_Pelvis(i,:)/norm(Vectores.W_Pelvis(i,:));

    %%%%Versor en dirección X
    Vectores.U_Pelvis(i,:) = cross(Vectores.V_Pelvis(i,:),Vectores.W_Pelvis(i,:));
    Vectores.U_Pelvis(i,:) = Vectores.U_Pelvis(i,:)/norm(Vectores.U_Pelvis(i,:));

    %%%Cálculo punto cadera derecha

    Puntos.Articu.CaderaD(i,:) = Puntos.P15(i,:)...
        +0.598*Longitud.A02*Vectores.U_Pelvis(i,:)...
        -0.344*Longitud.A02*Vectores.V_Pelvis(i,:)...
        -0.290*Longitud.A02*Vectores.W_Pelvis(i,:);
    
    Puntos.Articu.CaderaI(i,:) = Puntos.P15(i,:)...
        +0.598*Longitud.A02*Vectores.U_Pelvis(i,:)...
        +0.344*Longitud.A02*Vectores.V_Pelvis(i,:)...
        -0.290*Longitud.A02*Vectores.W_Pelvis(i,:);
end

%%
%....................... CALCULOS PIERNA DERECHA ..........................

close all;
clc;

for i=1:length(Vectores.U_PiernaD)
    
    Vectores.V_PiernaD(i,:) = Puntos.P03(i,:)-Puntos.P05(i,:);
    Vectores.V_PiernaD(i,:) = Vectores.V_PiernaD(i,:)/norm(Vectores.V_PiernaD(i,:));

    VectorAux1 = (Puntos.P04(i,:)-Puntos.P05(i,:));
    VectorAux2 = (Puntos.P03(i,:)-Puntos.P05(i,:));
    Vectores.U_PiernaD(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.U_PiernaD(i,:) = Vectores.U_PiernaD(i,:)/norm(Vectores.U_PiernaD(i,:));

    Vectores.W_PiernaD(i,:) = cross(Vectores.U_PiernaD(i,:),Vectores.V_PiernaD(i,:));
    Vectores.W_PiernaD(i,:) = Vectores.W_PiernaD(i,:)/norm(Vectores.W_PiernaD(i,:));
    
    %%% Rodilla Derecha
    Puntos.Articu.RodillaD(i,:) = Puntos.P05(i,:)+0.500*Longitud.A11*Vectores.W_PiernaD(i,:);
    
    %...................SISTEMA LOCAL MUSLO DERECHO
    
    Vectores.I_MusloD(i,:) = Puntos.Articu.CaderaD(i,:)-Puntos.Articu.RodillaD(i,:);
    Vectores.I_MusloD(i,:) = Vectores.I_MusloD(i,:)/(norm(Vectores.I_MusloD(i,:)));
    
    VectorAux1 = (Puntos.P06(i,:)-Puntos.Articu.CaderaD(i,:));
    VectorAux2 = (Puntos.Articu.RodillaD(i,:)-Puntos.Articu.CaderaD(i,:));
    Vectores.J_MusloD(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.J_MusloD(i,:) = Vectores.J_MusloD(i,:)/(norm(Vectores.J_MusloD(i,:)));
    
    Vectores.K_MusloD(i,:) = cross (Vectores.I_MusloD(i,:),Vectores.J_MusloD(i,:));
    
    
end


%%
%..................... Cálculos de Ejes PIE DERECHO   .....................

close all;
clc;

for i=1:length(Vectores.U_PieD)
    
    Vectores.U_PieD(i,:) = Puntos.P01(i,:)-Puntos.P02(i,:);
    Vectores.U_PieD(i,:) = Vectores.U_PieD(i,:)/norm(Vectores.U_PieD(i,:));
    
    Vectores.W_PieD(i,:) = cross((Puntos.P01(i,:)-Puntos.P03(i,:)),(Puntos.P02(i,:)-Puntos.P03(i,:)));
    Vectores.W_PieD(i,:) = Vectores.W_PieD(i,:)/norm(Vectores.W_PieD(i,:));
    
    Vectores.V_PieD(i,:) = cross(Vectores.W_PieD(i,:),Vectores.U_PieD(i,:));
    Vectores.V_PieD(i,:) = Vectores.V_PieD(i,:)/norm(Vectores.V_PieD(i,:));

    %%% Cálculo Tobillo y Punta
    
    %%% R.Ankle
    Puntos.Articu.TobilloD(i,:) = Puntos.P03(i,:)...
        +0.016*Longitud.A13*Vectores.U_PieD(i,:)...
        +0.392*Longitud.A15*Vectores.V_PieD(i,:)...
        +0.478*Longitud.A17*Vectores.W_PieD(i,:);
    %%% R.Toe
    Puntos.Articu.PuntaD(i,:) = Puntos.P03(i,:)...
        +0.752*Longitud.A13*Vectores.U_PieD(i,:)...
        +1.074*Longitud.A15*Vectores.V_PieD(i,:)...
        -0.187*Longitud.A19*Vectores.W_PieD(i,:);
end



%%
%..................... CALCULO EJES PIERNA IZQUIERDA  .....................
close all;
clc;

for i=1:length(Vectores.U_PiernaI)
    Vectores.V_PiernaI(i,:) = Puntos.P10(i,:)-Puntos.P12(i,:);
    Vectores.V_PiernaI(i,:) = Vectores.V_PiernaI(i,:)/norm(Vectores.V_PiernaI(i,:));

    Vectores.U_PiernaI(i,:) = cross((Puntos.P10(i,:)-Puntos.P12(i,:)),(Puntos.P11(i,:)-Puntos.P12(i,:)));
    Vectores.U_PiernaI(i,:) = Vectores.U_PiernaI(i,:)/norm(Vectores.U_PiernaI(i,:));
    
    Vectores.W_PiernaI(i,:) = cross(Vectores.U_PiernaI(i,:),Vectores.V_PiernaI(i,:));
    Vectores.W_PiernaI(i,:) = Vectores.W_PiernaI(i,:)/norm(Vectores.W_PiernaI(i,:));
    
    %%% Rodilla Izquierda
    Puntos.Articu.RodillaI(i,:) = Puntos.P12(i,:)-0.500*Longitud.A11*Vectores.W_PiernaI(i,:);
    
end


%%
%........................ CALCULOS PIE IZQUIERDO .........................

close all;
clc;

for i=1:length(Vectores.U_PieI)
    Vectores.U_PieI(i,:) = Puntos.P08(i,:)-Puntos.P09(i,:);
    Vectores.U_PieI(i,:) = Vectores.U_PieI(i,:)/norm(Vectores.U_PieI(i,:));

    Vectores.W_PieI(i,:) = cross((Puntos.P08(i,:)-Puntos.P10(i,:)),(Puntos.P09(i,:)-Puntos.P10(i,:)));
    Vectores.W_PieI(i,:) = Vectores.W_PieI(i,:)/norm(Vectores.W_PieI(i,:));

    Vectores.V_PieI(i,:) = cross(Vectores.W_PieI(i,:),Vectores.U_PieI(i,:));
    Vectores.V_PieI(i,:) = Vectores.V_PieI(i,:)/norm(Vectores.V_PieI(i,:));
    
    %%% R.Ankle
    Puntos.Articu.TobilloI(i,:) = Puntos.P10(i,:)...
        +0.016*Longitud.A14*Vectores.U_PieI(i,:)...
        + 0.392*Longitud.A16*Vectores.V_PieI(i,:)...
        -0.478*Longitud.A18*Vectores.W_PieI(i,:);
    
    %%% R.Toe
    Puntos.Articu.PuntaI(i,:) = Puntos.P10(i,:)...
        +0.752*Longitud.A14*Vectores.U_PieI(i,:)...
        +1.074*Longitud.A16*Vectores.V_PieI(i,:)...
        +0.187*Longitud.A20*Vectores.W_PieI(i,:);
end

%%
%........................ CALCULOS SISTEMAS LOCALES .......................

%...................SISTEMA LOCAL PELVIS
Vectores.I_Pelvis = Vectores.W_Pelvis;
Vectores.J_Pelvis = Vectores.U_Pelvis;
Vectores.K_Pelvis = Vectores.V_Pelvis;

for i=1:length(Vectores.U_PieD)
    
    %...................SISTEMA LOCAL MUSLO DERECHO
    
    Vectores.I_MusloD(i,:) = Puntos.Articu.CaderaD(i,:)-Puntos.Articu.RodillaD(i,:);
    Vectores.I_MusloD(i,:) = Vectores.I_MusloD(i,:)/(norm(Vectores.I_MusloD(i,:)));
    
    VectorAux1 = (Puntos.P06(i,:)-Puntos.Articu.CaderaD(i,:));
    VectorAux2 = (Puntos.Articu.RodillaD(i,:)-Puntos.Articu.CaderaD(i,:));
    Vectores.J_MusloD(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.J_MusloD(i,:) = Vectores.J_MusloD(i,:)/(norm(Vectores.J_MusloD(i,:)));
    
    Vectores.K_MusloD(i,:) = cross (Vectores.I_MusloD(i,:),Vectores.J_MusloD(i,:));
    
    %...................SISTEMA LOCAL PIERNA DERECHO
    
    Vectores.I_PiernaD(i,:) = Puntos.Articu.RodillaD(i,:)-Puntos.Articu.TobilloD(i,:);
    Vectores.I_PiernaD(i,:) = Vectores.I_PiernaD(i,:)/(norm(Vectores.I_PiernaD(i,:)));
    
    VectorAux1 = (Puntos.P05(i,:)-Puntos.Articu.RodillaD(i,:));
    VectorAux2 = (Puntos.Articu.TobilloD(i,:)-Puntos.Articu.RodillaD(i,:));
    Vectores.J_PiernaD(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.J_PiernaD(i,:) = Vectores.J_PiernaD(i,:)/(norm(Vectores.J_PiernaD(i,:)));
    
    Vectores.K_PiernaD(i,:) = cross (Vectores.I_PiernaD(i,:),Vectores.J_PiernaD(i,:));
    
    %...................SISTEMA LOCAL PIE DERECHO
    
    Vectores.I_PieD(i,:) = Puntos.P02(i,:)-Puntos.Articu.PuntaD(i,:);
    Vectores.I_PieD(i,:) = Vectores.I_PieD(i,:)/(norm(Vectores.I_PieD(i,:)));
    
    VectorAux1 = (Puntos.Articu.TobilloD(i,:)-Puntos.P02(i,:));
    VectorAux2 = (Puntos.Articu.PuntaD(i,:)-Puntos.P02(i,:));
    Vectores.K_PieD(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.K_PieD(i,:) = Vectores.K_PieD(i,:)/(norm(Vectores.K_PieD(i,:)));
    
    Vectores.J_PieD(i,:) = cross (Vectores.K_PieD(i,:),Vectores.I_PieD(i,:));
    
    %...................SISTEMA LOCAL MUSLO IZQUIERDO
    
    Vectores.I_MusloI(i,:) = Puntos.Articu.CaderaI(i,:)-Puntos.Articu.RodillaI(i,:);
    Vectores.I_MusloI(i,:) = Vectores.I_MusloI(i,:)/(norm(Vectores.I_MusloI(i,:)));
    
    VectorAux1 =(Puntos.Articu.RodillaI(i,:)-Puntos.Articu.CaderaI(i,:));
    VectorAux2 =(Puntos.P13(i,:)-Puntos.Articu.CaderaI(i,:));
    Vectores.J_MusloI(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.J_MusloI(i,:) = Vectores.J_MusloI(i,:)/(norm(Vectores.J_MusloI(i,:)));
    
    Vectores.K_MusloI(i,:) = cross (Vectores.I_MusloI(i,:),Vectores.J_MusloI(i,:));
    
    %...................SISTEMA LOCAL PIERNA IZQUIERDA
    
    Vectores.I_PiernaI(i,:) = Puntos.Articu.RodillaI(i,:)-Puntos.Articu.TobilloI(i,:);
    Vectores.I_PiernaI(i,:) = Vectores.I_PiernaI(i,:)/(norm(Vectores.I_PiernaI(i,:)));
    
    VectorAux1 = (Puntos.Articu.TobilloI(i,:)-Puntos.Articu.RodillaI(i,:));
    VectorAux2 = (Puntos.P12(i,:)-Puntos.Articu.RodillaI(i,:));
    Vectores.J_PiernaI(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.J_PiernaI(i,:) = Vectores.J_PiernaI(i,:)/(norm(Vectores.J_PiernaI(i,:)));
    
    Vectores.K_PiernaI(i,:) = cross (Vectores.I_PiernaI(i,:),Vectores.J_PiernaI(i,:));
    
    %...................SISTEMA LOCAL PIE IZQUIERDO
    
    Vectores.I_PieI(i,:) = Puntos.P09(i,:)-Puntos.Articu.PuntaI(i,:);
    Vectores.I_PieI(i,:) = Vectores.I_PieI(i,:)/(norm(Vectores.I_PieI(i,:)));
    
    VectorAux1 = (Puntos.Articu.TobilloI(i,:)-Puntos.P09(i,:));
    VectorAux2 = (Puntos.Articu.PuntaI(i,:)-Puntos.P09(i,:));
    Vectores.K_PieI(i,:) = cross(VectorAux1,VectorAux2);
    Vectores.K_PieI(i,:) = Vectores.K_PieI(i,:)/(norm(Vectores.K_PieI(i,:)));
    
    Vectores.J_PieI(i,:) = cross(Vectores.K_PieD(i,:),Vectores.I_PieI(i,:));
    
end

%............................. CENTROS DE MASA ............................
Puntos = Centros_de_Masa(Puntos);

Paso = 44;
Consecutivo = false;
Escala = 1/10;




%%

for i=1:length(Vectores.U_PieD)
%%%% Para la cadera
Vectores.L_HJC_D(i,:) = cross(Vectores.K_Pelvis(i,:),Vectores.I_MusloD(i,:));
Vectores.L_HJC_D(i,:) = Vectores.L_HJC_D(i,:)/norm(Vectores.L_HJC_D(i,:));
Vectores.L_HJC_I(i,:) = cross(Vectores.K_Pelvis(i,:),Vectores.I_MusloI(i,:));
Vectores.L_HJC_I(i,:) = norm(Vectores.L_HJC_I(i,:));

%%%% Para las piernas
Vectores.L_KJC_D(i,:) = cross(Vectores.K_MusloD(i,:),Vectores.I_PiernaD(i,:));
Vectores.L_KJC_D(i,:) = Vectores.L_KJC_D(i,:)/norm(Vectores.L_KJC_D(i,:));
Vectores.L_KJC_I(i,:) = cross(Vectores.K_MusloI(i,:),Vectores.I_PiernaI(i,:));
Vectores.L_KJC_I(i,:) = Vectores.L_KJC_I(i,:) /norm(Vectores.L_KJC_I(i,:) );

%%%% Para los pies
Vectores.L_AJC_D(i,:) = cross(Vectores.K_PiernaD(i,:),Vectores.I_PieD(i,:));
Vectores.L_AJC_D(i,:) = Vectores.L_AJC_D(i,:)/norm(Vectores.L_AJC_D(i,:));
Vectores.L_AJC_I(i,:) = cross(Vectores.K_PiernaI(i,:),Vectores.I_PieI(i,:));
Vectores.L_AJC_I(i,:) = Vectores.L_AJC_I(i,:)/norm(Vectores.L_AJC_I(i,:));
end

for i=1:length(Vectores.U_PieD)
%............................... Muslo y Pelvis  
Angulos.Alfa_HJC_D(i) = acosd(dot(Vectores.L_HJC_D(i,:),Vectores.J_Pelvis(i,:)))*...
    dot(Vectores.L_HJC_D(i,:),Vectores.I_Pelvis(i,:))/abs(dot(Vectores.L_HJC_D(i,:),Vectores.I_Pelvis(i,:)));

Angulos.Beta_HJC_D(i) = asind(dot(Vectores.K_Pelvis(i,:),Vectores.I_MusloD(i,:)));

Angulos.Gamma_HJC_D(i) = -acosd(dot(Vectores.L_HJC_D(i,:),Vectores.J_MusloD(i,:)))*...
    dot(Vectores.L_HJC_D(i,:),Vectores.K_MusloD(i,:))/abs(dot(Vectores.L_HJC_D(i,:),Vectores.K_MusloD(i,:)));

Angulos.Alfa_HJC_I(i) = acosd(dot(Vectores.L_HJC_I(i,:),Vectores.J_Pelvis(i,:)))*...
    dot(Vectores.L_HJC_I(i,:),Vectores.I_Pelvis(i,:))/abs(dot(Vectores.L_HJC_I(i,:),Vectores.I_Pelvis(i,:)));

Angulos.Beta_HJC_I(i) = -asind(dot(Vectores.K_Pelvis(i,:),Vectores.I_MusloI(i,:)));

Angulos.Gamma_HJC_I(i) = acosd(dot(Vectores.L_HJC_I(i,:),Vectores.J_MusloI(i,:)))*...
    dot(Vectores.L_HJC_I(i,:),Vectores.K_MusloI(i,:))/abs(dot(Vectores.L_HJC_I(i,:),Vectores.K_MusloI(i,:)));

%................................ Piernas
Angulos.Alfa_KJC_D(i) = -acosd(dot(Vectores.L_KJC_D(i,:),Vectores.J_MusloD(i,:)))*...
    dot(Vectores.L_KJC_D(i,:),Vectores.I_MusloD(i,:))/abs(dot(Vectores.L_KJC_D(i,:),Vectores.I_MusloD(i,:)));

Angulos.Beta_KJC_D(i) = asind(dot(Vectores.K_MusloD(i,:),Vectores.I_PiernaD(i,:)));

Angulos.Gamma_KJC_D(i) = -acosd(dot(Vectores.L_KJC_D(i,:),Vectores.J_PiernaD(i,:)))*...
    dot(Vectores.L_KJC_D(i,:),Vectores.K_PiernaD(i,:))/abs(dot(Vectores.L_KJC_D(i,:),Vectores.K_PiernaD(i,:)));

Angulos.Alfa_KJC_I(i) = -acosd(dot(Vectores.L_KJC_I(i,:) ,Vectores.J_MusloI(i,:)))*...
    dot(Vectores.L_KJC_I(i,:) ,Vectores.I_MusloI(i,:))/abs(dot(Vectores.L_KJC_I(i,:) ,Vectores.I_MusloI(i,:)));

Angulos.Beta_KJC_I(i) = -asind(dot(Vectores.K_MusloI(i,:),Vectores.I_PiernaI(i,:)));

Angulos.Gamma_KJC_I(i) = acosd(dot(Vectores.L_KJC_I(i,:) ,Vectores.J_PiernaI(i,:)))*...
    dot(Vectores.L_KJC_I(i,:) ,Vectores.K_PiernaI(i,:))/abs(dot(Vectores.L_KJC_I(i,:) ,Vectores.K_PiernaI(i,:)));

%................................... Pies
Angulos.Alfa_AJC_D(i) = acosd(dot(Vectores.L_AJC_D(i,:),Vectores.I_PiernaD(i,:)))*...
    dot(Vectores.L_AJC_D(i,:),Vectores.J_PiernaD(i,:))/abs(dot(Vectores.L_AJC_D(i,:),Vectores.J_PiernaD(i,:)));

Angulos.Beta_AJC_D(i) = asind(dot(Vectores.K_PiernaD(i,:),Vectores.I_PieD(i,:)));

Angulos.Gamma_AJC_D(i) = acosd(dot(Vectores.L_AJC_D(i,:),Vectores.K_PieD(i,:)))*...
    dot(Vectores.L_AJC_D(i,:),Vectores.J_PieD(i,:))/abs(dot(Vectores.L_AJC_D(i,:),Vectores.J_PieD(i,:)));

Angulos.Alfa_AJC_I(i) = acosd(dot(Vectores.L_AJC_I(i,:),Vectores.I_PiernaI(i,:)))*...
    dot(Vectores.L_AJC_I(i,:),Vectores.J_PiernaI(i,:))/abs(dot(Vectores.L_AJC_I(i,:),Vectores.J_PiernaI(i,:)));

Angulos.Beta_AJC_I(i) = -asind(dot(Vectores.K_PiernaI(i,:),Vectores.I_PieI(i,:)));

Angulos.Gamma_AJC_I(i) = -acosd(dot(Vectores.L_AJC_I(i,:),Vectores.K_PieI(i,:)))*...
    dot(Vectores.L_AJC_I(i,:),Vectores.J_PieI(i,:))/abs(dot(Vectores.L_AJC_I(i,:),Vectores.J_PieI(i,:)));
end

[Promedios_Standing] = Promedio_Angulos(Angulos,1,100);

%%
close all;
figure8 = figure ('Color',[1 1 1]);

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




