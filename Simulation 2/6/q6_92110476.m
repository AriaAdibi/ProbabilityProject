%% initialization
close all; clear all; clc;

INIT_MONEY= 476+75;
MAX_N= 10* 1000;

N_EXPERIMENTS= 100;

%set Ns and Ps randomely or
N_DIFF_NS= 20;
Ns= randi([INIT_MONEY+1, MAX_N], N_DIFF_NS);
Ps= rand(1, N_DIFF_NS);
%set them manually
%N_DIFF_NS= ?;
%Ns= [?];
%Ps= [?];

%% estimating the "NOT_RUIN" probability
for i=1:1:N_DIFF_NS  
    N= Ns(i);   p= Ps(i);
    iSuccesses= 0;
    
    for j=1:1:N_EXPERIMENTS
        cMoney= INIT_MONEY;  
        %fprintf('%d ', cMoney); TODO
        while( cMoney > 0 && cMoney < N )
            %fprintf('! cMOney= %d\n', cMoney);TODO
            %outcome= binornd(1, p);
            outcome= rand()>0.5;
            
            if( outcome == 1 )
                cMoney= cMoney+1;
            elseif( outcome == 0 )
                cMoney= cMoney-1;
            else
                error('Something is wrong 0');
            end
            %
            %fprintf('outcome= %d, cMoney= %d\n', outcome, cMoney);
            %
        end
           
        %fprintf('%d %d %d\n', cMoney, N, cMoney==N);TODO
        if( cMoney == N )
            iSuccesses= iSuccesses+1;
        end
    end
    
    %output
    fprintf('For N= %d and p= %f, my estimate is: %f\n', N, p, iSuccesses/N_EXPERIMENTS);
end