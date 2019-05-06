
function [] = Plot_Vectores(PuntoAplicacion,Vector1,Vector2,Vector3,Paso,Frame1,Frame2,consecutivo)
LineWidth = 1.8;
    for i=Frame1:Paso:Frame2
        quiver3(PuntoAplicacion(i,1),PuntoAplicacion(i,2),PuntoAplicacion(i,3),...
            Vector1(i,1),Vector1(i,2),Vector1(i,3),'r','LineWidth',LineWidth);
        hold on;
        quiver3(PuntoAplicacion(i,1),PuntoAplicacion(i,2),PuntoAplicacion(i,3),...
            Vector2(i,1),Vector2(i,2),Vector2(i,3),'g','LineWidth',LineWidth);
        hold on;
        quiver3(PuntoAplicacion(i,1),PuntoAplicacion(i,2),PuntoAplicacion(i,3),...
            Vector3(i,1),Vector3(i,2),Vector3(i,3),'b','LineWidth',LineWidth);
        hold on;
        scatter3 (PuntoAplicacion(i,1),PuntoAplicacion(i,2),PuntoAplicacion(i,3),'h');
        hold on;
        if(consecutivo == true)
            pause;
        end
    end

