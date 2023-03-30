# Localization and Cloning the Repository: 
**This Localization is tested on a windows machine as of 3/24/23**
##  Video tutorial: https://www.youtube.com/watch?v=l-xhTzQk8qA

1. Requirements 
* Flutter 3.3.8 (or newer) https://docs.flutter.dev/get-started/install
* Python  3.8–3.11 (3.9.6 recomended)  https://www.python.org/downloads/release/python-396/
* MariaDB  10.10.2 (or newer) https://mariadb.org/download/?t=mariadb&p=mariadb&r=10.10.2&os=windows&cpu=x86_64&pkg=msi&m=gigenet
* Apache 2.4.56 https://www.apachelounge.com/download/


Install guides: 


* Apache: https://www.youtube.com/watch?v=Eg0M5x-BBGw
* Flutter: https://www.youtube.com/watch?v=VFDbZk2xhO4&t=508s


the rest of this document assumes you have set up the required dev tools above including downloading required dependent technologies for flutter and set up system paths to respective bin files



2. Configuring Apache:

fresh install of apache used and assuming that httpd was already installed as a service on your machine 
* open httpd.conf which can be found in the conf folder of your apache installation 
*  change line 60 from: Listen 80 to: 

        Listen 8000     
*  uncomment line 120: 
  
       LoadModule headers_module modules/mod_headers.so 

*  uncomment line 143:  
    
       LoadModule proxy_module modules/mod_proxy.so 

*  uncomment line 152:
    
       LoadModule proxy_http_module modules/mod_proxy_http.so

*  at the end of the file add:

	   ProxyPass / http://127.0.0.1:5000/
	   RequestHeader set X-Forwarded-Proto http
	   RequestHeader set X-Forwarded-Prefix / Create 
           
a virtual environment in python to run the app.py file (a method also described here: https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/)

on command line/terminal line, change the directory into the backend directory ./code/backend

enter in the command line: 

      pip install virtualenv
* enter in the command line:
    
      py -m venv env 
* enter into the virtual environment by entering: 
      
      .\env\Scripts\activate


The next step is done while in the virtual environment


1. Downloading Python Requirements onto the virtual system environment 
* while in the backend virtual environment as in the previous step 
*  enter in the command line:

        pip install -r requirements.txt
*  all dependencies should be downloaded onto your system


4. add 'config.json' file inside the backend folder 'code/backend':

        {
            "mysql":{
            "host":"localhost",
            "user":"root",
            "port": {port that mariadb server running on} ,
            "passwd": "{password for database server}",
            "db":"crab"
            }
        }

5. add 'salt.json' file inside the backend folder 'code/backend':

        {
            "salt":{
                "salt_string":"{secret salt string goes here}"
        }


6. add new folder to backend called "templates" in the backend folder 'code/backend'



7. Download and add "modelGen.h5" and "modelMel.h5" and add these files to the backend folder

 model files can be gotten by submitting a models inquiry  to: crabuofr@gmail.com



8. Running the application:
currently, there is an issue where our application can only run on browsers on mobile phones or through launching the frontend as an executable  on desktop 

- Running on mobile 
  -  open command prompt 
  -  enter in command line: 
        
          ipconfig 
  -  copy the IPv4 address of your Wireless LAN adapter Wi-Fi (ex: 142.3.83.240)
  -  open the file 'api_manager.dart' that can be found in this path: code/FrontEnd_V1/lib/Utils
  -  change the URL Variable to http://{your IPv4 address}:8000
  -  in a command line go to  'code/FrontEnd_V1'
  -  enter in command line : 
  
          flutter build web --release --base-href=/web/
  -  after flutter is done building copy everything from 'code/FrontEnd_V1/build/web' and past it into the folder 'code/backend/templates'
  -  enter into your virtual environment in the 'code/backend' as described im step 2 
  -  enter in command line: 
  
          flask run
  
  -  start your apache service, you can do so in the Services Application 
  -  on your mobile device, go to your browser of choice and enter {your IPv4 address}:8000
- Running on desktop:
  -  open command prompt 
  -  enter in command line: 
        
          ipconfig 
  -  copy the IPv4 address of your Wireless LAN adapter Wi-Fi (ex: 142.3.83.240)
  -  open the file 'api_manager.dart' that can be found in this path: code/FrontEnd_V1/lib/Utils
  -  change the URL Variable to http://{your IPv4 address}:8000
  
  -  change directory to 'code/FrontEnd_V1'
  -  enter in the command line 
            
          flutter run 
