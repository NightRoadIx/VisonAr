% Practica 14
% Filtros Derivativos
clear all
% close all
imview close all
clc

disp('* * * * *FILTROS DERIVATIVOS* * * * *');
% Lectura de la imagen
[img sx sy]=readimg(1);
% Umbral
umbral=input('Nivel del Umbral -> ');

% Preguntar por que filtro
modo=input('Filtros Derivativos: \n 1.-Prewitt \n 2.-Roberts \n 3.-Sobel \n Opción -> ');
switch modo
    case 1 %Filtro Prewitt
        disp('<<Filtro Prewitt>>');
        % Mascara a aplicar
        mask=[-ones(1,3); zeros(1,3); ones(1,3)];
        amx=abs(filter2(mask,img));
        amy=abs(filter2(mask',img));
    case 2 % Filtro Roberts
        disp('<<Filtro Roberts>>');
        % Mascaras et x & et y
        maskx=[1 0;0 -1];
        masky=[0 1;-1 0];
        amx=abs(filter2(maskx,img));
        amy=abs(filter2(masky,img));        
    case 3 % Filtro Sobel
        disp('<<Filtro Sobel>>');
        % Mascara a aplicar
        mask=[-1 -2 -1; zeros(1,3); 1 2 1];
        amx=abs(filter2(mask,img));
        amy=abs(filter2(mask',img));        
    otherwise
        disp('<<Opción errónea>>');
end
% Suma de los filtros
amt=amx+amy;

% Mostrar los filtros
figure
subplot(2,2,1),imshow(img),title('Imagen Original')
subplot(2,2,2),imshow(amx,[]),title('Imagen Filtrada (Parte X)')
subplot(2,2,3),imshow(amy,[]),title('Imagen Filtrada (Parte Y)')
subplot(2,2,4),imshow(amt,[]),title('Imagen Filtrada')