%% initilization
clear all; close all; clc;

global N_DAYS_PER_YEAR
    N_DAYS_PER_YEAR= 365;
global EPS
    EPS= 10^-4;
    
N_EXPERIMENTS= 10^4;
N_SEARCH_REPETITION= 2;

N= [20, 200, 2000];
MAX_N= 2 * 10^3; %for the binary search

MAX_K= 2000;

%% part a
    %% part 1
    tic
    for n=N
        %output
        fprintf( 'n= %d: %f\n', n, pSameBDayAsMe(n, N_EXPERIMENTS) );
    end
    toc
    %% part 2
    tic
    for n=N
        %output
        fprintf( 'n= %d: %f\n', n, pKSameBDay(n, 2, N_EXPERIMENTS) );
    end
    toc
%% part b
    %% part 1
    tic
    M= zeros(N_SEARCH_REPETITION, 1);
    for i= 1:1:N_SEARCH_REPETITION

        n_a= 1;   n_b= MAX_N; %searching within [a,b]
        while(n_b > n_a)
            n_c= floor( (n_a+n_b)/2 );

            p= pSameBDayAsMe(n_c, N_EXPERIMENTS);
            if( p > 0.9 + EPS )
                n_b= n_c-1;
            elseif( p < 0.9 - EPS )
                n_a= n_c+1;
            else
                n_a= n_c;   n_b= n_c;
                break;
            end
        end
        M(i)= n_a;

    end
    toc
    %output
    fprintf('Minimum n for part (1) is approximately %d\n', round(mean(M,1)) );

    %% part 2
    tic
    M= zeros(N_SEARCH_REPETITION, 1);
    for i= 1:1:N_SEARCH_REPETITION

        n_a= 1;   n_b= MAX_N; %searching within [a,b]
        while(n_b > n_a)
            n_c= floor( (n_a+n_b)/2 );

            p= pKSameBDay(n_c, 2, N_EXPERIMENTS);
            %fprintf('%d, %d, %f\n', n_a, n_b, p);
            if( p > 0.9 + EPS )
                n_b= n_c-1;
            elseif( p < 0.9 - EPS )
                n_a= n_c+1;
            else
                n_a= n_c;   n_b= n_c;
                break;
            end
        end
        M(i)= n_a;

    end
    toc
    %output
    fprintf('Minimum n for part (2) is approximately %d\n', round(mean(M,1)) );
    
%% part c
tic
for n=N
    maxK= min(n, MAX_K);
    p= zeros(1, maxK);
    for k=1:1:maxK
        p(k)= pKSameBDay(n, k, N_EXPERIMENTS);
        if( abs( p(k) ) < EPS )
            break;
        end
    end
    
    fig= figure('Name',sprintf('pKSameBDay vs K -- n= %d', n),'NumberTitle','off');
    plot(p);
    myDefaultFigureProperties(fig);
    xlabel('k', 'FontWeight', 'bold');
    ylabel('pKSameBDay', 'FontWeight', 'bold');
end
toc