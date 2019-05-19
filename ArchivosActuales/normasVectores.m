function [NormasVectores] = normasVectores(Matriz)

    NormasVectores = zeros(length(Matriz),1);

    for i = 1:length(Matriz)
        NormasVectores(i) = sqrt(sum(Matriz(i,:).*Matriz(i,:)));
    end

end