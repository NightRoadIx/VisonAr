% Práctica 8
% Adquisición de imágenes por medio de una cámara web
clear all
close all
clc

% %%
% Crear el objeto de video de cámara
% La función puede tomar la forma:
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
% % La función GETSNAPSHOT realizar una gran cantidad de trabajo cuando es
% % llamada. Requiere de conectarse con el dispositivo (la cámara),
% % configurarla, iniciar la adquisición, adquirir un fotograma, detener la
% % adquisición y finalmente cerrar el dispositivo. Esto significa que tomar
% % un fotograma requiere de una gran cantidad de tiempo basándose en los
% % fotogramas por segundo de la cámara.

%% Realizar lo mismo pero con disparo manual (Manual Trigger)

% Confgurar el objeto para el disparo manual
triggerconfig(vidobj, 'manual');

% Una vez que el dispositivo está configurado en disparo manual, se llama a
% START. Esto produce que el dispositivo regrese datos de vuelta a MATLAB,
% pero no registrará fotogramas en la memoria en este punto
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

% Llamar a la función STOP para detener el dispositivo
stop(vidobj)

% Limpiar la variable
clear vidobj