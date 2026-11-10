function pred = knnpred(Xtest,X,y,K,dist_type,preprocess_rows,preprocess_columns)

% prediction with local regression based on K Nearest Neighbours (KNN)
%
% pred = knnpred(Xtest,X,y,K,dist_type,preprocess_rows,preprocess_columns)
%
% INPUT:            
% Xtest                 dataset to be predicted [n_test x variables]
% X                     training dataset [samples x variables]
% y                     training response vector [samples x 1]
% K                     number of neighbors
% preprocess_rows       row data preprocessing
%                       'none' no scaling
%                       'snv' standard normal variate
%                       'msc' multiplicative scatter correction
%                       'der1' first derivative
%                       'der2' second derivative
% preprocess_columns    column data preprocessing 
%                       'none' no scaling
%                       'cent' centering
%                       'scal' variance scaling
%                       'auto' autoscaling (centering + variance scaling)
%                       'rang' range scaling (0-1)
%
% OUTPUT:
% pred is a structure containing
% yc                    predicted response [n_test x 1]
% neighbours            index of neighbours ordered for similarity as numerical array [n_test x K]
% D                     distance matrix [n_test x samples]
% H                     leverages [n_test x 1]
%    
% RELATED ROUTINES:
% knnfit                fit KNN regression model
% knncv                 cross-validatation of KNN
% knnsel                selection of the optimal K for KNN
% reg_gui               main routine to open the graphical interface
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

n = size(Xtest,1);
[X_scal_train,px_row] = data_pretreatment_rows(X,preprocess_rows);
[X_scal_train,param] = data_pretreatment(X_scal_train,preprocess_columns);
X_scal = data_pretreatment_rows(Xtest,preprocess_rows,NaN,NaN,px_row.mean_vector);
X_scal = test_pretreatment(X_scal,param);
D = knn_calc_dist(X_scal_train,X_scal,dist_type);
neighbors = zeros(n,K);
for i=1:n
    D_in = D(i,:);
    [d_tmp,n_tmp] = sort(D_in);
    neighbors(i,:) = n_tmp(1:K);
    d_neighbors = d_tmp(1:K);
    pred.yc(i,1) = knncalcy(y(neighbors(i,:)));
end
pred.neighbors  = neighbors;
pred.D = D;
if size(X_scal_train,1) > 2*size(X_scal_train,2)
    pred.H = diag(X_scal*pinv(X_scal_train'*X_scal_train)*X_scal');
else
    pred.H = NaN(size(X_scal,1),1);
end
