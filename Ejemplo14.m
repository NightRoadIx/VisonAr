%Practica 14 Crecimiento de Región
clear all
close all
clc

%Umbral
T=input('Teclea el valor del umbral ->');
%Lectura de la imagen
imagen = uigetfile({'*.jpg; *.png'});
imacolor=imread(imagen);
img = rgb2gray(imacolor);
[sx, sy] = size(img);
%obtener el punto semilla (x,y,nivel_gris)
[x,y,gl]=impixel(img);

tic
%Crear una nueva imagen
nova=img;
%crear una matriz de ceros del tamaño de la imagen
cosa=zeros(sx,sy);
ffs=0;

figure
%Realizar la unión sobre la imagen hasta topar con el menor de los limites
for k=1:min(x,y)-2
    ffs=0;
    %Mover sobre la imagen en forma cuadrada creciente
    for j=x-k:x+k
        for i=y-k:y+k
            %la primera pasada se da como si nada
            if k == 1
                %Restricción, valor del umbral |Ps-Pcij| <= T
                if abs(max(gl)-double(img(i,j))) <= T
                    nova(i,j)=0;
                    cosa(i,j)=1;
                end
            %pero las demás tienen que checar los 8 vecinos
            else
                %Restricción, valor del umbral |Ps-Pcij| <= T
                if abs(max(gl)-double(img(i,j))) <= T
                    %checar los 8 vecinos antes de proseguir
                    %vec8(cosa,i,j)
                    if vec8(cosa,i,j) ~= 0
                        nova(i,j)=0;
                        cosa(i,j)=1;
                        %si se encuentra alguno que ya no es vecino de
                        %nadie corta el programa
                    else
                        ffs=ffs+1;
                    end
                end                
            end
        end
    end
    %si al pasar por el cuadro ya ninguno en todo el contorno tiene los 8
    %vecinos, entonces corta el programa pues ya no hay región
    if ffs >= (8*k)
        break;
    end
    imshow(nova);
end
toc
%Mostrar las imagenes
figure,imshow(cosa);