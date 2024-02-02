%% Plot_Pax_Actin_Z_Histograms_All
clear
close all

%ROI=[7 8 9 10 11 12 14 15 17 20];
ROI=[8 11];
delta_z=zeros(size(ROI));

for i=1:10
    file_name_actin = sprintf('ROI_%d-1_ACTIN.csv', ROI(1,i));
    actin = readtable(file_name_actin);
    actin = table2array(actin);

    file_name_pax = sprintf('ROI_%d-1_PAX.csv', ROI(1,i));
    pax = readtable(file_name_pax);
    pax = table2array(pax);
    
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

    figure;histogram('BinEdges',edges_pax,'BinCounts',counts_pax,'FaceColor',"#D95319",'FaceAlpha',0.55);ylim([0 0.15]);hold on;
    paxgauss = plot(fit_pax); set(paxgauss,'color',"r",'LineWidth',2); hold on;
    line([fit_pax.b1 fit_pax.b1],[0 fit_pax.a1],'linestyle','--','LineWidth',1.5,'Color',"r");hold on;
    text(fit_pax.b1+2,fit_pax.a1+0.015,['Z_{pax} = ' num2str(fit_pax.b1) ' nm'],'Color',"r",'fontweight', 'bold');hold on;

    histogram('BinEdges',edges_actin,'BinCounts',counts_actin,'FaceColor',	"#7E2F8E",'FaceAlpha',0.55);ylim([0 0.15]);
    actingauss = plot(fit_actin); set(actingauss,'color',"#000000",'LineWidth',2); hold on;
    line([fit_actin.b1 fit_actin.b1],[0 fit_actin.a1],'linestyle','--','LineWidth',1.5,'Color',"#000000");hold on;
    text(fit_actin.b1+10,fit_actin.a1+0.015,['Z_{actin} = ' num2str(fit_actin.b1) ' nm'],'Color',"#000000",'fontweight', 'bold');hold on;

    delta_z(1,i) = abs(fit_pax.b1-fit_actin.b1);
    delta_z(1,i)

    xlabel('Z (nm)');ylabel('Normalized Number of localizations');
    legend('Paxillin','Paxillin Fit','Z_{pax}','Actin','Actin Fit','Z_{actin}');
    title('Distribution of localized particles in Z');
    subtitle(['ROI: ',num2str(i)]);

end