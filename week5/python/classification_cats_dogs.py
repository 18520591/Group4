import os
import numpy as np 
import pandas as pd 
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Activation, Dropout, Flatten
from tensorflow.keras.layers import Convolution2D
from tensorflow.keras.layers import MaxPooling2D
from sklearn.model_selection import train_test_split
from keras.preprocessing.image import ImageDataGenerator
import matplotlib.pyplot as plt
from zipfile import ZipFile
ZipFile("drive/My Drive/MicrochipDesign/test.zip","r").extractall()
ZipFile("drive/My Drive/MicrochipDesign/train.zip", "r").extractall()
#
train_dir = "./train"
test_dir = "./test1"

train_names = os.listdir(train_dir)
categories = []
for i in train_names: 
    category = i.split(".")[0]
    if category == "dog":
        categories.append("dog")
    else:
        categories.append("cat")
train = pd.DataFrame({
    "filename" : train_names,
    "category" : categories
})
input_shape = (224, 224, 3)
#VGG-16
model = tf.keras.models.Sequential([
    Convolution2D(filters=64, kernel_size=(3,3), activation = 'relu', input_shape=input_shape, padding="same"),
    Convolution2D(filters=64, kernel_size=(3,3), activation = 'relu', padding="same"),
    MaxPooling2D(pool_size=(2, 2), strides=(2,2)),
    Convolution2D(filters=128, kernel_size=(3,3), activation = 'relu', padding="same"),
    Convolution2D(filters=128, kernel_size=(3,3), activation = 'relu', padding="same"),
    MaxPooling2D(pool_size=(2, 2), strides=(2,2)),
    Convolution2D(filters=256, kernel_size=(3,3), activation = 'relu', padding="same"),
    Convolution2D(filters=256, kernel_size=(3,3), activation = 'relu', padding="same"),
    Convolution2D(filters=256, kernel_size=(3,3), activation = 'relu', padding="same"),
    MaxPooling2D(pool_size=(2, 2), strides=(2,2)),
    Convolution2D(filters=512, kernel_size=(3,3), activation = 'relu', padding="same"),
    Convolution2D(filters=512, kernel_size=(3,3), activation = 'relu', padding="same"),
    Convolution2D(filters=512, kernel_size=(3,3), activation = 'relu', padding="same"),
    MaxPooling2D(pool_size=(2, 2), strides=(2,2)),
    Convolution2D(filters=512, kernel_size=(3,3), activation = 'relu', padding="same"),
    Convolution2D(filters=512, kernel_size=(3,3), activation = 'relu', padding="same"),
    Convolution2D(filters=512, kernel_size=(3,3), activation = 'relu', padding="same"),
    MaxPooling2D(pool_size=(2, 2), strides=(2,2)),
    Flatten(),
    Dense(4096, activation = 'relu'),
    Dense(4096, activation = 'relu'),
    Dense(1, activation = 'softmax')
])
#chia tap train va validation

train_f, validate_f = train_test_split(train, test_size = 0.2, random_state = 42)
train_f = train_f.reset_index(drop = True)
validate_f = validate_f.reset_index(drop = True)

#tao tap train
train_datagen = ImageDataGenerator(rotation_range=40,
    rescale=1./255,
    shear_range=0.2,
    zoom_range=0.5,
    horizontal_flip=True,
    width_shift_range=0.2,
    height_shift_range=0.2
)

train_generator = train_datagen.flow_from_dataframe(
    train_f, 
    "./train", 
    x_col='filename',
    y_col='category',
    target_size=(224,224),
    class_mode='binary',
    batch_size=64,
    color_mode="rgb",
    shuffle=True,
    validate_filenames=False
)
#tao tap validation

validation_datagen = ImageDataGenerator(rescale=1./255)

validation_generator = validation_datagen.flow_from_dataframe(
    validate_f, 
    "./train", 
    x_col='filename',
    y_col='category',
    target_size=(224,224),
    class_mode='binary',
    batch_size=64,
    color_mode="rgb",
    shuffle=True,
    validate_filenames=False
)
model.compile(optimizer='adam',
              loss='binary_crossentropy',
              metrics = ['accuracy'])

#
history = model.fit_generator(
    train_generator,
    steps_per_epoch=len(train_f)/64,
    epochs=10,
    validation_data=validation_generator,
    validation_steps=len(validate_f)/64
)
#-----------------------------------------------------------
#-----------------------------------------------------------
acc      = history.history[     'accuracy' ]
val_acc  = history.history[ 'val_accuracy' ]
loss     = history.history[    'loss' ]
val_loss = history.history['val_loss' ]

epochs   = range(len(acc)) 

#------------------------------------------------
#------------------------------------------------
plt.plot  ( epochs,     acc )
plt.plot  ( epochs, val_acc )
plt.title ('Training and validation accuracy')
plt.figure()

#------------------------------------------------
#------------------------------------------------
plt.plot  ( epochs,     loss )
plt.plot  ( epochs, val_loss )
plt.title ('Training and validation loss'   )
