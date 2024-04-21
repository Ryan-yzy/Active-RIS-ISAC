function UElocation=generaUEloca(UE1cenloca,UE2cenloca,Radius,K)
         UElocation=zeros(K,2);
         for k=1:K
             if k==1
                 r=sqrt(rand)*Radius;
                 theta=2*pi*rand;
                 UElocation(k,1)=UE1cenloca(1)+r*cos(theta);
                 UElocation(k,2)=UE1cenloca(2)+r*sin(theta);               
             else
                 r=sqrt(rand)*Radius;
                 theta=2*pi*rand;
                 UElocation(k,1)=UE2cenloca(1)+r*cos(theta);
                 UElocation(k,2)=UE2cenloca(2)+r*sin(theta);
             end
         end
             
end
         