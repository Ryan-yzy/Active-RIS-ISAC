function [W,SNR]=calW(barHbsue,Pbs,G,Phi,A,d,e,M,K,epsilon,W_t,J_t,B,D,E)
   S=Phi'*A*Phi*G;
   T=Phi*G;
   %%%% Adjust the input scale of CVX to ensure its performance
   barHbsue=barHbsue*1e4;
   d=d*1e8;
   S=S*1e3;
   T=T*1e3;
   e=e*1e6;
   cvx_clear;
   cvx_begin quiet
        variable W(M,M+K) complex
        maximize (2*real(trace(W_t'*B'/J_t*B*W))-(square_pos(norm(W_t'*B'/J_t*E*W,'fro'))))
        subject to
         square_pos(norm(W,'fro'))<=Pbs;
          (square_pos(norm(S*W,'fro')))+(square_pos(norm(T*W,'fro')))<=e;
            for k=1:K
                (1+1/epsilon)*2*real(barHbsue(:,k)'*W_t(:,k)*(W(:,k)'*barHbsue(:,k)))...
                -(1+1/epsilon)*real(barHbsue(:,k)'*W_t(:,k)*W_t(:,k)'*barHbsue(:,k))>=square_pos((norm(barHbsue(:,k)'*W)))+d(k)                
            end
   cvx_end
    J=D+E*W*W'*E';
%    J=1/2*(J+J');
   (trace(J_t^(-1)*B*W_t*W_t'*B'*J^(-1)*J))-((norm(W_t'*B'/J_t*E*W_t,'fro')))^2   
   SNR=cvx_optval-trace(J_t^(-1)*B*W_t*W_t'*B'*J^(-1)*D);
end
