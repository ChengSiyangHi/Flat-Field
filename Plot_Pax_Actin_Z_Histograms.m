%% Plot_Pax_Actin_Z_Histograms
clear
clc
close all

pax = readtable('ROI_8-1_PAX.csv');
pax = table2array(pax);

actin = readtable('ROI_8-1_ACTIN.csv');
actin = table2array(actin);

%% Normalize the particle number
part_num_pax = sum(pax(:,3));
part_num_actin = sum(actin(:,3));

pax(:,3) = pax(:,3)/part_num_pax;
actin(:,3) = actin(:,3)/part_num_actin;

%% Z compression
z_com = 0.75;
pax(:,1) = pax(:,1)*z_com;
pax(:,2) = pax(:,2)*z_com;
actin(:,1) = actin(:,1)*z_com;
actin(:,2) = actin(:,2)*z_com;

%% Plot and fit Pax and Actin histograms in one figure
edges_pax = (pax(:,1))';
edges_pax = [edges_pax pax(size(pax,1),2)];
counts_pax = (pax(:,3))';

edges_actin = (actin(:,1))';
edges_actin = [edges_actin actin(size(actin,1),2)];
counts_actin = (actin(:,3))';

x_pax=(pax(:,1)+pax(:,2))/2;
y_pax=pax(:,3);
[fit_pax, gof_pax] = fit_gauss2d(x_pax, y_pax);

x_actin=(actin(:,1)+actin(:,2))/2;
y_actin=actin(:,3);
[fit_actin, gof_actin] = fit_gauss2d(x_actin, y_actin);


%% Plot the figure
figure;histogram('BinEdges',edges_pax,'BinCounts',counts_pax,'FaceColor','w','FaceAlpha',0.60);ylim([0 0.15]);hold on;
paxgauss = plot(fit_pax); set(paxgauss,'color','w','LineWidth',4); hold on;
line([fit_pax.b1 fit_pax.b1],[0 fit_pax.a1],'linestyle','--','Color',"w",'LineWidth',4);hold on;
text(fit_pax.b1,fit_pax.a1+0.01,['Z_{pax} = ' num2str(fit_pax.b1) ' nm'],'Color',"w");hold on;

histogram('BinEdges',edges_actin,'BinCounts',counts_actin,'FaceColor',[0.45098,0.52157,0.88627],'FaceAlpha',0.60);ylim([0 0.15]);
actingauss = plot(fit_actin); set(actingauss,'color',[0.45098,0.52157,0.88627],'LineWidth',4); hold on;
line([fit_actin.b1 fit_actin.b1],[0 fit_actin.a1],'linestyle','--','Color',[0.45098,0.52157,0.88627],'LineWidth',4);hold on;
text(fit_actin.b1+10,fit_actin.a1+0.01,['Z_{actin} = ' num2str(fit_actin.b1) ' nm'],'Color',"w");hold on;

delta_z = (fit_pax.b1-fit_actin.b1);

xlabel('Z (nm)');ylabel('Normalized Number of localizations');
%legend('Paxillin','Paxillin Fit','Z_{pax}','Actin','Actin Fit','Z_{actin}');
title('Distribution of localized particles in Z');
subtitle('ROI: 9');

set(gca, 'box', 'off')
H = gca;
H.LineWidth = 2;
% H.XAxis.TickLength = [0 0];

set(gca, 'Color','k', 'XColor','w', 'YColor','w')
set(gcf, 'Color','k')