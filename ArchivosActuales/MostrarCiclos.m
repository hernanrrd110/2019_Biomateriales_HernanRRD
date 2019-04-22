function [vector_interpolado,abscisa_nueva] = MostrarCiclos(vector_muestras)
N = length(vector_muestras);
paso1 = 101/N;
abscisa_vieja = 0:paso1:101-101/N;
paso2 = 0.5;
abscisa_nueva = 0:paso2:100;
vector_interpolado = interp1(abscisa_vieja,vector_muestras,abscisa_nueva,'spline');
end


