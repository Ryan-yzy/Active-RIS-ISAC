function J_t1=calJ(sigma1,sigmar,G,Phi,A,R,M,cancel_f)
    C=G'*Phi'*A*Phi;
   % J_t1=sigma1^2*C*C'+sigma2^2*G'*Phi'*Phi*G+sigmar^2*eye(M)+cancel_f*G'*Phi*G*R*G'*Phi'*G;
    J_t1=sigma1^2*C*C'+2*sigma1^2*G'*Phi'*Phi*G+sigmar^2*eye(M)+cancel_f*G'*Phi*G*R*G'*Phi'*G+sigma1^2*(G'*Phi*Phi'*A*Phi*G+G'*Phi'*A*Phi*Phi'*G);
end