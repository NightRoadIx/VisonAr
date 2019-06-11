imaqreset
close all 
clear all 
clc

% Crear el objeto para la entrada de video
vid = videoinput('winvideo');

% Configurar la entrada
% Obtener imágenes de manera infinita (para que sea un video)
set(vid, 'FramesPerTrigger', Inf);
% Espacio de color RGB (Rojo, Verde y Azul), el formato de default
set(vid, 'ReturnedColorspace', 'rgb')
% Especifica con que frecuencia el objeto de entrada de video adquiere un
% marco de la secuencia de video
vid.FrameGrabInterval = 1;

% Iniciar el video
start(vid)

% Obtener una fotografía del video, guardar en variable "data"
data = getsnapshot(vid);

% Detener el objeto videoinput
stop(vid);
% Liberar la memoria
flushdata(vid);
% Este es muy importante, tienen que utilizarlo para terminar la ejecución
% de la cámara de video, en caso de que no se haga, la lectura del video no
% se podrá volver a hacer
delete(vid);


% Procesamiento
% Convertir la imagen de formato RGB a YCbCr
% Este formato codifica la luminosidad, la cromancia (esto es la
% información del color de la imagen)
% [Dale una revisión a la entrada del Wikipedia:
% https://es.wikipedia.org/wiki/YCbCr]
data_YCBCR = rgb2ycbcr(data);

% Una vez que lo convertiste, la imagen "data_YCBCR" es un arreglo
% tridimensional, del estilo M x N x 3, donde:
% M - ancho de la imagen
% N - alto de la imagen
% y las 3 capas son:
% (1) Luminancia Y
% (2) Crominancia Cb
% (3) Crominancia Cr
% Lo que está pidiendo es que identifiques piel cuando:
% 77 <= Cb <= 127
A = (data_YCBCR(:,:,2)>=67)&(data_YCBCR(:,:,2)<= 119);
% 133 <= Cr <= 173
B = (data_YCBCR(:,:,3)>=142)&(data_YCBCR(:,:,3)<= 173);
% Entonces para crear la imagen binaria (solo 0's y 1's)
C = A&B;
% REVISA LOS VALORES DE LOS INTERVALOS PUES NO SIEMPRE FUNCIONA MUY BIEN, O
% DEBES DE TENER LA ILUMINACIÓN BIEN CONTROLADA

% Mostrar todas las imágenes en una sola gráfica:
figure,
subplot(3,3,1), imshow(data)
subplot(3,3,2), imshow(rgb2gray(data))
subplot(3,3,3), imshow(data_YCBCR)
subplot(3,3,4), imshow(A)
subplot(3,3,5), imshow(B)
subplot(3,3,6), imshow(C)
subplot(3,3,7), imhist(data_YCBCR(:,:,1))
subplot(3,3,8), imhist(data_YCBCR(:,:,2))
subplot(3,3,9), imhist(data_YCBCR(:,:,3))

% Mostrar solo la imagen a recortar
figure, imshow(C)

% Mide las propiedades de las regiones de una imagen, se manda la imagen a
% analizar y la forma de la medida, en este caso 'BoundingBox' es el
% rectángulo más pequeño que contiene a la región de interés (en este caso
% la región de la imagen donde existan solo '1s', o sea la detección de la
% piel
st = regionprops(C, 'BoundingBox');
tama = zeros(length(st), 2);
% Hacer un recorrido por todas las posibles regiones encontradas y las
% maraca con un rectángulo rojo
for k = 1 : length(st)
    BB = st(k).BoundingBox;
    rectangle('Position', [BB(1),BB(2),BB(3),BB(4)], 'EdgeColor','r','LineWidth',2 )
    tama(k, :) = [BB(3), BB(4)];
end
[v, in] = max(tama);
BB = st(in(1)).BoundingBox;
% Corta la imagen y la guarda en "recortada"
recortada = imcrop(C, BB);

figure, imshow(recortada);