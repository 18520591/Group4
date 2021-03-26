import os
os.system('python3 rgb2txt.py')
os.system('vlog "/home/thevu/Desktop/CE434/week2/LAB1/convert/Convert_Circuit.v" "/home/thevu/Desktop/CE434/week2/LAB1/convert/Test_Convert_Circuit.v"')
os.system('vsim -c -do "run -all" Test_Convert_Circuit.v')
os.system('python3 "/home/thevu/Desktop/CE434/week2/LAB1/convert.py"')
