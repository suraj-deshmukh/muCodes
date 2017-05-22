from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation, Flatten
from keras.layers import Convolution2D, MaxPooling2D
from keras.optimizers import SGD
import numpy as np
import cv2
from keras import backend as K
K.set_image_dim_ordering('th')

model = Sequential()
model.add(Convolution2D(32, kernel_size=(3, 3),padding='same',input_shape=(3 , 100, 100)))
model.add(Activation('relu'))
model.add(Convolution2D(64, (3, 3)))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.25))

model.add(Convolution2D(64,(3, 3), padding='same'))
model.add(Activation('relu'))
model.add(Convolution2D(64, 3, 3))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.25))

model.add(Flatten())
model.add(Dense(512))
model.add(Activation('relu'))
model.add(Dropout(0.5))
model.add(Dense(5))
model.add(Activation('sigmoid'))

sgd = SGD(lr=0.01, decay=1e-6, momentum=0.9, nesterov=True)
model.compile(loss='binary_crossentropy', optimizer=sgd, metrics=['accuracy'])
model.load_weights("weights.hdf5")

classes = ['desert','mountains','water','sunset','trees']
threshold = np.array([0.6,  0.3,  0.4,  0.3,  0.7])

def get_image_scenes_prediction(image_path):
    img = cv2.imread(image_path)
    img = cv2.resize(img,(100,100))
    img = img.transpose((2,0,1))
    img = img.astype('float32')
    img = img/255
    img = np.expand_dims(img,axis=0)
    pred = model.predict(img)
    return pred

def scenes_predict(image_path):
    proba = get_image_scenes_prediction(image_path)
    pred = np.array([1 if proba[0,i]>=threshold[i] else 0 for i in range(proba.shape[1])])
    labels = [classes[i] for i in range(5) if pred[i]==1 ]
    return ','.join(labels)
