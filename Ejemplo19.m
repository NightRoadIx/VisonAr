% Filtro Pasa Bajas
clear all
close all
clc

%Lectura de la imagen
% Abrir un cuadro de diálogo con los posibles archivos a seleccionar dentro
% de la carpeta
imagen = uigetfile({'*.jpg; *.png'});
% Se abre la imagen y convierte a escala de gris
gris = rgb2gray(imread(imagen));
% Obtener el tamaño
[sx, sy] = size(gris);
T=input('Teclea el tamaño de la mascara [nxn] -> ');

% Creación de la mascara
mask=ones(T,T)/(T.^2);

% Aplicarla
% pero para simplificar se generan ceros alrededor de la imagen
corte=(T-1)/2;
gris_ceros=zeros(sx+(2*corte),sy+(2*corte));
gris_ceros(1+corte:sx+corte,1+corte:sy+corte)=gris;
%Se aplica a la imagen nueva con bordes ceros
tic
for i=1:sx
    for j=1:sy
        ifpb(i,j)=sum(sum(gris_ceros(i:i+2*corte,j:j+2*corte).*mask));
    end
end
toc

% sin embargo, se puede utilizar lo siguiente:
% ifpb=filter2(mask,gris);

%mostrar imagenes
imshow(gris), figure, imshow(ifpb,[]);