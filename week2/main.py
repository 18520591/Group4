import os
os.system('python3 rgb2txt.py')
os.system('vlog "/home/thevu/Desktop/CE434/week2/LAB1/convert/rgb_to_hsv.v" "/home/thevu/Desktop/CE434/week2/LAB1/convert/testbench.v"')
os.system('vsim -c -do "run -all" testbench.v')
os.system('python3 "/home/thevu/Desktop/CE434/week2/LAB1/convert.py"')
