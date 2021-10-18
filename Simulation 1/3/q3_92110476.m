%% initialization
clear all; close all; clc;
N_EXPERIMENTS= 10^3;
N= 50;

%% let's toss
%T -> 0  -- H -> 1

LongestConsecutiveOnes= zeros(1, N_EXPERIMENTS);
for exN= 1:1:N_EXPERIMENTS
    S= randi( [0,1], [1, N], 'uint8' );
    S= [S,0];
    
    longestConsecutiveOnes= 0;
    nCurrentConsecutiveOnes= 0;
    for i= 1:1:N+1
        if(S(i)==1)
            nCurrentConsecutiveOnes= nCurrentConsecutiveOnes+1;
        else
            longestConsecutiveOnes= max( longestConsecutiveOnes, nCurrentConsecutiveOnes );
            nCurrentConsecutiveOnes= 0;
        end
    end
    
    LongestConsecutiveOnes(exN)= longestConsecutiveOnes;
end

%% output
fprintf('Average length of logest consecutive Hs is approximately %f\n', mean(LongestConsecutiveOnes) );
