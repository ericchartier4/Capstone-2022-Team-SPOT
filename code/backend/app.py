import os
import logging

from flask import Flask, jsonify, render_template, request, send_from_directory,make_response
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
from keras.callbacks import Callback, ModelCheckpoint, ReduceLROnPlateau, TensorBoard
from keras.preprocessing.image import ImageDataGenerator
from keras_preprocessing.image import load_img 
from keras_preprocessing.image import img_to_array
from keras_preprocessing.image import array_to_img
from keras.utils.np_utils import to_categorical
from keras.models import Sequential, load_model
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.model_selection import train_test_split
import keras.applications.mobilenet
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
from datetime import date
import base64
import hashlib
import encodings

from werkzeug.middleware.proxy_fix import ProxyFix

# Dictionary :
#     'NV': 'Melanocytic nevi',
#     'Mel': 'Melanoma',
#     'BKL': 'Benign keratosis-like lesions ',
#     'BCC': 'Basal cell carcinoma',
#     'Akiec': 'Actinic keratoses',
#     'Vasc': 'Vascular lesions',
#     'DF': 'Dermatofibroma'
#     'MelBen' : 'Benign  Melanoma'
#     'MelMalig' : 'Malignant Melanoma'







app = Flask(__name__)
api = Api(app)
if not os.path.exists(r".\uploads"):
   os.makedirs(r".\uploads")
modelGen = load_model(r".\modelGen.h5")

modelMel = load_model(r".\modelMel.h5")                           


with open("config.json") as json_data_file:
    mysqlconfig = json.load(json_data_file)
config = {
    'host': mysqlconfig['mysql']['host'],
    'port': mysqlconfig['mysql']['port'],
    'user': mysqlconfig['mysql']['user'],
    'password': mysqlconfig['mysql']['passwd'],
    'database': "crab"
}

with open("salt.json") as salt_file:
    salt_json = json.load(salt_file)
salt = salt_json["salt"]["salt_string"]



conn = mariadb.connect(host=mysqlconfig['mysql']['host'],port=mysqlconfig['mysql']['port'],password=mysqlconfig['mysql']['passwd'],user=mysqlconfig['mysql']['user'])
cur = conn.cursor()
cur.execute('CREATE DATABASE IF NOT EXISTS crab;')
conn.commit()
conn.close()  
conn = mariadb.connect(**config)

cur = conn.cursor()
# for line 100 , make sure EntryURL is the last element for functionality on line 391
cur.execute('CREATE TABLE IF NOT EXISTS users ( UserID INT NOT NULL PRIMARY KEY AUTO_INCREMENT, FirstName VARCHAR(255) NOT NULL, Email VARCHAR(255) NOT NULL, LastName VARCHAR(255) NOT NULL,  Password VARCHAR(255) NOT NULL);')
cur.execute('CREATE TABLE IF NOT EXISTS entries ( EntryID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,UserID INT NOT NULL, FOREIGN KEY (UserID)  REFERENCES users(UserID), EntryText LONGTEXT, EntryArea LONGTEXT, NV FLOAT,  Mel FLOAT,  BLK FLOAT,  BCC FLOAT,  Akiec FLOAT ,  Vasc FLOAT ,  DF FLOAT, MelBen FLOAT , MelMalig FLOAT, EntryDate DATE,ImageURL LONGTEXT);')
conn.commit()
conn.close() 

app.wsgi_app = ProxyFix(
    app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1
)

def analyzePhoto(img):
    imgArray = img_to_array(img)
    imgGen = img.resize((100,100))
    imgGenArray = img_to_array(imgGen)
    imgMel = img.resize((224,224))
    imgMelArray  = img_to_array(imgMel)
    img4dMel = imgMelArray.reshape(-1,224,224,3)
    img4dGen = imgGenArray.reshape(-1,100,100,3)


    genPrediction = modelGen.predict(img4dGen)[0]
  
    melPrediction = modelMel.predict(img4dMel)[0]  
    melResult = ((genPrediction[1])*100) 
    melResult= (np.round(melResult,1))
    melBenResult = ((melPrediction[0])*100)
    melBenResult= (np.round(melBenResult,1))
    melMaligResult = ((melPrediction[1])*100)
    melMaligResult = (np.round(melMaligResult,1))
   
    




    nVResult = ((genPrediction[0])*100)
    nVResult =  (np.round(nVResult,1))
    bKLResult = ((genPrediction[2])*100)
    bKLResult= (np.round(bKLResult,1))
    bCCResult = ((genPrediction[3])*100)
    bCCResult= (np.round(bCCResult,1))
    akiecResult =  ((genPrediction[4])*100)
    akiecResult= (np.round(akiecResult,1))
    vascResult = ((genPrediction[5])*100)
    vascResult = (np.round(vascResult,1))
    dFResult = ((genPrediction[6])*100)
    dFResult = (np.round(dFResult,1))

    return   melResult,   melBenResult,  melMaligResult, nVResult, bKLResult, bCCResult, akiecResult, vascResult, dFResult

def saltHash(password):
    password = str(password)+salt
    sha256 =hashlib.sha256()
    sha256.update(password.encode("utf-8"))
    password = sha256.hexdigest()
    return password
   


TEMPLATES_DIR = 'templates'

@app.route('/')
def render_page_web():
    
    return render_template('index.html')

@app.route('/web/<path:name>')
def return_flutter_doc(name):

    pathlist = str(name).split('/') 
    DIR_NAME = TEMPLATES_DIR

    if len(pathlist) > 1:
        for i in range(0, len(pathlist) - 1):
            DIR_NAME += '/' + pathlist[i]

    return send_from_directory(DIR_NAME, pathlist[-1])




class SignUp(Resource):
    def post(self):
        
         
        fName = request.values['fName']
        lName = request.values['lName']
        email = request.values['email']
        password = request.values['pass']
        password =saltHash(password)       
        
        conn = mariadb.connect(**config)
        cur = conn.cursor()
        cur.execute("INSERT INTO users (FirstName,LastName, Email,Password) VALUES (%s, %s, %s, %s)",(fName,lName,email,password))
        
        conn.commit()
        conn.close()
        
     
        response = jsonify({'status':"200"})
        response.headers.add('Access-Control-Allow-Origin', '*') # needed line to fix CORS error 
        return response

class LogIn(Resource):
    def post(self):
        
         
        email = request.values['email']
        password = request.values['pass']
        password =saltHash(password)   
      
        
        conn = mariadb.connect(**config)
        cur = conn.cursor()

        sql = "SELECT *  FROM users WHERE Email = %s AND Password = %s;"
        
        val = (email,password)
        cur.execute(sql,val)
        results = cur.fetchall()
        
        
        if (len(results) > 0):
            response = jsonify({'Result': True})
        else:
            response = jsonify({'Result': False})
        
        


        
        conn.commit()
        conn.close() 
       
        response.headers.add('Access-Control-Allow-Origin', '*') # needed line to fix CORS error 
        return response



class AddEntry(Resource):
    def post(self):

        melResult = 0
        melBenResult = 0   
        melMaligResult = 0  
        nVResult = 0  
        bKLResult = 0 
        bCCResult = 0  
        akiecResult = 0
        vascResult = 0 
        dFResult = 0 
        
        upload_path = r'.\uploads'
        filecount = 0
        # Iterate uplad direct
        for path in os.listdir(upload_path):
            if os.path.isfile(os.path.join(upload_path, path)):
                filecount += 1
         
        email = request.values['email']
        password = request.values['pass']
        password =saltHash(password)   
        details = request.values['details']
        area = request.values['area']
        conn = mariadb.connect(**config)
        cur = conn.cursor()

        sql = "SELECT UserID  FROM users WHERE Email = %s AND Password = %s;"

        
        val = (email,password)
        cur.execute(sql,val)
        results = cur.fetchall()
        if results == []:
            conn.close() 
            image = request.files['image']
            imageName = "quickscanImage"+str(filecount) # geting file extention 
            image.save(os.path.join(r".\uploads" , imageName))   
            img = load_img(fr".\uploads\{imageName}")
            
            melResult,   melBenResult,  melMaligResult, nVResult, bKLResult, bCCResult, akiecResult, vascResult, dFResult = analyzePhoto(img)
            os.remove(fr".\uploads\{imageName}")
        else:
            userID_tuple = results[0]
            userID = userID_tuple[0]
            image = request.files['image']
            imageName = image.filename+str(filecount)+"."+image.content_type.split('/')[-1] # geting file extention 
            image.save(os.path.join(r".\uploads" , imageName))   
            img = load_img(fr".\uploads\{imageName}")
            melResult,   melBenResult,  melMaligResult, nVResult, bKLResult, bCCResult, akiecResult, vascResult, dFResult = analyzePhoto(img)
            cur.execute("INSERT INTO entries (UserID,EntryText, EntryArea,NV, Mel,BCC, BLK, Akiec, Vasc, DF, MelBen, MelMalig,EntryDate,ImageURL) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",(userID,details,area,nVResult,melResult,bCCResult,bKLResult,akiecResult,vascResult,dFResult,melBenResult,melMaligResult,date.today(),imageName))
            conn.commit()
            conn.close() 

        
     
        entryDict = {'nVResult':str(nVResult),'melResult':str(melResult),'bCCResult':str(bCCResult),'bKLResult':str(bKLResult),'akiecResult':str(akiecResult),'vascResult':str(vascResult),'dFResult':str(dFResult),'melBenResult':str(melBenResult),'melMaligResult':str(melMaligResult),'scan':'null','date':'null','about':'null','area':'null','imageBinary':'null'}
        entriesList = []
        entriesList.append(entryDict)
        response = jsonify(entriesList)
       
 
        response.headers.add('Access-Control-Allow-Origin', '*') # needed line to fix CORS error 
        return response
    



class GetEntries(Resource):
    def post(self):
        
         
        email = request.values['email']
        password = request.values['pass']
        password =saltHash(password)   
      
        conn = mariadb.connect(**config)
        cur = conn.cursor()

        sql = "SELECT UserID  FROM users WHERE Email = %s AND Password = %s;"
        
        val = (email,password)
        cur.execute(sql,val)
        results = cur.fetchall()
        userID_tuple = results[0]
        userID = userID_tuple[0]
       
        str_UserID = str


        sql = "SELECT *  FROM entries WHERE UserID = %s;"
        
    
        cur.execute(sql,(str(userID),)) 
        results = cur.fetchall()
        entriesList =[]
        if results == []:
            conn.close() 
            entriesList.append({'date':"NullList"})
            response = jsonify(entriesList)
        
            response.headers.add('Access-Control-Allow-Origin', '*') # needed line to fix CORS error 
            return response   



        for val in results:
            
            entryID,userID,entryText,entryArea,nVResult, melResult, bKLResult, bCCResult, akiecResult, vascResult, dFResult,   melBenResult,  melMaligResult, entryDate,entryURL = val
            imageBinary = "null"
            with open(os.path.join(r".\uploads" , entryURL),"rb") as imageData:
                  imageBinary = imageData.read()
                  imageBinary = base64.b64encode(imageBinary).decode('ascii')
                 
                  
            entryDict = {'nVResult':str(nVResult),'melResult':str(melResult),'bCCResult':str(bCCResult),'bKLResult':str(bKLResult),'akiecResult':str(akiecResult),'vascResult':str(vascResult),'dFResult':str(dFResult),'melBenResult':str(melBenResult),'melMaligResult':str(melMaligResult),'scan':str(entryID),'date':str(entryDate),'about':entryText,'area':entryArea,'imageBinary':imageBinary}
            entriesList.append(entryDict)
        response = jsonify(entriesList)
     
       
    



        conn.commit()
        conn.close() 
        response.headers.add('Access-Control-Allow-Origin', '*') # needed line to fix CORS error 
        
        return response

class DeleteEntries(Resource):
    def post(self):
        
         
        email = request.values['email']
        password = request.values['pass']
        entryID = request.values['entryID']
        password =saltHash(password)   
       
        
        conn = mariadb.connect(**config)
        cur = conn.cursor()

        

        sql = "SELECT UserID  FROM users WHERE Email = %s AND Password = %s;"
        
        val = (email,password)
        cur.execute(sql,val)
        results = cur.fetchall()
        userID_tuple = results[0]
        userID = userID_tuple[0]
        
        str_UserID = str


        sql = "SELECT *  FROM entries WHERE UserID = %s  AND EntryID = %s;"
        
    
        cur.execute(sql,(str(userID),entryID)) 
        results = cur.fetchall()
        for val in results: 
            entryURL = val[-1]
            os.remove(fr".\uploads\{entryURL}")




        sql = "DELETE FROM entries WHERE UserID = %s  AND EntryID = %s;"
       
        cur.execute(sql,(str(userID),entryID)) 
        conn.commit()
        conn.close() 
        response = jsonify({'status':"200"})
        response.headers.add('Access-Control-Allow-Origin', '*') # needed line to fix CORS error 
        return response   
    


class DeleteAccount(Resource):
    def post(self):
        
         
        email = request.values['email']
        password = request.values['pass']
        password =saltHash(password)   
       
       
        
        conn = mariadb.connect(**config)
        cur = conn.cursor()

        

        sql = "SELECT UserID  FROM users WHERE Email = %s AND Password = %s;"
        
        val = (email,password)
        cur.execute(sql,val)
        results = cur.fetchall()
        userID_tuple = results[0]
        userID = userID_tuple[0]
        
        str_UserID = str


        sql = "SELECT * FROM entries WHERE UserID = %s;"
        
    
        cur.execute(sql,(str(userID),)) 
        results = cur.fetchall()
        for val in results: 
            entryURL = val[-1]
            os.remove(fr".\uploads\{entryURL}")


        sql = "DELETE FROM entries WHERE UserID = %s;"
       
        cur.execute(sql,(str(userID),)) 

        sql = "DELETE FROM users WHERE UserID = %s AND Password = %s ;"
       
        cur.execute(sql,(str(userID),password)) 

       

        conn.commit()
        conn.close() 
        response = jsonify({'status':"200"})
        response.headers.add('Access-Control-Allow-Origin', '*') # needed line to fix CORS error 
        return response   


      


api.add_resource(SignUp, '/signUp')
api.add_resource(LogIn, '/logIn')
api.add_resource(AddEntry, '/addEntry')
api.add_resource(GetEntries, '/getEntries')
api.add_resource(DeleteEntries, '/deleteEntries')
api.add_resource(DeleteAccount, '/deleteAccount')


if __name__ == '__main__':
    app.run()

