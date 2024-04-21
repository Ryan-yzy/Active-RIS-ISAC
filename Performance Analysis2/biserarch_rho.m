function rho_real=biserarch_rho(rho_max,rho_min,N, Pris, Pbs,beta_r,Pathloss_g,rho_real)
    while (rho_max-rho_min)>1
        Pris_a=Pbs*rho_real^4*N^3*beta_r^2*Pathloss_g+Pbs*rho_real^2*N*Pathloss_g;
        if (Pris_a>Pris)
            rho_max=rho_real;
            rho_real=0.5*(rho_max+rho_min);
        else
            rho_min=rho_real;
            rho_real=0.5*(rho_max+rho_min);
        end
    end
end