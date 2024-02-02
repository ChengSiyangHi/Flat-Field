%% Plot_Overall_Histograms
clear

%% Plot actin data
Actin = readtable('ActinFilteredData.csv');
Actin = table2array(Actin);

figure; 
subplot(2,2,1); histogram(Actin(:,9),50); box off;
xlabel('Signal (photons/loc)'); ylabel('Counts');

subplot(2,2,2); histogram(Actin(:,10),50); box off;
xlabel('Background (photons/pix)'); ylabel('Counts');

subplot(2,2,3); histogram([Actin(:,2) Actin(:,8)],50); box off;% xlim([0 30]); 
xlabel('\sigma_{xy} (nm)'); ylabel('Counts');

subplot(2,2,4); histogram(Actin(:,3),50); box off;% xlim([0 30]);
xlabel('\sigma_{z} (nm)'); ylabel('Counts');

sgtitle('ACTIN DATA');

%% Plot paxillin data
Pax = readtable('PaxilinFilteredData.csv');
Pax = table2array(Pax);

figure; 
subplot(2,2,1); histogram(Pax(:,9),50); box off;
xlabel('Signal (photons/loc)'); ylabel('Counts');

subplot(2,2,2); histogram(Pax(:,10),50); box off;
xlabel('Background (photons/pix)'); ylabel('Counts');

subplot(2,2,3); histogram([Pax(:,2) Pax(:,8)],50); box off;
ax = gca; ax.YAxis.Exponent = 4; % xlim([0 30]);
xlabel('\sigma_{xy} (nm)'); ylabel('Counts');

subplot(2,2,4); histogram(Pax(:,3),50); box off;
ax = gca; ax.YAxis.Exponent = 4; % xlim([0 30]);
xlabel('\sigma_{z} (nm)'); ylabel('Counts');

sgtitle('PAXILLIN DATA');