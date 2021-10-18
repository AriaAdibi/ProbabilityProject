%% initialization
clear all; close all; clc;

N_EXPERIMENTS= 10^5;

%% lets get out of the cave!!
A= [0, 2, 3, 5];

approxE= 0;
for exN= 1:1:N_EXPERIMENTS
    S= A( randperm(4) ); %not needed but let's use it anyway
    
    nDaysTrapped= 0;
    chosenDoor= S( randi(4) );
    while( chosenDoor ~= 0 )
        nDaysTrapped= nDaysTrapped + chosenDoor;
        chosenDoor= S( randi(4) );
    end
    
    approxE= approxE + nDaysTrapped;
end
approxE= approxE/N_EXPERIMENTS;

%output
fprintf('Approximat number of Days that we are in the cave, assuming if choosing a right door cause us to pop out!, is %f\n', approxE);