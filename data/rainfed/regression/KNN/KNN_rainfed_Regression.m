%-------------------------KNN ----------------------------
clc
clear
close all
%% -------- Loading Folds --------
%Change the file names to vary the number of folds.
X = load('TreinoX_20_feature.mat');
y = load('TreinoY_20_feature.mat');
Xtest = load('TesteX_20_feature.mat');
TesteY = load('TesteY_20_feature.mat');

%---------Knn--------

K = 5;
dist_type = 'euclidean';
%                       'euclidean' Euclidean distance
%                       'mahalanobis' Mahalanobis distance
%                       'cityblock' City Block distance
%                       'minkowski' Minkowski distance
preprocess_rows = 'none';
%                       'none' no scaling
%                       'snv' standard normal variate
%                       'msc' multiplicative scatter correction
%                       'der1' first derivative
%                       'der2' second derivative
preprocess_columns = 'none';
%                       'none' no scaling
%                       'cent' centering
%                       'scal' variance scaling
%                       'auto' autoscaling (centering + variance scaling)
%                       'rang' range scaling (0-1)

for i = 1:5
resp{i,:} = knnpred(Xtest.TesteX{i,:},X.TreinoX{i,:},y.TreinoY{i,:},K,dist_type,preprocess_rows,preprocess_columns);
end

%% ------------------------- Error Metrics -------------------------
for i =1:5
    aux{i,:} = corrcoef(resp{i,:}.yc, TesteY.TesteY{i,:});
    R2{i,:} = aux{i,:}(1,2).^2;
    sy = size(TesteY.TesteY{i,:});
    y = sy(1);
    RMSE{i,:} = sqrt(sum((TesteY.TesteY{i,:} - resp{i,:}.yc).^2)/y);
end

%% ------------------------- Plots -------------------------
for i = 1:5
    
    % --- True vs Predicted ---
    figure;
    plot(TesteY.TesteY{i,:}, '-');
    hold on;
    plot(resp{i,:}.yc, 'o');
    title(['KNN - Fold ' num2str(i) ' (True vs Predicted)']);
    xlabel('Sample Index');
    ylabel('Output');
    legend('True', 'Predicted');

    % --- Predicted vs True (Scatter Plot) ---
    figure;
    scatter(resp{i,:}.yc,TesteY.TesteY{i,:}, 'or');
    hold on;
    plot(-20:10, -20:10, '-b');   % Identity line
    title(['KNN - Fold ' num2str(i) ' (Predicted vs True)']);
    xlabel('Prediction');
    ylabel('True Value');
end
