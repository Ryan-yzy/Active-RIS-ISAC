clear all；close all；
clear all;clc;close all;
[all_themes, all_colors] = GetColors();
figure(1);
%%
load beam_base
SINR2=zeros(1,101);
i=0;
for azimuth=-0.5*pi:0.0001*pi:0.5*pi
    i=i+1;
    n=0:N-1;
    aAoDirstg0=exp(imaginary*n*pi*sin(azimuth));
    aAoAirstg0=exp(imaginary*n*pi*sin(azimuth));
    As=sqrt(calbeta(DisIRS2TG))*aAoDirstg0'*aAoAirstg0;
    B=G'*Phi'*As*Phi*G;
    SINR2(i)=trace(B*R*B'/J_t1);%J和R都跟RIS的相位无关 
    beam(i)=trace(R*B');
end
%SINR2=SINR2/iniConvout(OutNmax)
beam=10*log10(beam/max(beam));
plot(-90:0.018:90,beam,'-', 'Color', all_colors(2, :),'LineWidth',1.25)
hold on;
grid on;

%%
load beam_ele36
SINR2=zeros(1,101);
i=0;
for azimuth=-0.5*pi:0.0001*pi:0.5*pi
    i=i+1;
    n=0:N-1;
    aAoDirstg0=exp(imaginary*n*pi*sin(azimuth));
    aAoAirstg0=exp(imaginary*n*pi*sin(azimuth));
    As=sqrt(calbeta(DisIRS2TG))*aAoDirstg0'*aAoAirstg0;
    B=G'*Phi'*As*Phi*G;
    SINR2(i)=trace(B*R*B'/J_t1);%J和R都跟RIS的相位无关 
    beam(i)=trace(R*B');
end
%SINR2=SINR2/iniConvout(OutNmax)
beam=10*log10(beam/max(beam));
plot(-90:0.018:90,beam,'.-', 'Color', all_colors(1, :),'LineWidth',1.25)
hold on;
grid on;
%%
% load beam_QoS30
% SINR2=zeros(1,101);
% i=0;
% for azimuth=-0.5*pi:0.0001*pi:0.5*pi
%     i=i+1;
%     n=0:N-1;
%     aAoDirstg0=exp(imaginary*n*pi*sin(azimuth));
%     aAoAirstg0=exp(imaginary*n*pi*sin(azimuth));
%     As=sqrt(calbeta(DisIRS2TG))*aAoDirstg0'*aAoAirstg0;
%     B=G'*Phi'*As*Phi*G;
%     SINR2(i)=trace(B*R*B'/J_t1);%J和R都跟RIS的相位无关 
%     beam(i)=trace(R*B');
% end
% %SINR2=SINR2/iniConvout(OutNmax)
% beam=10*log10(beam/max(beam));
% plot(-90:0.018:90,beam,'-', 'Color', all_colors(2, :),'LineWidth',1.25)
% hold on;
% grid on;
%%
% load beam_001
% SINR2=zeros(1,101);
% i=0;
% for azimuth=-0.5*pi:0.0001*pi:0.5*pi
%     i=i+1;
%     n=0:N-1;
%     aAoDirstg0=exp(imaginary*n*pi*sin(azimuth));
%     aAoAirstg0=exp(imaginary*n*pi*sin(azimuth));
%     As=sqrt(calbeta(DisIRS2TG))*aAoDirstg0'*aAoAirstg0;
%     B=G'*Phi'*As*Phi*G;
%     SINR2(i)=trace(B*R*B'/J_t1);%J和R都跟RIS的相位无关 
%     beam(i)=trace(R*B');
% end
% %SINR2=SINR2/iniConvout(OutNmax)
% beam=10*log10(beam/max(beam));
% plot(-90:0.018:90,beam,'.-', 'Color', all_colors(1, :),'LineWidth',1.25)
% hold on;
% grid on;
%%
xlim([-90 90])
xticks([-90,-45,0,45,90]);
ylim([-50,0])
stem(9.46,-70,'--','marker','none', 'Color', all_colors(3, :),'LineWidth',1.5)
hold on;
xlabel('Angle (degree)')

ylabel('Normalized beampattern (dB)')
legend('$N=16$','$N=36$','The angle of the target','Interpreter','latex')