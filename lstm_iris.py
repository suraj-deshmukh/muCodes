from sklearn.datasets import load_iris
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation
from keras.optimizers import SGD
from keras.layers import Embedding
from keras.layers import LSTM
import keras
import numpy as np

data = load_iris()
x = data.data
X = []
for i in x:
    X.append([[j] for j in i])

X = np.array(X)

y = data.target
y = keras.utils.np_utils.to_categorical(y)

model = Sequential()
model.add(LSTM(128,input_shape=(4,1),return_sequences=False))
model.add(Dropout(0.5))
model.add(Dense(32))
model.add(Dense(3, activation='softmax'))

model.compile(loss='categorical_crossentropy',
              optimizer='sgd',
              metrics=['accuracy'])

model.fit(X, y, batch_size=16, nb_epoch=10)
score = model.evaluate(X, y, batch_size=16)
