clc;
clear;
close all;

%% Loading files
arq = xlsread('ordered_data_Rainfed_Regression.xlsx');   % Irrigated data separated by water potential

%% Organizing the data
wavelength = arq(3:end,1);            % Wavelength
x = arq(2:end,2:end);                 % Input data
y = arq(1,2:end);                     % Water potential (target)
p = arq(3:end,2:end);                 % Reflectance only
h = [linspace(400,400.0299,1)'; wavelength];
w = arq(1:end,2:end)';                % Full reflectance matrix (transposed)

%% Feature selection (change folds with different feature subsets)
x2 = x';
y2 = y';

x2 = x2(:,1:5);        % Select the first 5 features
% x2 = x2(:,1:10);     % Option: select first 10 features

%% Cross-validation configuration
rng("default");
cv = cvpartition(y2, 'KFold', 5);     % 5-fold cross-validation

k = cv.NumTestSets;

%% Splitting data into train and test sets for each fold
for i = 1:k
    trainingIdx = training(cv,i);         % Indices for training set
    XTrain = x2(trainingIdx,:);
    YTrain = y2(trainingIdx);

    testIdx = test(cv,i);                 % Indices for test set
    XTest = x2(testIdx,:);
    YTest = y2(testIdx);

    TreinoX{i,:} = XTrain; 
    TreinoY{i,:} = YTrain;
    TesteX{i,:} = XTest;
    TesteY{i,:} = YTest;
end

%% Saving results
%Organize the file names to vary the number of folds.
 save('TreinoX.mat','TreinoX');
 save('TreinoY.mat','TreinoY');
 save('TesteX.mat','TesteX');
 save('TesteY.mat','TesteY');
