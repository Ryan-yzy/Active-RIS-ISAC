clear all;clc;
rng('default');
[all_themes, all_colors] = GetColors();
tic
%% System Setting
noisedensity=-174;% thermal noise power density (dBm/Hz)
B=10*10^6;% system bandwidth (Hz)
noisepow=10^((noisedensity-30)/10)*B;% noise power 
imaginary=sqrt(-1);
M=1; %发射天线
K=2;  %单天线用户个数
%N=10^3; %反射元素个数
Pris=0.1;
Pbs=1;
% afabsirs=2.2;%pathloss 里面的指数项
% afairsue=2.2;
% afabsue=2.2;
% afairstg=2.2;%RIS到target的路径 
% PL0=-30;
BSloca=[0,0];
xIRS=5;
yIRS=30;
IRSloca=[xIRS,yIRS];
Xtgloca=0;
Ytgloca=60;%固定不变的
TGloca=[Xtgloca,Ytgloca];
Ricianfactor=3;% BS2RIS
sigma1=sqrt(noisepow);%第一次反射噪声
sigma2=sqrt(noisepow);%第二次反射噪声
sigmar=sqrt(noisepow);%在BS处接收的噪声
sigmaz=sqrt(noisepow);%在UE处接收到的噪声
a_RIS=10^4;
%% simulation setting
simulationtime=1;
cancel_f=10^(-3);
num=25;%num=1表示对系统进行测试，不进行参数比较
error=0;%报错信息
%% Simulation activity
for number=1:num  
    N=40*(number);
    %Generate the channel
    DisBS2IRS=caldisirs(BSloca,IRSloca); %计算RIS和BS间距离，1*1
    DisIRS2TG=caldisirstg(IRSloca,TGloca);%1*1
    %BS-RIS
    PL_LoS_g=-10*2.0*log10(DisBS2IRS)-31.4-10*2.1*log10(2.7)-2.9;% Sun Shu Umi SC
    Pathloss_g=10^(PL_LoS_g/10);
    n=0:N-1;
    theta_g=atan(IRSloca(1)/(0-IRSloca(2)));
    atheta_2=exp(imaginary*n*pi*sin(theta_g)).';
    g=sqrt(Pathloss_g)*atheta_2;
    % RIS-Target_RIS
    theta_a=atan(IRSloca(1)/(60-IRSloca(2)));
    atheta_3=exp(imaginary*n*pi*sin(theta_a)).';
    Los_A=atheta_3*atheta_3'; %Toeplitz矩阵
    beta_r=sqrt(calbeta(DisIRS2TG));
    A=beta_r*Los_A;
   %[Hbsirs,Hbsue,Hirsue,Hirstg]=generatechannel(Ricianfactor,DisBS2IRS,DisBS2UE,DisIRS2UE,DisIRS2TG,afabsirs,afairsue,afabsue,PL0,K,M,N);
%    [Hbsirs,Hbsue,Hirsue,Hirstg]=generatechannel2(Ricianfactor,DPbsisBS2IRS,DisBS2UE,DisIRS2UE,DisIRS2TG,K,M,N,IRSloca,TGloca);    % BS2UE(M*K) and IRS2UE(N*K) are Rayleigh channel, BS2IRS(N*M) is Rician channel, IRS2target2IRS(N*N) is LoS channel,
    for i=1:N
        angle_psi=angle(atheta_3(i))-angle(g(i));
        psi(i)=exp(1j*angle_psi);
    end
    rho_0=sqrt(a_RIS);
   % rho_1=(Pris/(Pbs*N^3*beta_r*Pathloss_g))^(0.25);
    rho_2=min(rho_0,sqrt(Pris/(N*Pathloss_g*Pbs)));
%    rho_2=rho_0;
%     rho_1=rho_0;
%     rho_2=rho_0;
    Phi=diag(psi)*rho_2;
   % Psi=diag(psi);
    g1(number)=2*real(sigma1^2*g'*Phi*Phi'*A*Phi*g)+cancel_f^2*abs(Pbs*g'*Phi*g)^2;
    %g1(number)=cancel_f^2*rho_1^2*Pbs*N^2*Pathloss_g^2;
    g2(number)=2*rho_2^3*sigmar^2*N^2*beta_r*Pathloss_g;
   % f=g'*Psi'*atheta_3*sqrt(beta_r);
    %test
    %N^2*beta_r*Pathloss_g-abs(f)^2
    %Pbs*rho^4*abs(g'*Psi'*A*Psi*g)^2-Pbs*rho^4*N^4*Pathloss_g^2*beta_r^2
    %result
    SNR(number)=Pbs*rho_2^4*N^4*Pathloss_g^2*beta_r^2/(sigmar^2);
    SINR_app(number)=Pbs*rho_2^4*N^4*Pathloss_g^2*beta_r^2/(sigmar^2+2*rho_2^2*sigmaz^2*N*Pathloss_g);
 %   SINR_up(number)=Pbs*rho_1^4*N^4*Pathloss_g^2*beta_r^2/(rho_1^4*sigmaz^2*N^3*beta_r^2*Pathloss_g);
    SINR_self(number)=Pbs*rho_2^4*N^4*Pathloss_g^2*beta_r^2/(sigmar^2+2*rho_2^2*sigmaz^2*N*Pathloss_g+rho_2^4*sigmaz^2*N^3*beta_r^2*Pathloss_g+g1(number));
 %   SINR_low(number)=Pbs*rho_2^4*N^4*Pathloss_g^2*beta_r^2/(sigmar^2+2*rho_2^2*sigmaz^2*N*Pathloss_g+rho_1^4*sigmaz^2*N^3*beta_r^2*Pathloss_g+g2(number));  
end
%%
close all
for i=1:num
    ele(i)=40*(i);
end
logSNR_power=10*log10(SNR);
logSINR_app_power=10*log10(SINR_app);
%logSINR_up_power=10*log10(SINR_up);
logSINR_self_power=10*log10(SINR_self);
%logSINR_low_power=10*log10(SINR_low);
plot(ele,logSNR_power,'+-','Color', all_colors(1, :),'LineWidth',2);
hold on;
plot(ele,logSINR_app_power,'o-','Color', all_colors(2, :),'LineWidth',2);
hold on;
%plot(ele,logSINR_up_power,'*-','Color', all_colors(3, :),'LineWidth',2);
hold on;
plot(ele,logSINR_self_power,'s-','Color', all_colors(4, :),'LineWidth',2);
hold on;
%plot(ele,logSINR_low_power,'d-','Color', all_colors(5, :),'LineWidth',2);
grid on
% plot(16:4:36,result_pas,'*-','Color', all_colors(3, :),'LineWidth',1.5);
% plot(16:4:36,result_pas_fair,'s-','Color', all_colors(4, :),'LineWidth',1.5);
% plot(16:4:36,result_pas_fair6,'d-','Color', all_colors(5, :),'LineWidth',1.5);
% plot(16:4:36,result_pas_6,'h-','Color', all_colors(6, :),'LineWidth',1.5);
%xlim([16,36])
%xlim([200,7500])
legend('SNR','${\rm{ SINR}}_{\rm{app}}$','${\rm{ SINR}}_{\rm{up}}$', 'SINR','${\rm{ SINR}}_{\rm{low}}$','Interpreter','latex')
xlabel('Number of RIS reflecting elements');
ylabel('Radar SINR (dB)');
save performance_result_power_small_01w_both