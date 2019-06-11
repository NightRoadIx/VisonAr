# Cargar la libreria numpy como np
import numpy as np
# Importar cv2 (la libreria del opencv)
import cv2

# Leer una imagen, el 0 indica que en color gris
# Para este caso se usa una imagen JPG
img = cv2.imread('imagen.jpeg',1)
# Abrir una ventana con la imagen
cv2.imshow('image',img)
# Esperar una tecla y recibirla en la variable
k = cv2.waitKey(0)
if k == 27:				# Tecla ESC
	# Finalizar la ventana
    cv2.destroyAllWindows()
elif k == ord('s'):		# Tecla 's'
	# Reescribir la ventana
    cv2.imwrite('endgame.png',img)
    cv2.destroyAllWindows()
