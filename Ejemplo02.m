% Practica 2
% Cambio en la resoluci�n espacial de im�genes
clear all
close all
clc

% Leer la imagen, que sea cuadrada:
% Por ejemplo 512 x 512, 1024 x 1024, etc...
original = imread('imagen.jpg');

% Sin embargo, si no lo es as�, pues se hace un corte
% Asegurar que la imagen sea de 512 x 512 pixeles
corte = original(1:512, 1:512, :);

% Obtener la imagen en nivel de grises
gris = rgb2gray(corte);

% Realizar el procesamiento
for k = 1:6
    % Se reduce la resoluci�n a la mitad (512 -> 256 -> 128 -> 64...)
    % Todo esto depende a que nivel se puede reducir la resoluci�n de la
    % imagen
    % Por tanto est� bajo el mando de 2^k
    qu = 2^k;
    
    % Entonces ahora se revisa cada uno de los cuadrantes de la imagen, se
    % toman cuadrantes de 2x2 pixeles, 4x4, 8x8, 16x16 y etc�tera
    % Hay que tomar en cuenta las orillas
    for i = 1:qu:512-(qu-1)
        for j = 1:qu:512-(qu-1)
            % Se obtiene el promedio y para evitar los valores decimales,
            % y se redondea mediante la instrucci�n ceil (por qu�?)
            prom = ceil( mean( mean( corte(i:i+(qu-1), j:j+(qu-1)) ) ) );
            % Se asigna finalmente el valor
            prueba(i:i+(qu-1), j:j+(qu-1)) = prom;
        end
    end
    % Ir mostrando las im�genes en ventanas por separado
    figure
    imshow(uint8(prueba))
end