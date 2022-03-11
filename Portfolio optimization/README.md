###  PORTFOLIO OPTIMIZATION

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