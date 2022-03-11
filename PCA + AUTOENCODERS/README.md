### PCA and Autoencoders

This project represents the first steps towards the modelling of Generative Adversarial Networks (GAN), which I'll be working on the following weeks. Before getting our hands-on developing GANs, we need to understand how PCA and Autoencoders work. 

1) 'pca_sp500.ipynb':

    - This code uses the SP500 price data of its components to extract PCAs that better explain the variance of our data. 

    a) Preparing our data:

        • We will read our data and prepare a data-frame which will have dates as index and each asset as columns. 
        • We then fill the data-frame with the corresponding close data. 
        • We eliminate those columns with NaN data. 
        • Since we are going to use financial data, it is necessary to make our data independent and our variance stationary. In order to do so, we will perform the log of our data, and then we calculate the daily returns using diff().
    
    b) Performing a PCA:

        • From sklearn we import PCA and we then just use PCA.fit_transorm(n_components)
        • We do some plots to see how our data is extracted.
    
2) 'autoencoder_mnist_ipynb':

    - PCA performs well when our data is linear. However, we might be working with non-linear data, and we will need to use a deep learning model to extract our principal components. 
    - To extract such principal components, we will use an encoder and decoder. 
    - The objective will be to design a model that encodes our data into a vector of weights (principal components) that explain our data variance, and then a decoder that will decode that vector to generate the same original data. We will see that it doesn't work perfectly, but it gets close to the original images. 

    a) Preparing our data:
        • First load the fashion_mnist dataset from keras.datasets.
        • We will split our data into train and test. 
        • We then transform our data to get values between 1 and -1; which will favor the training of our model. 
    
    b) The Encoder:
        • To encode our data we will use a keras sequential model.
        • It will use a flatten layer with an input shape of (28,28,).
        • A Dense hidden layer with 100 neurons and a RELU activation function. 
        • A final dense layer with 50 neurons. 

        Our principal component vector will have 50 weights that best explain the variance in our data.

    c) The Decoder:
        • To decode our data, we will also use a keras sequential model. 
        • It will use a Dense layer with 100 neurons and a RELU activation function. Its input shape will be the principal component vector dimension (50, ).
        • We add another Dense layer with (28*28) neurons and an activation function that will be TANH. 
        • Finally, we reshape our data into (28,28) dimensions. 
    
    d) The final model:
        • The model will combine the Encoder and Decoder models, and will have as target the same data as the input data.
        • Therefore, our model will try to focus all its efforts to get the principal component vector that best explains the data. 
        • Once we train the model, we can see how the images are quite similer, but still we get some noise. 
    
    e) Designing an autoencoder using 2DCNN:
        • We will design another autoencoder, but this time our encoder and decoder will be using 2DCNN. 
        • We see that we get a better performance. 