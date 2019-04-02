
function [] = Plot_Vectores(PuntoAplicacion,Vector1,Vector2,Vector3,Paso,Frame1,Frame2,consecutivo)
    for i=Frame1:Paso:Frame2
        quiver3(PuntoAplicacion(i,1),PuntoAplicacion(i,2),PuntoAplicacion(i,3),Vector1(i,1)/30,Vector1(i,2)/30,Vector1(i,3)/30,'r');
        hold on;
        quiver3(PuntoAplicacion(i,1),PuntoAplicacion(i,2),PuntoAplicacion(i,3),Vector2(i,1)/30,Vector2(i,2)/30,Vector2(i,3)/30,'g');
        hold on;
        quiver3(PuntoAplicacion(i,1),PuntoAplicacion(i,2),PuntoAplicacion(i,3),Vector3(i,1)/30,Vector3(i,2)/30,Vector3(i,3)/30,'b');
        hold on;
        scatter3 (PuntoAplicacion(i,1),PuntoAplicacion(i,2),PuntoAplicacion(i,3),'h');
        hold on;
        if(consecutivo == true)
            pause;
        end
    end

