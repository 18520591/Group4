import json
from jinja2 import Template
import jinja2
from tensorflow import keras

#lay file mau
def get_template_sample(filename):
    with open(filename, 'r', encoding='UTF-8') as f:
        return f.read()

#dua weight vao file .v
def save_report(content, filename):
    with open(filename, 'w', encoding='UTF-8') as f:
        f.write(content)

def build_report():
    model = keras.models.load_model("model_softmax4.h5")
    index = 0
    layer = 0
    data = GetData(model, layer, index) 
    verilog_template = get_template_sample("template.v")
    jinja2_template = Template(verilog_template)
    content = jinja2_template.render(**data)
    filename = "featuremap_template"+str(index)+".v"
    save_report(content, filename)


#lay du lieu tu model
def GetData(model, layer, index):
    weights = model.layers[layer].get_weights()[0]
    biases  = model.layers[layer].get_weights()[1]
    [a,b,c,d] = weights.shape
    data = {}
    for i in range(0,c):
        for j in range(0,b):
            for k in range(0,a):
                data['w'+str(3*j+k)+"_"+str(i+1)] = float_to_floatingPoint(weights[k][j][i][index])
        
    data['bias'] = float_to_floatingPoint(biases[index])
    return data

##chuyen tu float -> floatin point
#chuyen tu dec -> bin
def dec_to_bin(num):
  s = bin(num)
  s = s[2:len(s)]
  return s

def check(s):
  j = 0
  for i in s:
    j = j + 1
    if i == '1':
      return j

#chuyen float -> floating point
def float_to_floatingPoint(num):
  if num == 0:
    return "00000000000000000000000000000000"
  if num > 0:
    rs = '0'
  else:
    rs = '1'
  num = abs(num)
  PhanNguyen = int(num)
  PhanThapPhan = num - PhanNguyen
  tmp1 = dec_to_bin(PhanNguyen)
  i = 0
  tmp = ""
  while i<30 and PhanThapPhan!=0:
    PhanThapPhan = PhanThapPhan*2
    if(PhanThapPhan>=1):
      tmp = tmp + '1'
      PhanThapPhan = PhanThapPhan - 1
    else:
      tmp = tmp + '0'
  if num < 1:
    i = check(tmp)
    ex = 127 - i
    fr = tmp[i:len(tmp)]
  else:
    i = check(tmp1)
    ex = 127 + len(tmp1) - i
    fr = tmp1[i:len(tmp1)] + tmp
  ex = dec_to_bin(ex)
  l = len(ex)
  if l!=8:
    for i in range(0,8-l):
      ex = '0'+ex
  l = len(fr)
  if l<23:
    for i in range(0,23-l):
      fr = fr+'0'
  else:
    fr = fr[0:23]
  rs = "32'b"+rs+ex+fr
  return rs

# main
if __name__ == "__main__":
    build_report()