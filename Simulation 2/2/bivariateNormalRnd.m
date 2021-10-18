%input: mu= [muX, muY] (must be 1*2)
%       Sigma= [cov(X,X), cov(X,Y); cov(Y,X), cov(Y,Y)] ==> symmetric positive definite matrix
function a= bivariateNormalRnd(mu,Sigma)
    if( isequal(size(mu), [1,2]) == 0 )
        error('mu must have dimensions 1x2.');
    end
    if( isequal(size(Sigma), [2,2]) == 0 )
        error('Sigma must have dimensions 2x2.');
    end
    
    try
        U=chol(Sigma);
    catch
        [E,Lambda]=eig(Sigma);
        if( min(diag(Lambda))<0 )
            error('Sigma must be positive semi-definite.')
        end
        U = sqrt(Lambda)*E';
    end

    a = randn(1,2)*U + mu;
end