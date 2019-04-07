
function [Puntos,Longitud,Datos,Vectores] = Inicializacion(Puntos,Longitud,Datos,Vectores)

%.......................... PUNTOS MARCADORES .............................

%..... PELVIS
%%%% Asis derecha
Puntos.P07 = Datos.Pasada.Marcadores.Crudos.r_asis;
%%%% Asis izquierda
Puntos.P14 = Datos.Pasada.Marcadores.Crudos.l_asis;
%%%% Sacro
Puntos.P15 = Datos.Pasada.Marcadores.Crudos.sacrum;
%%%% Caderas
Puntos.Articu.CaderaD = zeros(length(Puntos.P07),3);
Puntos.Articu.CaderaI = zeros(length(Puntos.P07),3);

%..... PIERNA DERECHA
%%%% Maleolo Derecho
Puntos.P03 = Datos.Pasada.Marcadores.Crudos.r_mall;
%%%% Barra Tibial 2 Derecha
Puntos.P04 = Datos.Pasada.Marcadores.Crudos.r_bar_2;
%%%% Epicondilo Derecho
Puntos.P05 = Datos.Pasada.Marcadores.Crudos.r_knee_1;
%%%% Barra 1 Muslo
Puntos.P06 = Datos.Pasada.Marcadores.Crudos.r_bar_1;
%%%% Rodilla Derecha
Puntos.Articu.RodillaD = zeros(length(Puntos.P04),3);

%..... PIE DERECHO
%%%% Metatarciano Derecho
Puntos.P01 = Datos.Pasada.Marcadores.Crudos.r_met;
%%%% Tobillo Derecho
Puntos.P02 = Datos.Pasada.Marcadores.Crudos.r_heel;
%%%% Maleolo Derecho
Puntos.P03 = Datos.Pasada.Marcadores.Crudos.r_mall;
%%%% Punta y Tobillo Derecho
Puntos.Articu.PuntaD = zeros(length(Puntos.P01),3);
Puntos.Articu.TobilloD = zeros(length(Puntos.P01),3);

%..... PIERNA IZQUIERDA
%%%% Maleolo Izquierdo
Puntos.P10 = Datos.Pasada.Marcadores.Crudos.l_mall;
%%%% Barra 2 Tibial Izquierdo
Puntos.P11 = Datos.Pasada.Marcadores.Crudos.l_bar_2;
%%%% Epicondilo Izquierdo
Puntos.P12 = Datos.Pasada.Marcadores.Crudos.l_knee_1;
%%%% Barra 1 Muslo
Puntos.P13 = Datos.Pasada.Marcadores.Crudos.l_bar_1;
%%%% Rodilla Izquierda
Puntos.Articu.RodillaI = zeros(length(Puntos.P11),3);

%..... PIE IZQUIERDO
%%%% Metatarciano Izquierdo
Puntos.P08 = Datos.Pasada.Marcadores.Crudos.l_met;
%%%% Tobillo Izquierdo
Puntos.P09 = Datos.Pasada.Marcadores.Crudos.l_heel;
%%%% Maleolo Izquierdo
Puntos.P10 = Datos.Pasada.Marcadores.Crudos.l_mall;
%%%% Punta y Tobillo Izquierdo
Puntos.Articu.PuntaI = zeros(length(Puntos.P08),3);
Puntos.Articu.TobilloI = zeros(length(Puntos.P08),3);

%........................... VECTORES UVW .................................

%..... PELVIS
Vectores.U_Pelvis = zeros(length(Puntos.P07),3);
Vectores.V_Pelvis = zeros(length(Puntos.P07),3);
Vectores.W_Pelvis = zeros(length(Puntos.P07),3);

%..... PIERNA DERECHA
Vectores.U_PiernaD = zeros(length(Puntos.P04),3);
Vectores.V_PiernaD = zeros(length(Puntos.P04),3);
Vectores.W_PiernaD = zeros(length(Puntos.P04),3);

%..... PIE DERECHO
Vectores.U_PieD = zeros(length(Puntos.P01),3);
Vectores.V_PieD = zeros(length(Puntos.P01),3);
Vectores.W_PieD = zeros(length(Puntos.P01),3);

%..... PIERNA IZQUIERDA
Vectores.U_PiernaI = zeros(length(Puntos.P11),3);
Vectores.V_PiernaI = zeros(length(Puntos.P11),3);
Vectores.W_PiernaI = zeros(length(Puntos.P11),3);

%..... PIE IZQUIERDO
Vectores.U_PieI = zeros(length(Puntos.P08),3);
Vectores.V_PieI = zeros(length(Puntos.P08),3);
Vectores.W_PieI = zeros(length(Puntos.P08),3);

%........................... VECTORES IJK .................................

Vectores.I_MusloD = zeros(length(Puntos.P04),3);
Vectores.J_MusloD = zeros(length(Puntos.P04),3);
Vectores.K_MusloD = zeros(length(Puntos.P04),3);

Vectores.I_PiernaD = zeros(length(Puntos.P04),3);
Vectores.J_PiernaD = zeros(length(Puntos.P04),3);
Vectores.K_PiernaD = zeros(length(Puntos.P04),3);

Vectores.I_PieD = zeros(length(Puntos.P04),3);
Vectores.J_PieD = zeros(length(Puntos.P04),3);
Vectores.K_PieD = zeros(length(Puntos.P04),3);

%...................... LONGITUDES ANTROPOMETRICAS ........................

%..... PELVIS
Longitud.A02 = Datos.antropometria.children.LONGITUD_ASIS.info.values*0.01;

%..... PIERNA DERECHA
Longitud.A11 = Datos.antropometria.children.DIAMETRO_RODILLA_DERECHA.info.values*0.01;

%..... PIE DERECHO
Longitud.A13 = Datos.antropometria.children.LONGITUD_PIE_DERECHO.info.values*0.01;
Longitud.A15 = Datos.antropometria.children.ALTURA_MALEOLOS_DERECHO.info.values*0.01;
Longitud.A17 = Datos.antropometria.children.ANCHO_MALEOLOS_DERECHO.info.values*0.01;
Longitud.A19 = Datos.antropometria.children.ANCHO_PIE_DERECHO.info.values*0.01;

%..... PIERNA IZQUIERDA
Longitud.A12 = Datos.antropometria.children.DIAMETRO_RODILLA_IZQUIERDA.info.values*0.01;

%..... PIE IZQUIERDO
Longitud.A14 = Datos.antropometria.children.LONGITUD_PIE_IZQUIERDO.info.values*0.01;
Longitud.A16 = Datos.antropometria.children.ALTURA_MALEOLOS_IZQUIERDO.info.values*0.01;
Longitud.A18 = Datos.antropometria.children.ANCHO_MALEOLOS_IZQUIERDO.info.values*0.01;
Longitud.A20 = Datos.antropometria.children.ANCHO_PIE_IZQUIERDO.info.values*0.01;

%............................. CENTROS DE MASA ............................

%...................MUSLO DERECHO
Puntos.CM.MusloD = zeros(length(Puntos.P04),3);

%...................MUSLO IZQUIERDO
Puntos.CM.MusloI = zeros(length(Puntos.P04),3);

%...................PANTORRILLA DERECHA
Puntos.CM.PantorrillaD = zeros(length(Puntos.P04),3);

%...................PANTORRILLA IZQUIERDA
Puntos.CM.PantorrillaI = zeros(length(Puntos.P04),3);

%...................PIE DERECHO
Puntos.CM.PieD = zeros(length(Puntos.P04),3);

%...................PIE IZQUIERDO
Puntos.CM.PieI = zeros(length(Puntos.P04),3);

end


