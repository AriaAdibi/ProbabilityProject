
%% Initialization
close all; clear all; clc;

INIT_MONEY= 476+75;
MAX_N= 1000;

N_LOOK_AHEADS= 10* 1000* 1000; %for optimization
N_EXPERIMENTS= 500;

%set Ns and Ps randomely or
N_DIFF_NS= 1;
Ns= randi([INIT_MONEY+1, MAX_N], N_DIFF_NS);
Ps= rand(1, N_DIFF_NS);
%set them manually
% N_DIFF_NS= 1;
% Ns= [552];
% Ps= [0.2];

%% Estimating the "NOT_RUIN" probability
tic
for i=1:1:N_DIFF_NS  
    N= Ns(i);   p= Ps(i);
    iSuccesses= 0;
    
    for j=1:1:N_EXPERIMENTS
        cMoney= INIT_MONEY;  
        
        %guaranteed that 0 < cMoney < N
        while( cMoney > 0 && cMoney < N )
            didWin= rand(1, N_LOOK_AHEADS) < p; %optimization
            
            for k=1:1:N_LOOK_AHEADS
                if( didWin(k) == 1 )
                    cMoney= cMoney+1;
                else
                    cMoney= cMoney-1;
                end
                
                if(cMoney == 0 || cMoney == N)
                    break;
                end
            end
        end
           
        if( cMoney == N )
            iSuccesses= iSuccesses+1;
        end
    end
    
    %output
    fprintf('For N= %d and p= %f, my estimate is: %f\n', N, p, iSuccesses/N_EXPERIMENTS);
end
toc