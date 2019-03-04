% Practica 5
% Rebanado de Planos de Bits
clear all
close all
clc

% Lectura de imagen
% Obtención de tamaño de la imagen
gris=rgb2gray(imread(imagen));
%Tamaño de imagen
[sxo, syo]=size(gris);

% Ahora esconder alguna imagen
hiden=rgb2gray(imread(imagen_escondida));
%Tamaño de imagen
[sx, sy]=size(gris);

% Numero de plano
kplano=input('Teclea el plano a donde se va a esconder [0,7]->');

% Recortar la imagen original al tamaño de la que se piensa esconder
gris=gris(1:sx,1:sy);

figure(1)
% Separar los planos de bits
for k=1:8
    % Aqui se realiza el cambio
    plano(:,:,k)=bitand(gris,2^(k-1));
    % Se muestran
    subplot(2,4,k);
    imshow(double(plano(:,:,k)));
    cadena=strcat('Plano de Imagen -> ',num2str(k-1));
    title(cadena)
end

%Aqui mostrar la imagen con planos de bits
figure(2)
%Imagen original
subplot(2,4,1),imshow(gris)
title('Original')

%Eliminar cada plano
for k=1:8
    %Se van eliminando los planos, esto es ir quitandole a 256 para llevar
    %una cuenta en retroceso de 255 (sin el plano 0), 254 (sin el plano 0 &
    %1), 252 (sin los planos 0,1 & 2) y asi sucesivamente hasta llegar solo
    %al plano 7 con valores de 0 & 128
    splano=bitand(gris,256-2^(k-1));
    subplot(2,4,k);
    imshow(splano);
    cadena=strcat('Quitando hasta el plano: ',num2str(k-1));
    title(cadena);
end

%Mostrar algunos planos combinados
figure(3)
subplot(2,4,1), imshow(bitor(plano(:,:,1),plano(:,:,8))), title('Plano 0 & 7')
subplot(2,4,2), imshow(bitor(plano(:,:,2),plano(:,:,7))), title('Plano 1 & 6')
subplot(2,4,3), imshow(bitor(plano(:,:,5),plano(:,:,6))), title('Plano 4 & 5')
subplot(2,4,4), imshow(bitor(plano(:,:,7),plano(:,:,8))), title('Plano 6 & 7')

subplot(2,4,5), imshow( bitor(bitor(plano(:,:,1),plano(:,:,2)),plano(:,:,3)) ), title('Plano 0,1 & 2')
subplot(2,4,6), imshow( bitor(bitor(plano(:,:,3),plano(:,:,4)),plano(:,:,5)) ), title('Plano 2,3 & 4')
subplot(2,4,7), imshow( bitor(bitor(plano(:,:,6),plano(:,:,7)),plano(:,:,8)) ), title('Plano 5,6 & 7')
subplot(2,4,8), imshow( bitor(bitor(plano(:,:,1),plano(:,:,2)),plano(:,:,8)) ), title('Plano 0,1 & 7')

%Para esconder la imagen
figure(4)
subplot(2,2,1), imshow(gris), title('Imagen original')
subplot(2,2,2), imshow(hiden), title('Imagen a esconder')
hiden=bitand(hiden,128);
subplot(2,2,3), imshow(double(hiden)), title('Plano de imagen escondida')

%Aqui se recuperan todos los planos de la imagen excepto el primero
%(plano 0)
recupera=uint8(zeros(sx,sy));
for k=2:8
    recupera=bitor(recupera,plano(:,:,k));
end
%se hace or con la imagen a esconder recorriendo 7 bits para esconderla en
%plano 0
sp=bitor(recupera,bitshift(hiden,-(7-kplano)));
subplot(2,2,4), imshow(sp), title('Imagen final')