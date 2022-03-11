###  Using Dockerfiles and Cloud Services

PLEASE BE AWARE THAT THIS PROJECT IS NO LONGER ACTIVE IN CLOUD SERVICES, SO IT IS NOT OPERATIVE. THOUGH YOU CAN SEE THE RESULT AS AN IMAGE FORMAT IN THE FOLDER. 

The objective of this project is to get a hands-on with cloud services and Dockerfiles. This project will develop a Dash application which will connect to a docker image uploaded in google cloud, getting a permanent internet address. The Dash application will plot the electricity price evolution based on the dates selected by the user. The data will be obtained from a free-data website. 

- This project contains three parts, which will be described below:

    1) Dash Application (1 Parte Aplicacion Dash folder): 
        - '1 Parte Aplicacion Dash.py': 
            The code generates a dash application that will offer the user the possibility to compare the electricity price based on the dates selected. In order to do so, we will use the function datepickersingle from dash, which allow the user to select dates. Furthermore, we have generated a CSS file within the assets folder. This CSS file is going to contain HTML code that generates the design of the dash website. 

            This dash application won't be using any cloud service yet, so you can execute the dash app at localhost 8080:8080. 
            
    2) Dash app with cloud services:

        2.1) Docker lambda datos (folder):

            - The main code is 'app.py': 
                This code is going to update our daily price data in our data base. In order to do so, the code will connect to the website api where we get the price data from, it will homogenize the data, and then upload it to an S3 bucket from AWS. 
                                
            - Cloud function:
                In order to get our main code to production, we will use different AWS cloud services. First, we will activate the S3 (database) service and we will generate a bucket where our price data will be uploaded daily. Furthermore, in order to get the code to upload the daily data, we will use a lambda function also from AWS; which allows to execute a code everytime a trigger occurs. The lambda function will use a docker image dedposited at the ECR cloud service, and it will have as a trigger a CRON that will execute everyday at 10am.  

        2.2) Final docker app:

            - Main function:

                The main function of the dockerfile will be to connect our S3 bucket data-base and offer the user the opportunity to: 
                    a) Compare the intraday price of today with the intraday price of another selected date.
                    b) Observe the evolution of the daily mean electricity price between two selected dates (we will use datepickerrane from dash)
                    c) We plot the comparisions. 
            
            - Cloud function: 

                To run the final docker app we will be using cloud services and github actions, beside the already in use services of AWS for ERC, S3 and lambda function. We will upload our docker image to the "container registry" services of google cloud. One we have our image uploaded, we will youse the "cloud run" function in order to be get our docker image operative. 

                Finally, we will connect our github with google cloud. By doing so, we will be able to perform changes in our dash application and such changes will be immediately uploaded to the up and running dash web. 
    
