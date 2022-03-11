###  Vectorization with R and Python

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
    
