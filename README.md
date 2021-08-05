# xsjzbx-paper_All-weather-natural-silent-speech-recognition-via-ML-assisted-tattoo-like-electronic
This folder contains all code needed to produce the simulation results and the data analyses for the paper:
"All-weather, natural silent speech recognition via machine-learning-assisted tattoo-like electronics"
Authors: Youhua Wang, Tianyi Tang, Yin Xu

Code Contents:
 - main.m: main program, it includes the whole process of preprocessing the original signal, extracting features, constructing feature vectors, classification and recognition.
 - wavelet_packet_decomposition_reconstruct.m: code to decompose the signal with four layer wavelet, denoise with soft threshold, reconstruct and extract RWE feature.
 - jEMAV.m: code to extract EMAV(Enhanced Mean absolute value) feature.
 - jLD.m: code to extract LD(Log Detector) feature.
 - jMMAV.m: code to extract MMAV(Modified Mean Absolute Value) feature.
 - jRMS.m: code to extract RMS(Root Mean Square) feature.
 - jSSC.m: code to extract SSC(Slope Sign Change) feature.
 - jWAMP.m: code to extract WAMP(Willison Amplitude) feature.
 - jZC.m: code to extract ZC(Zeros Crossing) feature.
 - train_LDA.m: code to train LDA(Linear Discriminant Analysis) model.(It is provided by the machine learning toolbox of MATLAB 2019b)

Dependencies:
 - All code has been tested using either MATLAB R2019b on Windows 10. 

Example usage:
 - First, you should place all .mat files in a directory that is included in the Matlab path, or update the path to include them.
 - main.m is the main wrapper from which all results in the paper are generated.
 - The dimension of the input data is 4(Channels × Sampling point × Class × Trials).
 - The whole program may take several minutes to run, depending on the specs of your computer. 

Addition:
jEMAV.m, jLD.m, jMMAV.m, jRMS.m, jSSC.m, jWAMP.m, jZC.m comes from the EMG feature extraction toolbox written by Wang Wei(https://github.com/JingweiToo/EMG-Feature-Extraction-Toolbox).
