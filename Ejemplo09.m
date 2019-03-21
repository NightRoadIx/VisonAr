% Practica 9 
% Promediado de Imagenes
% En esta se obtienen varias im�genes que pueden estar movidas o con alg�n
% tipo de alteraci�n (como ruido, desonfoque, etc) y al obtener muchas
% im�genes de las mismas, se puede hacer un promedio para disminuir estos
% efectos
clear all
close all
clc

% Iniciar un objeto de la c�mara
vidobj = videoinput('winvideo');

%Leer las imagenes de una c�mara
% en este caso ser�an 8 en total
for i=1:8
    % Obtener una captura de la imagen
    cadena = getsnapshot(vidobj);
    % Cambiar a escala de grises
    imagen=rgb2gray(cadena);
    % Cuando se trata de la primera imagen se obtiene el tama�o de la
    % imagen (se supone todas las im�genes deben de ser del mismo tama�o)
    if i == 1
        [sx,sy]=size(imagen);
        kt=zeros(sx,sy);
    end
    subplot(2,4,i),imshow(imagen);
    % sumar
    kt=kt+double(imagen);
end
%promedio
kt=kt/i;

figure
% Mostrar la imagen final promediada
imshow(uint8(kt));

% Llamar a la funci�n STOP para detener el dispositivo
stop(vidobj)

% Limpiar la variable
clear vidobj