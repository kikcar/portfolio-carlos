###  GENETIC ALGORITHM SOLVING MARKOWTIZ

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