import os
import logging

from flask import Flask, jsonify, render_template, request, send_from_directory
from flask_restful import Api, Resource


import json
import math
import os
import cv2
import shutil
import zipfile
from PIL import Image
import numpy as np
from keras import layers
from tensorflow.keras.applications import ResNet50,MobileNet, DenseNet201, InceptionV3, NASNetLarge, InceptionResNetV2, NASNetMobile
from keras.callbacks import Callback, ModelCheckpoint, ReduceLROnPlateau, TensorBoard
from keras.preprocessing.image import ImageDataGenerator
from keras.preprocessing.image import load_img
from keras.preprocessing.image import img_to_array
from keras.preprocessing.image import array_to_img
from keras.utils.np_utils import to_categorical
from keras.models import Sequential, load_model
from tensorflow.keras.optimizers import Adam
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import cohen_kappa_score, accuracy_score
import scipy
from tqdm import tqdm
import tensorflow as tf
from keras import backend as K
import gc
from functools import partial
from sklearn import metrics
from collections import Counter
import json
import itertools
from pathlib import Path
import time
import mariadb


#app.logger.info(datalist)
#logging.basicConfig(level=logging.DEBUG)
 

 # assume you have created a uploads folder
 #DATE - format YYYY-MM-DD for sql 

# CREATE DATABASE IF NOT EXISTS crab;
# USE crab; 
app = Flask(__name__)
api = Api(app)
if not os.path.exists(r".\uploads"):
   os.makedirs(r".\uploads")
model = load_model(r".\model.h5")
with open("config.json") as json_data_file:
    mysqlconfig = json.load(json_data_file)
print (mysqlconfig['mysql']['passwd'])
print (mysqlconfig['mysql']['port'])
print (mysqlconfig['mysql']['host'])
print (mysqlconfig['mysql']['user'])
print (mysqlconfig['mysql']['db'])
config = {
    'host': mysqlconfig['mysql']['host'],
    'port': mysqlconfig['mysql']['port'],
    'user': mysqlconfig['mysql']['user'],
    'password': mysqlconfig['mysql']['passwd'],
    'database': mysqlconfig['mysql']['db']
}

conn = mariadb.connect(**config)
# create a connection cursor
cur = conn.cursor()
# execute a SQL statement
#to 

cur.execute('CREATE TABLE IF NOT EXISTS users ( UserID INT NOT NULL PRIMARY KEY AUTO_INCREMENT, FirstName VARCHAR(255) NOT NULL, Email VARCHAR(255) NOT NULL, LastName VARCHAR(255) NOT NULL,  Password VARCHAR(255) NOT NULL, DOB DATE);')
cur.execute('SELECT * FROM users') # need to use fetchall to print 
#cur is a curser that contains mory of previous execution 
rows = cur.fetchall()    # get all selected rows, as Barmar mentioned
for r in rows:
    print(r)
conn.commit()
conn.close() 
class Upload(Resource):
    def post(self):
        
         
        print (request.files)
        print (request.files["image"].filename)
        print (request.files["image"].mimetype)
        print (request.files["image"].content_type)
        
    
        image = request.files['image']
        image.save(os.path.join(r".\uploads" , image.filename))   
        img = load_img(fr".\uploads\{image.filename}")
        img_array = img_to_array(img)
        img_4d = img_array.reshape(-1,224,224,3)
        prediction=model.predict(img_4d)[0]
        benignResult = str((prediction[0])*100)
        melignentResult = str((prediction[1])*100)
        print("benign:" + benignResult + "malignent:" + melignentResult)
        os.remove(fr".\uploads\{image.filename}")
        #image = request.files('image');
        #image.save(os.path.join(uploads_path , image.filename))
        response = jsonify({'benign': benignResult,'malignent':melignentResult})
        response.headers.add('Access-Control-Allow-Origin', '*') # needed line to fix CORS error 
        return response
class SignUp(Resource):
    def post(self):
        
         
        print (request.values['email'])
        print (request.values['email'])
        print (request.values['email'])
        print (request.values['email'])
        print (request.values['email'])
        fName = request.values['fName']
        lName = request.values['lName']
        email = request.values['email']
        password = request.values['pass']
        dOB  = request.values['dOB']
        
        conn = mariadb.connect(**config)
        cur = conn.cursor()
        cur.execute("INSERT INTO users (FirstName,LastName, Email,Password,DOB) VALUES (?, ?, ?, ?, ?)",(fName,lName,email,password,dOB))
        
        conn.commit()
        conn.close() 
        ##image = request.files['image']
        #image.save(os.path.join(r".\uploads" , image.filename))   
        #img = load_img(fr".\uploads\{image.filename}")
        #img_array = img_to_array(img)
        #img_4d = img_array.reshape(-1,224,224,3)
        #prediction=model.predict(img_4d)[0]
        #benignResult = str((prediction[0])*100)
        #melignentResult = str((prediction[1])*100)
        #print("benign:" + benignResult + "malignent:" + melignentResult)
        #os.remove(fr".\uploads\{image.filename}")
        #image = request.files('image');
        
        #image.save(os.path.join(uploads_path , image.filename))
        response = jsonify({'benign': "hello",'malignent':"he"})
        response.headers.add('Access-Control-Allow-Origin', '*') # needed line to fix CORS error 
        return response

api.add_resource(Upload, '/upload')
api.add_resource(SignUp, '/signUp')


if __name__ == '__main__':
    app.run(debug=True)

