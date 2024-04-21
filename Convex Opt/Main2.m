clear all;clc;
rng('default');
tic
%%%% Please switch the default solver to Mosek to ensure a stable solution in CVX.
%% System Setting
noisedensity=-174;% thermal noise power density (dBm/Hz)
B=10*10^6;% system bandwidth (Hz)
noisepow=10^((noisedensity-30)/10)*B;% noise power 
imaginary=sqrt(-1);
M=4; %Number of transmit antenna
K=2;  %Number of the single-antenna users 
N=16; %Number of the reflecting elements
Pris=0.1;
Pbs=1-0.41*N*0.001-Pris;% transmit power of BS considering the hardware consumption of active RIS

BSloca=[0,0];
xIRS=5;
yIRS=10;
IRSloca=[xIRS,yIRS];
Xu1loca=0; %UE1 is located near the BS
UE1cenloca=[30,10];
Xu2loca=0;
Yu2loca=yIRS;%UE2 is located near the RIS
UE2cenloca=[30,10];
Xtgloca=0;
Ytgloca=60;
TGloca=[Xtgloca,Ytgloca];
sigma1=sqrt(noisepow);%the noise power of the active RIS
sigmar=sqrt(noisepow);%the noise power of the DFRC BS
sigmaz=sqrt(noisepow);%the noise power of the UE
epsilon=10;% QoS of UE
%% simulation setting
Radius=10;
OutNmax=20;%outer iteration times t_max You may reduce it in practice
Nmax=20;%inner iteration times for BS t_max^1 You may reduce it in practice
InNmax=20;%inner iteration times for RIS t_max^2 You may reduce it in practice
simulationtime=1;% Monte Carlo
cancel_f=0.1;
num=1;
iniConvall=zeros(num,OutNmax); %Sensing SNR after optimizing the RIS reflecting coefficients in each iteration
iniConvinnbis=zeros(num,OutNmax);%Sensing SNR after optimizing the BS precoding in each iteration
%% Simulation activity
for simul=1:simulationtime  
    simul
    %Generate the channel
    UElocation=generaUEloca(UE1cenloca,UE2cenloca,Radius,K);%k*3
    DisBS2IRS=caldisirs(BSloca,IRSloca); %Distance between BS and RIS，1*1
    DisBS2UE=caldisbsue(UElocation,BSloca,K);%k*1
    DisIRS2UE=caldisirsue(IRSloca,UElocation,K);%k*1
    DisIRS2TG=caldisirstg(IRSloca,TGloca);%1*1
    [Hbsirs,Hbsue,Hirsue,Hirstg]=generatechannel2(DisBS2IRS,DisBS2UE,DisIRS2UE,DisIRS2TG,K,M,N,IRSloca,TGloca);
    % BS2UE(M*K) and IRS2UE(N*K) are Rayleigh channel, BS2IRS(N*M) is Rician channel, IRS2target2IRS(N*N) is LoS radar channel.
    [H2,H1,G,A]=equavilent(Hbsue,Hirsue,Hbsirs,Hirstg);
    v1=30*exp(imaginary*2*pi*rand(1,N)); %initialize
    Phi=diag(v1');%N*N
    Wc=zeros(M,K); %Communication Beamformer
    Wr=zeros(M,M); %Sensing Beamformer 
    W=[Wc,Wr];
    %%%% In the considered scenario, we noticed that the introduction of the sensing beamformer
    %%%% does not have a significant impact on the  performance of ISAC systems. However, mathematically,
    %%%% dedicated signal may guarantee the optimality in many cases [8].
    %%%% If you want to reduce the computation complexity, you can replace W with Wc.
    W_t=[Wc,Wr]; %iterative Beamformer
    d=zeros(1,K);
    e=0;
    iterout=0;
    %Some necessary parameters
    veca=reshape(A,[],1);
    vecI=reshape(eye(N),[],1);
    Z=zeros(N+1,N+1);
    Z(N+1,N+1)=1;
    %%%%%BS beamforming%%%%%
    while iterout<OutNmax
        iterout=iterout+1;  
        iterinner=0;
        iter=0;
        [barHbsue,B,C,D,E,d,e]=parafor_BS(Phi,Hbsue,Hbsirs,Hirsue,K,M,G,A,sigma1,sigmaz,sigmar,cancel_f,Pris);
        if iterout==1 %Generate the feasible solution
            [W_t,flag]=calWfes(barHbsue,Pbs,G,Phi,A,d,e,M,K,epsilon);
        end
        J_t=D+E*(W_t*W_t')*E';
        %real(trace(W_t'*B'/J_t*B*W_t))-(square_pos(norm(W_t'*B'/J_t*E*W_t,'fro'))) 
        while iter<=Nmax  %%Upate the BS beamformer              
            [W,~]=calW(barHbsue,Pbs,G,Phi,A,d,e,M,K,epsilon,W_t,J_t,B,D,E);
            W_t=W;
            J_t=D+E*(W_t*W_t')*E';              
%             if iterout==1
%                 iniConvinnMM(1,iter+1)=iniConvinnMM(1,iter+1)+SNR;
%             end
%%%%        you  can check the inner iteration here
            iter=iter+1;
        end
        R1=W_t(:,1)*W_t(:,1)';
        R2=W_t(:,2)*W_t(:,2)';
        R=W_t*W_t';
        J_t1=J_t;
        B_t1=B;
        iniConvinnbis(num,iterout)=iniConvinnbis(num,iterout)+trace(B_t1*R*B_t1'/J_t1);
%%%%%Active RIS Reflecting coefficients%%%%%
        while iterinner<=InNmax 
            T_t1=J_t1^(-1)*B_t1*R*B_t1'*J_t1^(-1);
            %%
            alpha_square=norm(Phi'*A*Phi)/norm(G* T_t1*G'*Phi);
            [M1,n1,n2,M2,K_t1]=calRadarSINR(A,G,R,B_t1,J_t1,T_t1,sigma1,N,alpha_square,cancel_f);
            [M3,M4]=calactRISpower(A,G,R,sigma1,N);
            [R1_line_1,R2_line_1]=calcommSINR2(G,H1(:,1),H2(:,1),R,R1);
            [R1_line_2,R2_line_2]=calcommSINR2(G,H1(:,2),H2(:,2),R,R2);
            [Vbar]=calVbar2(n1,n2,M1,M2,M3,M4,K_t1,H1,N,Pris,epsilon,R1_line_1,R2_line_1,R1_line_2,R2_line_2,sigma1,sigmaz,Z,T_t1,G,R);
            %[v,target]=getvviaGauss2(Vbar,2000,q1,Q2,q3,q4,N,Pris,Q3,q5,q6_1,R1_line_1,R2_line_1,...
        %q6_2,R1_line_2,R2_line_2,epsilon); %Gaussian Randomization
            [v]=getvviaeig(Vbar);%Rank one decomposition
            u=v(N+1);
            v=v(1:N);
            Phi=diag(v');            
            %%% Update the parameters
            B_t1=G'*Phi'*A*Phi*G;
            J_t1=calJ(sigma1,sigmar,G,Phi,A,R,M,cancel_f);
            T_t1=J_t1^(-1)*B_t1*R*B_t1'*J_t1^(-1);           
%             if iterout==1
%                 iniConvinnMM2(1,iterinner+1)=iniConvinnMM2(1,iterinner+1)+target;%
%             end
%%%%        you  can check the inner iteration here
            iterinner=iterinner+1;
        end
        iniConvall(num,iterout)=iniConvall(num,iterout)+trace(B_t1*R*B_t1'/J_t1);
    end
    
end
save 01_1