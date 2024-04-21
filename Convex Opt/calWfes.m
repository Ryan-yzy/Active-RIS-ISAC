function [W,flag]=calWfes(barHbsue,Pbs,G,Phi,A,d,e,M,K,epsilon)
   S=Phi'*A*Phi*G;
   T=Phi*G;
   %%%% Adjust the input scale of CVX to ensure its performance
   barHbsue=barHbsue*1e3;   
   d=d*1e6;
   S=S*1e3;
   T=T*1e3;
   e=e*1e6;
   %%%% Please change the default solver into Mosek
   cvx_clear;
   cvx_begin 
        variable R(M,M) hermitian semidefinite;
        variable R1(M,M) hermitian semidefinite;
        variable R2(M,M) hermitian semidefinite;
        subject to
             trace(R) <= Pbs;
            (1+1/epsilon)*real(barHbsue(:,1)'*R1*barHbsue(:,1))-(barHbsue(:,1)'*R*barHbsue(:,1)+d(1))>=0;
            (1+1/epsilon)*real(barHbsue(:,2)'*R2*barHbsue(:,2))-((barHbsue(:,2)'*R*barHbsue(:,2))+d(2))>=0; 
            trace(S*R*S')+trace(T*R*T')<=e;
            R==R1+R2;
   cvx_end
   W(:,1)=R1*barHbsue(:,1)/sqrt(barHbsue(:,1)'*R1*barHbsue(:,1));
   W(:,2)=R2*barHbsue(:,2)/sqrt(barHbsue(:,2)'*R2*barHbsue(:,2));
   Res=0.5*((R- W(:,1)*W(:,1)'- W(:,2)*W(:,2)')+(R- W(:,1)*W(:,1)'- W(:,2)*W(:,2)')');
   W(:,3:M+K)=chol(Res);
   if cvx_optval==+inf
       flag=0;
   else
       flag=1;
   end
