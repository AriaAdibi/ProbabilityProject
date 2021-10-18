%% Initialization
clear all; close all; clc;

%note that lim[ 1/(1+x^4) ] as x->oo or x->-oo is 0 and 1/(1+x^4) is an
%even function
X_LIM= 8192; % 1/(1+x^4) < eps_machine(of double precision) ==> lim= 8192 % we approximate the rest of the area to be 0
Y_LIM= 1; %supremum of 1/(1+x^4)

N_POINTS= 20* 1000* 1000;

%% Calculate the under the curve area
%the function is even ==> the area= 2* \int_{0}^{LIM} 1/(1+x^4) dx
%accoriding to Monte Carlo(that latently uses string law of large numbers)
%--> I= [md(b-a)]/n (excerpted from the book)

points= rand(2, N_POINTS); %X;Y
points(1,:)= points(1,:) * X_LIM;
points(2,:)= points(2,:) * Y_LIM;

nPointsUnder= sum( points(2,:) < 1./(1+points(1,:).^4) );

fprintf('The approximated under the curve area is: %f\n', 2* ( nPointsUnder*Y_LIM*(X_LIM-0) )/N_POINTS);