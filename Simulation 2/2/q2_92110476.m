%% Initialization
clear all; close all; clc;

%refer to help of bivariateNormalRnd function
MU= [1, 1];
SIGMA= [1, 0.5; 0.5, 1];

N_EXPERIMENTS= 10* 1000;

Y_LIM= 1.5; %for the graphs

%% Generating 2 random variables with bivariate normal distribution when mu= MU and Sigma= SIGMA
%the function is bivariateNormalRnd
a= bivariateNormalRnd(MU, SIGMA);
%output
fprintf(   ['Generating 2 random variables with bivariate normal distribution when\n',...
            'mu=[%f, %f] and Sigma= [%f, %f; %f, %f]:\n \t %f, %f\n'], MU(1), MU(2),...
             SIGMA(1), SIGMA(3), SIGMA(2), SIGMA(4), a(1), a(2) );
         
%% Estimating E[X | |Y-1|<1] where X and Y have binormaldist with mu= MU and Sigma= SIGMA and graphing the result
% I assumed the output of |Y-1|<1 is either 0 or 1
nEx0= 0;    %number of experiments in which the output is 0 (i.e >= 1)
nEx1= 0;    %number of experiments in which the output is 1 (i.e < 1)
X0= zeros(1, N_EXPERIMENTS);    indx0= 1;
X1= zeros(1, N_EXPERIMENTS);    indx1= 1;
while( nEx0 < N_EXPERIMENTS && nEx1 < N_EXPERIMENTS )
    a= bivariateNormalRnd(MU, SIGMA);
    x= a(1);    y= a(2);
    
    if( nEx1 < N_EXPERIMENTS && abs(y-1)<1 )
        X1(indx1)= x;
        indx1= indx1+1;
        nEx1= nEx1+1;
    elseif( nEx0 < N_EXPERIMENTS && abs(y-1)>=1 )
        X0(indx0)= x;
        indx0= indx0+1;
        nEx0= nEx0+1;
    end
end 

%output
EX0= mean(X0);  EX1= mean(X1);
fprintf(    ['The approximated value for E[X | |Y-1|<1] with given conditions\n',...
             'is %f and %f when the output of the condition is 0 and 1 respectively.\n'],...
             EX0, EX1 );
fig= figure('Name', 'E[X|Z] vs Z where Z= |Y-1|<1 (0 for false, 1 for true)',...
            'NumberTitle','off');
bar([0,1], [EX0, EX1]);
myDefaultFigureProperties(fig);
xlabel('Z   (Z= |Y-1|<1)', 'FontWeight', 'bold');
ylabel('E[X|Z]', 'FontWeight', 'bold');
ylim( [0,Y_LIM] );

%% Estimating the distribution of Var(X_n) where X_n= E[X | |Y-1|<n]
%note that E[X_n]= E[ E[X | |Y-1|<n] ]= E[X]
%E[X]= 1

N= [1, 5, 10];
for n=N
    % I assumed the output of |Y-1|<n is either 0 or 1
    nEx0= 0;    %number of experiments in which the output is 0 (i.e >= n)
    nEx1= 0;    %number of experiments in which the output is 1 (i.e < n)
    X0= zeros(1, N_EXPERIMENTS);    indx0= 1;
    X1= zeros(1, N_EXPERIMENTS);    indx1= 1;
    while( nEx0 < N_EXPERIMENTS && nEx1 < N_EXPERIMENTS )
        a= bivariateNormalRnd(MU, SIGMA);
        x= a(1);    y= a(2);

        if( nEx1 < N_EXPERIMENTS && abs(y-1)<n )
            X1(indx1)= x;
            indx1= indx1+1;
            nEx1= nEx1+1;
        elseif( nEx0 < N_EXPERIMENTS && abs(y-1)>=n )
            X0(indx0)= x;
            indx0= indx0+1;
            nEx0= nEx0+1;
        end
    end
    
    %output
    %E[X]= 1
    VarX0= mean( (1-X0).^2 );  VarX1= mean( (1-X1).^2 );
fprintf(    ['The approximated value for Var(X_%d) with given conditions\n',...
             'is %f and %f when the output of the condition is 0 and 1 respectively.\n'],...
             n, VarX0, VarX1 );
         
    fig= figure('Name', sprintf('Var(X_%d) vs Z_%d where Z_%d= |Y-1|<%d (0 for false, 1 for true)', n,n,n,n),...
            'NumberTitle','off');
    bar([0,1], [VarX0, VarX1]);
    myDefaultFigureProperties(fig);
    xlabel( sprintf('Z_{%d}   (Z_{%d}= |Y-1|<{%d})', n,n,n), 'FontWeight', 'bold');
    ylabel( sprintf('Var(X_{%d})', n), 'FontWeight', 'bold');
    ylim( [0,Y_LIM] );
end