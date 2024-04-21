clear all;clc;
load iterations
iniConvinnbis=iniConvinnbis/simulationtime;
logConvbis=10*log10(real(iniConvinnbis));
iniConvall=iniConvall/simulationtime;
logConvall=10*log10(real(iniConvall));
figure(1)
plot(1:OutNmax,logConvbis,'red','LineWidth',1.25);
hold on;
plot(1:OutNmax,logConvall,'blue','LineWidth',1.25);
hold on;
load iniSNR
iniConvout=iniConvout/simulationtime;
logConvout=10*log10(real(iniConvout));
plot(1:OutNmax,logConvout,'yellow','LineWidth',1.25);
hold on;
inifConvout=inifConvout/simulationtime;
logfConvout=10*log10(real(inifConvout));
plot(1:OutNmax,logfConvout,'m','LineWidth',1.25);
hold on;
% averConvout=sum(iniConvout(8:OutNmax))/(OutNmax-8);
% logaver=10*log10(real(averConvout));
% y=34*ones(1,OutNmax);
% plot(1:OutNmax,y,'m','LineWidth',1.25);
legend('MM method Optimize W','MM method Optimize \Phi','SNR via Cauchy Method','fraction SNR')
grid on;
xlabel('Number of Outer-layer Iterations');
ylabel('SNR (dB)');
