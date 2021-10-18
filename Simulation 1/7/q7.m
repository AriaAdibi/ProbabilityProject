%% initialization
clear all; close all; clc;

N_EXPERIMENTS= 10^6;

MAX_VAL_Xi= 6; %values of uniform random variable X_i in range {1, ..., MAX_VAL_Xi}
MAX_INDX_Si= 36;

%% Estimating probability mass function S_n= X_1 + ... + X_n
S= randi( MAX_VAL_Xi, [1, N_EXPERIMENTS] );

for i= 1:1:MAX_INDX_Si
    pMF= histcounts(S, 1:1:i*MAX_VAL_Xi+1)/N_EXPERIMENTS;
    
    %output
    %fprintf('Probability Mass Function of S_%d is:\n', i);
    %pMF
    
    fig= figure('Name',sprintf('Estimate of Probability Mass Function S_%d', i),'NumberTitle','off');
    bar(pMF, 0.4);
    myDefaultFigureProperties(fig, i);
    
    S= S + randi( MAX_VAL_Xi, [1, N_EXPERIMENTS] );
end