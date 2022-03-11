1) My first projects with R:

These are the first lines of code I have ever typed in R, so please be aware of potential rookie mistakes and lack of clearness. 

- The folder contains the data being used in a '.csv' format. 

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
    
