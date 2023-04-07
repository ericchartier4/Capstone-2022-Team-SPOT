Test Case Name: User - add entry that is not and image but a video 

Test Case ID: TCUT16

Test Objective: test to see if system rejects a non-image entry 

Preconditions: 
- logged in as a created user   

Test Steps:
 -logged in
 - add entry ( video recorded on device) 

Expected Results:  System should reject this  video file 
Actual Results:   File "C:\Users\***\Documents\Capstone-2022-Team-Crab\code\backend\app.py", line 287, in post
    img = load_img(fr".\uploads\{imageName}")
  File "c:\users\***\documents\capstone-2022-team-crab\code\backend\env\lib\site-packages\keras_preprocessing\image\utils.py", line 114, in load_img
    img = pil_image.open(io.BytesIO(f.read()))
  File "c:\users\***\documents\capstone-2022-team-crab\code\backend\env\lib\site-packages\PIL\Image.py", line 3283, in open  
    raise UnidentifiedImageError(msg)
PIL.UnidentifiedImageError: cannot identify image file <_io.BytesIO object at 0x0000025A6C7AC310>


Pass/Fail: Pass 

Notes:
- The video file was rejected by the back end only returning 500 status code. 
- the frontend is stuck at the loading circle. 
- !! need refactoroing in the front end to reject the non-image inputs, possibly booting user back to the new_scan_screen !!
-  !! image saved to filesystem need to not save non-image files!!



Environment: apple IOS  safari browser 

Test Data: N/A

Test Run Date: April 4, 2023



