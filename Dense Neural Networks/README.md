### DENSE NEURAL NETWORKS

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