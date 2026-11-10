clc;
clear all;
close all;

%% -------- Loading files --------
arq = xlsread('raw_data_Irrigated_Regression.xlsx');   % Irrigated data separated by water potential

%% -------- Organizing the data --------
wavelength = arq(6:end,1);
x = arq(6:end,2:end);
p = arq(2:end,2:end);
h = [linspace(400,400.0299,4)'; wavelength];

%% -------- Filtering transient signal --------
[a, b] = size(x);
y = zeros(size(x));
for k = 1:b
    y(:,k) = medfilt1(x(:,k), 2);    % Median filter (window = 2)
end

%% -------- Merging data --------
xf = [arq(1:5,2:end); y];

%% -------- Normalizing with z-score --------
zi = zscore(xf(2:end,:)');          % zscore normalizes by column → data must be transposed
art = [linspace(400,400.0299,4)'; wavelength];

%% -------- Correlation analysis --------
target = xf(1,:);
dados = zi';                         % Return to original orientation

co = zeros(a,1);
for t = 1:a
    aux = corrcoef(dados(t,:), target);
    co(t) = aux(1,2);
end

%% -------- Filtering relevant features --------
aux = find(abs(co) > 0.248);






