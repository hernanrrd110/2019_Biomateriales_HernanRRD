
function [Punto_Filtrado] = FiltroPB(Punto_SinFiltrar,fm,Frame1,Frame2)
Orden = 2;
frec_corte = 6;
fe = fm/2;
wn = frec_corte/fe;
[b,a] = butter(Orden,wn);
Punto_Filtrado = filtfilt(b,a,Punto_SinFiltrar(Frame1:Frame2,:));
end






