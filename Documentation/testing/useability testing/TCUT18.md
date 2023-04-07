Test Case Name: Quickscan - add entry that is not and image but a video 

Test Case ID: TCUT18

Test Objective: test to see if system rejects a non-image entry using quickscan

Preconditions: 
- logged in as a created user   

Test Steps:
 -use quickscan
 - add entry ( video recorded on device) 

Expected Results:  System should reject this  video file 
Actual Results: 

Pass/Fail: Pass 

Notes:
- The video file was rejected by the back end only returning 500 status code. 
- the frontend is stuck at the loading circle. 
- !! need refactoroing in the front end to reject the non-image inputs, possibly booting user back to the new_scan_screen !!
- !! currently saves file in file system!!



Environment: apple IOS  safari browser 

Test Data: N/A

Test Run Date: April 4, 2023



