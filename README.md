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
    
8) Using dockerfiles and cloud services: 

    PLEASE BE AWARE THAT THIS PROJECT IS NO LONGER ACTIVE IN CLOUD SERVICES, SO IT IS NOT OPERATIVE. THOUGH YOU CAN SEE THE RESULT AS AN IMAGE FORMAT IN THE FOLDER. 

    - The objective of this project is to get a hands-on with cloud services and Dockerfiles. This project will develop a Dash application which will connect to a docker image uploaded in google cloud, getting a permanent internet address. The Dash application will plot the electricity price evolution based on the dates selected by the user. The data will be obtained from a free-data website. 

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

9) Machine Learning:

    - This project is going to be a playground to use different machine learning techniques with supervised learning to solve a classification problem.

    - The objective will be to construct a model that allows to recognize different technical analysis patterns within a price time series. Specifically we will be trying to detect double bottoms and double tops in candle charts.

    - We will create three different models:

        1) The first model will be a binary classification problem, and it will detect whether there is a double bottom or not. We will then analyze the results using a confusion matrix, a ROC curve, its AUROC result, and the accuracy. We will also plot the permutation importance of our features. 

        2) The second model will be solving a multilabel classification problem, detecting double bottoms, double tops, and no pattern detected. To solve this problem we will be using three different ML techiniques, and then we will use the one with the best result based on accuracy estimated with cross validation. 

        3) Finally, the third model will use a semi-supervised approach. We have to label our double tops and double bottoms manually, which is tedious and time-consuming. In order to improve this labelling process, we will design a cotraining algorithm that will do further labelling for us. Then we will compare the results with our original model. 

    - Data: We will be using the data provided in 'datos_eurostoxx.csv' and 'benchmark_data.pkl'.

    - Problem approach: 

        1) Labelling our data:
            • Since we are going to be using supervised learning, we will need to label our data in order to train our model. 
            • We will do so ploting random 30-day-window candle charts from out benchmark price data. We will design the code to allow the user to give an input 0,1,2 according to the type of pattern the user considers its displayed (i.e, 0 = No pattern, 1 = Double bottom, 2 = Double top). 
            • Once we have our patterns labelled, we will save the starting date of each 30-day window and its label to a data-frame; which we will be using to generate the data for our models.
        
        2) Feature Engineering:
            • Once we have our window-data and labels, we have to think how are we going to transform our raw data into features that better represent the underlying problem, in this case to detect our price patterns. 
            • The feature engineering process is kind of a creative process, so each user could think of different features. The ones we will be using are:
                - Days between the max-close and low-close from the time-series window. 
                - A binary feature that will represent which event happened first, the minimum (0) or the maximum (1) of the time series. 
                - A local minimum detector that will help to find our double bottom (W). We will design a function that will evaluate the technical supports that exist within the window-data. We can think of it as a 'V' figure detector. In order to do so, we will use the low-data of the series and 5 daily candles. If the following conditions are met, then we will say a 'V' bottom exist: 
                    a) If the low of the candle (X-1) is grater than or equal to the candle (X).
                    b) If the low of the candle (X-2) is greater than or equal to the candle (X-1).
                    c) If the low of the candle (X) is lower than or equal to the candle (X+1)
                    d) If the low of the candle (X+1) is lower than or equal to the candle (X+2)
                
                If no bottom is find, then the function will return a 0. If different bottoms are to be found, we will establish a threshold based on the minimum data of the window-series + a percentage. If our bottom detected is above that threshold, then we will discard it, as it will mean that it is not a true bottom. 

                - To detect double tops We will use the same techinque used above, but in the inverse order.
                - We will use the previous bottoms and tops in order to detect a breakout of that double bottom or double top. We will use a binary label to establish whether a breakout has hapenned or not (1/0). 
                - Number of positive days
                - Number of negative days
                - Return of the window
                - Mean price-distance between the 30day rolling mean and the price data within the window. 
        
        3) Scaling of features:

            • We will sclae our features so they all have the same mean and variance. 
    
        4) Train and test partitioning:

            • We will divide our data into train and test, using 70% of our data to train our model and 30% to test it. 
        
    a) 'etiquetado.ipynb':

        - This notebook will be used for the labelling process. 
        - It will be displaying random 30-day windows and the user will do the manual labelling process. Each user will have a different opinion on what is a double top or double bottom. It is recommended to label as a pattern those candle charts that show a clear pattern; otherwise the model won't learn. 
        - Finally it will save all our labels into three .csv files. 
    
    b) 'ML_MODELS.ipynb':

        - This notebook will be used to create our models. It will be using all the data that the machine learning folder contains. 
        - First we will upload the data and then display three examples, one of each label. 
        - We will design a class function called 'generador_características', which will be generating our features given the data inputs. It will return a data-frame that will have:
            • Each raw is an observation (30-day window).
            • It will have as columns our features.
            • The last column will be our labels, which we will separate later as y.
            • The df will be shuffeled, so there will be a mix of target labels 1,2,0. 
        - We will create a feature scaler function to scale our features in order to have the same mean and variance. We can check this condition is met by displaying the feature statistics.
        
        1) First Model: 

            - We will generate our features which will have as labels either 1 or 0, being a double bottom or no pattern. 
            - We perform a train-split function and split our data into x_train, x_test, y_train, y_test. 
            - We will be using a random forest model imported from SKLEARN. The model will use 20 estimators and a stratifiedKfold of 4 splits. 
            - In order to optimize our model we will also use a grid of parameters, and the GridSearchCV function will use all those parameters and select the ones that provide the greatest accuracy in cross validation. 
            - We then train our model and use it on test data.
            - We analyze our result metrics. 
            - We do a permutation importance in order to plot the importance of our features.

        2) Second Model:

            - Here the process will be similar to the one followed in the first model. Recall that this time we are going to solve a multilabel problem using different ML techniques. In particular we will be using:
                a) Ensembling (decisiont ree, Knn, and bayesian clasificator)
                b) Random forest 
                c) Bagging
            
            - We will create a class called 'ml_classificator' that will contain our models and will perform the different calculations for each model. The model with the greatest accuracy will be selected. All models will be optimized within the process. 

            - We will then get the model results and analyze its metrics. 
            - Finally, we will run our model with new eurostoxx data the model has never seen. We will see 5 examples of each label the model has detected and the confidence level the model is assiging to each classification. 
        
        3) Third Model:

            - This model will be used to improve our labelling process using a cotraining algorithm with semi-supervisation. 
            - We will use our first model as a classificator and we will split our features in two parts. For each new window, we will run the model two times, one with each set of characteristics. Those examples were the two results are the same target, will be labelled according to the prediction. 
            - We then will add these new predictions to our original dataset, and used to re-train our model before a new set of windows are displayed to the model. 
            - The objective is to increase our training dataset at the same time we are labelling new data. 
        
10) Dense Neural Networks

    FIRST TIME USING DEEP LEARNING 

    - This project will be used to solve regression and classification problems using dense neural networks. 
    - The objective will be to use DNN layers, use different activation functions, and optimizing our models.
    - The data used will be generated randomly. 
    - We will be solving problems using keras and tensorflow.          

    1) Solving a linear regression problem using Keras:
        • We will use a Sequential model 
        • We will establish a simple model with one layer and linear activation function
        • Our loss function will be Mean Squared Error and we will be using a Stochastic Gradient Descent optimizer with a learning rate established at 0.0001.
    
    2) Solving a non-linear regression using keras:
        • We will be using a sequential model with two layers.
        • The first layer will be using 10 neutrons and a TANH activation function.
        • Finally, the output layer will have a linear activation function.
        • Our loss function will be Mean Squared Error and we will be using a Stochastic Gradient Descent optimizer with a learning rate established at 0.06.

    3) Solving a 2-dimension logistic regression using keras:

        • We will be using a sequential model with two layers.
        • The first layer will be using 10 neutrons and a RELU activation function.
        • Finally, the output layer will have a sigmoid (binary classification) activation function.
        • Our loss function will be the binary_crossentropy and we will use the SGD optimizer with a learning rate of 0.04
    
    4) We will construct a more complex model:
        • It will have an input layer with 54 neurons.
        • Two layers with 256 and 32 neurons respectively, using sigmoid as an activation function and batch normalization. 
        • An output layer with 7 neurons using a softmax.
        • It will use Dropout with 0.2 in both layers.
        • We will include both L1 and L2 regularizers. 
        • We will initialize our weights using the Xavier method. 
    
    5) We will train our model to check it is working:
      
    6 and 7) We will solve regression problems using TensorFlow:
        • Solving problems with tensorflow are a bit more complex than using keras, but it also allows more flexibility.
    
    8) Optimizing NN hiperparameters using Keras:
        • We will use the keras model we created at 4) and we will optimize the hiperparameters used.
        • In order to do the optimization we will use keras tunning. 
        • The process requires to create a model_builder function that will have all the parameters we want to optimize.
        • We will save all our optimization runs into log-files. 
        • Finally we will select the model with the best loss results. 
    
    9) Optimizing NN hiperparameters using Tensorflow:
        • The process is very similar to the one described in 8), but we will use tensorboard to display our results.

    10) Solving a Kaggle problem - Tabular Playground Series - Jan 2022:

        • The problem requires to predict the sales data for three stores.
        • We will solve the problem using only DNN layers. 
        • We need to do our feature engineering:
             Given our available data is only the name of each store, dates, and sales. We will model our features by extracting the day, store, product, year, month, day, day-of-week, week-end, and quarter. All these can be extracted using pandas datetime. 
        
        • We will train our model based on such features.
        • The model will be using keras and having as hiperparameters: 
            1) Number of layers
            2) Number of neurons in each layer
            3) Regularization values
            4) Acivation functions for the hidden layers
            5) Different optimizers
            6) Different Dropout values

11) Convultional + Recurrent NN:

    - Here we will be using Convultional Neuroal Networks using two famous datasets: Cifar100 and MNIST. 
    - RNN + CNN playground folder contains different applications of CNN and RNN layers with financial data. There is no real objective in the codes, its just like a "playground". Be aware that some of the problems proposed doesn't make any financial sense. But it is useful to see how this kind of layers can be used with financial data. 

    a) Solving CIFAR100 ('solving_CIFAR100.ipynb'):

        - We are going to use 2D CNN to classify the cifar100 images. 
        - First we will import the dataset from keras.datasets and perform a train and test split. We will convert our train and test data to categorical. 
        - We will define a keras sequential model to solve our classification problem. We will be using:
            • Our model input shape will be (32,32,3). 
            • It will have 3 convultional 2D layers.
            • Each layer will have a Relu activation function, L1 regularization, BatchNormalization, and Dropout. 
            • We won't be using padding. 
            • We will establish a kernel size of 3. 
            • Finally, a flatten layer and an output softmax layer with 100 neurons (since que have 100 different classes). 
        
        - We will be using an Adam optimizer with a categorical_crossentropy loss function. 
        - The training process will use 50 epochs, validation_split at 0.3, and early stopping. 
        - Once we have our model trained, we evaluate the model. 
    
    b) Solving MNIST ('solving_MNIST.ipynb'):

        - We are going to use 2D CNN to classify the MNIST number-images. 
        - First we will import the dataset from keras.datasets and perform a train and test split. We will also convert our train and test data to categorical. 
        - The main issue here is that we are using CNN 2D layers. When we analyze the MNIST data, we see that the dimentions don't match those required in a 2D CNN (n_samples, high, wide, channels)... the channel dimension is missing.
        - To solve for the dimension problem, we will be using a reshape of our data and adding a channel dimension. This way we won't get a dimension error from keras. 
        - We will define a keras sequential model to solve our classification problem. We will be using:
            • Our input shape will be (28,28,1).
            • We will use three conv2D layers, the first one will use padding. The activation functions will al be a RELU. 
            • We will use Dropout, BatchNormalization, and MaxPooling2D. 
            • We will establish a kernel size of 3. 
            • Finally, a flatten layer and an aoutput with softmax activation and 10 neurons (we have to classify 10 numbers).
        
        - We will be using an Adam optimizer with a categorical_crossentropy loss function. 
        - The training process will use 200 epochs
        - Finally we evaluate the model and test it in our test data.

    c) RNN + CNN PLAYGROUND:

        As mentioneed above, this folder contains different applications of CNN and RNN layers with financial data. We are not going to preprocess any financial data, as the focus will be on coding RNN and CNN with financial data, so we might see unacceptable accuracies accross the codes. 

        1) 'ejercicio_uno.ipynb': 

            - Objective: Defining models with correct layers and dimensions.
            - This code will be modelling three models that need to solve the following problems: 

                a) Design a classification model where we have 5000 images with dimensions 28x28, for every object we will have 20 possible labels:

                    - The proposed model will use convultional neural networks. 
                    - Since the dimensions are 28x28 and we are going to use 2DCNN, a third channel dimension needs to be added. Therefore, the input shape of our model will be (28,28,1).
                    - We will use two convultional layers with dropout and padding valid.
                    - The activation functions will be a RELU for the two CNN layers and a kernel size of 3. 
                    - Finally, a flatten layer and a 20 neurons output layer using a softmax function. 
                    - The model will be compiled using a SGD optimizer with a 0.0001 learning rate.
                    - The loss function used will be a categorical_crossentropy.
                
                b) We have the following price data from an asset: 50k observations of 11 days each observation. Design a model that has as input the first 10 days of each observation and needs to predict the 11th. Requirements: Use at least 2 LSTM layers, a GRU layer, and a Dense layer:

                    - THe proposed model will be using Recurrent neural networks. The reasoning behind using such RNN is because our data is sequential... the 11th price will be based on the evolution of the previous 10 days. 
                    - We will first use two LSTM layers with a RELU activation function. 
                    - The input shape of the first layer will be (50.000,10)
                    - We will use the return_sequences TRUE parameter from the LSTM layers. 
                    - We will then add the GRU layer with return sequences FALSE and a RELU activation function. 
                    - Finally, and output dense layer with 50000 neurons and a linear activation function. 
                    - The loss function used will be MSE and a SGD optimizer. 
                
                c) We have the following price data from 10 assets: 50k observations with 7 days of price data for each observation for each asset. Therefore, the dimensions of our data are (5000,7,10). The idea is to predict the 8th day of an 11th asset based on the data of the other 10 assets:

                    -The proposed model would be using a combination of RNN + CNN + DNN. 
                    - We would first model a LSTM layer with a relu activation function, return sequences true, and an input shape of (7,10). 
                    - For the CNN layers, since we are working with financial data, we don't need the "channel" dimension we had with 2D CNN layers. Therefore, we will use 1D CNN layers, which make more sense. 
                    - We create two CONV1D layers with a kernel size of 3, padding 'same', and a relu activation function.
                    - Finally we use a Flatten layer and a dense linear function. 
                    - The loss function used will be MSE and a SGD optimizer. 
        
        2) 'ejercicio_dos.ipynb':
            - Objective: Train a model using keras with CNN to predict the daily close data of Apple. We will be using the data provided in the folder. The idea is to use the previous 4 days to predict the 5th close price. We will then compare it to a simple linear model. 

                - data preparation:
                    • We will upload the data and extract the open and close values from apple. 
                    • We will then use a 5 time step and create a df with n_observations and 5 daily price data.
                    • We split our data into train and test, being the 5th day our target data.

                - Model Design: 
                    • We will use two conv1D layers with kernel size 3, input shape (4,1), relu activation and padding 'same'.
                    • Finally we use a flatten layer and a dense linear activation.
                    • The loss function used will be MAE and an Adam optimizer.

                Finally we compare the model results to a linear model. 

        3) 'ejercicio_tres.ipynb': 
            - Objective: Solve the same problem as in the second exercise, but this time combining CNN and RNN. 

            - data preparation: Same as the one we used earlier.               
            - Model Design:
                • We will use first a GRU layer (RNN) with a relu activation function and return sequences True.
                • Return sequences needs to be True in order to use a CONV1D as the next layer. Otherwise we would get a dimension error from keras. 
                • We then use a CONV1D layer with kernel size 3, a relu activation function, an l2 regularizer and padding 'same'. 
                • Finally we use a flatten layer and a dense linear activation.
                • The loss function used will be MAE and an Adam optimizer.

                Finally we compare the model results to a linear model.
        
        4) 'ejercicio_cuatro.ipynb': 
            - Objective: Design a model using keras combining CNN + RNN + Dense layers to predict the daily close data of Apple. We will be using the data of Amazon, Microsoft, Meta (facebook), Google, and Apple from the previous 4 days to predict a 5th day for each observation. 

            - Data Preparation:
                • We will upload the data and extract the open and close values from each company. 
                • We will then use a 5 time step and create a df with n_observations and 5 daily price data.
                • We split our data into train and test, being the 5th day our target data.
                • We will get the following data dimensions (n_observations, 5, 5).
            
            - Model Design:
                • All activation functions will be RELU except the last one. 
                • We will use first a LSTM layer with an input shape of (4,5) and return sequences True. 
                • We add a GRU layer with return sequences True.
                • We add a CONV1D layer with kernel dize 3, l2 regularizer, and padding 'same'. 
                • Batchnormalization
                • We repeat the above layers again.
                • Finally we use a flatten layer and a dense linear activation.
                • The loss function used will be MAE and an Adam optimizer.

                We compare the model results to a linear model.

        5) 'ejercicio_cinco.ipynb': 
            - Objective: Use the previous model but with conv2D layers. 
            - The problem is solved creating a channel dimension so the conv2D work and we don't get a dimensional error.
        
        6) 'ejercicio_seis.ipynb':

            BE AWARE THIS PROBLEM DOESN'T MAKE ANY FINANCIAL SENSE. 

            - Objective: Predict the closing Apple price data using plots from the apple price evolution. 
            - Data Preparation:
                • We will prepare the data using the same process as the one described in 2).
                • Once we have our data-set prepared, we need to plot the data in a grey-sclae and save each plot into a list.
                • Each plot will have the following dimension (144,144,1) 
            
            - Model Design:
                • We will be using conv2D layers, Dropout, and Maxpooling2D.
                • Finally we use a flatten layer and a dense linear activation.
               








                


















        








               










                


            








