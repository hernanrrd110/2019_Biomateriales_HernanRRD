function [marcadores,informacionCine,Fuerzas,informacionFuerzas,Antropometria,Eventos,h] = leer_c3d2(Archivo);
%Archivo='0029_Davis_Marcha01_Walking01sgBTS.c3d'
h = btkReadAcquisition(Archivo);
[marcadores informacionCine] = btkGetMarkers(h);
[Fuerzas informacionFuerzas] = btkGetForcePlatforms(h);
Antropometria=btkFindMetaData(h,'Antropometria');
Eventos=btkGetEvents(h);
