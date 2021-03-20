import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt

def rgb_to_hsv(r, g, b):
    r = r / 255.0
    g = g / 255.0
    b = b / 255.0
    mx = max(r, g, b)
    mn = min(r, g, b)
    diff = mx - mn
    if (mx == mn):
        h = 0
    elif mx == r:
        h = (60 * ((g - b) / diff) + 360) % 360
    elif mx == g:
        h = (60 * ((b - r) / diff) + 120) % 360
    elif mx == b:
        h = (60 * ((r - g) / diff) + 240) % 360
    if mx == 0:
        s = 0
    else:
        s = (diff / mx) * 100
    v = mx * 100
    return h, s, v
img = cv.imread('/home/dat/MicrochipDesign/LAB1/anh.png')
(height, width,depth) = img.shape
h = [[0 for x in range(width)] for y in range(height)]
s = [[0 for x in range(width)] for y in range(height)]
v = [[0 for x in range(width)] for y in range(height)]

f = open("/home/dat/MicrochipDesign/LAB1/rgb.txt","w")
for i in range(0,height):
    for j in range(0,width):
        (B, G, R) = img[i][j]
        h_t, s_t, v_t = rgb_to_hsv(R, G, B)
        b = str(B)
        g = str(G)
        r = str(R)
        f.write(r + " " + g + " " + b +"\n")
        h_t = round(255*h_t/360)
        s_t = round(s_t*2.55)
        v_t = round(v_t*2.55)
        h[i][j] = h_t
        s[i][j] = s_t
        v[i][j] = v_t

f.close()
h = np.array(h)
s = np.array(s)
v = np.array(v)
hsv = cv.merge([v, s, h])
plt.imshow(hsv)
plt.title('anh HSV xu ly theo python', fontweight ="bold")
plt.show()



