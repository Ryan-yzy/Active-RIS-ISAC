function DisIRS2UE=caldisirsue(IRSloca,UElocation,K)

         DisIRS2UE=zeros(K,1);
         for i=1:2
                 DisIRS2UE(i)=norm(IRSloca-UElocation(i,:));
         end