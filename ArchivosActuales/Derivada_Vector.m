function [Vector_Derivado] = Derivada_Vector(Vector, fm)

tm = 1/fm;

Vector_Derivado = zeros(size(Vector));

for i=2:(length(Vector)-1)
Vector_Derivado(i,:) = (Vector(i+1,:)-Vector(i-1,:))/(2*tm);
end

end