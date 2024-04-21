function [Hbsirs,Hbsue,Hirsue,Hirstg]=generatechannel2(Ricianfactor,DisBS2IRS,DisBS2UE,DisIRS2UE,DisIRS2TG,K,Nt,M,IRSloca,TGloca)
         imaginary=sqrt(-1);
         Hbsirs=zeros(M,Nt);
         Hbsue=zeros(Nt,K);
         Hirsue=zeros(M,K);
         Hirstg=zeros(M,M);
         coeff=Ricianfactor/(Ricianfactor+1);
%% 计算base与RIS间的路损
             PL_LoS=-10*2.0*log10(DisBS2IRS)-31.4-10*2.1*log10(2.7)-2.9;% Sun Shu Umi SC
             Pathloss_LoS=10^(PL_LoS/10);
             n=0:Nt-1;
             theta=2*pi*rand;
             aAoDbsirs=exp(imaginary*n*pi*sin(2*pi*theta));%产生发射信号（天线）的方位角，可以认为是随机的
             n=0:M-1;
             theta=2*pi*rand;
             aAoAbsirs=exp(imaginary*n*pi*sin(2*pi*theta));
             Los=sqrt(Pathloss_LoS)*aAoAbsirs'*aAoDbsirs;
             Nlos=sqrt(1/2)*randn(M,Nt)+imaginary*sqrt(1/2)*randn(M,Nt); 
             PL_NLoS=-10*3.5*log10(DisBS2IRS)-24.4-10*1.9*log10(2.7)-8;% Sun Shu Umi SC
             Pathloss_NLoS=10^(PL_NLoS/10);
             Nlos=Nlos*sqrt(Pathloss_NLoS);
             Hbsirs=Los+Nlos; 
%% 计算BS和UE间的路损         
             for k=1:K
                    PL_NLoS=-10*3.5*log10(DisBS2UE(k))-24.4-10*1.9*log10(2.7)-8;% Sun Shu Umi SC
                    Pathloss_NLoS=10^(PL_NLoS/10);
                    Hbsue(:,k)=sqrt(Pathloss_NLoS)*(sqrt(1/2)*randn(1,Nt)+imaginary*sqrt(1/2)*randn(1,Nt));
             end
         
%% 计算IRS和UE间的信道
             for k=1:K
                    PL_NLoS=-10*3.5*log10(DisIRS2UE(k))-24.4-10*1.9*log10(2.7)-8;% Sun Shu Umi SC
                    Pathloss_NLoS=10^(PL_NLoS/10);
                    Hirsue(:,k)=sqrt(Pathloss_NLoS)*(sqrt(1/2)*randn(1,M)+imaginary*sqrt(1/2)*randn(1,M));
             end
%% 计算IRS和TG间的信道 点目标
             n=0:M-1;
             theta=atan(IRSloca(1)/(100-IRSloca(2)));
             
             %theta=pi/6;
             aAoDbsirs=exp(imaginary*n*pi*sin(theta));%产生发射信号（天线）的方位角，可以认为是随机的
             aAoAbsirs=exp(imaginary*n*pi*sin(theta));
             Los=aAoAbsirs'*aAoDbsirs; %Toeplitz矩阵
             beta=sqrt(calbeta(DisIRS2TG));
             Hirstg=beta*Los;
            % Hirstg=ExtendTg_Channel(DisIRS2TG,IRSloca,TGloca,M);
         