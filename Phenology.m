% This code reproduces the phenology graph from the Wytham critical wind
% speeds paper. 

%% Do the analysis - calculate maxima etc
%This is a bit messy but does the trick
load('ECN_gusts.mat')
load('PhenologyData')
gust = plot(ECN_gusts.time,ECN_gusts.gust)
DV=datevec(ECN_gusts.time);
DV  = DV(:, 1:3);   % [N x 3] array, no time
DV2 = DV;
DV2(:, 2:3) = 0;    % [N x 3], day before 01.Jan
DoY=datenum(DV) - datenum(DV2);
temp=cat(2,DoY,ECN_gusts);
%%
maxima=nan(365,10);
for d=1:365
    for y=2007:2016
        temp1=max(ECN_gusts.gust(find(DV(:,1)==y & DoY==d)));
        if length(temp1)<1; continue
            elseif length(temp1)>1; temp1=temp1(1);
            else
            maxima(d,y-2006)=temp1;
        end
    end
end


%% Make the plot with new colours
color1=brewermap(9,'Set1');
Ocol=color1(7,:);
Scol=color1(9,:);
%Acol=color1(4,:);
color2=brewermap(8,'Dark2'); 
Bcol=color2(2,:);
color3=brewermap(12,'PiYG');
Acol=color3(2,:);

h1=plot([-10 -9],[-1 -1],'Color',Scol,'LineWidth',3)  ;%sycamore
hold on
h2=plot([-10 -9],[-1 -1],'Color',Ocol,'LineWidth',3) ;%oak
h3=plot([-10 -9],[-1 -1],'Color',Acol,'LineWidth',3); %ash
hblank2=plot(1,1,'color',[ 0 0 0 0]);
 hwind=plot(smooth(max(maxima,[],2),4));
 
h=0.5;
for i=1:6
    if i==1; a1=20; var=PhenologyData.Son; colr=Scol; end
    if i==2; a1=19; var=PhenologyData.Oon; colr=Ocol; end
    if i==3; a1=18; var=PhenologyData.Aon; colr=Acol; end
    if i==4; a1=18; var=PhenologyData.Aoff; colr=Acol; end
    if i==5; a1=19; var=PhenologyData.Soff; colr=Scol; end
    if i==6; a1=20; var=PhenologyData.Ooff; colr=Ocol; end
    plot([min(var) max(var)],[a1 a1],'Color',colr,'LineWidth',1)
    rectangle('Position',[quantile(var,0.25),a1-h/2,quantile(var,0.75)-quantile(var,0.25),h],...
        'FaceColor',cat(2,colr,0.4),'EdgeColor',colr,'LineWidth',1)
    hold on
end



ylabel('Maximum wind speed (ms^-^1)')
box off
set(gca, 'xtick', 1:30:361);
b=15;
set(gca,'xticklabel', {[ blanks(b) 'Jan'], [ blanks(b) 'Feb'], [ blanks(b) 'Mar'],[ blanks(b) 'Apr'],[ blanks(b) 'May'], ... 
    [ blanks(b) 'Jun'],[ blanks(b) 'Jul'], [ blanks(b) 'Aug'], [ blanks(b) 'Sep'], [ blanks(b) 'Oct'],[ blanks(b) 'Nov'], [ blanks(b) 'Dec'], ''});
set(hwind, 'LineStyle', '-', 'LineWidth', 1.5,'Color', 'black')
set(gca, 'FontName', 'Helvetica')
set(gca, 'FontSize', 16)
axis([0 365 5 22])
hlegend=legend([hwind  hblank2 hblank2 h1 h2 h3],'Wind speed (ms^-^1)', '   ', '   ','Sycamore', 'Oak','Ash' ,'Location','SouthWest');
legend boxoff
t=text(7,8.7,'Leaf on / off timings');
set(t, 'FontName', 'Helvetica','FontSize', 14)
set(gca, 'FontName', 'Helvetica','FontSize', 16)
set(hlegend, 'FontName', 'Helvetica','FontSize', 14)
