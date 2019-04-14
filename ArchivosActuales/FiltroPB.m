
function [Punto_Filtrado] = FiltroPB(Punto_SinFiltrar,fm,Frame1,Frame2)
Orden = 2;
frec_corte = 6;
fe = fm/2;
wn = frec_corte/fe;
[b,a] = butter(Orden,wn);
tamanio = length(Punto_SinFiltrar);
Punto_Filtrado = Punto_SinFiltrar;
Punto_Filtrado_previo = filtfilt(b,a,Punto_SinFiltrar(Frame1:Frame2,:));
for i = 1:tamanio
    if(i>Frame1 && i<Frame2)
        Punto_Filtrado(i) = Punto_Filtrado_previo(i+1-Frame1);
    end
end






