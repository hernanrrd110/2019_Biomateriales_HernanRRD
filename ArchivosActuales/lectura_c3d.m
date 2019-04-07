
function [DatosMarcadores, infoCinematica,Plataformas,infoDinamica,Antropometria,Eventos,h,Datos] = lectura_c3d()

Ubact=cd;
[Archivo, Ubc3d] = uigetfile('*.c3d');
cd(Ubc3d)
[DatosMarcadores, infoCinematica,Plataformas,infoDinamica,Antropometria,Eventos,h]=leer_c3d(Archivo);
cd(Ubact)

%%%%Opcionalmente podrían generar estructuras de datos para el posterior
%%%%procesamiento
Datos.Pasada.Marcadores.Crudos=DatosMarcadores;
Datos.Pasada.Plataformas(1).Crudos = Plataformas(1);
Datos.Pasada.Plataformas(2).Crudos = Plataformas(2);
Datos.info.Cinematica=infoCinematica;
Datos.info.Dinamica=infoDinamica;

Datos.antropometria=Antropometria;
Datos.eventos=Eventos;
