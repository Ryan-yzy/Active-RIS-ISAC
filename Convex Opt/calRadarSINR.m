function   [M1,n1,n2,M2,K_t1]=calRadarSINR(A,G,R,B_t1,J_t1,T_t1,sigma1,N,alpha_square,cancel_f)
    vecAH=reshape(A',[],1);
    n1=diag(vecAH)'*reshape(G*R*B_t1'*J_t1^(-1)*G',[],1);
    S=kron(eye(N),G*T_t1*G');
    S=0.5*(S'+S);
    L1=sqrtm(S);
    M1=sigma1*L1*diag(vecAH);
    n2=cancel_f*reshape(G*R*G',[],1)'*diag(reshape(G*T_t1*G',[],1));
    n2=n2';
    M2=sigma1/sqrt(alpha_square)*diag(vecAH);
    K_t1=sigma1^2*alpha_square*G*T_t1*G'*G*T_t1*G';    
end