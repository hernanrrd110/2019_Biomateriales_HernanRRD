
function [Promedios] = Promedio_Angulos(Angulos,Frame1,Frame2)
nombres = fieldnames(Angulos);
for i=1:length(nombres)
    aux=char(nombres{i,1});
    Promedios.(sprintf('%s',aux)) = mean(Angulos.(sprintf('%s',aux))(Frame1:Frame2));
end
end






