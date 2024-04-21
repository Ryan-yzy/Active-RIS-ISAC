function UElocation=generaUEloca(UE1cenloca,UE2cenloca,Radius,K)
         UElocation=zeros(K,2);%分别生成两个用户的位置（感觉这个代码写的不是很好hhh）
         for k=1:K
             if k==1
                 r=sqrt(rand)*Radius;
                 theta=2*pi*rand;
                 UElocation(k,1)=UE1cenloca(1)+r*cos(theta);
                 UElocation(k,2)=UE1cenloca(2)+r*sin(theta);
                 %UElocation(k,3)=UE1cenloca(3);                 
             else
                 r=sqrt(rand)*Radius;
                 theta=2*pi*rand;
                 UElocation(k,1)=UE2cenloca(1)+r*cos(theta);
                 UElocation(k,2)=UE2cenloca(2)+r*sin(theta);
                % UElocation(k,3)=UE2cenloca(3);
             end
         end
             
end
         