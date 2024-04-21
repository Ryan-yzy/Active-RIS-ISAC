function beta2=calbeta(DisIRS2TG)
    wavelength=3*10^8/(2.7*10^9);
    RCS=1;
    beta2=wavelength^2*RCS/(64*pi*pi*pi*DisIRS2TG^4);
end