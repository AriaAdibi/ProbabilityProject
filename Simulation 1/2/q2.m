%% initialization
clear all; close all; clc;
N_EXPERIMENTS= 10^4;
N_CURTAINS= 3;

%% let's play
S= randi( N_CURTAINS, [2, N_EXPERIMENTS], 'uint8' );
S= ( S(1,:)==S(2,:) );
pNotChange= sum(S)/N_EXPERIMENTS;
pChange= 1-pNotChange; %= (N_EXPERIMENTS-sum(S))/N_EXPERIMENTS

%% output
fprintf('The probability of wining the goat! if the chosen curtain were changed is approximately %f\n', pChange);
fprintf('The probability of wining the goat! if the chosen curtain were not changed is approximately %f\n', pNotChange);