% Practica 6
% Ensanchamiento/Disminución Contraste
clear all
close all
clc

% Lectura de la imagen
% Abrir un cuadro de diálogo con los posibles archivos a seleccionar dentro
% de la carpeta
imagen = uigetfile({'*.jpg; *.png'});
% Se abre la imagen
imgray = rgb2gray(imread(imagen));

% En gris
% imgray=rgb2gray(img);
% Ingresar datos, ojo este algoritmo funciona solo cuando 
% r1 <= r2 & s1 <= s2
% Pero esto depende 
while(1)
    r1=input('Teclea el valor de r1 -> ');
    s1=input('Teclea el valor de s1 -> ');
    r2=input('Teclea el valor de r2 -> ');
    s2=input('Teclea el valor de s2 -> ');
    if(r1 <= r2)&&(s1<= s2)
        break;
    end;
    % Ojo con esta parte, es posible de realizar, pero el detalle quedaría
    % como si fuera el negativo de la imagen en ese intervalo
    warning('<Cambio en contraste no posible, teclear valores de nuevo>')
end
%Se aplica el algoritmo
imgrayac=rectas(imgray,r1,s1,r2,s2);
%Y las graficas de las imagenes
subplot(2,2,1), imshow(imgray); title('Imagen original')
subplot(2,2,2), imshow(uint8(imgrayac)); title('Imagen modificada en contraste')
subplot(2,2,3) 
%Se obitene la grafica de las lineas
line([0 r1],[0 s1],'LineWidth',3,'Color','r');
line([r1 r2],[s1 s2],'LineWidth',3,'Color','b');
line([r2 255],[s2 255],'LineWidth',3,'Color','g'); grid
axis([0 255 0 255]); title('Modificacion en contraste'), xlabel('r'), ylabel('s')