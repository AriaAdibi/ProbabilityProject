function areThese2EXsEqual(S, theDistributionName)
    global EPS N_EXPERIMENTS
    
    %defE <-- E according to definition
    %newE <-- the new under investigation E
    defE= mean(S);

    maxGenNum= max(S);
    newE= 0;
    for i=1:1:maxGenNum
        newE= newE + sum(S>=i);
    end
    newE= newE/N_EXPERIMENTS;

    if( abs(defE-newE) < EPS )
        %output
        fprintf('For %s distribution, they are the same.\n', theDistributionName);
    else
        %output
        fprintf('For %s distribution, they are not the same!!!!--Apparently the simulation failed!\n', theDistributionName);
    end
end