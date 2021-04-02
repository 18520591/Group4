import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
'''
#convert from binary to decimal
def bin_to_dec(binary):
    decimal = 0
    for digit in binary:
        decimal = decimal*2 + int(digit)
    return decimal

#convert from Floating point to float(+)
def FloatingPoint_to_float(fp):
    if (fp[1:len(fp)] == '0000000000000000000000000000000'):
        return 0
    ex = fp[1:9]
    fr = fp[9:len(fp)]
    ex = bin_to_dec(ex) - 127
    t = 0
    d = 0
    for i in fr:
        d = d + 1
        if i == '1':
            t = t + pow(2, -d)
    fr = t + 1
    return fr * pow(2,ex)
'''

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
        h = abs(g-b)*43/diff
    elif mx == g:
        h = abs(g-b)*43/diff + 85
    elif mx == b:
        h = abs(g-b)*43/diff + 171
    if mx == 0:
        s = 0
    else:
        s = (diff / mx)
    v = mx
    return h, s, v

img = cv.imread('/home/dat/MicrochipDesign/LAB1/lucbinh.jpg')
(height, width,depth) = img.shape
h_v = [[0 for x in range(width)] for y in range(height)]
s_v = [[0 for x in range(width)] for y in range(height)]
v_v = [[0 for x in range(width)] for y in range(height)]
f = open("/home/dat/MicrochipDesign/LAB1/hsv.txt","r")
for i in range(0, height):
    for j in range(0, width):
        a = f.readline()
        h_t = round(int(a)/360*255)
        h_v[i][j] = h_t
        a = f.readline()  
        s_t = round(int(a)*2.55)
        s_v[i][j] = s_t
        a = f.readline()
        v_t = round(int(a)*2.55)
        v_v[i][j] = v_t 
        
f.close()


h = [[0 for x in range(width)] for y in range(height)]
s = [[0 for x in range(width)] for y in range(height)]
v = [[0 for x in range(width)] for y in range(height)]

for i in range(0,height):
    for j in range(0,width):
        (B, G, R) = img[i][j]
        h_t, s_t, v_t = rgb_to_hsv(R, G, B)
        h_t = round(255*h_t/360)
        s_t = round(s_t*255)
        v_t = round(v_t*255)
        h[i][j] = h_t
        s[i][j] = s_t
        v[i][j] = v_t

h = np.array(h)
s = np.array(s)
v = np.array(v)

h_v = np.array(h_v)
s_v = np.array(s_v)
v_v = np.array(v_v)

hsv_f = cv.cvtColor(img, cv.COLOR_BGR2HSV)
h_f, s_f, v_f = cv.split(hsv_f)
e_py = 0
e_v = 0
for i in range(0, height):
    for j in range(0, width):
        e_py = abs(h[i][j] - h_f[i][j]) + abs(s[i][j] - s_f[i][j]) + abs(v[i][j] - v_f[i][j]) + e_py
        e_v = abs(h_v[i][j] - h_f[i][j]) + abs(s_v[i][j] - s_f[i][j]) + abs(v_v[i][j] - v_f[i][j]) + e_v

e_py = (e_py/(height*width*depth))/255
e_v = (e_v/(height*width*depth))/255

print("python = ", e_py)
print("verilog = ", e_v)


h_o = h.astype(np.uint8)
s_o = s.astype(np.uint8)
v_o = v.astype(np.uint8)
h_v_o = h_v.astype(np.uint8)
s_v_o = s_v.astype(np.uint8)
v_v_o = v_v.astype(np.uint8)
cv.imshow("H_python", h_o)
cv.imshow("S_python", s_o)
cv.imshow("V_python", v_o)
cv.imshow("H_verilog", h_v_o)
cv.imshow("S_verilog", s_v_o)
cv.imshow("V_verilog", v_v_o)

cv.waitKey(0)*/