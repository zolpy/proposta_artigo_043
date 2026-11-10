%% ------------------------- Random Forest Regression ----------------------------
clc;
clear;
close all;

%% -------- Loading Folds --------
%Change the file names to vary the number of folds.
load('TreinoX_20_feature.mat');
load('TreinoY_20_feature.mat');
load('TesteX_20_feature.mat');
load('TesteY_20_feature.mat');

%% ------------------------- Training Random Forest Models -------------------------
for i = 1:5
    Mdl{i,:} = fitrensemble( ...
        TreinoX{i,:}, TreinoY{i,:}, ...
        'OptimizeHyperparameters', 'all', ...
        'HyperparameterOptimizationOptions', struct('UseParallel', true) ...
    );

    predictions{i,:} = predict(Mdl{i,:}, TesteX{i,:});
end

%% ------------------------- Error Metrics -------------------------
for i = 1:5
    
    % Correlation and R²
    aux{i,:} = corrcoef(predictions{i,:}, TesteY{i,:});
    R2{i,:} = aux{i,:}(1,2)^2;

    % RMSE
    sy = size(TesteY{i,:});
    n = sy(1);
    RMSE{i,:} = sqrt(sum((TesteY{i,:} - predictions{i,:}).^2) / n);
end

%% ------------------------- Plots -------------------------
for i = 1:5
    
    % --- True vs Predicted ---
    figure;
    plot(TesteY{i,:}, '-');
    hold on;
    plot(predictions{i,:}, 'o');
    title(['Random Forest Regression - Fold ' num2str(i) ' (True vs Predicted)']);
    xlabel('Sample Index');
    ylabel('Output');
    legend('True', 'Predicted');

    % --- Predicted vs True (Scatter Plot) ---
    figure;
    scatter(predictions{i,:}, TesteY{i,:}, 'or');
    hold on;
    plot(-20:10, -20:10, '-b');   % Identity line
    title(['Random Forest Regression - Fold ' num2str(i) ' (Predicted vs True)']);
    xlabel('Prediction');
    ylabel('True Value');
end

