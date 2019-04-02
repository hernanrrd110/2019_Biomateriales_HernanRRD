
function [marcadores,informacionCine,Fuerzas,informacionFuerzas,Antropometria,Eventos,h] = lectura_c3d(Archivo);

[DatosMarcadores, infoCinematica,Plataformas,infoDinamica,Antropometria,Eventos,h]=leer_c3d(Archivo);
%cd('/home/marco3407/marco3407@gmail.com/UNER/BiomecÃ¡nica/Tp Laboratorio 2/2019/Archivos c3d')
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

%%%%%%%%Cálculos Ciclo

%%%%%%Frecuencia de muestreo de 340
fm = 340;

%%%Pie derecho (ciclo)
FrameRHS = round(Eventos.Derecho_RHS(1)*fm);
FrameRTO = round(Eventos.Derecho_RTO*fm);
%%%Pie izquierdo (ciclo)
FrameLHS = round(Eventos.Izquierdo_LHS(1)*fm);
FrameLTO = round(Eventos.Izquierdo_LTO*fm);
