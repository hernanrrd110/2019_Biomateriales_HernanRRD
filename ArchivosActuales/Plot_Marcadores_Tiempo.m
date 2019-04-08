
function [] = Plot_Marcadores_Tiempo(Marcador,Frame1,Frame2,colorseti)
plot3(Marcador(Frame1:Frame2,1),Marcador(Frame1:Frame2,2),Marcador(Frame1:Frame2,3),'Color',colorseti);
hold on;
 

