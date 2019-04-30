function [vector_Porcentaje,t_porcentaje] = MostrarApoyo(vector_amostrar,Porcentaje)

maximo = max(vector_amostrar);
maximo = round(maximo);
minimo = min(vector_amostrar);
minimo = round(minimo);
longitud = maximo-minimo;% Longitud del vector con un paso de 1 grado

% vector_Porcentaje = zeros(longitud+1,1);
t_porcentaje = zeros(longitud+1,1);
t_porcentaje(:) = Porcentaje;
vector_Porcentaje = minimo:1:maximo;




