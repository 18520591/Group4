import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt

img = cv.imread('/home/dat/MicrochipDesign/LAB1/anh.png')
hsv = cv.cvtColor(img, cv.COLOR_BGR2HSV)
h, s, v = cv.split(hsv)
hsv = cv.merge([v, s, h])

plt.imshow(hsv)
plt.title('anh HSV xu ly theo ham cua python', fontweight ="bold")
plt.show()

cv.waitKey(0)