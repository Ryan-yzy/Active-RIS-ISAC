function DisBS2UE=caldisbsue(UElocation,BSloca,K)
         DisBS2UE=zeros(K,1);
             for k=1:K 
                        DisBS2UE(k,1)=norm(BSloca-UElocation(k,:));
             end
end