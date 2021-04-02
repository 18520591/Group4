import cv2 as cv
import numpy as np
'''
# convert from float(+) to floating point
def float_to_floatingPoint(a):
    if (a == 0):
        return '00000000000000000000000000000000'
    b = int(a)
    c = a - int(a)
    b = bin(b)
    b = b[2:len(b)]
    i = 0
    d = '0'
    while (i < 73 and c != 0):
        i = i + 1
        c = c * 2
        if c >= 1:
            c = c - 1
            d = d + '1'
        else:
            d = d + '0'
    num = b + d[1:len(d)]
    i = 0
    while (num[i] != '1'):
        i = i + 1
    t = i + 1
    ex = bin(127 + (len(b) - i - 1))
    ex = ex[2:len(ex)]
    ex = ex[::-1]
    if(len(ex) < 8):
        temp = len(ex)
        for i in range(temp, 8):
            ex = ex + '0'
    ex = ex[::-1]
    num = num[t:len(num)]
    if (len(num) > 23):
        fr = num[0:23]
    elif (len(num) < 23):
        temp = len(num)
        for i in range(temp, 23):
            num = num + '0'
        fr = num
    else:
        fr = num
    return '0' + ex + fr
           
'''
img = cv.imread('/home/dat/MicrochipDesign/LAB1/lucbinh.jpg')
(height, width,depth) = img.shape


f = open("/home/dat/MicrochipDesign/LAB1/rgb.txt","w")
for i in range(0,height):
    for j in range(0,width):
        (B, G, R) = img[i][j]
        r = str(R)
        g = str(G)
        b = str(B)
        f.write(r + " " + g + " " + b +"\n")
f.close()