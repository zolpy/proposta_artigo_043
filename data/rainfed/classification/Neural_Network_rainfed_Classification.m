%% ------------------------- Neural Network (All Features) ----------------------------
clc;
clear;
close all;

%% -------- Loading Folds --------
%Change the file names to vary the number of folds.
load('TreinoX_22_feature.mat');
load('TreinoY_22_feature.mat');
load('TesteX_22_feature.mat');
load('TesteY_22_feature.mat');

%% ------------------------- Neural Network Classifier -------------------------
for i = 1:5
    Mdl{i,:} = fitcnet( ...
        TreinoX{i,:}, TreinoY{i,:}, ...
        'OptimizeHyperparameters', 'all', ...
        'HyperparameterOptimizationOptions', struct('UseParallel', true) ...
    );

    testPredictions{i,:} = predict(Mdl{i,:}, TesteX{i,:});
end

%% ------------------------- Confusion Matrix -------------------------
for i = 1:5

    % Determine sizes
    sy = size(TesteY{i,:});
    numY = sy(1);

    sp = size(testPredictions{i,:});
    numP = sp(1);

    % One-hot encoding (assumes 5 classes)
    targets = zeros(5, numP);
    outputs = zeros(5, numY);

    targetsIdx = sub2ind(size(targets), testPredictions{i,:}', 1:numP);
    outputsIdx = sub2ind(size(outputs), TesteY{i,:}', 1:numY);

    targets(targetsIdx) = 1;
    outputs(outputsIdx) = 1;

    % Plot confusion matrix
    figure;
    cb = plotconfusion(targets, outputs, ['Neural Network - Fold ' num2str(i)]);
end

%% ------------------------- Balanced Accuracy -------------------------
for i = 1:5

    % Compute confusion matrix
    C = confusionmat(TesteY{i,:}, testPredictions{i,:});

    % Per-class accuracy
    classAccuracies = diag(C) ./ sum(C, 2);

    % Balanced accuracy = mean per-class accuracy
    balancedAccuracy(i,:) = mean(classAccuracies);
end

