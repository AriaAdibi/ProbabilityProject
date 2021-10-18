%Estimates the probability of existence of k individuals
%among n individuals whose their birthays are the same
function p= pKSameBDay(n, k, nExperiments)
    global N_DAYS_PER_YEAR
    p= 0;
    for nEx=1:1:nExperiments
        S= randi(N_DAYS_PER_YEAR, [1, n], 'uint16');
        p= p + double( max(histcounts(S, 1:1:N_DAYS_PER_YEAR+1)) >= k);
    end
    p= p/nExperiments;
end