function [q1,Q2,q3,q4]=calRadar2(veca,vecI,G,R,sigma1,sigma2,N,B_t1,J_t1,T_t1)
    diagA=diag(veca);
    q1=(reshape(G*J_t1^(-1)*B_t1*R*G',[],1))'*diagA;
    q1=q1';    
    Q2=sigma1^2*diagA'*kron(eye(N),G*T_t1*G')*diagA;
    vecGTG=reshape(G*T_t1*G',[],1);
    q3=(reshape(G*R*G',[],1))'*diag(vecGTG);
    q3=q3';
    q4=sigma2^2*vecGTG'*diag(vecI);
    q4=q4';
end