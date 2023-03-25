# Capstone-2022-Team-Crab

## Project Name: SPOT 

## Team Members: 
* Chirayu Patel
* Eric Chartier
* Kyle Jakob Labatete
* Yuting Li

# Project Idea: 
Our original goal is to build an AI application that users can upload images of their skin and this application will tell them whether they might have melanoma (skin cancer).
But upon completion of the AI to detectect melanoma, the Project scope has widened to include the  detection of the seven most comon skin diseases:  
*  Bowen's disease
*  Basal cell carcinoma
*  Benign keratosis-like lesions 
*  Melanoma
*  Melanocytic nevi
*  Vascular lesions

# Project background/Business Opportunity

We choose to do this AI application because it fulfils one of the 17 goals of the UN: good health and well-being. According to our research, the international average diagnosis price of melanoma is $150 USD per month, and the total cost of a patient could reach $3800 - $8000. Furthermore, the cost of skin cancer treatment varies from $4960 to $170,515, the later the stages the higher the cost. We decided to develop an application that is easily accessible to everyone at little or no cost, and we aim to diagnose melanoma as early as possible and thereby to save the patients from suffering and economic losses.  There are existing applications that provide similar services, however, according to research overseen by Memorial Sloan Kettering Cancer Center (MSK) dermatologists Veronica Rotemberg and Allan Halpern reported that the overall accuracy of the apps that were evaluated was only 59%. Today is the era that the application of convolution algorithm on image recognition has become mature, and therefore we choose convolution as our primary algorithm and this should provide us with a much higher accuracy rate.

# Localization and Cloning the Repository: 
**This Localization is tested on a windows machine as of 3/24/23**
##  Video tutorial:

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

        listen 8000     
*  uncomment line 120: 
  
       LoadModule headers_module modules/mod_headers.so 

*  uncomment line 143:  
    
       LoadModule proxy_module modules/mod_proxy.so 

*  uncomment line 152:
    
       LoadModule proxy_http_module modules/mod_proxy_http.so

*  at the end of the file add:

	   ProxyPass / http://127.0.0.1:5000/
	   RequestHeader set X-Forwarded-Proto http
	   RequestHeader set X-Forwarded-Prefix / 

3. Create virtual environment in python to run the app.py file (a method also described here: https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/)
* on command line/terminal line, change the directory into the backend directory ./code/backend
* enter in command line: 

      pip install virtualenv
* enter in the command line:
    
      py -m venv env 
* enter into the virtual environment by entering: 
      
      .\env\Scripts\activate


The next step is done while in the virtual environment


3. Downloading Python Requirements onto virtual system environment 
* while in the back end virtual environment as in the previous step 
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



7. Download and add "model77.h5" and "modelMel.h5" and add these files to the backend folder

### model files can be gotten by submitting a models request to: crabuofr@gmail.com

8. Running the application

### currently an issue where our application can only run on mobile phones  or desktop, not both

- Running on mobile 
  -  open command prompt 
  -  enter in command line: ipconfig 
  -  copy the IPv4 address of your Wireless LAN adapter Wi-Fi (ex: 142.3.83.240)
  -  open the file 'api_manager.dart' that can be found in this path: code/FrontEnd_V1/Utils
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
  -  open the file 'api_manager.dart' that can be found in this path: code/FrontEnd_V1/Utils
  -  change the URL Variable to http://127.0.0.1:5000
  -  enter into your virtual environment in the 'code/backend' as described im step 2 
  -  enter in command line: 
  
          flask run
  -  change directory to 'code/FrontEnd_V1'
  -  enter in the command line 
            
          flutter run 
