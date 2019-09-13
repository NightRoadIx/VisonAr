% Filtro Hight Boost
clear all
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
% Obtener el valor de A
A=input('Teclea el valor de A -> ');
% Pedir el tama�o de la m�scara
som=input('Tama�o de la m�scara a utilizar -> ');

% Modo de obtener el High-Boost
modo=input('Modo de obtenci�n del High Boost: \n 1.-Paso Bajo \n 2.-Paso Alto \n 3.-Por M�scara \n Opci�n -> ');
switch modo
    case 1
        disp('<- Paso Bajo ->');
        % crear mascara
        mask=ones(som,som)/(som.^2);
        % luego se aplica a la imagen
        % paso_bajo=apl_mask(gris,mask);
        paso_bajo=filter2(mask,gris);
        % luego se hace la operaci�n (A)(original)-Paso Bajo
        high_boost=A.*double(gris)-paso_bajo;
    case 2
        disp('<- Paso Alto ->');
        % mascara crearla
        mask=-ones(som,som);
        mask((som+1)/2,(som+1)/2)=som^2-1;
        % luego se aplica a la imagen
        % palto=apl_mask(gris,mask);
        palto=filter2(mask,gris);
        % luego se hace la operaci�n (A-1)(original)+Paso Alto
        high_boost=(A-1).*double(gris)+palto;
        % se corrige el intervalo din�mico
        % high_boost=comp_int(high_boost);
    case 3
        disp('<- Por m�scara ->');
        % crear esta mascara
        mask=-ones(som,som);
        mask((som+1)/2,(som+1)/2)=(som^2)*A-1;
        mask=(1/(som^2)).*mask;
        % luego se aplica a la imagen
        % high_boost=apl_mask(gris,mask);
        high_boost=filter2(mask,gris);
        % transformar el intervalo din�mico
        % high_boost=comp_int(high_boost);
    otherwise
        disp('<<Opci�n err�nea>>');
end
% mostrarlas
imshow(gris), figure
imshow(high_boost,[]);
