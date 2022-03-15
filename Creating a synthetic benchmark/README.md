###  Creating a Synthetic Benchmark

 "Any Monkey Can Beat The Market -  Give a monkey enough darts and they'll beat the market"

This project pretends to code a benchmark following the famous premise stated above. We're going to create a synthetic benchmark based on monkeys that invest in the market. This problem is usually solved following the "blindfolded monkey" approach, where each simulation represents a blindfolded monkey throwing darts (selecting portfolios).

However, using only blindfolded monkeys doesn't seem to be a fair... therefore, we will be also using monkeys with habilities. Such habilities will be either Jensen's Alpha, Sharpe Ratio, or Markowitz frontier. 

We will be using investment funds NAV data contained in the zipped files 'navs' which contain a pickle file, and 'maestro.csv'.

- Reasoning behind this project.

    • This project is very usefull when designing algorithms. It is very easy to do a wrong backtesting and getting misleading results. If you perform a synthetic benchmark using the monkey it can be used as an indicator to check whether your results are valid or not. The ending point is that you will never be able to beat the monkey that beats the market, if you beat him... there's something you're doing wrong. 

- Constraints:

    • Each monkey will be able to reinvest their money to compound returns.
    
    • Each portfolio will contain between 2 and 30 assets. 
    
- Problem approach:
    
    • We will be using the same data preparation and cleaning approach followed in the Markowitz problem. Reutilizing the same functions.

    • A number of 17k funds will remain, so we will perform 100 million simulations (monkeys) in order to do enough exploration. The code will have an execution time under 24h.

    • For each monkey, we will assign an hability:
        - Random investment: The monkey will be blindfolded and invest in N assets (respecting the limit).
        - Markowitz frontier approach: The monkey will have the hability to perform a markowitz frontier given a 250 days window. 
        - Sharpe Ratio approach: The monkey will have the hability to select random assets that have a positive sharpe ratio above a pre-specified threshold, which will also be determined randomly. 
        - Jensen's Alpha approach: The monkey will have the hability to select random assets that have a positive jensen's alpha in relation with the MSCI World benchmark.

    • Both sharpe ratio and jensen's alpha will be calculated following random windows between 15-60 days taking a 5 day-step. Therefore, for each monkey having such habilities, will be able to use either a 15,20,30,35...60 window.  

    • Finally, we will establish a random threshold between 1% and 20% return for each monkey. If the return obtained by a monkey is above that threshold, the monkey will be able to reinvest its money. 

    a) 'funciones_monos.py'    

        - This code is going to be used as a library that we will import on the main code 'Monkeys_with_habilities.ipynb'.
        - It contains the main functions we'll be using to solve the problem. Specifically:
            
            • 'homogeneizacion_fondos': This function will get as input a dataframe containing all funds. It will homogenize all data in a data-frame that will have as index the unique business dates and the funds' names as columns, and finally, match the NAV of each fund and each date. Finally, once we get the homogenized df, it will make financial sense to eliminate those funds that have less than 85% (also an input) of NAV data.
            • 'limpiar_datos': This function will clean our data replacing empty values with NaN. After that, we will use a forward and backward fillna.
            
            - Jensen's alpha hability:
                • 'alpha_jensen': This function will calculate the daily jensen's alpha for each window. 
                • 'calculo_alpha': The function will recieve as input the buy and sell date for each monkey that has been assigned with the jensen's alpha hability. It will select random assets with positive alpha in relation to the MSCI benchmark, assign random weights, calculate the portfolio returns.
                • 'habilidad_alpha': The function will use the 'calculo_alpha' descibred above. It will be calculating all compounded returns and reusing the previous function for each reinvestment. It will return an accumulated return for each monkey. 
            
            - Sharpe ratio hability: 
                • 'sharpe_ratio': This function will calculate the daily sharpe ratio for each window.
                • 'calculo_sharpe': The function will recieve as input the buy and sell date for each monkey that has been assigned with the sharpe ratio hability. It will select random assets with positive alpha above a threshold, assign random weights, calculate the portfolio returns.
                • 'habilidad_sharpe': The function will use the 'calculo_sharpe' descibred above. It will be calculating all compounded returns and reusing the previous function for each reinvestment. It will return an accumulated return for each monkey. 

            - Markowitz hability:    
                • 'habilidad_markowitz': The function will perform a markowitz frontier optimization and invest in the best portfolio for each 250 day window. 
            
            - Blindfolded monkey:
                • 'Calculo_aleatorio': This function will recieve as input a buy and sell date, and select a random portfolio. 
                • 'Habilidad_aleatorio': The function will use the 'calculo_aleatorio' described above. It will be calculating all compounded returns and reusing the previous function for each reinvestment. It will return an accumulated for each monkey.

    b) 'Monkeys_with_habilities.ipynb':

         - This is the main code of the project. It will import as a library the functions descibred in 'funciones_monos.py'.
         - It will upload the data and use the homogenization and data cleaning functions to preprocess our data. 
         - It will use the functions necessary to generate the different windows with the calculation of daily alpha's and sharpe's for each window. 
         - It will determine randomly the number of monkeys with each hability. 
         - Then it will calculate each monkey return based on their investment habilities and save the results in a pickle file. The pickle file option is due to the fact that the code needs nearly 22hours to execute, so we can be saving our results every X steps. 
         - Finally, we will upload all the pickles generated and we will extract the best monkey. The monkey that beats the market. 
