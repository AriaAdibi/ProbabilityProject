%% initialization
clear all; close all; clc;

N_EXPERIMENTS= 10^5;
EPS= 10^5;
    
POISSON_LAMBDA= 10;
UNIFORM_DISTRIBUTION_MAX_V= 100; %MIN_V= 1

%% generating points with desired distribution and calculating random variables
S= [randi(UNIFORM_DISTRIBUTION_MAX_V, [1, N_EXPERIMENTS]); poissrnd(POISSON_LAMBDA, [1, N_EXPERIMENTS])]; %X1;X2

%h= X_1^2 + 2X_2 + X_3/4; ---- X_3= X_1 + X_2;
h= S(1,:).^2 + 2.*S(2,:) + ( S(1,:)+S(2,:) )/4;

%% part a - lets check the equality
%the left hand side
defE= mean(h);

%the right hand side
possibleValuesOfX1= unique( S(1,:) );
possibleValuesOfX2= unique( S(2,:) );

%E according to the law of the unconscious starician
unconsciousE= 0;
for x1= possibleValuesOfX1
    for x2= possibleValuesOfX2
        %p= P( (X1, X2, X3)= (x1, x2, x3) )
        p= sum ( S(1,:)==x1 & S(2,:)==x2 )/ N_EXPERIMENTS;
        unconsciousE= unconsciousE + p*(x1^2 + 2*x2 + (x1+x2)/4);
    end
end

%checking
if( abs(defE-unconsciousE) < EPS )
    fprintf('The Equation seems to hold.\n');
else
    fprintf('The Equation seems to not hold!!!!!\n');
end

%% part b
maxX1= UNIFORM_DISTRIBUTION_MAX_V;
maxX2= max(possibleValuesOfX2);
maxX3= maxX1 + maxX2;
maxH= maxX1^2 + 2*maxX2 + (maxX1+maxX2)/4;

%PMF X1
fig= figure('Name', 'Probability mass function X_1','NumberTitle','off');
bar( histcounts(S(1,:), 1:1:maxX1+1)/N_EXPERIMENTS);
myDefaultFigureProperties(fig, sprintf('X_{%d}', 1) );

%PMF X2
fig= figure('Name', 'Probability mass function X_2','NumberTitle','off');
bar( histcounts(S(2,:), 1:1:maxX2+1)/N_EXPERIMENTS);
myDefaultFigureProperties(fig, sprintf('X_{%d}', 2) );

%PMF X3
fig= figure('Name', 'Probability mass function X_3','NumberTitle','off');
bar( histcounts( S(1,:)+S(2,:), 1:1:maxX3+1)/N_EXPERIMENTS);
myDefaultFigureProperties(fig, sprintf('X_{%d}', 3) );

%PMF h(X1, X2, X3)
fig= figure('Name', 'Probability mass function h(X1, X2, X3)','NumberTitle','off');
bar( histcounts( h, 1:1:maxH+1)/N_EXPERIMENTS);
myDefaultFigureProperties(fig, sprintf('h(X_{%d}, X_{%d}, X_{%d})', 1, 2, 3) );

