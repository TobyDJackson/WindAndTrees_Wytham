%% This code was written in December 2017 and updated in July 2018. 
% It loops over all one ha trees to extractCWS with and without materials
% and also calculates the architectural traits from the QSMs. 

% This is not intended to be used by others in its current form, instead it
% is supposed to give an example of the workflow. The outputs are saved and
% provided in the GitHub repo.

Import_OneHa_v2 % This imports the file names and basic info from excel.
%% This section reads in the simulation results and calculates CWS
% It is split so that species specific materials come first, then uniform materials
% Due to updates, there are three folders in which the simulations are
% stored - newest first they are OneHa_v2, OneHa_v1_100, OneHa_v1
path='C:\Users\Toby\Dropbox\Tobys_Stuff\MATLAB\QSM_Simulations\AQUA_Simulations\OneHa_Sims\';
%sim_names=dir(strcat(path,'\OneHa_Sims2\','*.dat'));
wss=[5 10 15 20 25 30 35 40 45 50 55 60 65 70]; % 
xq=0:0.1:70;
wss2=[5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100];
xq2=0:0.1:100;

n=438; %number of completed simulations
OneHa_v2=OneHa_v2(1:n,:);
fo_MOFF=nan(n,1); fo_MON=nan(n,1); CWS_MOFF=nan(n,1); CWS_MON=nan(n,1);
s15_MON=nan(n,1); s15_MOFF=nan(n,1); found_where=nan(n,1); found_qsm=ones(n,1); 
            
for i=1:n
    if i==378; continue; end
    if i==395; continue; end
     if i==397; continue; end
    ID=OneHa_v2.Tree_ID(i);
    disp(i)
    % MON - Calculate CWS with material properties 
    ON=1;
    if ON==1
        %First look in the v2 folder, then the v1_100
        this_sim=dir(strcat(path,'OneHa_v2\OneHa_v2_newSims_MON\trimmed_dats\','cyl_data_wytham_winter_',char(ID),'-*.mat'));
        if length(this_sim)==1; found_where(i)=3; end
        if length(this_sim)==0
             this_sim=dir(strcat(path,'OneHa_v1_100\MON_100\trimmed_dats\','cyl_data_wytham_winter_',char(ID),'-*.mat'));
             if length(this_sim)==1; found_where(i)=2; end
        end
        if length(this_sim)==1
             load(strcat(this_sim.folder,'\',this_sim.name)); CWS_Raw=output{5}; CWS_steps=output{6}; FREQ_STEP=output{1};
            fo_MON(i)=FREQ_STEP(1,1);
            steps_interp=interp1(wss2,CWS_steps(1,:),xq2);
            breaking_strain=OneHa_v2.MOR(i)./OneHa_v2.Elasticity(i);
            [M,I]=min(abs(steps_interp-breaking_strain));
            CWS_MON(i)=xq2(I);
            s15_MON(i)=CWS_steps(1,3);
        else
            this_sim=dir(strcat(path,'OneHa_v1\OneHa_Sims2_MON\trimmed_dats\','cyl_data_wytham_winter_',char(ID),'-*.mat'));
            if length(this_sim)==1; found_where(i)=1; 
                load(strcat(this_sim.folder,'\',this_sim.name));   
                CWS_Raw=output{5}; CWS_steps=output{6}; FREQ_STEP=output{1};
                fo_MON(i)=FREQ_STEP(1,1);
                steps_interp=interp1(wss,CWS_steps(1,:),xq);
                breaking_strain=OneHa_v2.MOR(i)./OneHa_v2.Elasticity(i);
                [M,I]=min(abs(steps_interp-breaking_strain));
                CWS_MON(i)=xq2(I);
                s15_MON(i)=CWS_steps(1,3);
            elseif length(this_sim)==0;    found_where(i)=0; disp('NOT FOUND'); 
            end

  
            if length(this_sim)>1
                disp('problem here')
                disp(this_sim.name)
            end
        end
  
        PLOT=1;
        if PLOT==1
            subplot(1,2,1)
            plot(sqrt((CWS_Raw(:,1,1).^2)+(CWS_Raw(:,1,2).^2)),'black')
            xlim([0 1200])
            %xticks([0 400 800 1200])
            %yticks([0 4e-3 8e-3 12e-3])
           
            xlabel('Time steps')
            ylabel Strain
            set([gca], 'FontName', 'Helvetica','FontSize', 9)

            subplot(1,2,2)
            plot(wss.^2,(CWS_steps(1,:)),'-+','Color','black')
            xlabel('ws^2')
            ylabel Strain
            hold on
            line([0 CWS_MON(i).^2], ([breaking_strain breaking_strain]),'Color','red','LineStyle','--')
            line(([CWS_MON(i) CWS_MON(i)]).^2,([0 breaking_strain]),'Color','red','LineStyle','--')
            textLoc(['CWS = ', num2str(CWS_MON(i)) ,' m/s'],'SouthEast');
            set([gca], 'FontName', 'Helvetica','FontSize', 9)
            pause
            close all
        end
    end
    
    
    % MOFF - Calculate CWS without material properties MOFF
    ON=1;
    if ON==1
        %First look in the v2 folder, then the v1_100 - these both have 100ms
        this_sim=dir(strcat(path,'OneHa_v2\OneHa_v2_newSims_MOFF\trimmed_dats\','cyl_data_wytham_winter_',char(ID),'-*.mat'));
        if length(this_sim)==0
             this_sim=dir(strcat(path,'OneHa_v1_100\MOFF_100\trimmed_dats\','cyl_data_wytham_winter_',char(ID),'-*.mat'));
        end
        if length(this_sim)==1
             load(strcat(this_sim.folder,'\',this_sim.name));  CWS_Raw=output{5}; CWS_steps=output{6}; FREQ_STEP=output{1};
            fo_MOFF(i)=FREQ_STEP(1,1);
            steps_interp=interp1(wss2,CWS_steps(1,:),xq2);
            breaking_strain=66/8400;
            [M,I]=min(abs(steps_interp-breaking_strain));
            CWS_MOFF(i)=xq2(I);
            s15_MOFF(i)=CWS_steps(1,3);
        else % If it is not available in either of the above look in the OneHa_v1 which goes up to 70
             this_sim=dir(strcat(path,'OneHa_v1\OneHa_Sims2_MOFF\trimmed_dats\','cyl_data_wytham_winter_',char(ID),'-*.mat'));
            if length(this_sim)==1;
                load(strcat(this_sim.folder,'\',this_sim.name)); 
                CWS_Raw=output{5}; CWS_steps=output{6}; FREQ_STEP=output{1};
                fo_MOFF(i)=FREQ_STEP(1,1);
                steps_interp=interp1(wss,CWS_steps(1,:),xq);
                breaking_strain=66/8400;
                [M,I]=min(abs(steps_interp-breaking_strain));
                CWS_MOFF(i)=xq(I);
                s15_MOFF(i)=CWS_steps(1,3);
                %pause
            elseif length(this_sim)==0;    %If it is not found at all, it is the sycamore or unavailable.
                CWS_MOFF(i)=CWS_MON(i);  
                s15_MOFF(i)=s15_MON(i);
            end       
        end 
        
        PLOT=0;
        if PLOT==1
            subplot(1,2,1)
            plot(sqrt((CWS_Raw(:,1,1).^2)+(CWS_Raw(:,1,2).^2)),'black')
            xlabel('Timesteps')
            ylabel Strain
            title('Raw Simulation Output')

            subplot(1,2,2)
            plot(wss.^2,(CWS_steps(1,:)),'-o','Color','black')
            xlabel('Wind Speed ^2')
            ylabel Strain
            title('Critical Wind Speed')
            hold on
            line([0 CWS_MOFF(i).^2], ([breaking_strain breaking_strain]),'Color','red','LineStyle','--')
            line(([CWS_MOFF(i) CWS_MOFF(i)]).^2,([0 breaking_strain]),'Color','red','LineStyle','--')
            textLoc(['CWS = ', num2str(CWS_MOFF(i)) ,' m/s'],'SouthEast');
            pause
            close all
        end
    end
           
    
    % Import QSM and calculate architectures
    ON=0;
    if ON==1
        folder='C:\Users\Toby\Dropbox\Tobys_Stuff\MATLAB\QSM_Simulations\Wytham_1ha_QSMs\Simp_by_radius_v2\';
        this_qsm=dir(strcat(folder,'cyl_data_wytham_winter_',char(OneHa_v2.Tree_ID(i)),'-_1_2.mat'));
        %load(strcat(folder,'cyl_data_wytham_winter_',char(OneHa.LIDAR_ID(i)),'-_1_2.mat'))
        %pause
        if length(this_qsm)==0; found_qsm(i)=0;  disp('no qsm');  continue; end %this doesn't occur!
            load(strcat(this_qsm.folder,'\',this_qsm.name))
            [ values Sail  ] = Calculate_architectures( CylData_updated );
            Save_Archs(i,[1:11])=values;
            static_calc(i)=Static_model( CylData_updated, 8.5e9, 20, 0.82, 15, 0.05 ,0, [1 1]);
            x(i)=CylData_updated(1,3);
            y(i)=CylData_updated(1,4);
            z(i)=CylData_updated(1,5);
        end
    
    % pc colored plot
    ON=0;
    if ON==1
        colormap(brewermap(17,'RdYlGn'));
        CWS_color=(log(s15_MON)*-10);%CWS_MON;%-10; CWS_color(find(CWS_color)<=0)=1;
        PC=import_pointcloud(strcat('C:\Users\Toby\Desktop\Data\OneHa_PointClouds\wytham_winter_'...
        ,char(OneHa.LIDAR_ID(i)),'.txt'));
        P=downsample(PC,50);
        % Colour by CWS (choose MON or MOFF)
        if CWS_MOFF(i)==100
            scatter3(P(:,1),P(:,2),P(:,3),0.1,zeros(length(P),3),'.')
        else
           scatter3(P(:,1),P(:,2),P(:,3),0.1,ones(length(P),1).*CWS_color(i),'.')
        end
        hold on
    end
end
%box off; axis off; grid off
c = colorbar;
c.Label.String = 'Strain at 15ms^-^1';

%% Calculate competition indices

Import_OneHa_Full2 %This requires the full Wytham census data
[ Fullx, Fully ] = correct_census_coords2( FullCensus.lx, FullCensus.ly, FullCensus.plotnum, FullCensus.subplot);
[ OneHax, OneHay ] = correct_census_coords2( OneHa_v2.lx, OneHa_v2.ly, OneHa_v2.plotnum, OneHa_v2.subplot);
PLOT=0;
for i=1:length(OneHa_v2.x)
    this_row=find(FullCensus.tag==OneHa_v2.censusID(i));
    if length(this_row)>1; this_row=this_row(length(this_row)); end
    distances=sqrt((Fullx(this_row)-Fullx).^2+(Fully(this_row)-Fully).^2);
    neighbours10=find(distances<=10 & distances>=0.05);
    competition(i)=sum(FullCensus.dbh16mm(neighbours10)./distances(neighbours10),'omitnan');
    if PLOT==1
        scatter(Fullx(this_row),Fully(this_row),FullCensus.dbh16mm(this_row), 'b')
        hold on
        scatter(Fullx(neighbours10),Fully(neighbours10),FullCensus.dbh16mm(neighbours10),'r')
        pause
    end
    %scatter(OneHa_Data.x(neighbours10),OneHa_Data.y(neighbours10),OneHa_Data.dbh16(neighbours10),'g')
 
    %competition2(i)=(1/Full_Census.dbh16(rows_21(i)))*sum(close_neighbours(isnan(close_neighbours)==0))+0.5*sum(far_neighbours(isnan(far_neighbours)==0));
    
end


%% Bring together and save
Save_Archs=table2array(Save_Archs); 
dbh=OneHa_v2.dbh16mm;
Hmax=0.792*((OneHa_v2.Elasticity*10.^6./(OneHa_v2.Density*9.814)).^(1/3)) .*(OneHa_v2.dbh16mm/1000).^(2/3)
height=Save_Archs(:,1);
slender=dbh./height;
OneHa_Data=table(CWS_MON,CWS_MOFF,s15_MON, s15_MOFF,OneHa_v2.dbh16mm, slender, Hmax,OneHa_v2.Growth_Rate,...
    x', y', z',OneHa_v2.DBH_cm, OneHa_v2.species,competition', ...
Save_Archs(:,1),Save_Archs(:,3),Save_Archs(:,4),Save_Archs(:,5),Save_Archs(:,6),Save_Archs(:,7),Save_Archs(:,8),Save_Archs(:,9),Save_Archs(:,10)...
    ,'VariableNames',{'CWS_MON','CWS_MOFF',  's15_MON','s15_MOFF','dbh16','Slenderness','Hmax','GrowthRate', 'x', 'y','z_plot','dbhTLS','Species',...
   'Competition','Height', 'Volume','Pf','CrownHeight','CrownWidth','CrownAsymmetry','BranchingAngle','SailArea','CVR'});
OneHa_Data(find(found_where==0),:)=[];
OneHa_Data(find(OneHa_Data.Height==0),:)=[];
OneHa_Data.Properties.VariableNames'

