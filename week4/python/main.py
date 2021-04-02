import os
import cv2
import numpy as np

os.system('python3 /home/dat/MicrochipDesign/LAB1/rgb2txt.py')

os.system('vlog "/home/dat/MicrochipDesign/LAB1/convert_fl/Convert.v" "/home/dat/MicrochipDesign/LAB1/convert_fl/testbench.v"')
os.system('vsim -c -do "run -all" testbench')
os.system('python3 /home/dat/MicrochipDesign/LAB1/convert.py')
