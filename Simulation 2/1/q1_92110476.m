%% Initialization
clear all; close all; clc;

N_RAND_SAMPLE= 10* 1000;
N_EXPERIMENTS= 10* 1000;

%Expectation and standard deviation of laplace distribution when mu= 1 and
%sigma= 1
%distribution= 1/(2\sigma)e^(-|x-\mu|/\sigma)  %E(X)= \mu   %Var(X)=
%2\sigma^2
LAPLACE11_MU= 1;
LAPLACE11_SIGMA= 2;

%these are for part c
%IMPORTANT: N_RSAMPLE1 <= N_RSAMPLE2 must be satisfied. (just for
%simplifying the code)
N_RSAMPLE1= 50;
N_RSAMPLE2= 100;
%SLLN: Strong law of large numbers
SLLN_EPS= 0.05; %must be positive

%% Generating laplace11Rnd
%--> look at the laplace11Rnd function when mu= 1 and sigma= 1

%% Estimating E(1/|X|+1)
fprintf('The approximated value for E(1/|X|+1) is %f.\n\n', mean( 1./( abs(laplace11Rnd(1,N_RAND_SAMPLE))+1 ) ) );

%% k= N_RSAMPLE1 vs N_RSAMPLE2 P[|(x1+..+xk)/k -1|<0.05]
%N_RSAMPLE1 <= N_RSAMPLE2
successes1= 0;
successes2= 0;
for nEx= 1:1:N_EXPERIMENTS
    S= laplace11Rnd(1, N_RSAMPLE2);
    if( abs( mean(S(1:N_RSAMPLE1))-LAPLACE11_MU ) < SLLN_EPS )
        successes1= successes1+1;
    end
    if( abs( mean(S(1:N_RSAMPLE2))-LAPLACE11_MU ) < SLLN_EPS )
        successes2= successes2+1;
    end
end

%output
fprintf(    ['The approximated value, using Strong law of large numbers,\n',...
             'of P[|(x1+..+xk)/k-LAPLACE11_MU|<%f] ,where LAPLACE11_MU= %f,\n',...
             'for k= %d and k=%d is %f and %f respectively.\n'], ...
              SLLN_EPS, LAPLACE11_MU, N_RSAMPLE1, N_RSAMPLE2, ...
              successes1/N_EXPERIMENTS, successes2/N_EXPERIMENTS);
%maybe a TODO for when the desired result is not aquired. (but it seems
%that the result is always obtained.)
fprintf(    ['\t As Expected the probability for k=%d was higher and therefore a better \n',...
             'approximation for E(X) as suggested by Strong law of large numbers.\n\n'], N_RSAMPLE2 );

%% Approximating the same probabilities as before, however, this time using Central Limit Theorem
%as explained in the report, calculating P[|(x1+..+xk)/k-LAPLACE11_MU|<eps
%is equivalent to calculating
%P[ -eps*sqrt(n)/\sigma< [(x1+..+xk)-n*LAPLACE11_MU]/\sigma*sqrt(n) <eps*sqrt(n)/\sigma ]
%approximately= normcdf(eps*sqrt(n)/\sigma) - normcdf(-eps*sqrt(n)/\sigma)
theUpperBounds= SLLN_EPS .* sqrt([N_RSAMPLE1, N_RSAMPLE2]) ./ LAPLACE11_SIGMA;
theLowerBounds= -theUpperBounds;

%output
fprintf(    ['The approximated value, using Central limit theorem,\n',...
             'of P[|(x1+..+xk)/k-LAPLACE11_MU|<%f] ,where LAPLACE11_MU= %f,\n',...
             'for k= %d and k=%d is %f and %f respectively.\n'], ...
              SLLN_EPS, LAPLACE11_MU, N_RSAMPLE1, N_RSAMPLE2, ...
              normcdf(theUpperBounds(1)) - normcdf(theLowerBounds(1)),...
              normcdf(theUpperBounds(2)) - normcdf(theLowerBounds(2)) );
fprintf(    ['\t As can be seen, in this problem the approximation of central limit theorem\n',...
             'is probably not "good enough" for small ns such as 100, however, if you change\n',...
             'the order of magnitude of n to 4 (by changing N_RSAMPLE1 and N_RSAMPLE2)\n',...
             'you can see the significant improvement in the approximation.\n'] )