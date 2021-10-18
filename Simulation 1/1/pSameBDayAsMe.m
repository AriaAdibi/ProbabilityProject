%Estimates the probability of existence of an individual
%among n individuals whose birthay is same as mine
function p= pSameBDayAsMe(n, nExperiments)
    %my date of birth is 1
    global N_DAYS_PER_YEAR
    S= randi(N_DAYS_PER_YEAR, [n, nExperiments], 'uint16')==1;
    if(n ~= 1)
        S= sum(S);
    end
    
    p= length(find(S))/nExperiments;
end