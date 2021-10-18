%% Initialization
close all; clear all; clc;

INIT_MONEY= 476+75;
MAX_N= 2000;

N_LOOK_AHEADS= 10* 1000* 1000; %for optimization
N_EXPERIMENTS= 500;

%set Ns and Ps randomely or
N_DIFF_NS= 1;
Ns= randi([INIT_MONEY+1, MAX_N], N_DIFF_NS);
Ps= rand(1, N_DIFF_NS);
%set them manually
% N_DIFF_NS= 1;
% Ns= [15];
% Ps= [0.5];

%% Estimating the "NOT_RUIN" probability
tic
for i=1:1:N_DIFF_NS  
    N= Ns(i);   p= Ps(i);
    ithSuccesses= 0;
    
    for j=1:1:N_EXPERIMENTS
        cMoney= INIT_MONEY;  
        
        %guaranteed that 0 < cMoney < N
        while( cMoney > 0 && cMoney < N )
            didWin= rand(1, N_LOOK_AHEADS) < p; %optimization
            
            indx= 1;    %the index on didWin
            while( indx <= N_LOOK_AHEADS )
                theJumpSize= min( [cMoney, N-cMoney, N_LOOK_AHEADS-indx+1] );
                s= sum( didWin( indx:1:(indx+theJumpSize-1) ) );
                cMoney= cMoney + s - (theJumpSize-s);
                indx= indx+theJumpSize;
                
                if(cMoney == 0 || cMoney == N)
                    break;
                end
            end
        end
        
        if( cMoney == N )
            ithSuccesses= ithSuccesses+1;
        end
    end
    
    %output
    fprintf('For N= %d and p= %f, my estimate is: %f\n', N, p, ithSuccesses/N_EXPERIMENTS);
end
toc