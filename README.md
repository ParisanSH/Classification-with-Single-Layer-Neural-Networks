# Classification-with-Single-Layer-Neural-Networks
In this simple mini project, I have just tried to show the concepts of Discrete-neuron Perceptron and Continuous-neuron Perceptron in Single-Layer Feedforward Networks for Classification.

I train and test a single-layer discrete-neuron perceptron neural network to classify English letters. In this dataset, there are 20 samples (with different fonts) of English alphabet letters, stored in 26 folders. Each letter is a PNG image file of size 60×60. Part A: Discrete-neuron Perceptron

Convert every PNG image into bipolar values of +1 for white and -1 for non-white (black) pixels.
For this part (discrete-neuron perceptron), assume each pixel of the letter as a bipolar feature (n=3600), and use them as input to Neural Network.
Train the Neural Network model using the training data and then classify the test letters.
To examine the generalization ability, the leave-one-out cross-validation (LOOCV) method is used, and the accuracy is reported. In LOOCV on N data samples, each time one sample is set aside for testing the model while all remained samples are used for training it. This procedure is repeated N times until all samples are chosen as tested once. The average of accuracies is the accuracy of the model.
To examine its robustness to noise, the network is trained using all training letters, then test it is tested using degraded training letters with 15% and 25% of noise (only the black pixels of the letters are toggled) as new test data, and the new accuracy is calculated.


Part B: Continuous-neuron Perceptron 
For this part, I have tried to train and test a single-layer continuous-neuron perceptron neural network to classify English letters. This time, each letter is assumed as a 60×60 grayscale image with 256 intensities (0 to 255) for each pixel, and the continuous-neuron perceptron is used.
