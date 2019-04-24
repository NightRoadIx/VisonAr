% Practica 13
% Detección de bordes por Laplaciano
% Operador Laplaciano para un campo escalar es la suma de todas las
% segundas derivadas parciales no mixtas dependientes de una variable
% En este caso se detecta los cruces por cero y con una binarización con
% umbral cercano a "cero"
clear all
close all
clc

% Abrir un cuadro de diálogo con los posibles archivos a seleccionar dentro
% de la carpetaLa extra
imagen = uigetfile({'*.jpg; *.png'});
%La Imagen
imgag = imread(imagen);
%Cambiar a grises
img = rgb2gray(imgag);
%Lectura de Sigma
sigma=input('Valor de sigma -> ');

tic
% Creación de la mascara
% Detección de bordes Marr-Hildreth
% Este método tiene como base que los cambios de intensidad no son
% independientes de la escala de la imagen, implicando que su detección
% requiere del uso de operadores de diferente tamaño
% Un cambio de intensidad repentino llevará a un pico o con la primera
% derivada, un cruce por cero en la segunda derivada
% tamaño
n = ceil((3*sigma)*2+1);
% obtención
lim=(n-1)/2;
for x=-lim:lim
    for y=-lim:lim
        r=x^2+y^2;
        mask(x+lim+1,y+lim+1)=-((r^2-sigma^2)/(sigma^4))*exp(-r^2/(2*sigma^2));
    end
end
%normalización de la mascara
mask=mask-mean(mask(:));

%Aplicar la mascara
iwm=filter2(mask,img);
% Modificar la imagen obtenida a uint8
% d=linspace(min(iwm(:)),max(iwm(:)),256);
% iwm1=uint8(arrayfun(@(x) find(abs(d(:)-x)==min(abs(d(:)-x))),iwm));
iwm1 = uint8(255*mat2gray(iwm));

[counts, bins] = imhist(iwm1);
[a, umbral]=max(counts);

%Umbralizar
imbin = iwm < 0;

%Detectar bordes (por Sobel)
%mascara de Sobel
mask_sobel=[-1 -2 -1; zeros(1,3); 1 2 1];
%Aplicación
amx=abs(filter2(mask_sobel,iwm1));
amy=abs(filter2(mask_sobel',iwm1));
%suma de las aplicaciones
amt=amx+amy;
% % Modificar la imagen obtenida a uint8
% d=linspace(min(amt(:)),max(amt(:)),256);
% amt1=uint8(arrayfun(@(x) find(abs(d(:)-x)==min(abs(d(:)-x))),amt));
amt1 = uint8(255*mat2gray(amt));
toc

%Mostrar figuras
figure
subplot(2,4,1),imshow(img),title('Imagen Original')
subplot(2,4,2),imshow(iwm1),title('Imagen con mascara')
subplot(2,4,3),imshow(amt1),title('Aplicando Sobel')
subplot(2,4,4),imshow(amt1<10),title('Detección de bordes')

subplot(2,4,5),imhist(img),title('Imagen Original')
subplot(2,4,6),imhist(iwm1),title('Imagen con mascara')
subplot(2,4,7),imhist(amt1),title('Aplicando Sobel')
subplot(2,4,8),mesh(mask),title('Máscara')

figure
subplot(1,2,1), imshow(iwm1>(umbral-5))
subplot(1,2,2), imshow(amt1<10)
