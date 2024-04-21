clear all;clc;
close all
rng('default');
[all_themes, all_colors] = GetColors();

%%
subplot(2,1,2)
load performance_result_power_1
plot(ele(1:20),logSINR_up_power(1:20),'+:','Color', all_colors(3, :),'LineWidth',1.5);
hold on;
% plot(ele,logSNR,'+-','Color', all_colors(1, :),'LineWidth',1.5);
% hold on;
% plot(ele,logSINR_app,'o-','Color', all_colors(2, :),'LineWidth',1.5);
hold on;
plot(ele(1:20),logSINR_self_power(1:20),'o:','Color', all_colors(4, :),'LineWidth',1.5);
hold on;
plot(ele(1:20),logSINR_low_power(1:20),'s:','Color', all_colors(5, :),'LineWidth',1.5);
hold on;
%%
load performance_result_power_1w_r %实际上是2W
% plot(ele,logSINR_up_power,'*-','Color', all_colors(1, :),'LineWidth',1.5);
% % hold on;
% plot(ele,logSNR,'+-','Color', all_colors(1, :),'LineWidth',1.5);
% hold on;
% plot(ele,logSINR_app,'o-','Color', all_colors(2, :),'LineWidth',1.5);
 hold on;
plot(ele,logSINR_self_power,'s-','Color', all_colors(2, :),'LineWidth',1.5);
hold on;
plot(ele,logSINR_low_power,'d-','Color', all_colors(6, :),'LineWidth',1.5);
hold on;


% plot(ele,logSNR_power,'+:','Color', all_colors(11, :),'LineWidth',1.5);
% hold on;
% plot(ele,logSINR_app_power,'o:','Color', all_colors(12, :),'LineWidth',1.5);
% hold on;
% % plot(ele,logSINR_up_power,'*-','Color', all_colors(13, :),'LineWidth',2);
% hold on;
% plot(ele,logSINR_self_power,'s:','Color', all_colors(14, :),'LineWidth',1.5);
% hold on;
% plot(ele,logSINR_low_power,'d:','Color', all_colors(15, :),'LineWidth',1.5);
% grid on

%xlim([16,36])
xlim([1000,20*1000])
xticks([1000,(5000:5000:20000)])
grid on
%xticks([200,500,1000,2000,3000,4000,5000])
legend('${\rm{ SINR}}_{\rm{up}}$', 'SINR, $\rho^2=a_{\rm{RIS}}$','${\rm{ SINR}}_{\rm{low}}$, $\rho^2=a_{\rm{RIS}}$','${\rm{ SINR}}$, $\rho^2=a_{\rm{RIS}}$, $P_{\rm{RIS}}=1$ W','${\rm{ SINR}}_{\rm{low}}$, $\rho^2=a_{\rm{RIS}}$, $P_{\rm{RIS}}=1$ W','Interpreter','latex')

xlabel('Number of RIS reflecting elements');
ylabel('Radar SINR (dB)');




%% small number of element
subplot(2,1,1)
load performance_result_power_small_01w_both
plot(ele,logSNR_power,'+:','Color', all_colors(11, :),'LineWidth',1.5);
hold on;
% plot(ele,logSNR,'+-','Color', all_colors(1, :),'LineWidth',1.5);
% hold on;
% plot(ele,logSINR_app,'o-','Color', all_colors(2, :),'LineWidth',1.5);
hold on;
plot(ele,logSINR_self_power,'o:','Color', all_colors(12, :),'LineWidth',1.5);
hold on;
plot(ele,logSINR_app_power,'s:','Color', all_colors(13, :),'LineWidth',1.5);
hold on;
%%
load performance_result_power_small_aris
plot(ele,logSNR_power,'s-','Color', all_colors(23, :),'LineWidth',1.5);
hold on;
% plot(ele,logSNR,'+-','Color', all_colors(1, :),'LineWidth',1.5);
% hold on;
% plot(ele,logSINR_app,'o-','Color', all_colors(2, :),'LineWidth',1.5);
hold on;
plot(ele,logSINR_self_power,'d-','Color', all_colors(24, :),'LineWidth',1.5);
hold on;
plot(ele,logSINR_app_power,'o-','Color', all_colors(25, :),'LineWidth',1.5);
hold on;


% plot(ele,logSNR_power,'+:','Color', all_colors(11, :),'LineWidth',1.5);
% hold on;
% plot(ele,logSINR_app_power,'o:','Color', all_colors(12, :),'LineWidth',1.5);
% hold on;
% % plot(ele,logSINR_up_power,'*-','Color', all_colors(13, :),'LineWidth',2);
% hold on;
% plot(ele,logSINR_self_power,'s:','Color', all_colors(14, :),'LineWidth',1.5);
% hold on;
% plot(ele,logSINR_low_power,'d:','Color', all_colors(15, :),'LineWidth',1.5);
% grid on
grid on;
%xlim([16,36])
xlim([40,1000])
xticks([40,(50*2:50*2:500*2)])

legend('SNR, $\rho^2=a_{\rm{RIS}}$, $P_{\rm{RIS}}=0.1$ W','${\rm{ SINR}}$, $\rho^2=a_{\rm{RIS}}$, $P_{\rm{RIS}}=0.1$ W','${\rm{ SINR}}_{\rm{app}}$, $\rho^2=a_{\rm{RIS}}$, $P_{\rm{RIS}}=0.1$ W','SNR, $\rho^2=a_{\rm{RIS}}$', 'SINR, $\rho^2=a_{\rm{RIS}}$','${\rm{ SINR}}_{\rm{app}}$, $\rho^2=a_{\rm{RIS}}$','Interpreter','latex')
xlabel('Number of RIS reflecting elements');
ylabel('Radar SINR (dB)');