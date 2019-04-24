% Practica 10
% Deteccion de puntos pasa una máscara por la imagen, la cual debe de
% multiplicar todos sus elementos por el valor de nivel de gris de la
% imagen, sumar todos los productos y posteriormente a la imagen generada,
% evaluar un valor umbral para generar una imagen binaria
clear all
close all
clc

% Mascara a utilizar
% Resalta los puntos
A=[-1 -1 -1;
   -1  8 -1;
   -1 -1 -1];

% Abrir un cuadro de diálogo con los posibles archivos a seleccionar dentro
% de la carpeta
imagen = uigetfile({'*.jpg; *.png'});
%La Imagen
img=imread(imagen);
%Cambiar a grises
gris=rgb2gray(img);
%Poner el umbral a puntos
T=input('Teclea el valor de umbral T -> ');

%Se aplica el filtro
%primero la mascara
% La función filter2 realiza una convolución de la máscara con la imagen
nova=filter2(A,gris);
%luego hace la umbralización
pdet=nova > T;

%Mostrar las imagenes
cad=strcat('Deteccion de puntos con T = ', num2str(T));
subplot(1,2,1); imshow(gris); title('Imagen Original');
subplot(1,2,2); imshow(pdet); title(cad); 