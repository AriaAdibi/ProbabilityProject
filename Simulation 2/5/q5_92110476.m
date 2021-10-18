%% Initialization
clear all; close all; clc;

N_POINTS= [5000, 20* 1000, 50*1000, 1000*1000];

X_LENGTH= 2;
Y_LENGTH= 1;

%% Generating points
for nPoints= N_POINTS
    
    %this is uniform due to the definition of uniform random number in a
    %region of a plane
    nP= 0;
    xPoints= zeros(1, nPoints); yPoints= zeros(1, nPoints);
    while(nP < nPoints)
        %choosing a random number from the rectangle
        %[-X_LENGTH/2,X_LENGTH/2]*[-Y_LENGTH/2,Y_LENGTH/2]
        x= rand()*X_LENGTH-X_LENGTH/2;  y= rand()*Y_LENGTH-Y_LENGTH/2;
        
        %check to see if the point is in the ellipses
        if(x^2+4*y^2<=1)
            nP= nP+1;
            xPoints(nP)= x; yPoints(nP)= y;
        end
    end

    % output
    fig= figure('Name', sprintf('%d pseudo-randomly and uniformly selected points in x^2 + 4y^2 <= 1.', nPoints),...
                'NumberTitle','off');
    plot(xPoints, yPoints, '.');
    myDefaultFigureProperties(fig);
    xlabel('X', 'FontWeight', 'bold');
    ylabel('Y', 'FontWeight', 'bold');
end