###  Solving the MARKOWITZ Frontier using 70k investment funds

 The objective of this project is to solve the markowitz frontier with 70k funds and get a code capable of solving it under 24h of execution. We won't be using any AI, ML, nor optimization techniques. 

    Portfolio constraints: 
        - Each portfolio will contain between 1 and 30 assets.

    We are going to use the data contained in the two .zip files called 'funds_data_1' and 'funds_data_2'.

    a) 'Funciones_marko.py':

        This code is going to be used as a library that we will import on the main code 'Markowitz.ipynb'.
        It contains the main functions we'll be using to solve the problem. Specifically:
            1) data preparation:
                • 'Read_multiple_csv': Since we are going to be using a lot of .csv files to upload the fund data, this function allows the reading of all files within a loop function and saves the data into a list. 
                • 'dataframe_fondos': This function will loop through the list previously created and convert it into a unique dataframe. 
                • 'homogeneizar_datos': This function will recieve as input the unique dataframe we get as output from the previous function. The objective will be to homogenize all data in a data-frame that will have as index the unique business dates and the funds' names as columns, and finally, match the NAV of each fund and each date. Finally, once we get the homogenized df, it will make financial sense to eliminate those funds that have less than 85% (also an input) of NAV data. 
                • 'limpiar_datos': This function will clean our data replacing empty values with NaN. After that, we will use a forward and backward fillna. 
            2) Markowitz function:
                • Inputs = Mean daily fund returns, fund returns, and a list of selected assets. 
                • It will assign random weights to the selected assets and then perform basic portfolio calculations (portfolio returns and variance). 
                • Finally, it will save the assets, weights, risk, returns, and sharpe-ratio to a dictionary.
    
    b) 'Markowitz.ipynb':
        
        This notebook will contain the code that solves the markowitz frontier using functions imported from the previous python code just described.

        - First we will establish the path containing our data and we will pass it through the 'read_multiple_csv' function. 
        - Once we have our data, we pass it as input for the 'dataframe_fondos' function. 
        - We establish a threshold of minimum % of NAV data to eliminate the assets with less data, and we pass it as input to the 'homogeneizar_datos' and 'limpiar_datos' functions. Now we have our data cleaned and homogenized ready to use for our calculations. 
        - We then perform basic calculations of returns that we will be using for our markowitz function. 
        - We will Select between 1 and 30 random assets, and perform 20 simulations using the markowitz_function.
        - We repeat the previous process 2 million times; getting a total of 40M portfolio simulations.
        - To gain computational speed we will be using the multiprocessing library. 
        - Finally, we run the code (it lasts around 23 hours) and we extract all the simulations data. 
        - We plot the frontier and select the most efficient portfolio as the winner. 
    
