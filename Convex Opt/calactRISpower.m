function [M3,M4]=calactRISpower(A,G,R,sigma1,N)
    vecAH=reshape(A',[],1);
    S=kron(eye(N),G*R*G');
    L2=sqrtm(S);
    M3=L2*diag(vecAH);
    M4=sigma1*diag(vecAH);
end