###  My first projects with Python

This notebook contains different applications of python using financial data. Be aware that these problems are oriented from an academic perspective.

a) 'finance_with_python.ipynb':

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
    
