% Practica 3
% Cambio en la resoluci�n de bits (intensidad)
clear all
close all
clc

% Leer la imagen
original = imread('imagen.jpg');

% Obtener la imagen en nivel de grises
gris = rgb2gray(original);

% Variable de control
j = 0;

% Algoritmo para el cambio de n�mero de bits
for i=1:8
    % D�bese de cambiar la variable en un valor de:
    % 1, 3, 7, 15, 31, 63, 127, 255 (osea la potencia de 2 correspondiente
    % menos 1)
    j = (2^i) - 1;
    % Luego se hace la operaci�n de dividir el valor del pixel en nivel de
    % gris
    prueba = ceil( gris/j );
    % Finalmente se debe multiplicar por el valor de j, ya que la imagen va
    % a perder brillo
    subplot(2,4,i)
    imshow(prueba*j)
end