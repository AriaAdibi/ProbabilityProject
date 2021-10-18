%% Initialization
clear all; close all; clc;

MAX_N_SAMPLING= 1000;

MU= 50;
SIGMA= sqrt(35);

%% Claculating the mean of our random samples
means= zeros(1, MAX_N_SAMPLING); 
for i=1:1:MAX_N_SAMPLING %sampling i points
    S= normrnd(MU, SIGMA, [1, i]);
    means(i)= mean(S);
end

%% Output
fig= figure('Name', 'Random Sample Mean - Sampling x Points','NumberTitle','off');
bar(means);
myDefaultFigureProperties(fig);
xlabel('Number of Samples', 'FontWeight', 'bold');
ylabel('Mean of Random Sample', 'FontWeight', 'bold');

fig= figure('Name', 'Random Sample Mean + 100/log(n) - Sampling x Points','NumberTitle','off');
bar(means + 100./ log(1:1:MAX_N_SAMPLING));
myDefaultFigureProperties(fig);
xlabel('Nuber of Samples', 'FontWeight', 'bold');
ylabel('Mean of Random Sample + 100/log(n)', 'FontWeight', 'bold');