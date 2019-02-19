% Practica 4
% Obtención del negativo
clear all
close all
clc

%Lectura de la imagen
% Abrir un cuadro de diálogo con los posibles archivos a seleccionar dentro
% de la carpeta
imagen = uigetfile({'*.jpg; *.png'});
% Se abre la imagen
img = imread(imagen);

% Convertir la imagen en color en su negativo
imgn = 255 - img(:,:,:);
% convertir la negativo-color en gris-negativo
imgrayn = rgb2gray(imgn);
% original en escala de grises
imgray = rgb2gray(img);

%Mostrar las imagenes
subplot(2,2,1), imshow(img), title('Imagen Original (color)')
subplot(2,2,2), imshow(imgn), title('Imagen Negativo (color)')
subplot(2,2,3), imshow(imgray), title('Imagen Original (gris)')
subplot(2,2,4), imshow(imgrayn),title('Imagen Negativo (gris)')