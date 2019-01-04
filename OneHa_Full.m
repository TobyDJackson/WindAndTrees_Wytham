% This code makes the main figures for the paper on critical wind speeds in
% Wytham

%% Load up data and plot basic info
load('OneHa_Data_300718.mat')
load('Field21_010818.mat')
error_free_trees=[2 4:11 13:15 17:21];
Field21=Field21(error_free_trees,:);

%% Make the allometry plot
Sycamore=find(OneHa_Data.Species=='ACERPS');
Oak=find(OneHa_Data.Species=='QUERRO');
Ash=find(OneHa_Data.Species=='FRAXEX');
Sycamore21=find(Field21.Species=='Sycamore');
Oak21=find(Field21.Species=='Oak');
Ash21=find(Field21.Species=='Ash');
Birch21=find(Field21.Species=='Birch');
color1=brewermap(9,'Set1');
color2=brewermap(12,'PiYG');
Ocol=color1(7,:);
Scol=color1(9,:);
%Acol=color1(4,:);
Acol=color2(2,:);
%Bcol=brewermap(8,'Dark2'); Bcol=Bcol(2,:);
Bcol=brewermap(8,'Paired'); Bcol=Bcol(8,:);
edge_width=1.3;

% Height diameter plot for each tree - coloured by species 
subplot(1,2,1)
h1=scatter(OneHa_Data.dbh16(Sycamore),OneHa_Data.Height(Sycamore),OneHa_Data.dbh16(Sycamore)/10,Scol,'filled','MarkerFaceAlpha',0.6);
hold on
h2=scatter(OneHa_Data.dbh16(Oak),OneHa_Data.Height(Oak),OneHa_Data.dbh16(Oak)/10,Ocol,'filled','MarkerFaceAlpha',0.7);
h3=scatter(OneHa_Data.dbh16(Ash),OneHa_Data.Height(Ash),OneHa_Data.dbh16(Ash)/10,Acol,'filled','MarkerFaceAlpha',0.7);
h4=scatter(Field21.dbh16(Sycamore21),Field21.Height_m(Sycamore21),Field21.dbh16(Sycamore21)/10,Scol,'filled','MarkerEdgeColor','black','LineWidth',edge_width);
h6=scatter(Field21.dbh16(Ash21),Field21.Height_m(Ash21),Field21.dbh16(Ash21)/10,Acol,'filled','MarkerEdgeColor','black','LineWidth',edge_width);
h7a=scatter(Field21.dbh16(Birch21),Field21.Height_m(Birch21),Field21.dbh16(Birch21)/10,Bcol,'filled');
h7b=scatter(Field21.dbh16(Birch21),Field21.Height_m(Birch21),Field21.dbh16(Birch21)/10,'white','filled','MarkerEdgeColor','black','LineWidth',edge_width);
h7=scatter(Field21.dbh16(Birch21),Field21.Height_m(Birch21),Field21.dbh16(Birch21)/10,Bcol,'filled','MarkerEdgeColor','black','LineWidth',edge_width);
hlegend=legend([h1 h2 h3 h7a h7b],{'Sycamore','Oak','Ash','Birch','Field data'}, 'Location','SE');
%hlegend=legend([h1 h2 h3 h4  h6 h7],'Model - sycamore','Model - oak','Model - ash', 'Field - sycamore','Field - ash','Field - birch', 'Location','SouthEast');
legend boxoff
axis([0 1000 0 30])
xlabel('dbh (mm)')
ylabel('Height (m)')
set([gca hlegend], 'FontName', 'Helvetica','FontSize', 12)


% Height diameter plot for each tree - coloured by CWS
subplot(1,2,2)
colormap(brewermap(70,'RdYlGn'));
h1=scatter(OneHa_Data.dbh16(Sycamore),OneHa_Data.Height(Sycamore),OneHa_Data.dbh16(Sycamore)/10, OneHa_Data.CWS_MON(Sycamore),'filled');
hold on
h2=scatter(OneHa_Data.dbh16(Oak),OneHa_Data.Height(Oak),OneHa_Data.dbh16(Oak)/10, OneHa_Data.CWS_MON(Oak),'filled');
h3=scatter(OneHa_Data.dbh16(Ash),OneHa_Data.Height(Ash),OneHa_Data.dbh16(Ash)/10, OneHa_Data.CWS_MON(Ash),'filled');
h4=scatter(Field21.dbh16(Sycamore21),Field21.Height_m(Sycamore21),Field21.dbh16(Sycamore21)/10,Field21.Wscrit(Sycamore21),'filled','MarkerEdgeColor','black','LineWidth',edge_width);
%h5=scatter(Field21.dbh16(Oak21),Field21.Height_m(Oak21),Field21.dbh16(Oak21)/10,Field21.Wscrit(Oak21),'filled','MarkerEdgeColor','black','LineWidth',edge_width);
h6=scatter(Field21.dbh16(Ash21),Field21.Height_m(Ash21),Field21.dbh16(Ash21)/10,Field21.Wscrit(Ash21),'filled','MarkerEdgeColor','black','LineWidth',edge_width);
h7=scatter(Field21.dbh16(Birch21),Field21.Height_m(Birch21),Field21.dbh16(Birch21)/10,Field21.Wscrit(Birch21),'filled','MarkerEdgeColor','black','LineWidth',edge_width);
c = colorbar('southoutside');
c.Label.String = 'Critical wind speed (ms^-^1)';
axis([0 1000 5 30])
xlabel('dbh (mm)')
ylabel('Height (m)')
set([gca c], 'FontName', 'Helvetica','FontSize', 12)


%% BoxPlot
OneHa_Data(OneHa_Data.CWS_MON==100,:)=[];
OneHa_Data(OneHa_Data.CWS_MOFF==100,:)=[];
Sycamore=find(OneHa_Data.Species=='ACERPS');
Oak=find(OneHa_Data.Species=='QUERRO');
Ash=find(OneHa_Data.Species=='FRAXEX');
Which_col=Acol;
tempCWS_MON=OneHa_Data.CWS_MON; tempCWS_MON(find(tempCWS_MON==100))=nan;
tempCWS_MOFF=OneHa_Data.CWS_MOFF; tempCWS_MOFF(find(tempCWS_MOFF==100))=nan;

data_MON=cat(2,cat(1,tempCWS_MON(Oak),nan(length(Sycamore)-length(Oak),1)), tempCWS_MON(Sycamore),cat(1,tempCWS_MON(Ash),nan(length(Sycamore)-length(Ash),1)));
data_MOFF=cat(2,cat(1,tempCWS_MOFF(Oak),nan(length(Sycamore)-length(Oak),1)), tempCWS_MOFF(Sycamore),cat(1,tempCWS_MOFF(Ash),nan(length(Sycamore)-length(Ash),1)));
species_means=[mean(data_MON,1,'omitnan'); std(data_MON,1,'omitnan'); mean(data_MOFF,1,'omitnan'); std(data_MOFF,1,'omitnan')]
[mean(OneHa_Data.CWS_MON(Sycamore),'omitnan')]
data_combo=cat(2,data_MON(:,1),data_MOFF(:,1),data_MOFF(:,2),data_MON(:,3),data_MOFF(:,3));
x={'Oak MON','Oak MOFF','Sycamore','Ash MON','Ash MOFF'};
x=[1 2 4 6 7];
color_in=Scol;
h=boxPlot(x,data_combo,'lineColor',color_in,'medianColor',color_in,'symbolColor',color_in,'symbolMarker','+')
hold on
scatter(4*ones(length(Sycamore21),1),Field21.Wscrit(Sycamore21),25,'x','black','LineWidth',0.8)
scatter(6*ones(length(Ash21),1),Field21.Wscrit(Ash21),25,'x','black','LineWidth',0.8)
scatter(7*ones(length(Ash21),1),Field21.Wscrit(Ash21),25,'x','black','LineWidth',0.8)
set([gca], 'FontName', 'Helvetica','FontSize', 12)
ylabel('Critical wind speed (ms^-^1)')
ylim([0 100])

%% CWS vs Growth rate  
tempCWS_MON=OneHa_Data.CWS_MON; tempCWS_MON(find(tempCWS_MON==100))=nan;
tempCWS_MOFF=OneHa_Data.CWS_MOFF; tempCWS_MOFF(find(tempCWS_MOFF==100))=nan;
subplot(2,5,[1 2 3 6 7 8])
si=30;
h1=scatter(OneHa_Data.GrowthRate(Sycamore),tempCWS_MON(Sycamore),OneHa_Data.dbh16(Sycamore)/10,Scol,'filled','MarkerFaceAlpha',0.5);
hold on
h2=scatter(OneHa_Data.GrowthRate(Oak),tempCWS_MON(Oak),OneHa_Data.dbh16(Oak)/10,Ocol,'filled');
h3=scatter(OneHa_Data.GrowthRate(Ash),tempCWS_MON(Ash),OneHa_Data.dbh16(Ash)/10,Acol,'filled');
h4=scatter(Field21.GrowthRate(Sycamore21),Field21.Wscrit(Sycamore21),Field21.dbh16(Sycamore21)/10,Scol,'filled','MarkerEdgeColor','black','LineWidth',edge_width);
h6=scatter(Field21.GrowthRate(Ash21),Field21.Wscrit(Ash21),Field21.dbh16(Ash21)/10,Acol,'filled','MarkerEdgeColor','black','LineWidth',edge_width);
h7a=scatter(Field21.GrowthRate(Birch21),Field21.Wscrit(Birch21),Field21.dbh16(Birch21)/10,Bcol,'filled');
h7b=scatter(Field21.GrowthRate(Birch21),Field21.Wscrit(Birch21),Field21.dbh16(Birch21)/10,'white','filled','MarkerEdgeColor','black','LineWidth',edge_width);
h7=scatter(Field21.GrowthRate(Birch21),Field21.Wscrit(Birch21),Field21.dbh16(Birch21)/10,Bcol,'filled','MarkerEdgeColor','black','LineWidth',edge_width);
%hlegend=legend([h1 h2 h3 h4 h6 h7],{'Model - sycamore','Model - oak','Model - ash'; 'Field - sycamore','Field - ash','Field - birch'}, 'Location','NorthOutside');
hlegend=legend([h1 h2 h3 h7a h7b],{'Sycamore','Oak','Ash','Birch','Field data'}, 'Location','NE');
axis([-2 15 0 100]); legend boxoff
xlabel('Radial growth rate (mmy^-^1)','Interpreter','tex')
ylabel('Critical wind speed (ms^-^1)','Interpreter','tex')
set([gca hlegend], 'FontName', 'Helvetica','FontSize', 12)
htext=text(-4.5,100,'A')
set(htext,'FontSize',18,'FontWeight','Bold')

subplot(2,5,[4 5])
LargeSycamore=Sycamore(OneHa_Data.dbh16(Sycamore)>400);
LargeOak=Oak(OneHa_Data.dbh16(Oak)>400);
LargeAsh=Ash(OneHa_Data.dbh16(Ash)>400);
data_x=cat(1,OneHa_Data.GrowthRate(LargeSycamore),OneHa_Data.GrowthRate(LargeOak),OneHa_Data.GrowthRate(LargeAsh));
data_y=cat(1,tempCWS_MON(LargeSycamore),tempCWS_MON(LargeOak),tempCWS_MON(LargeAsh));
data_y(data_x<0)=[]; data_x(data_x<0)=[]; 
fit1=fitlm(data_x,data_y,'robust','bisquare')
fit1=fitlm(data_x,data_y)
h=plot(fit1);
set(h,'Color','black','MarkerEdgeColor','white')
hold on
h1=scatter(OneHa_Data.GrowthRate(LargeSycamore),tempCWS_MON(LargeSycamore),OneHa_Data.dbh16(LargeSycamore)/10,Scol,'filled','MarkerFaceAlpha',0.5);
h2=scatter(OneHa_Data.GrowthRate(LargeOak),tempCWS_MON(LargeOak),OneHa_Data.dbh16(LargeOak)/10,Ocol,'filled');
h3=scatter(OneHa_Data.GrowthRate(LargeAsh),tempCWS_MON(LargeAsh),OneHa_Data.dbh16(LargeAsh)/10,Acol,'filled');
axis([-2 15 20 100]); legend off; title ''; xlabel ''; ylabel '';
htext1=textLoc(strcat('R^2 = ',num2str(round(fit1.Rsquared.Adjusted,2)),'    p < 0.01 '),'NorthEast')
xlabel('Radial growth rate (mmy^-^1)','Interpreter','tex')
ylabel('Critical wind speed (ms^-^1)','Interpreter','tex')
set([gca htext1], 'FontName', 'Helvetica','FontSize', 12)
htext=text(16.2,100,'B')
set(htext,'FontSize',18,'FontWeight','Bold')

subplot(2,5,[9 10])
data_xF=cat(1, Field21.GrowthRate(Sycamore21),Field21.GrowthRate(Ash21),Field21.GrowthRate(Birch21));
data_yF=cat(1,Field21.Wscrit(Sycamore21),Field21.Wscrit(Ash21),Field21.Wscrit(Birch21));
data_yF(data_xF<0)=[]; data_xF(data_xF<0)=[]; 
fit1=fitlm(data_xF,data_yF,'robust','bisquare')
fit1=fitlm(data_xF,data_yF)
h=plot(fit1);
set(h,'Color','black','MarkerEdgeColor','white')
hold on
h4=scatter(Field21.GrowthRate(Sycamore21),Field21.Wscrit(Sycamore21),Field21.dbh16(Sycamore21)/10,Scol,'filled','MarkerEdgeColor','black','LineWidth',edge_width);
h6=scatter(Field21.GrowthRate(Ash21),Field21.Wscrit(Ash21),Field21.dbh16(Ash21)/10,Acol,'filled','MarkerEdgeColor','black','LineWidth',edge_width);
h7=scatter(Field21.GrowthRate(Birch21),Field21.Wscrit(Birch21),Field21.dbh16(Birch21)/10,Bcol,'filled','MarkerEdgeColor','black','LineWidth',edge_width);
legend off; title ''; xlabel ''; ylabel '';
htext1=textLoc(strcat('R^2 = ',num2str(round(fit1.Rsquared.Adjusted,2)),'    p < 0.01 '),'NorthEast')
xlabel('Radial growth rate (mmy^-^1)','Interpreter','tex')
ylabel('Critical wind speed (ms^-^1)','Interpreter','tex')
set([gca htext1], 'FontName', 'Helvetica','FontSize', 12)
htext=text(10.5,60,'C')
set(htext,'FontSize',18,'FontWeight','Bold')

%% Prepare data table for  GLM to test what drives CWS
rows=find(isnan(OneHa_Data{:,1})==1);
for col=[1 2 12 15 20 22 23]%[2:12 14:23]
    rows=cat(1,rows,find(isnan(OneHa_Data{:,col})==1));
end
rows=unique(rows); 
OneHa_dt_raw=OneHa_Data; OneHa_dt_raw(rows,:)=[];  OneHa_dt=OneHa_dt_raw;
names=OneHa_dt.Properties.VariableNames; PLOT=0;
for col=[1:12 14:23]
    col
    if col==16
        OneHa_dt_raw{:,col}=log(OneHa_dt_raw{:,col});
     elseif col>=22
        OneHa_dt_raw{:,col}=log(OneHa_dt_raw{:,col});
    else
        OneHa_dt{:,col}=(OneHa_dt_raw{:,col}-mean(OneHa_dt_raw{:,col},'omitnan'))./std(OneHa_dt_raw{:,col},'omitnan');
    end
    if PLOT==1
        subplot(1,2,1)
        hist(OneHa_dt_raw{:,col})
        title(names{col})
        subplot(1,2,2)
        hist(OneHa_dt{:,col})
        pause
    end
end
Sycamore_dt=find(OneHa_dt.Species=='ACERPS');
Oak_dt=find(OneHa_dt.Species=='QUERRO');
Ash_dt=find(OneHa_dt.Species=='FRAXEX');

%% Make the plot adding 1 variable at a time for SI
lm1=fitglm(OneHa_dt,'CWS_MON~ Height*dbhTLS');
lm2=fitglm(OneHa_dt,'CWS_MON~ Height*dbhTLS+CVR');
lm3=fitglm(OneHa_dt,'CWS_MON~Height*dbhTLS+CVR+Species');
lm4=fitglm(OneHa_dt,'CWS_MON~Height*dbhTLS+CVR+Species+SailArea');
lm5=fitglm(OneHa_dt,'CWS_MON~Height*dbhTLS+CVR+Species+SailArea+CrownAsymmetry');
labels={'Size','+ ln(CVR)','+ Species','+ ln(Sail area)','+ Crown asymmetry'};
add_R2=cat(1,lm1.Rsquared.Adjusted,lm2.Rsquared.Adjusted,lm3.Rsquared.Adjusted,lm4.Rsquared.Adjusted,lm5.Rsquared.Adjusted)
add_AIC=cat(1,lm1.ModelCriterion.AIC,lm2.ModelCriterion.AIC,lm3.ModelCriterion.AIC, lm4.ModelCriterion.AIC,lm5.ModelCriterion.AIC);

fig=figure; color1=brewermap(12,'BrBg'); color1=color1(9,:); set(fig,'defaultAxesColorOrder',[[0 0 0]; color1]);
yyaxis left
scatter(1:5,add_R2,40,'+','MarkerEdgeColor','black','LineWidth',2); axis([0 6 0 0.6]); ylabel('R^2'); 
set([gca], 'FontName', 'Helvetica','FontSize', 10)
yyaxis right
scatter(1:5,add_AIC,40,'o','MarkerEdgeColor',color1,'LineWidth',2); xticks(1:9); xticklabels(labels); xtickangle(45); ylabel('AIC'); 
set([gca], 'FontName', 'Helvetica','FontSize', 12)

%% Interaction plot
lm1=fitlm(OneHa_dt,'CWS_MON~ Height*dbhTLS');
lm2=fitlm(OneHa_dt,'CWS_MON~ Height*dbhTLS+CVR');
lm3=fitlm(OneHa_dt,'CWS_MON~Height*dbhTLS+CVR+SailArea+CrownAsymmetry');
plotInteraction(lm1,'Height','dbhTLS')
yticklabels({'\bfHeight','low dbh','med dbh','high dbh','\bfdbh','short','medium','tall'})
title('Interaction of height and dbh'); set([gca], 'FontName', 'Helvetica','FontSize', 12)
xlim([-15 15]);  title '';  xlabel('Effect size')

%% Plot effects
subplot(1,2,1)
lm4=fitlm(OneHa_dt,'CWS_MON~Height*dbhTLS');
h=plotEffects(lm4); set(h,'Color','black'); set([gca], 'FontName', 'Helvetica','FontSize', 12); 
subplot(1,2,2)
lm5=fitlm(OneHa_dt,'CWS_MON~Height*dbhTLS+SailArea+CVR');
h=plotEffects(lm5); set(h,'Color','black'); set([gca], 'FontName', 'Helvetica','FontSize', 12); 