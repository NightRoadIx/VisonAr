%Practica 1
%Procesamiento Digital de Imagenes
clear all           %Limpia todas las variables
close all           %Cierra todas las ventanas que estorben
clc                 %Limpia la consola (en donde se ejecutan las instrucciones)

%Obtener Imagen
%imagen.jpg debe de encontrarse dentro del directorio donde se trabaja
%esto es si se decide crear un directorio en C:\Matlab\work, las
%imagenes y este archivo .m debe de estar dentro del directorio
original=imread('imagen.jpg'); %Original se vuelve matriz m x n x 3

%*******Hacer cambios a la imagen en el color*******
%Cambia a gris la imagen que se guarda en la matrix original
gris=rgb2gray(original);
% Asignar el tamaño de la imagen a una variable
r=size(original);
M=zeros(r); %Se obtiene una matriz M tamaño m x n x 3 lleno de ceros
%Cambia a a color Rojo
rojo=uint8(M);  %Se convierte M de formato double a entero (int)
%Aqui es bastante interesante rojo es tamaño m x n x 3 y se debe de vaciar
%la matriz de la imagen original, pero solo las componentes m x n x 1 que
%es la "parte roja" de la imagen original y asi se hace uso del operador :
%que hace un recorrido completo de los valores, por tanto si se hace la
%asignación:
%rojo(: , : , : 1) se recorre todos los puntos de m x n de la parte 1, y
%esto ahorra dos sentencias for que recorrerian exactamente los mismo
rojo(:,:,1)=original(:,:,1);

%Ahora se hace los mismo con los colores verde y azul, las componentes 2 y
%3 de la matriz original
%Verde
verde=uint8(M);
verde(:,:,2)=original(:,:,2);
%Azul
azul=uint8(M);
azul(:,:,3)=original(:,:,3);

%*******Ahora combinaciones*******
%Rojo+Verde=Amarillo
rv=uint8(M);
%Para combinar rojo y verde ahora se deben de "vaciar" las componentes
%originales de rojo (1) y verde (2)
rv(:,:,1:2)=original(:,:,1:2);
%Rojo+Azul=Magenta
ra=uint8(M);
%Esta es un poco mas dificil de hacer en una sola línea por lo que se hace
%en dos partes para "vaciar" la parte roja (1) y azul (3)
ra(:,:,1)=original(:,:,1);
ra(:,:,3)=original(:,:,3);
%Verde+Azul=Cyan
va=uint8(M);
va(:,:,2:3)=original(:,:,2:3);
%*******3D********
%Por ultimo se genera una matrix formato double tomando la imagen en gris
%para poder generar una imagen en 3D usando mesh
mesh(double(gris))

%Ahora si se desean ver las imagenes se usan las siguientes instrucciones:
% imshow(original)
% imshow(rojo)
% imshow(verde)
% imshow(azul)
% imshow(rv)
% imshow(ra)
% imshow(va)
