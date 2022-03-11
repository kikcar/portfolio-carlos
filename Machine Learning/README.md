### MACHINE LEARNING

This project is going to be a playground to use different machine learning techniques with supervised learning to solve a classification problem.

The objective will be to construct a model that allows to recognize different technical analysis patterns within a price time series. Specifically we will be trying to detect double bottoms and double tops in candle charts.

We will create three different models:

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

