
function [AngulosRestados] = Resta_Prom_Angulos(Angulos,Promedios)
nombres = fieldnames(Angulos);
tamanio = length( Angulos.Alfa_HJC_D);
for i=1:length(nombres)
    aux=char(nombres{i,1});
    for j=1:tamanio
        AngulosRestados.(sprintf('%s',aux))(j) = Angulos.(sprintf('%s',aux))(j)...
            -Promedios.(sprintf('%s',aux)) ;
    end
    AngulosRestados.(sprintf('%s',aux))(i) = ...
        (AngulosRestados.(sprintf('%s',aux))(i))';
end
end






