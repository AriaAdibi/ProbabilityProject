function a= tester(p, N, initMoney)
    if( p == 0.5 )
        a= (initMoney)/N;
    else
        q= 1-p;
        a= 1 - ( (1-(p/q)^(N-initMoney) ) / (1-(p/q)^N) );
    end
end