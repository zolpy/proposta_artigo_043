
clc;
clear all;
close all;

%% Loading files
data = xlsread('raw_data_Irrigated_Classification.xlsx');   % Irrigated data separated by water potential

%% Organizing the data
wavelength = data(6:end,1);
x = data(6:end,2:end);
p = data(2:end,2:end);
h = [linspace(400,400.0299,4)'; wavelength];

%% Filtering transient signal
[a, b] = size(x);
y = zeros(size(x));
for k = 1:b
    y(:,k) = medfilt1(x(:,k), 2);    % Median filter (window = 2)
end

%% Combining the data
xf = [data(1:5,2:end); y];

%% Normalizing with z-score
zi = zscore(xf(2:end,:)');           % zscore normalizes by column, hence the transpose
art = [linspace(400,400.0299,4)'; wavelength];

%% Correlation analysis
target = xf(1,:);
dados = zi';                         % Transposed back to original orientation

co = zeros(a,1);
for t = 1:a
    aux = corrcoef(dados(t,:), target);
    co(t) = aux(1,2);
end

%% Filtering relevant data
aux = find(abs(co) > 0.3069);        % Select variables above correlation threshold




