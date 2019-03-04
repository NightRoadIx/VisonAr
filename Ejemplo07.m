% Practica 7
% Rebanado de nivel de grises
clear all
close all
clc

% Abrir un cuadro de diálogo con los posibles archivos a seleccionar dentro
% de la carpeta
imagen = uigetfile({'*.jpg; *.png'});
%La Imagen
img=imread(imagen);
%Cambiar a grises
gris=rgb2gray(img);
%Lectura de Intervalo [A,B]
while(1)
    A=input('Teclea el punto A ->');
    B=input('Teclea el punto B ->');
    if (A <= B) %Ojo esto es posible quitar si se desean intervalos sin orden [A,B]
        break;
    end
    warning('Intervalo no valido, debe ser del tipo [A,B]')
end

%Obtener el tamaño de la imagen
[sx,sy]=size(gris);

%Realizar la modificaciòn
for i=1:sx
    for j=1:sy
        %Si esta dentro del intervalo realiza el cambio
        if (gris(i,j) >= A )&&(gris(i,j) <= B )
            %Imagen nueva binaria, esto es llevar a 255
            nueva(i,j)=255;
            %Imagen nueva en escala de grises resaltada en 255
            nueva1(i,j)=255;
        %si no es asi deja como esta o manda a cero
        else
            nueva(i,j)=0; %Luego se pone el cero en la binaria
            nueva1(i,j)=gris(i,j); %Y en la otra se copia la imagen
        end
    end
end

%Mostrar la imagen original
figure(1)
subplot(2,1,1); imshow(gris);
%Mostrar lineas -> line(puntos, modificadores)
%Modificadores:
%'LineWidth',n  -> Grosor de Línea n
%'Color','c'    -> Color de linea c (igual que en plot)
subplot(2,1,2); line([0 255],[0 255],'LineWidth',2,'Color','g'); grid
axis([0 255 0 255]); title('Grafica Original'), xlabel('r'), ylabel('s')

%Mostrar la imagen resaltada binaria
figure(2)
subplot(2,1,1); imshow(nueva);
%Mostrar lineas
subplot(2,1,2); line([0 A],[0 0],'LineWidth',2,'Color','k');
line([A A],[0 255],'LineWidth',2,'Color','k');
line([A B],[255 255],'LineWidth',2,'Color','k');
line([B B],[255 0],'LineWidth',2,'Color','k');
line([B 255],[0 0],'LineWidth',2,'Color','k');
grid
axis([0 255 0 255]); title('Grafica imagen binaria'), xlabel('r'), ylabel('s')

%Mostrar la imagen resaltada en escala de grises
figure(3)
subplot(2,1,1); imshow(uint8(nueva1));
subplot(2,1,2); line([0 A],[0 A],'LineWidth',2,'Color','r');
line([A A],[A 255],'LineWidth',2,'Color','r');
line([A B],[255 255],'LineWidth',2,'Color','r');
line([B B],[255 B],'LineWidth',2,'Color','r');
line([B 255],[B 255],'LineWidth',2,'Color','r');
grid
axis([0 255 0 255]); title('Grafica imagen en escala de grises resaltada'), xlabel('r'), ylabel('s')

%Finalmente mostrar las imagenes juntas para comparación
figure(4)
subplot(1,3,1); imshow(gris);
subplot(1,3,2); imshow(uint8(nueva));
subplot(1,3,3); imshow(uint8(nueva1));