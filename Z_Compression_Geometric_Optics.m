%% Z_Compression_Geometric_Optics
% Reference: S.V. LOGINOV et al. BioRxiv (2024)
% Last edited by Siyang Cheng 2024/02/02

n1 = 1.52; % Refractive index of the oil
n2 = 1.33; % Refractive index of the sample
NA = 1.4; % Numerical aperture of the objective

Za = 10; % The actual z position of interest from the coverslip (um)
lambda = 560E-3;

m = sqrt(n2^2-n1^2);

if n2>n1 || n2==n1
    eps = lambda/4/Za/n2;
else
    eps = -lambda/4/Za/n2;
end

zeta_univ = n2/n1*(1-eps+m*n1*sqrt(eps*(2-eps)))/(1-(n2/n1)^2*eps*(2-eps));
zeta_crit = real((n1-sqrt(n1^2-NA^2)/(n2-sqrt(n2^2-NA^2))));

if n2>n1 || n2==n1
    zeta = min(zeta_univ, zeta_crit);
else
    zeta = max(zeta_univ, zeta_crit);
end