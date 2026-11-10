function [X_scal,param] = data_pretreatment(X,preprocess_columns)

% column data preprocessing
%
% [X_scal,param] = data_pretreatment(X,preprocess_columns)
%
% INPUT:
% X                     dataset [samples x variables]
% preprocess_columns    column data preprocessing 
%                       'none' no scaling
%                       'cent' centering
%                       'scal' variance scaling
%                       'auto' autoscaling (centering + variance scaling)
%                       'rang' range scaling (0-1)
%
% OUTPUT:
% X_scal                pretreated data matrix [samples x variables]
%
% This is an internal routine of the toolbox.
% The main routine to open the graphical interface is reg_gui
%
% HELP:
% note that a detailed HTML help is provided with the toolbox,
% see the HTML HELP files (help.htm) for futher details and examples
%
% LICENCE:
% This toolbox is distributed with an Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0) licence: https://creativecommons.org/licenses/by-nc-nd/4.0/
% You are free to share - copy and redistribute the material in any medium or format. The licensor cannot revoke these freedoms as long as you follow the following license terms:
% Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
% NonCommercial - You may not use the material for commercial purposes.
% NoDerivatives - If you remix, transform, or build upon the material, you may not distribute the modified material.
%
% REFERENCE:
% The toolbox is freeware and may be used if proper reference is given to the authors, preferably refer to the following paper:
% V. Consonni, G. Baccolo, F. Gosetti, R. Todeschini, D. Ballabio (2021) A MATLAB toolbox for multivariate regression coupled with variable selection. 
% Chemometrics and Intelligent Laboratory Systems, 213, 104313, DOI: 10.1016/j.chemolab.2021.104313
% 
% Regression toolbox for MATLAB
% version 1.4 - October 2021
% Davide Ballabio
% Milano Chemometrics and QSAR Research Group
% http://www.michem.unimib.it/

a = mean(X);
s = std(X);
m = min(X);
M = max(X);
thr_s = 1e-10;
if strcmp(preprocess_columns,'cent')
    amat = repmat(a,size(X,1),1);
    X_scal = X - amat;
elseif strcmp(preprocess_columns,'scal')
    f = find(s > thr_s);
    smat = repmat(s,size(X,1),1);
    X_scal = zeros(size(X,1),size(X,2));
    X_scal = X(:,f)./smat(:,f);
elseif strcmp(preprocess_columns,'auto')
    f = find(s > thr_s);
    amat = repmat(a,size(X,1),1);
    smat = repmat(s,size(X,1),1);
    X_scal = zeros(size(X,1),size(X,2));
    X_scal(:,f) = (X(:,f) - amat(:,f))./smat(:,f);
elseif strcmp(preprocess_columns,'rang')
    f = find(M - m > thr_s);
    mmat = repmat(m,size(X,1),1);
    Mmat = repmat(M,size(X,1),1);
    X_scal = zeros(size(X,1),size(X,2));
    X_scal(:,f) = (X(:,f) - mmat(:,f))./(Mmat(:,f) - mmat(:,f));       
else
    X_scal = X;
end
param.a = a;
param.s = s;
param.m = m;
param.M = M;
param.preprocess_columns = preprocess_columns;