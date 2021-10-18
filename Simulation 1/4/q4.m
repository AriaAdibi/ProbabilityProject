%%initialization
clear all; close all; clc;

global N_EXPERIMENTS
    N_EXPERIMENTS= 10^3;
global EPS
    EPS= 10^5;
    
POISSON_LAMBDA= 10;
UNIFORM_DISTRIBUTION_MAX_V= 100; %MIN_V= 1
N_BINOMIAL_TRIALS= 100;
P_SUCCESS= 0.2;

%%  testing for uniform distribution
S= randi(UNIFORM_DISTRIBUTION_MAX_V, [1, N_EXPERIMENTS], 'uint8');
areThese2EXsEqual(S, 'uniform');
%(UNIFORM_DISTRIBUTION_MAX_V+1)/2

%% testing for poisson distribution with parameter lambda
S= poissrnd(POISSON_LAMBDA, [1, N_EXPERIMENTS]);
areThese2EXsEqual(S, 'Poisson');
%POISSON_LAMBDA

%% testing for binomial distribution with parameters n, p
S= binornd(N_BINOMIAL_TRIALS, P_SUCCESS, [1,N_EXPERIMENTS]);
areThese2EXsEqual(S, 'binomial');
%N_BINOMIAL_TRIALS*P_SUCCESS