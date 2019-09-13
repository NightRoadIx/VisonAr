% Filtro de mediana
clear all
close all
close all
clc

% Lectura de la imagen
% Abrir un cuadro de diálogo con los posibles archivos a seleccionar dentro
% de la carpeta
imagen = uigetfile({'*.jpg; *.png'});
% Se abre la imagen y convierte a escala de gris
gris = rgb2gray(imread(imagen));
% Obtener el tamaño
[sx, sy] = size(gris);

% MASCARA
n=input('Tamaño mascara [nxn] -> ');

tic
% imgfm = medfilt2(gris,[n n]); 
% el método o función anterior
% puede usarse pero para entender como
% funciona el filtro
% obtener la mediana
% se llena de ceros los extremos
% punto de corte
c=(n-1)/2; 
% creo una matriz con ceros
cgris=zeros(sx+(2*c),sy+(2*c));
cgris(1+c:sx+c,1+c:sy+c)=gris;
% luego se saca la mediana de estos valores
for i=1:sx
    for j=1:sy
        imgfm(i,j)=uint8(median(median(cgris(i:i+2*c,j:j+2*c))));
    end
end
toc

% mostrar la imagen
imshow(gris), figure, imshow(imgfm);