function [v,target]=getvviaGauss2(Vbar,L,q1,Q2,q3,q4,N,Pirs,Q3,q5,q6_1,R1_line_1,R2_line_1,...
        q6_2,R1_line_2,R2_line_2,epsilon)
    max_F = 0;
    max_v = zeros(1,N);
    [U, Sigma] = eig(Vbar);
    for l = 1 : L
        r = sqrt(2) / 2 * (randn(N+1, 1) + 1j * randn(N+1, 1));
        vline = U * Sigma^(0.5) * r;
        v=vline(1:N);
        flag=checkfesible(vline,Pirs,Q3,q5,q6_1,R1_line_1,R2_line_1,...
        q6_2,R1_line_2,R2_line_2,epsilon,N);  %check whether it satisfied the constraint      
        Phi=diag(v');
        target=caltarget(v,q1,Q2,q3,q4);
        if (target>max_F && flag==1)
            max_v = v;
            max_F = target;
        end
    end
    v=max_v;
    target=real(max_F);
end