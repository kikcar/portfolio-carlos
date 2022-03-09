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






                


            








