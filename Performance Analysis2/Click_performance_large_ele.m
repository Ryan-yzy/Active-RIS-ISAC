clear all;clc;
rng('default');
[all_themes, all_colors] = GetColors();
tic
%% System Setting
noisedensity=-174;% thermal noise power density (dBm/Hz)
B=10*10^6;% system bandwidth (Hz)
noisepow=10^((noisedensity-30)/10)*B;% noise power 
imaginary=sqrt(-1);
M=1; 
K=2; 
Pris=1;
Pbs=1;
BSloca=[0,0];
xIRS=5;
yIRS=30;
IRSloca=[xIRS,yIRS];
Xtgloca=0;
Ytgloca=60;
TGloca=[Xtgloca,Ytgloca];
sigma1=sqrt(noisepow);%the noise power of the active RIS
sigmar=sqrt(noisepow);%the noise power of the DFRC BS
sigmaz=sqrt(noisepow);%the noise power of the UE
a_RIS=10^4;
%% simulation setting
simulationtime=1;
cancel_f=10^(-3);
num=20;
%% Simulation activity
for number=1:num  
    N=1000*(number);
    %Generate the channel
    DisBS2IRS=caldisirs(BSloca,IRSloca); 
    DisIRS2TG=caldisirstg(IRSloca,TGloca);
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
    for i=1:N
        angle_psi=angle(atheta_3(i))-angle(g(i));
        psi(i)=exp(1j*angle_psi);
    end
    rho_0=sqrt(a_RIS);
    rho_1=(Pris/(Pbs*N^3*beta_r^2*Pathloss_g))^(0.25);
    rho_max=200;
    rho_min=1;
    rho_real=(rho_min+1)*0.5;
    rho_real=biserarch_rho(rho_max,rho_min,N, Pris, Pbs,beta_r,Pathloss_g,rho_real);
    rho_1=rho_real;
    Phi=diag(psi)*rho_1;
   % Psi=diag(psi);
    g1(number)=2*real(sigma1^2*g'*Phi*Phi'*A*Phi*g)+cancel_f^2*abs(Pbs*g'*Phi*g)^2;
    %g1(number)=cancel_f^2*rho_1^2*Pbs*N^2*Pathloss_g^2;
    g2(number)=2*rho_1^3*sigmar^2*N^2*beta_r*Pathloss_g;
    SINR_up(number)=Pbs*rho_1^4*N^4*Pathloss_g^2*beta_r^2/(rho_1^4*sigmaz^2*N^3*beta_r^2*Pathloss_g);
    SINR_self(number)=Pbs*rho_1^4*N^4*Pathloss_g^2*beta_r^2/(sigmar^2+2*rho_1^2*sigmaz^2*N*Pathloss_g+rho_1^4*sigmaz^2*N^3*beta_r^2*Pathloss_g+g1(number));
    SINR_low(number)=Pbs*rho_1^4*N^4*Pathloss_g^2*beta_r^2/(sigmar^2+2*rho_1^2*sigmaz^2*N*Pathloss_g+rho_1^4*sigmaz^2*N^3*beta_r^2*Pathloss_g+g2(number));  
end
%%
close all
for i=1:num
    ele(i)=1000*(i);
end
%logSNR_power=10*log10(SNR);
%logSINR_app_power=10*log10(SINR_app);
logSINR_up_power=10*log10(SINR_up);
logSINR_self_power=10*log10(SINR_self);
logSINR_low_power=10*log10(SINR_low);
%plot(ele,logSNR_power,'+-','Color', all_colors(1, :),'LineWidth',2);
hold on;
%plot(ele,logSINR_app_power,'o-','Color', all_colors(2, :),'LineWidth',2);
hold on;
plot(ele,logSINR_up_power,'*-','Color', all_colors(3, :),'LineWidth',2);
hold on;
plot(ele,logSINR_self_power,'s-','Color', all_colors(4, :),'LineWidth',2);
hold on;
plot(ele,logSINR_low_power,'d-','Color', all_colors(5, :),'LineWidth',2);
grid on
legend('SNR','${\rm{ SINR}}_{\rm{app}}$','${\rm{ SINR}}_{\rm{up}}$', 'SINR','${\rm{ SINR}}_{\rm{low}}$','Interpreter','latex')
xlabel('Number of RIS reflecting elements');
ylabel('Radar SINR (dB)');
%save performance_result_power_1w_r


