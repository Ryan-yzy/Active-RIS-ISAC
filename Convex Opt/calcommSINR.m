function [q6,R1_line,R2_line]=calcommSINR(vecI,G,sigma1,h1,h2,R,Rk)
%remark�����ô˺�����ֻ�����εõ������û���Ӧ�ľ��������ں������棬��Ҫ���ε��ø����û���
    vechh=reshape(h1*h1',[],1);
    q6=sigma1^2*vecI'*diag(vechh);
    q6=q6';
    A=diag(h1')*G*R*G'*diag(h1);
    B=diag(h1')*G*R*h2;
    C=h2'*R*G'*diag(h1);%zע������û�С�
    D=h2'*R*h2;
    R1_line=[A,B;C,D];
    A=diag(h1')*G*Rk*G'*diag(h1);
    B=diag(h1')*G*Rk*h2;
    C=h2'*Rk*G'*diag(h1);
    D=h2'*Rk*h2;
    R2_line=[A,B;C,D];    
end
