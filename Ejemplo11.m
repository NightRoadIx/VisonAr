% Practica 11
% Deteccion de l�neas
% El principio de funcionamiento es muy similar al de detecci�n de puntos,
% solo que en esta ocasi�n, se cambia las m�scaras a utilizar
clear all
close all
clc

%Mascaras a utilizar
%Horizontal
A1=[-1 -1 -1;
     2  2  2;
    -1 -1 -1];
%Vertical
A2=[-1 2 -1;
    -1 2 -1;
    -1 2 -1];
%diagonal1
A3=[-1 -1  2;
    -1  2 -1;
     2 -1 -1];
%diagonal2
A4=[2 -1 -1;
   -1  2 -1;
   -1 -1  2];

% Abrir un cuadro de di�logo con los posibles archivos a seleccionar dentro
% de la carpeta
imagen = uigetfile({'*.jpg; *.png'});
%La Imagen
img=imread(imagen);
%Cambiar a grises
gris=rgb2gray(img);
%Poner el umbral a considerar para generar la imagen binaria
T=input('Teclea el valor de umbral T -> ');

%Se aplica cada filtro
tic
%primero la mascara
ldet1=filter2(A1,gris);
uldet1 = ldet1 > T;

%primero la mascara
ldet2=filter2(A2,gris);
uldet2 = ldet2 > T;

%primero la mascara
ldet3=filter2(A3,gris);
uldet3 = ldet3 > T;

%primero la mascara
ldet4=filter2(A4,gris);
uldet4 = ldet4 > T;
toc

%Mostrar todas las figuras
imshow(gris);
figure 
subplot(2,2,1), imshow(uldet1); title('Detecci�n lineas Horizontal')
subplot(2,2,2), imshow(uldet2); title('Detecci�n lineas Verical')
subplot(2,2,3), imshow(uldet3); title('Detecci�n lineas Diagonal Inv.')
subplot(2,2,4), imshow(uldet4); title('Detecci�n lineas Diagonal')