# CARLOS MERCADAL CARRETERO - MY PORTFOLIO

Welcome to my portfolio, here you'll find all the projects i've been working on. 

Considerations:

    - The portfolio is organized in a sequential order. Therefore, it can be seen an evolution both from the coding quality and libraries used, as well as the complexity of the projects. 
    - All libraries used will be published in a requirements.txt file within each section. 
    
1) my_first_projects_in_R:

These are the first lines of code I have ever typed in R, so please be aware of potential rookie mistakes and lack of clearness. 

- The folder contains the data being used in a '.csv' format. 
- Before running the code make sure to update the path where the data is read from. 

    a) 'solving_the_titanic.R':

        - This piece of code uses the data from 'train.csv' to solve basic data problems, with a focus on basic data exploration, cleaning, and extraction.

    b) 'my_first_algos_test.R':

        - This project uses the data from 'ibex_data.csv' and 'price_departures.csv'. These are data from the IBEX index composition, net of survivorship bias.  
        - The objective is to create three toy algorithms that buy and sell following signals determined by the user:

            - First algorithm:

                • For each asset, for each day, we buy at opening price and sell when the first of the following two events happen:
                    1 - An asset rises by 3 cents (stop profit)
                    2 - An asset falls by 10 cents (stop loss)

                • If neither of the events where to happen, we sell at closing price. There might be days where both events happened (we use the daily highs and lows as reference), since we don't   know which event happened first, we'll assume the stop loss gets hit first. 
                • We'll use an initial capital of 30k for each asset, with an order comission of 0.0003 * capital. 
                • Finally, we'll plot the accumulated returns by asset. 
            
            - Second algorithm:

                • Basing the second algorithm in the previous one, we'll add another feature. 
                • Using the data from 'price_departure.csv': for each asset, for each day, if price departure is >= 0.75, we'll buy at opening and sell at close following the previous events.
                • We'll repeat the same order commissions and plotting results as we did before. 
            
            - Third algorithm:

                • It is also based in the previous algorithms, adding another feature. This time we'll be using dynamic stop profits/loss instead of the static ones, and the used capital will be determined according to the volume at each date. 
                •  Therefore:
                    - capital used for each investment --> 0.5% of the daily volume.
                    - Stop profit --> if the price gets to the 30th quantile of the difference between the daily high and close. 
                    - Stop loss --> if the price gets to the 80th quantile of the differente between the daily low and close.

                • We'll repeat the same order commissions and plotting results as we did before.
    
    c) 'my_first_web_scrapping.R':

        - This project pretend to apply web-scrapping concepts i have learned. 
        - The objective is to get open long positions for each asset within the Ibex index. We'll be using webscrapping to get the composites of the index, and then
        get the open positions from another website. 
    

2) my_first_projects_in_Python:

    a) 'finance_with_python.ipynb':

        - This notebook contains different applications of python using financial data. Be aware that these problems are oriented from an academic perspective. 

        1) Trading with bollinger bands:

            • We'll be implementing a systematic trading algorithm using bollinger bands. The data used will be obtaind from the IEX trading api, and we'll use the closing SP500 data. 
            • Once we get the data, we have to calculate the bollinger bands. In order to do so, we'll calculate the rolling moving averages of 30 days, using +/- two times the standard deviation of such rolling averages. 
            • We plot the bollinger bands. 
            • As this is a trading algorithm, the trigger signals need to be defined:
                - Buy signal --> Closing price first crosses the lower band to the downside, when it crosses back above we buy. 
                - Sell signal --> Whenever the closing price is >= to the upper band, we sell. 
                - Shorting is not allowed. 
            
            • We plot the results by showing where the buy and sell signals were trigerred.
            • We calculate the mean returns 
            • We optimize the model using other variables. In this case we modify the calculation of the bands. 
            • Finally, to optimize the model we'll be using the multiprocessing library, which allows the maximum cores of your cpu (I have stated to use max - 2 cores). The objective is to gain computational speed when optimizing the model. 

        2) Montecarlo and Bootstrapping:

            • Montecarlo and Bootstrapping are very common tools in finance to calculate portfolio returns expectations. We'll be using the data from the IBEX index in 'ibex_div_data_close.csv'.
            • We calculate the log returns and then we plot the return distribution. 
            • Montecarlo:
                - We'll calculate the statistics from the distribution (mean and variance), and use it as input parameters in our montecarlo model. 
                - We'll generate 1000 simulations of possible returns. 
                - Plot one simulation.
            • Bootstrapping:
                - We'll get 1000 random sample of returns from the returns calculated previously. 
                - Plot one simulation.
            
            • We calculate the returns of investing in 100 random simulations from the ones we generated.
        
        3) Working with time series:

            • We'll use the data from  http://www.kibot.com/free_historical_data.aspx where it says free tick intraday data and tick with bid ask data.
            • First we calculate hourly, daily, monthly, and annual candles using the open, high, low, close data. 
            • We'll use the utils.py to draw a candle chart. 
            • We'll create a function that shows the price everytime a certain number of negotiations have ocurred. This negotiations will be the tick bars we downloaded before, and we'll get the price every 10k negotiations. 
            • Now we do a similar function buy extracting the price everytime 100k dollars have been negotiated. 
            • A calculation of the returns of every 10k negotiations and 100k dollars negotiated is computed. 
            • We plot the results. 
        
        4) Triple barrier method:

            • Here we'll be implementing the triple barrier method, which involves labelling an observation according to the first barrier touched out of three barriers. The labels will be -1,0,1 being -1 the lower barried, 0 the intermediate barrier, and 1 the upper barrier. 
            • We program the function that is going to be labelling the observations. 
            • We are going to optimize the barriers in order to get a balanced distribution of the different labels. 

3) vectorized_programming_R_and_Python:

    The objective is to code in the most efficient and vectorized way both in python and R. 

    Here we try to vectorize a solution for two problems:
     
    a) Jensen's Alpha ('jensen's_alpha_R' and 'jensen's_alpha_python'): 
        - We are going to calculate jensen's alpha for each date and each asset from the DAX index. 
        - We are going to use the data contained in 'DAX.csv' using the BUND data as the risk-free rate. 
        - We perform basic financial calculations (returns, covariances, and Betas) and apply the jensen's alpha formula. 
        - The code solves the problem in 0.09 seconds. 
    
    b) lottery ('lottery_R' and 'lottery_python'):
        - The objective is to create a fake lottery with 50k simulations and combinations of 5 numbers between 1 and 50. 
        - We generate 50k bids to simulate our participation en each simulation. 
        - We then calculate how many times we 'won' the lottery.
        - The code solves the problem under 0.73 seconds.

4) Solving the markowitz frontier using 70.000 investment funds:

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

5) Creating a synthetic benchmark:

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

6) Genetic Algorithm using markowitz:

    A genetic algorithm is a search heuristic that is inspired by Charles Darwin's theory of natural evolution. This algorithm reflects the process of natural selection where the fittest individuals are selected for reproduction in order to produce offspring of the next generation.

    - The Genetic Algorithm will be to solve the markowitz frontier with 70k investment funds. This problem-solving method will outperform (at least from a time-consumig perspective) the markowitz code we previously described. 

    - The folder contains a  notebook and a pickle called 'fondos_limpios' that contains the cleaned and homogenized fund data. 

    - constraints:
        • Each 'individual' will be able to invest in  portfolios containing between 1 and 20 random assets. The number of assets in each portfolio will be modified for each generation, but cannot exceed from 20 assets. 

    - Problem approach: 

        • First We will need to determine the number of 'individuals' that will become part of the first generation and determine the number of future generations. We will be using 50 individuals and 50 future generations. The first generation will be created with individuals investing in random assets respecting the constraints previously stated. For each individual of the first generation, we will perform a mean_variance optimization of 100 random weights, and select the weights that represent the highest sharpe ratio. The reasoning behind using 100 random weights is because it will permit a better exploration of possible combinations. 

        • Each individual of the first generation will be elegible to become 'moms and dads' of the future generation. 

        • For the next generation, each 'son' will inherit the genetics (assets) of 'mom and dad'. The genetic mutation (generation of the inherited portfolio) will be performed according to the following rules: 
            1) We concatenate mom and dad's assets and we eliminate duplicates. 
            2) We generate a correlation matrix and select those assets that are below a correlation threshold. 
            3) The son will inherit the uncorrelated assets and the asset with the highest sharpe ratio (that would be the 'best asset'/best gen inherited)
            4) If all assets from mom and dad are uncorrelated and the portfolio sums <= 20 assets, the son will inherit all of them. On the other hand, if the genetic mutation has more than 20 assets, then we will order them based on sharpe ratio and select a random number between 10 and 20 assets, always respecting the sharpe order.
            5) In addition to the genetic mutation, to favor asset exploration, if assets sum less than 16, then we will add between 1 and 4 random assets. This addition is necessary in order to avoid finding a local minima. 
        
        • For each individual of the next generation, we will perform a mean_variance optimization of 100 random weights, and select the weights that represent the highest sharpe ratio.

    a) 'algoritmo_genetico.ipynb':

        - This notebook contains the code with the genetic algorithm just described. 
        - We will be using a class that will perform all the calculations for each generation and genetic mutation. 
        - We then can analyze the results and get the best mean_variance portfolio. 
        - It solves the markowitz problem using 70k funds in 38 seconds. 

7) Portfolio Optimization:

    The project is going to be based on portfolio optimization using different strategies. In particular:

        - Minimum variance portfolio
        - Value portfolio
        - Quality portfolio
        - Growth portfolio
        - Maximum beta portfolio
        - Minimum beta portfolio
        - Momentum portfolio 
    
    - Objective: The main goal of the project is to create portfolios for each strategy for every day during 5 years using the data from a previous 60-day window. If this objective doesn't make sense, is because this project will be used in the future for my master's thesis, so this will only be the first part of a bigger project involving AI. For now, I am only looking to get daily weights for each strategy, respecting the sp500 composition for each date. 

    - Data: We will be using the data contained in 'filtro_sp.csv', 'SP500.xlsx', 'SX5E.csv', 'precios_activos_unicos.xlsx', 'dataset_inputs.csv'. 

    - Constraints:
        • The SP500 needs to be net of survivorship bias. 
        • Each portfolio strategy must have between 2 and 30 assets. 
        • Long only portfolios.
        • Each portfolio must respect the UCITS regulation that applies in Europe. Which means that the following weight constraints must be met:
            - A single asset can't weight more than 10% of the portfolio.
            - Those assets with weights above 5% can't add up to 40% weight in the portfolio. 
    
    - Problem approach:

        1) Solving the survivorship bias problem:
            • We need to get our SP500 data clean of survivorship bias. In order to accomplish this constraint, we will use the SP500 composition for the last 5 years in order to create a dataframe with all the companies that have formed part of the index within that time. 
            • Once we get all unique companies, we will create a data-frame which will be considered a filter. This filter will have the same dates as our daily sp500 data and each column will be a unique company. 
            • We will fill the filtering data-frame with 1 and 0 for each date for each company based on the company being part or not of the sp500 index.
            • Finally, we will multiply our filtering df with 1 and 0 by our original daily sp500 data. Therefore, we will get the actual daily prices for each date for each company that was part of the index for that date. 

        3) Calculating betas:
            • Since we won't be using fundamental data from each company to construct our quality, growth, value, and market portfolios, we will be using the data from the SP500 style indexes. 
            • For each style index, we will calculate the betas of each stock to that index.
            • The stocks with the 50 highest betas to each index will be considered for each portfolio style.  

        2) Optimizing the strategies:
            • First of all, we will be using the XPRESS solver that needs to be installed along the CVXPY library.
            • For each date, and for each strategy we will generate a function that returns a covariance matrix and the betas/return of each strategy depending on which strategy we are working on. 
            • Once we have the covariance and betas/returns of each date for each strategy, we will compute the daily variance optimization. Therefore, we will get daily weights for each strategy that maximize the return/betas and minimizes portfolio volatility. 

    a) 'data_strategies.py':

        - This piece of code will contain a class function that will preprocess our data. It will return our data net of survivorship bias, and it will also calculate the daily betas, returns, and covariances needed for our strategies. 

        - The Class function 'data_generator' will get as input the closing sp500 data and the net of bias sp500 filter. The class contains the following sub-functions appart from the constructor:
            • 'data_cleaning': The objective of the function is to prepare the data we will use. Particularly it will:
                - Get our rough sp500 close data and filter it with our sp500 filter dataframe to get it net of suvivorship bias. 
                - Select those assets with 90% or more daily data and removing the rest. 
                - Doing a forward and backward fill to possible NaN or empty values from the companies that remain. 
                - Do a similar task with the style indexes we are going to be working with. 

            • 'generador_estadísticos': The objective of this function is to prepare the stastic data we need for each strategy. It will return us for each strategy and for each day, a list with the statistics needed. For instance, we would get the daily stocks with the 50 best betas to the value factor and daily covariance of those 50 best stocks. 

    b) 'strategies.py':

        - This piece of code will contain the optimizers we will be using for our daily portfolios. 
        - The Class function 'Optimizer' will get as input the number of samples and highes and lowest gamma. Such gamma values are considered to the 'lambda' of a basic finance utility function, which expresses risk aversion. We will loop through N number of samples with different gamma values to optimize our portfolios. The sub-functions contained in the Class, appart from the construtor are:
            • 'maximize_target': It is the function created to optimize our maximum beta and momentum strategies. 
            • 'minimum_variance': It will optimize the minimum variance strategy.
            • 'min_beta': It will optimize the minimum beta strategy. 
        
        - All this sub-class functions are very similar, but their objective function differs based on whether we want to minimize or maximize our target. 
    
    c) 'main.py':

        - This is the main code and it will import as libraries the functions contained in 'data_strategies.py' and 'strategies.py'. 
        - It will upload the data described above and pass it to our data_strategies functions. 
        - Once we get our preprocessed data, we will pass it to the strategies optimizer functions defined above. 
        - Finally, we will get, for each day, the portfolio weights for each strategy completly optimized. 
    

           


















        








               










                


            








