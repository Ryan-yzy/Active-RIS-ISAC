function [Q3,q5]=calRISpower(veca,vecI,G,R,sigma1,sigma2,N)
    diagA=diag(veca);
    Q3=diagA'*kron(eye(N),G*R*G')*diagA+sigma1^2*(diagA'*diagA);
    q5=(reshape(G*R*G',[],1))'*diag(vecI)+(sigma1^2+sigma2^2)*vecI'*diag(vecI);
    q5=q5';
end