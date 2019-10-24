import cv2
import numpy as np

# Obtener la captura del video del dispositivo 0
cap = cv2.VideoCapture(0)

while(1):

    # Captura cada cuadro
    _, frame = cap.read()

    # Convertir de espacio de color BGR a HSV
    hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    # Definir el intervalo del color azul en HSV
    lower_red = np.array([242,50,50])
    upper_red = np.array([255,255,255])

    lower_green = np.array([90*255/360,50,50])
    upper_green = np.array([135*255/360,255,255])

    lower_blue = np.array([225*255/360,50,50])
    upper_blue = np.array([245*255/360,255,255])

    lower_violet = np.array([300*255/360,50,50])
    upper_violet = np.array([315*255/360,255,255])

    # Umbralizar la imagen HSV para que solo se obtengan los colores azules
    mask = cv2.inRange(hsv, lower_red, upper_red)
    mask2 = cv2.inRange(hsv, lower_green, upper_green)
    mask3 = cv2.inRange(hsv, lower_blue, upper_blue)
    mask4 = cv2.inRange(hsv, lower_violet, upper_violet)

    # Aplicar la máscara a la imagen original
    res = cv2.bitwise_and(frame,frame, mask= mask)
    res2 = cv2.bitwise_and(frame,frame, mask= mask2)
    res3 = cv2.bitwise_and(frame,frame, mask= mask3)
    res4 = cv2.bitwise_and(frame,frame, mask= mask4)

    cv2.imshow('frame',frame)
	#cv2.imshow('hsv',hsv)
    #cv2.imshow('mask',mask)
    cv2.imshow('res',mask)
    cv2.imshow('res2',mask2)
    cv2.imshow('res3',mask3)
    cv2.imshow('res4',mask4)
    k = cv2.waitKey(5) & 0xFF
    if k == 27:
        break

cv2.destroyAllWindows()