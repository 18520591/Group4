import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt

img = cv.imread('/home/dat/MicrochipDesign/LAB1/anh.png')
(height, width,depth) = img.shape
h_v = [[0 for x in range(width)] for y in range(height)]
s_v = [[0 for x in range(width)] for y in range(height)]
v_v = [[0 for x in range(width)] for y in range(height)]
f = open("/home/dat/MicrochipDesign/LAB1/hsv.txt","r")
for i in range(0, height):
    for j in range(0, width):
        a = f.readline()
        h_v[i][j] = round(int(a)*255/360)
        a = f.readline()  
        s_v[i][j] = round(int(a)*2.55)
        a = f.readline()
        v_v[i][j] = round(int(a)*2.55) 
f.close()
h_v = np.array(h_v)
s_v = np.array(s_v)
v_v = np.array(v_v)
hsv_v = cv.merge([v_v, s_v, h_v])
plt.imshow(hsv_v)
plt.title('anh HSV xu ly theo verilog', fontweight ="bold")
plt.show()

cv.waitKey(0)
