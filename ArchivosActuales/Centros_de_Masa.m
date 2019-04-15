function [Puntos] = Centros_de_Masa(Puntos)
%............................. CENTROS DE MASA ............................

%...................MUSLO DERECHO
Puntos.CM.MusloD = Puntos.Articu.CaderaD + 0.39*(Puntos.Articu.RodillaD-Puntos.Articu.CaderaD);

%...................MUSLO IZQUIERDO
Puntos.CM.MusloI = Puntos.Articu.CaderaI + 0.39*(Puntos.Articu.RodillaI-Puntos.Articu.CaderaI);

%...................PANTORRILLA DERECHA
Puntos.CM.PantorrillaD = Puntos.Articu.RodillaD + 0.42*(Puntos.Articu.TobilloD-Puntos.Articu.RodillaD);

%...................PANTORRILLA IZQUIERDA
Puntos.CM.PantorrillaI = Puntos.Articu.RodillaI + 0.42*(Puntos.Articu.TobilloI-Puntos.Articu.RodillaI);

%...................PIE DERECHO
Puntos.CM.PieD = Puntos.P02 + 0.44*(Puntos.Articu.PuntaD-Puntos.P02);

%...................PIE IZQUIERDO
Puntos.CM.PieI = Puntos.P09 + 0.44*(Puntos.Articu.PuntaI-Puntos.P09);