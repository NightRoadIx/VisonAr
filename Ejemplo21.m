% Filtro Pasa Altos
clear all
close all
close all
clc

% Lectura de la imagen
% Abrir un cuadro de di�logo con los posibles archivos a seleccionar dentro
% de la carpeta
imagen = uigetfile({'*.jpg; *.png'});
% Se abre la imagen y convierte a escala de gris
gris = rgb2gray(imread(imagen));
% Obtener el tama�o
[sx, sy] = size(gris);

% MASCARA
n=input('Tama�o mascara [nxn] -> ');
% crear la mascara
mask=-ones(n,n);
mask((n+1)/2,(n+1)/2)=n^2-1;

% APLICAR LA MASCARA
palto=filter2(mask,gris);

% mostrar la imagen
imshow(gris), figure, imshow(palto, []);