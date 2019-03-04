% Pr�ctica 8
% Adquisici�n de im�genes por medio de una c�mara web
clear all
close all
clc

% %%
% Crear el objeto de video de c�mara
% La funci�n puede tomar la forma:
% videoinput(nombreAdaptador, IDdipositivo, formato)
vidobj = videoinput('winvideo');
% % Obtener una captura de pantalla
% snapshot = getsnapshot(vidobj);
% 
% % Mostrar la imagen capturada
% imshow(snapshot)

% %%
% % Medir el tiempo para adquirir 20 fotogramas
% tic
% for i = 1:20
%     snapshot = getsnapshot(vidobj);
% %     imshow(snapshot);
% end
% 
% tiempo = toc;
% % Calcular el tiempo por fotograma y la velocidad efectiva de fotogramas
% timePerFrame = tiempo/20
% effectiveFrameRate = 1/timePerFrame
% 
% % La funci�n GETSNAPSHOT realizar una gran cantidad de trabajo cuando es
% % llamada. Requiere de conectarse con el dispositivo (la c�mara),
% % configurarla, iniciar la adquisici�n, adquirir un fotograma, detener la
% % adquisici�n y finalmente cerrar el dispositivo. Esto significa que tomar
% % un fotograma requiere de una gran cantidad de tiempo bas�ndose en los
% % fotogramas por segundo de la c�mara.

%% Realizar lo mismo pero con disparo manual (Manual Trigger)

% Confgurar el objeto para el disparo manual
triggerconfig(vidobj, 'manual');

% Una vez que el dispositivo est� configurado en disparo manual, se llama a
% START. Esto produce que el dispositivo regrese datos de vuelta a MATLAB,
% pero no registrar� fotogramas en la memoria en este punto
start(vidobj)

% Medir el tiempo en adquirir 20 cuadros
tic
for i=1:20
    snapshot = getsnapshot(vidobj);
end

tiempo = toc;
% Calcular el tiempo por fotograma y la velocidad efectiva de fotogramas
timePerFrame = tiempo/20
effectiveFrameRate = 1/timePerFrame

% Llamar a la funci�n STOP para detener el dispositivo
stop(vidobj)

% Limpiar la variable
clear vidobj