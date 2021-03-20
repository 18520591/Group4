import cv2 as cv
import numpy as np

img = cv.imread('/home/dat/MicrochipDesign/LAB1/anh.png')
(height, width,depth) = img.shape


f = open("/home/dat/MicrochipDesign/LAB1/rgb.txt","w")
for i in range(0,height):
    for j in range(0,width):
        (B, G, R) = img[i][j]
        h_t, s_t, v_t = rgb_to_hsv(R, G, B)
        b = str(B)
        g = str(G)
        r = str(R)
        f.write(r + " " + g + " " + b +"\n")
f.close()







