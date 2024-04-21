function barHbsue=calbarHbsue(Phi,Hbsue,Hbsirs,Hirsue,K,M)
         barHbsue=zeros(M,K);
                 for k=1:K
                     barHbsue(:,k)=(Hirsue(:,k)'*Phi*Hbsirs+Hbsue(:,k)')';
                 end
end

          
          
         
         