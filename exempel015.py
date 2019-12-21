import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('bamel.jpg',0)
edges = cv2.Canny(img,100,200)

plt.subplot(121),plt.imshow(img,cmap = 'gray')
plt.title('Imagen Original'), plt.xticks([]), plt.yticks([])
plt.subplot(122),plt.imshow(edges,cmap = 'gray')
plt.title('Imagen de los bordes'), plt.xticks([]), plt.yticks([])

plt.show()