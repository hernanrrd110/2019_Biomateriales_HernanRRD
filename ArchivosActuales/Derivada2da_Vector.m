function [Vector_Derivada2da] = Derivada2da_Vector(Vector, fm)

tm = 1/fm;
Vector_Derivado = Derivada_Vector(Vector, fm);
Vector_Derivada2da = zeros(size(Vector));

for i=3:(length(Vector)-2)
Vector_Derivada2da(i,:) = (Vector_Derivado(i+1,:)-Vector_Derivado(i-1,:))/(2*tm);
end

end