% PRACTICA 12
% Detecci�n de bordes por gradiente
% Los bordes son pixeles con alta variaci�n en la escala de grises que se
% encuentran en la imagen a procesar
% La derivada de una se�al continua proporciona las variaciones locales con
% respecto a una variable, de forma que el valor de la derivada es mayor
% cuanto m�s r�pidas son esta variaciones
% En el caso de funciones bidimensionales, la derivada es un vector que
% apunta en la direcci�n de la m�xima variaci�n de la funci�n, cuyo m�dulo
% es proporcional a dicha variaci�n
% En el caso bidimensional discreto, las distintas aproximaciones del
% operador gradiente se basa en la diferencias entre los niveles de grises
% de la imagen. La derivada parcial (gradiente de fila o columna) puede
% aproximarse por la diferencia de pixeles adyacentes de la misma fila (o
% columna)
clear all
close all
%imview close all
clc

disp('* * * * *DETECCI�N DE BORDES POR GRADIENTE* * * * *');
% Abrir un cuadro de di�logo con los posibles archivos a seleccionar dentro
% de la carpetaLa extra
imagen = uigetfile({'*.jpg; *.png'});
%La Imagen
imgag = imread(imagen);
%Cambiar a grises
img = rgb2gray(imgag);

%Umbral
umbral=input('Nivel del Umbral -> ');

%Preguntar por que filtro
modo=input('Filtros Derivativos a usar: \n 1.-Prewitt \n 2.-Roberts \n 3.-Sobel \n Opci�n -> ');
switch modo
    case 1 %Filtro Prewitt
        % Similar al de Sobel, para detecci�n de los gradientes de los
        % bordes
        disp('<<Filtro Prewitt>>');
        %Mascara a aplicar
        mask=[ones(1,3); zeros(1,3); -ones(1,3)];
        amx=abs(filter2(mask,img));
        amy=abs(filter2(mask',img));
    case 2 %Filtro Roberts
        % Muy simple y tiene buena respuesta ante bordes diagonales, sin
        % embargo es muy sensible al ruido y no funciona bien para la
        % detecci�n
        disp('<<Filtro Roberts>>');
        %Mascaras en x & en y
        maskx=[1 0;0 -1];
        masky=[0 1;-1 0];
        amx=abs(filter2(maskx,img));
        amy=abs(filter2(masky,img));        
    case 3 %Filtro Sobel
        % El operador de Sobel suaviza la imagen de tal manera que elimina
        % un poco de ruido de la imagen y se puede desaprecer falsos
        % bordes.
        disp('<<Filtro Sobel>>');
        %Mascara a aplicar
        mask=[-1 -2 -1; zeros(1,3); 1 2 1];
        amx=abs(filter2(mask,img));
        amy=abs(filter2(mask',img));        
    otherwise
        disp('<<Opci�n err�nea>>');
end
%Suma de los filtros
amt=amx+amy;

amx_u=amx > umbral;
amy_u=amy > umbral;
amt_u=amt > umbral;

%Mostrar los filtros
figure
subplot(2,2,1),imshow(img),title('Imagen Original')
subplot(2,2,2),imshow(amx,[]),title('Imagen Filtrada (Parte X)')
subplot(2,2,3),imshow(amy,[]),title('Imagen Filtrada (Parte Y)')
subplot(2,2,4),imshow(amt,[]),title('Imagen Filtrada')

%Mostrar los filtros
figure
subplot(2,2,1),imshow(img),title('Imagen Original')
subplot(2,2,2),imshow(amx_u,[]),title('Imagen Filtrada (Parte X)')
subplot(2,2,3),imshow(amy_u,[]),title('Imagen Filtrada (Parte Y)')
subplot(2,2,4),imshow(amt_u,[]),title('Imagen Filtrada')