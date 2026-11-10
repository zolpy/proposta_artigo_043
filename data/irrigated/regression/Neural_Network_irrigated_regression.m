%% ------------------------- Neural Network - Regression ----------------------------
clc;
clear;
close all;

%% -------- Loading Folds --------
%Change the file names to vary the number of folds.
load('TreinoX_20_feature.mat');
load('TreinoY_20_feature.mat');
load('TesteX_20_feature.mat');
load('TesteY_20_feature.mat');

%% ------------------------- Neural Network Regressor -------------------------
for i = 1:5
    Mdl{i,:} = fitrnet( ...
        TreinoX{i,:}, TreinoY{i,:}, ...
        'OptimizeHyperparameters', 'all', ...
        'HyperparameterOptimizationOptions', struct('UseParallel', true) ...
    );

    testPredictions{i,:} = predict(Mdl{i,:}, TesteX{i,:});
end

%% ------------------------- Error Metrics -------------------------
for i = 1:5

    % Correlation coefficient and R²
    aux{i,:} = corrcoef(testPredictions{i,:}, TesteY{i,:});
    R2{i,:} = aux{i,:}(1,2)^2;

    % RMSE
    sy = size(TesteY{i,:});
    n = sy(1);
    RMSE{i,:} = sqrt(sum((TesteY{i,:} - testPredictions{i,:}).^2) / n);
end

%% ------------------------- Plots -------------------------
for i = 1:5
figure;
plot(TesteY{i,:}, '-');
hold on;
plot(testPredictions{i,:}, 'o');
title('Neural Network Regression - True vs Predicted');
xlabel('Sample Index');
ylabel('Output');
legend('True', 'Predicted');

figure;
scatter(testPredictions{i,:}, TesteY{i,:}, 'or');
hold on;
plot(-20:10, -20:10, '-b');   % Identity line
title('Neural Network Regression – Predicted vs True');
xlabel('Prediction');
ylabel('True Value');

end



