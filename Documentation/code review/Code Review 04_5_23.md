# Code Review 
## Date: April 5, 2023 
## Reviewer: Eric Chartier {Fullstack Developer}




## Code Formatting:

- Deleted Uneeded comments from the code 

- cammelCase convention used,
  - violations:
    -  proper names of diseases seen on line 120 of ./code/FrontEnd_V1/lib/Controllers/home_controller.dart
    - class names in ./code/backend/app.py

- There is code that needs to be scrolled horizontally Violation examples:
    - Database initalization code in ./code/backend/app.py lines 100 and 101 
    

#  Architecture
- Separation of Concerns 
- separated back end ( model) and frontend(view/controller)
    -  in front end have two separate controllers, one for authentication for sign up/log in and a second for app functionality while using quick scan/ signed in to the application Design pattern used: model view controller 


# Coding best practices
 - No hard coding, use constants/configuration values.
   - I would not say it is hard coding, but interacting with JSON strings that are coming from the backend to the front end is tedious to interact with, this needs a major refactoring, maybe using something other the jsonified strings to the frontend , it leaves the programmer needing to be very particular of the strings they use and be aware of unintended spaces in the strings. an example of this can be found on line 120 of .code/FrontEnd_V1/lib/Controllers/home_controller.dart
- Group similar values under an enumeration (enum). 
  - I do not think this is applicable, we do not have many constant values, unless you count the colours of the front end which we have grouped together in .code/FrontEnd_V1/lib/Utils/appColours.dart
  - We also enumerated the glossary that we created ./code/FrontEnd_V1/Utils/glossary.dart that is a Map/Key Value pair that can be called anywhere in the frontend and can be extended pretty easily 

- Comments
  - there are no unneeded comments but there should be a comment on lines 100 and 101  in the .code/backend/app.py about needing the EntryURL to be at the end of the creation of the entries table, this is because of line 391 of the same file that takes advantage of pythons access of arrays where [-1] accesses the last element of a list 
- Avoid multiple if/else blocks.
  - there is a big offender to this found in .code/frontend/lib/auth_controller.dart on lines 125 and 143. there are all lines that need to be run in succession, and we only want one of these failing at a time so that the error snack bar only shows one error at a time 
- Use framework features, wherever possible instead of writing custom code. 
  - this has been done multiple times throughout the code one of the big ones that was super helpful was the show dialogue  widget seen on line 77 of .code/FrontEnd_V1/lib/Screens/home_screen.dart, this widget allows me to show a pop-up that I have used multiple occasions to show things such as the example photo in ./code/FrontEnd_V1/lib/Screens/new_scan_screen.dart
# Non Functional requirements
-  Maintainability (Supportability) 
   -  Readability
      - For .code/backend/app.py, I would consider this very readable and I can account this to Python's indentation system. I would suggest a refactor of the FrontEnd_V1 dart code this is due to darts mix of different brackets that make the code very hard to read and understand where widgets start or stop, I tried to quickly add into the readability of our dart code by spacing out different sections and keeping internetworking functions such as getEntries and getEntriesHelper on line 245 and 261  of ./code/FrontEnd_V1/lib/Controllers/home_controller.dart close together as they function together. 
  -  Testability
     -    I think a great boon not only to testability but to user functionality was the addition of the "QuickScan" feature which allowed us to skip through signup/login and get directly into interacting with our backend/ AI models. I also know that for testing our AI models in our AI development environment, the package Gradio was a great help in being a simple temporary UI to test our model with 
  -  Debuggability 
     -  to increase debuggability we need to add in visible error codes to the user in the event that our HTTP request functions on lines 263, 362, 478, 522 in  ./code/FrontEnd_V1/lib/Controllers/home_controller.dart and lines 62,105 in .code/frontend/lib/auth_controller.dart return a status code other than 200 this would help us to gain information about specific errors that user may be having 
  - Configurability
    - I think that reconfigurability could be improved, with our current setup of using json strings to pass values from the front end to the backend, while there is configurability in the fact that you do not have to interact with every variable all the time, such as in the getPieChart function on line 557 of ./code/FrontEnd_V1/lib/Controllers/home_controller.dart where we do not interact with some of the json variables such as 'Scan'. the downside of this is when extending functionality to say add a new disease to be calculated there are several reconfigurability points you have to access: 
     
      - I believe there should be good configurability in seperating the backend from the front end , due to the fact that the backend is an API.
      -   in ./code/FrontEnd_V1/lib/Controllers/home_controller.dart:
        - adding in the key value pair to both the scanDocTemplate and ScanDoc on lines 53 and 79. 
        - adding in the key value pair to addToScanDoc on line 108
        - adding the key value pair into getPieChart on line 557 
      - in .code/FrontEnd_V1/lib/Screens/view_details_screen.dart: 
        - add in the key ( name of the disease) to a new getHomeCard on line 216 
      - in .code/FrontEnd_V1/lib/Screens/home_screen.dart: 
        - add in the key ( name of disease) to a new getHomeCard on line 598
      - in .code/FrontEnd_V1/lib/Utils/glossary.dart
        - add in a key value pair , the key being the name, the value being the definition 
      - in .code/backend/app.py:
        - add in a database key  for the new disease on line 101, preferably keeping Entry URL as the last key 
        - add in the new prediction entry for the new disease in analyzePhoto on line 109 
        - add in new return values for the disease on lines 279 and 288 
        - add in new key value pair for your new disease to insert into the database on line 289 
        - add in key value pair to return to frontend using json string on line 295
        - add in return value for  the new disease on line 347 
        - add in key value pair to return to frontend using json string on line 354
e can choose different front ends while the back end remains the same 
  -  Reusability
     -  I think we made some amazing strides in reusability of our code, particularly when adding a new scan, as all screens and functionality are the same whether the user is signed in or just using quickscan. the way this works is that when using quickscan we have set the users username and passwords to null values so that when the photo goes to get scanned, the backend does not find any user in its database and thus scans the photo and sends  back the results without needing to sign up/log in. 
     -  another good example of good dry code is getHomeCard from ./code/FrontEnd_V1/lib/Controllers/home_controller.dart line 626 that can take the index of the an entry in the scanDoc as well as the spacific desease name  and get a formated card back that includes a link to the spacific glossary term. 
     -  on the objective of wet code there is a lot of repatition in some code such as scanDoc intitalization  on line 79  and scanDonTemplate on line 53 of ./code/FrontEnd_V1/lib/Controllers/home_controller.dart which is the exact same I wish we could have the scan doc initalized to the template or make it so that whenever the scanDoc is called without being initalized it displays nothing. 
     -  some wet code is also found in .code/backend/app.py spacifically when getting the UserID such on line 384-392 the process of which is repeated more than once in the file. 
  - Reliability
    - There are major patches needed to be added for more reliability, these include in the http  helper function   on lines 263, 362, 478, 522 in  ./code/FrontEnd_V1/lib/Controllers/home_controller.dart and lines 62,105 in .code/frontend/lib/auth_controller.dart as they do not have any exeption functions in case the back end returns a status code other than 200 
  -  Extensibility
     -  repeating again that the biggest boon to extensability would be to refactor the steps it would take to add in a new disease to the application , to do so we would need to decrease these steps: 
        - in ./code/FrontEnd_V1/lib/Controllers/home_controller.dart:
           - adding in the key value pair to both the scanDocTemplate and ScanDoc on lines 53 amd 79. 
           - adding in the key value pair to addToScanDoc on line 108
           - adding the key value pair into getPieChart on line 557 
         - in .code/FrontEnd_V1/lib/Screens/view_details_screen.dart: 
           - add in they key ( name of desiease) to a new getHomeCard on line 216 
         - in .code/FrontEnd_V1/lib/Screens/home_screen.dart: 
           - add in they key ( name of desiease) to a new getHomeCard on line 598
         - in .code/FrontEnd_V1/lib/Utils/glossary.dart
           - add in a key value pair , the key being the name , the value being the deffinition 
         - in .code/backend/app.py:
           - add in a database key  for the new diesease on line 101, perfeably keeping Entry URL as the last key 
           - add in the new prediction entry for the new disease in analyzePhoto on line 109 
           - add in new return values for the disease on line 279 and 288 
           - add in new key value pair for your new disease to insert into the database on line 289 
           - add in key value pair to return to frontend using json string on line 295
           - add in return value for  the new disease on line 347 
           - add in key value pair to return to frontend using json string on line 354
   -  Security
      -  the biggest sources of security concerns come from the http communications between the front end and the backend. 
      -  first because we are dealing with images, what most API's do is to get the images back to the user , they send a link to which acesses the image that is stored on the file system , this usally requires the use of verification of the users idenity through verification keys. what was done in this case as seen on line 351 of ./code/backend/app.py, the bytes of the image themseves are encoded and sent to the user to be unencoded , what this allowed us to do is avoid using GET functions that could provide the acess of the image itself via the URL, all current functioins are POST functions which should add to the security of the system. an unfortunate downside is that trying to load too many user images using this system can crash the application, so there is a possibility of the need to refactor to the authentication GET link system. 
      -  looking still in ./code/backend/app.py. we have to look at and analyze a particular issue , because we are using MariaDB, which is a SQL database , we have to worry about SQL injectiobs , which is unotherized acess to our database using the vairiables  of the SQL statement, the way to stop this is sto sanitize our vaiables before we use them. to sanatize them , we can also paramatrize the inputs, which we are doing , we are keeping a tuple of the variables that are put into the statement, instead of putting these veriables directly into the sql statement  this is according to this artical : https://realpython.com/prevent-python-sql-injection/.
      -  finally a last security concern is keeping plain text passwords in our database. to solve this issue we used the salt and hashing method seen on line 149 of ./code/backend/app.py. this concatonates a admin generated salt stored in ./code/backend/salt.json and then hashes the password to hide the password. 
      -  another layer of security would also be the ability to run meny diffrent instantiations of our software on many diffrent servers across the globe , this is good for security in that if one server is compromised , we do not have all user information centralized onto one server , meaning that if a security breach were to happen on one server , it would not release the information of every single user that has ever used spot , this is not preventive security but pre-emptive mitigation security  
   - Performance
     - a major suggestion to increase the proformence of the system would be to refactor the getEntries and getEntriesHelper functions on lines 245  and 261 of ./code/FrontEnd_V1/lib/Controllers/home_controller.dart as well as the GetEntries API function on line 307 of  ./code/backend/app.py what refactor is needed is a way to check the number of entries that the user currently has loaded locally on their device vs the number of entries that the user has saved on the database in the backend and only update the loaded enntries on the users frontend when there is a diffrence between the two numbers , this is bec ause everytime that the " history" button on line 116 of  .code/FrontEnd_V1/lib/Screens/home_screen.dart is pushed, we collect the information of the  users entries from the back end database and save it on the frontend user's running memory. this is inrefficent to do if the running memory already contains all information of a users current entries as we are sending repeated information to the user. 
  -  Scalability 
     -  we belive scallability will not be an issue , esspecally since we designed spot to utalize Apache, A common hosting framework out in industry, as a proxy ( a mail dilvery service that shuttles messages back and forth between our flask server that is doing the heavy lifting and our users). meaning that in theory , our application should be able to be intagrated into many diffremnt existing server ecosystems.
  -  Usability 
     -  There are a few issues ( that we have opened issue cards for on our github) that we have discovered while doing usability testing that could affect usability. most of it seems to be issues that may arise with different mobile devices, another issue has to do with some components of  ./code/backend/templates/ that are returning a 404 status code when certain devices try to load them.
# Object-Oriented Analysis and Design (OOAD) Principles
  - Single Responsibility Principle 
    - I believe we have most if not all functionality separated into different functions that are either alone as a stand-alone function or a function inside of a controller.
  - Open Closed Principle 
    - again, as pointed out in the extendability section, the big block to achieving the open-closed principle is the number of steps needed to add a new disease to the system. which is too long and uses too many fixed variables 
    - Interface segregation
      - I would also say that we have done pretty well in the area of interface segregation we can see this when looking at how a user adds a new scan we can begin at .code/FrontEnd_V1/lib/Screens/home_screen.dart when going to add a scan we then go to .code/FrontEnd_V1/lib/Screens/new_scan_screen.dart. next to .code/FrontEnd_V1/lib/Screens/view_image_screen.dart, next .code/FrontEnd_V1/lib/Screens/add_details_screen.dart and ending on .code/FrontEnd_V1/lib/Screens/view_details_screen.dart    
    - Dependency Injection
      - this principle is followed as close as possible, especially with one big dependency, the URL in .code/FrontEnd_V1/lib/Utils/api_manager.dart without it, a person would need to change four or more lines of code spread throughout the system. this is an important dependency as it gives backend access to the front end 

# other suggested refactoring 
 - move the homeExpndable and getGlossery function from .code/FrontEnd_V1/lib/Utils/tilesbilder.dart to ./code/FrontEnd_V1/lib/Controllers/home_controller.dart, we need to keep the Utiles folder for builder functions not implementations of these builder functions 
 - move getLegal function from .code/FrontEnd_V1/lib/Utils/legal.dart to ./code/FrontEnd_V1/lib/Controllers/home_controller.dart so that we can keep implementation functions out of the Utils section 
  





