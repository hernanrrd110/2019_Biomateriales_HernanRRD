function [VectorSinNaN,PrimerFrame,UltimoFrame] = QuitarNaN(Vector)

    vectorNaN = isnan(Vector);
    primerNaN = false;
    ultimoNaN = false;
    PrimerFrame = 0;
    UltimoFrame = 0;
    for i=1:length(Vector)
        
        if(vectorNaN(i,1) == 0)
            %------------
            if(primerNaN == false)
                PrimerFrame = i;
                primerNaN = true;
            end
            %------------
        else
            %------------
            if(ultimoNaN == false && primerNaN == true)
                UltimoFrame = i;
                ultimoNaN = true;
            end
            %------------
        end
        
    end
    
    UltimoFrame = UltimoFrame-1;
    VectorSinNaN = Vector(PrimerFrame:UltimoFrame,:);
end