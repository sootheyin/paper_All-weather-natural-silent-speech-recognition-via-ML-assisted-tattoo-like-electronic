

clear
%% Load data
load alldata.mat;       % 4-D data(channels * Sampling points * class * trials)
%% set the parameter
N_class =110;           % Number of class
N_trial = 10;           % Number of trails
channel=[1,2,3,4];      % The number of the selected channel
soft_threshold = 7;
for i = 1:N_class
    for j = 1:N_trial
        %% Load the data of a trial
        x = data(:,:,i,j);
        x = x(channel,:);
        %% Preprocessing raw data and extracting the feature of RWE
        [RWE, preprocessed_data] = wavelet_packet_decomposition_reconstruct(x,soft_threshold);
        %% The signal is rectified by full wave
        FW_data = abs(preprocessed_data);
        %% Feature Extraction
        % (1) Variance
        f1 = var(FW_data,[],2);
        % (2) Standard deviation
        f2 = std(FW_data,[],2);
        % (3) Skewness
        f3 = skewness(FW_data,[],2);
        % Feature vector
        feat_1 = [f1 f2 f3];
        for i_feat = 1:length(channel)
            % (4) Enhanced Mean absolute value
            X = FW_data(i_feat,:); f4=jEMAV(X);
            % (5) Zeros Crossing
            thres=0.01; f5=jZC(preprocessed_data(i_feat,:),thres);
            % (6) Slope Sign Change
            thres=0.01; f6=jSSC(X,thres);
            % (7) Root Mean Square
            f7=jRMS(X);
            % (8) Log Detector
            f8=jLD(X);
            % (9) Modified Mean Absolute Value
            f9=jMMAV(X);
            % (10) Willison Amplitude
            thres=0.01; f10=jWAMP(X,thres);
            % Feature vector
            feat_2(i_feat,:)=[f4,f5,f6,f7,f8,f9,f10];
        end
        %% Constructing feature matrix for off-line training
        All_feature= [RWE feat_1 feat_2];
        All_feature = All_feature(:)';
        data_feature(N_trial*(i-1)+j,(1:length(All_feature)))= All_feature;
        % Label for training
        label(N_trial*(i-1)+j,1) = [i];
    end
end
data_feature_with_label=[data_feature label]; % Constructing feature matrix
%% Training machine learning model
[validationPredictions, validationScores,trainedClassifier, ...
    validationAccuracy] = train_LDA(data_feature_with_label);




