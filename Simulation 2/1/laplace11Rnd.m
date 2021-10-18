%integratig f gives 	
%calculating F^-1 yealds    if 0>y>-1/2 (x>1) --> x= 1-ln(-2y)
%                           if 0<y<1/2  (x<1) --> x= 1+ln(2y)
%using Inverse transform we have x= F^-1(u) where u is a randomly generated
%number from U[0,1]
%input: m, n- m*n generated numbers
function X= laplace11Rnd(m, n)
    u= rand(m,n)-0.5;
    while( ~isempty( find(u==0, 1) ) ) %assuring that u ~= 0 (in any entry) (not defined in 0)
        u= rand(m,n)-0.5;
    end
    X= zeros(m, n);
    X( u<0 )= 1- log(-2.*u(u<0));
    X( u>0 )= 1+ log(2.*u(u>0));
end