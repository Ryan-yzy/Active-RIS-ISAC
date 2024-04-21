function flag=checkfesible(vline,Pirs,Q3,q5,q6_1,R1_line_1,R2_line_1,...
        q6_2,R1_line_2,R2_line_2,epsilon,M)
    v=vline(1:M);
    V=v*v';
    vhat=reshape(V,[],1);
    flag=1;    
    if vhat'*Q3*vhat+q5'*vhat-Pirs>=0
        flag=0;
    end
    if (1+epsilon)*vline'*R2_line_1*vline-vline'*R1_line_1*vline < q6_1'*vhat
        flag=0;
    end
    if (1+epsilon)*vline'*R2_line_2*vline-vline'*R1_line_2*vline < q6_2'*vhat
        flag=0;
    end
end