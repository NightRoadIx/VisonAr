% Práctica 15
% División y unión de imágenes
close all
clear all
clc

imagen = uigetfile({'*.jpg; *.png'});
umbral1=10;
umbral2=20;

% #################### Acondicionamiento de la imagen ################### %
% Primero leemos la imagen
imacolor=imread(imagen);
[H,W,Z]=size(imacolor);
% Si es una imagen a color se convierte a escala de gris
% y si no es a color se deja tal cual
if Z==1
    gris=imacolor;
else 
    gris=rgb2gray(imacolor);
end
% Se hace cuadrada a 512 por simplificar la operación y que no tarde tanto
gris=gris(1:512,1:512);
% ####################################################################### %

%% Se crea la matriz Sparse
% ma=mspa(gris,umbral1 );
% Comienza la división
% Se inicializa la división al tamaño de la imagen para la primera iteración
div=512;
% Se crea la matriz que va a contener las marcas de las divisiones
mspa=zeros(512,512);
for i=1:9  % Ciclo para las iteraciones
    for y=1:div:512  % Ciclo para recorrer la imagen verticalmente
        for x=1:div:512 % Ciclo para recorrer la imagen horizontalmente
            a=y+div-1;  % Datos del tamaño del bloque actual
            b=x+div-1;  % Datos del tamaño del bloque actual
            % Se verifica el bloque con la condición del umbral
            if (max(max(gris(y:a,x:b)))-min(min(gris(y:a,x:b))))>umbral1
            % Se pone las marcas de los bloques que se dividen
               mspa(y,x)=512/2^i;
               mspa(y,(div)/2+x)=512/2^i;
               mspa((div)/2+y,x)=512/2^i;
               mspa((div)/2+y,(div)/2+x)=512/2^i;  
            end
        end
    end
    div=512/2^i; % Se decrementa el tamaño de división
end

%% Se crea la imagen dividida
% division= div( mspa );

for y=1:512  % Ciclo para recorrer la imagen verticalmente
    for x=1:512 % Ciclo para recorrer la imagen horizontalmente
        if  mspa(y,x) ~= 0
            division(y,x:x+mspa(y,x))=255;
            division(y+mspa(y,x),x:x+mspa(y,x))=255;
            division(y:y+mspa(y,x),x)=255;
            division(y:y+mspa(y,x),x+mspa(y,x))=255;
        end
    end
end

%% Se obtienen tres imagenes:
% "union" es la imagen tomando el promedio en cada bloque
% "union1" es la imagen unida por regiones
% "union2" esla imagen unida por regiones pero binaria
% [union,union1,union2]= uni( gris,ma,umbral1,umbral2 );
for y=1:512  % Ciclo para recorrer la imagen verticalmente
    for x=1:512 % Ciclo para recorrer la imagen horizontalmente
        if  mspa(y,x) ~= 0
            union(y:y+mspa(y,x)-1,x:x+mspa(y,x)-1)=ceil(sum(sum(gris(y:y+mspa(y,x)-1,x:x+mspa(y,x)-1),1),2)/mspa(y,x)^2);
        end
    end
end

union1=zeros(512,512);
union2=zeros(512,512);

for g=0:umbral1:255
    for y=1:512  % Ciclo para recorrer la imagen verticalmente
    for x=1:512 % Ciclo para recorrer la imagen horizontalmente
        
        if and((union(y,x)>=g),(union(y,x)<(g+umbral1)))==1
            union1(y,x)=g;
        end
        if union(y,x)>=umbral2
            union2(y,x)=255;
        end
        
    end
    end
end


%% Mostrar las imágenes
imshow(gris)
figure,imshow(mspa)
figure,imshow(division)
figure,imshow(union,[])
figure,imshow(union1,[])
figure,imshow(union2,[])



    