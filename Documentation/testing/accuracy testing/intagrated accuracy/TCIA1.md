Test Case Name: Intagrated Accuracy 

Test Case ID: TCIA1

Test Objective: see the error betweem our AI creation environment vs  User environment (UI)

Preconditions: NA

Test Steps:

1. get the AI prediction results for some test picture in our AI environment 
2. get the AI prediction results for some test picture in our user environment (UI)



AI Results: ![TCAI1](./images/TCAI1.png)
Prediction : Dermatofibroma 78%

UI Results: ![TCUI1](./images/TCUI1.png)
Prediction : Dermatofibroma 98.5689%


 
$$
    |error| = |(AIprediction-UIprediction)/AIprediction|*100
$$

Error = 26.370%

  
