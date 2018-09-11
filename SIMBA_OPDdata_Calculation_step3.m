%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%  step 1 searching range & initial conditions input   %%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%     up surface searching below the sensor topnum     %%%%%%%%% 
%%%%%%%%    down surface searching below the sensor TOPNUM    %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% interval=1;
disp('Please input the sensor position, up surface seached below!');
disp('For example,you want this algorithm search the up suface below sensor 10');
disp('topnum=10');
topnum=input('topnum=');%initial condition of air-snow(ice) surface position
disp('Please input the sensor position, down surface seached below!');
TOPNUM=input('TOPNUM=');%initial condition of snow(ice)-seawater surface position
disp('Please input the daily snow growth limit condition!');
disp('For example,you want assume the daily snow growth is 30cm');
disp('Limtsnowfall=15');
Limtsnowfall=input('Limtsnowfall=');
disp('Please input daily icebottom growth limit condition!');
disp('For example,you want set the daily icebottom growth is 10cm');
disp('Limticegroth=5');
Limticegroth=input('Limticegroth=')
maxsitemp=6;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%     interfaces initial position conditions input     %%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

as_surface=input('as_surface=');%initial condition of air-snow(ice) surface position
si_surface=input('si_surface=');%initial condition of snow-ice surface position
iw_surface=input('iw_surface=');%initial condition of ice-water surface position
Daysremoved=input('Daysemoved=');% the days numble removed in the time  tail of SIMBA data
ats=as_surface;%initial condition of air-snow(ice) surface position
sti=si_surface;%initial condition of snow-ice surface position
itw=iw_surface;%initial condition of ice-water surface position

minsefs=itw;
Daycut=Daysremoved;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%  step2 time range selsction & data quality control   %%%%%%%%%
%%%%%%%%          & up and down surfaces searching            %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

deldata0_data=[];
deldata0_time=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%% remove the sensor temperature above 2*maxsitemp?12??%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pas=find(M1>2*maxsitemp);
M1(pas)=nan;
deldata0_data=M1;
deldata0_time1=M2;
[m,n]=size(deldata0_data);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%     different daily data selection for alculation     %%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

deldata0_time2=datevec(deldata0_time1);
deldata0_time3=[];
delt=deldata0_time2(:,1)*10000+deldata0_time2(:,2)*100+deldata0_time2(:,3);
[difout,a,b]=(unique(delt));
deldata0_data=deldata0_data';
deldata0_time3=deldata0_time1(a,:);
deldata0_data1=deldata0_data(:,a)';
deldata0_time=deldata0_time3;
deldata0_data=deldata0_data1;
[m,n]=size(deldata0_data);
pontned=m-Daycut;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%          abnormal data points smoothing              %%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for ii=1:pontned+1
    for jj=3:n-3;%make sure again needed
        y=[deldata0_data(ii, jj-2 ),deldata0_data(ii, jj-1 ),deldata0_data(ii,jj+1),deldata0_data(ii, jj )];
        mean_y=mean(y);
        if abs(deldata0_data(ii,jj)-mean_y)>=5;
            deldata0_data(ii,jj)=mean_y;
        end
    end
    
end

for ii=1:pontned+1
    for jj=3:n-3;%make sure again needed
        y=[deldata0_data(ii, jj-1 ),deldata0_data(ii,jj+1)];
        mean_y=mean(y);
        if abs(deldata0_data(ii,jj)-mean_y)>=2;
            deldata0_data(ii,jj)=mean_y;
        end
    end
    
end

for ii=1:pontned+1
    for jj=3:n-3;%make sure again needed
        y=[deldata0_data(ii, jj-1 ),deldata0_data(ii,jj+1)];
        mean_y=mean(y);
        if abs(deldata0_data(ii,jj)-mean_y)>=1.5;
            deldata0_data(ii,jj)=mean_y;
        end
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%           abnormal data points removing              %%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x=[];

for ii=1:pontned+1;
    x=find(abs(deldata0_data(ii,:))>40);
    deldata0_data(ii,x)=nan;
    y=find(deldata0_data(ii,30:end)>10);
    deldata0_data(ii,y)=nan;
end

deldata0_data=deldata0_data';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%                data adjustment                       %%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dpk=diff(datenum(deldata0_time))-1;
[dpk1,dpk2]=find(dpk>0);
if isempty(dpk1)
    
else dpk1=[0;dpk1;dpk1(end)];
    pas=[];
    pas1=[];
    pas2=[];
    
    if length(dpk1)==2
        pas=nan*zeros(240,dpk(dpk1(2)));
        pas1=deldata0_data(:,dkp1(1)+1:dpk1(2));
        pas2=[pas1,pas];
        deldata0_data=[pas2,deldata0_data(:,dkp1(2)+1,end)];
    elseif length(dpk1)>2
        for i=1:length(dpk1)-2
            pas=nan*zeros(240,dpk(dpk1(i+1)));
            pas1=deldata0_data(:,dpk1(i)+1:dpk1(i+1));
            pas2=[pas2,pas1,pas];
        end
        pas2=[pas2,deldata0_data(:,dpk1(end)+1:end)];
        
    end
    deldata0_data=pas2;
    deldata0_time=datenum(deldata0_time);
    deldata0_time=datestr([deldata0_time(1):1:deldata0_time(end)]);
    
end

[m,n]=size(deldata0_data);
clean_data=deldata0_data;

run SIMBA_OPDdata_Calculation_step4_2.m

%%%%%%%%%%%%step 2 clear data
%%%%%%%%%%%%step 3 choice pattern
%%%%%%%%%%%%step 4 find out up&down surfaces
%%%%%%%%%%%%step 5 find out the snow-ice layer by Stefan layer
%%%%%%%%%%%%step 6 thickness time serious
%%%%%%%%%%%%step 7 different layers
%%%%%%%%%%%%step 8 flux calculation
