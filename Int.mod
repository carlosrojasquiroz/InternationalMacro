var C C_star Ch Cf Ch_star Cf_star Yh Yf omega omega_star news;
varexo epsilon_Yh epsilon_Yh_news epsilon_Yf epsilon_omega epsilon_omega_star;
parameters sigma gamma mu rho_Yh rho_Yf rho_omega rho_omega_star;
parameters Css C_starss Chss Cfss Ch_starss Cf_starss Yhss Yfss omegass omega_starss;
parameters corr_new1 corr_new2 corr_new3 corr_new4;

sigma=2.0;
gamma=0.75;
mu=0.5;
rho_Yh=0.75;
rho_Yf=0.75;
rho_omega=0.25;
rho_omega_star=0.25;
corr_new1=0.25;
corr_new2=0.25;
corr_new3=0.25;
corr_new4=0.25;

model;
exp(C)=exp(Ch)^gamma*exp(Cf)^(1-gamma);
exp(C_star)=exp(Ch_star)^gamma*exp(Cf_star)^(1-gamma);  
exp(Ch)=(1/(1+((1-mu)/mu*exp(omega_star)/exp(omega))^(1/sigma)))*exp(Yh);
exp(Cf)=(1/(1+((1-mu)/mu*exp(omega_star)/exp(omega))^(1/sigma)))*exp(Yf);  
exp(Ch_star)=exp(Yh)-exp(Ch);
exp(Cf_star)=exp(Yf)-exp(Cf);
Yh=rho_Yh*Yh(-1)+epsilon_Yh+0.25*news+corr_new1*news(-1)+corr_new2*news(-2)+corr_new3*news(-3)+corr_new4*news(-4);
news=epsilon_Yh_news;
Yf=rho_Yf*Yf(-1)+epsilon_Yf;
omega=rho_omega*omega(-1)+epsilon_omega;
omega_star=rho_omega_star*omega_star(-1)+epsilon_omega_star;
end;

steady_state_model;
Yhss=1;
Yfss=1;
omegass=1;
omega_starss=1;
Chss=(1/(1+((1-mu)/mu*omega_starss/omegass)^(1/sigma)))*Yhss;
Cfss=(1/(1+((1-mu)/mu*omega_starss/omegass)^(1/sigma)))*Yfss;
Ch_starss=Yhss-Chss;
Cf_starss=Yfss-Cfss;
Css=Chss^gamma*Cfss^(1-gamma);
C_starss=Ch_starss^gamma*Cf_starss^(1-gamma);
C=log(Css);
C_star=log(C_starss);  
Ch=log(Chss);  
Cf=log(Cfss);  
Ch_star=log(Ch_starss);  
Cf_star=log(Cf_starss);  
Yh=log(Yhss);  
Yf=log(Yfss);  
omega=log(omegass);  
omega_star=log(omega_starss);
news=0;
end;

shocks;
var epsilon_Yh; stderr 1;
var epsilon_Yf; stderr 0; 
var epsilon_Yh_news; stderr 1;
var epsilon_omega; stderr 1;  
var epsilon_omega_star; stderr 1;
end;

resid;
steady;
check;

stoch_simul(order=1,irf=24,nograph);