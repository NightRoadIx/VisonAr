% Práctica 16 Método de Otsu
clear all
close all
clc

% Abrir un cuadro de diálogo con los posibles archivos a seleccionar dentro
% de la carpetaLa extra
imagen = uigetfile({'*.jpg; *.png'});
%La Imagen
img = imread(imagen);
%Cambiar a grises
gris = rgb2gray(img);
% %Lectura de la imagen
% imagen=input('Nombre imagen.extensión -> ','s');
% %Se obtiene en tonos de gris
% gris=rgb2gray(imread(imagen));
%Se obtiene su tamaño
[sy sx]=size(gris);

%Calculo de la distribucion de probabilidad de los niveles de gris
P=zeros(1,256);
%Sobre toda la imagen
for i=1:sy*sx
    %Se agrega un 1 para ir de 1 a 256 en niveles de gris
    P(gris(i)+1) = P(gris(i)+1) + 1;
end
%Se obtiene la distribución  pi = fi / N
P = P / (sy*sx);
%Se observa el histograma
figure, plot(1:256,P), title('Distribución de Probabilidad de nivel de gris')
figure, imhist(gris)


% Calculo del momento acumulado de orden cero y del de primer orden
omega = zeros(1,256);
%Se agrega al vector omega el primer valor de la distribución de
%probabilidad
omega(1) = P(1);
%Vector de medias
mu = zeros(1,256);
for i=2:256
    %Se va sumando omega
    omega(i) = omega(i-1) + P(i);
    %Se obtiene mu
    mu(i) = mu(i-1) + (i-1)*P(i);
end
%Graficar omega y mu
figure, plot(1:256,omega), title('Vector Omega')
figure, plot(1:256,mu), title('Vector Mu (Momento Acumulado)')

% Calculo del umbral optimo segun Otsu
%Iniciar valores
%SigmaB cuadrada
sigmaB2 = 0;
%SigmaB cuadrada máxima
sigmaB2max = 0;
%Intensidad media total de la imagen
mut = mu(256);
%Umbral Óptimo
umbralOptimo = 0;

%Obtener el Umbral Optimo
%Recorrer sobre los 256 niveles de gris
for t=1:256
    %Omega1 es igual al omega(t)
    omega1 = omega(t);
    %Omega2 es 1 - omega(t), ya que omega1 + omega2 = 1
    omega2 = 1 - omega1;
    
    %Condición cuando ambas omegas sean diferentes de cero
    if omega1~=0 & omega2~=0
        %Se obtiene la operación mu1 = Sum [(i*pi)/omega1(t)]
        mu1 = mu(t) / omega1;
        %Se obtiene mu2
        mu2 = (mut-mu(t)) / omega2;
        %Se calcula sigmaB cuadrada
        sigmaB2 = (omega1 * (mu1-mut)^2) + (omega2 * (mu2 - mut)^2);
        %se calcula que sea máxima
        if sigmaB2 > sigmaB2max
            %Se reasgina para colocarla como máxima
            sigmaB2max = sigmaB2;
            %El Umbral optimo cambia
            umbralOptimo = t-1;
        end
    end
end

%Crear cadena para el título de Umbral Optimo
cad=sprintf('Imagen Binaria con Umbral %d', umbralOptimo)
%Ya con el Umbral Optimo se umbraliza la imagen
binaria=logical(gris < umbralOptimo);
%Se muestran las imagenes
figure
%La normal
subplot(1,2,1), imshow(gris), title('Imagen en tonos de gris')
%La umbralizada
subplot(1,2,2), imshow(binaria), title(cad)