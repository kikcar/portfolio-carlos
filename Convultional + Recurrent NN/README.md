### Convultional and Recurrent Neural Networks

Here we will be using Convultional Neuroal Networks using two famous datasets: Cifar100 and MNIST. 
RNN + CNN playground folder contains different applications of CNN and RNN layers with financial data. There is no real objective in the codes, its just like a "playground". Be aware that some of the problems proposed doesn't make any financial sense. But it is useful to see how this kind of layers can be used with financial data. 

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