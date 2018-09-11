% clear all , clc

disp('Please input the date when your SIMBA developed!');
disp('The format please follow the example below :)');
disp('year_star=31/01/2015(example)');

year_star=input('year_star=','s');
year_star=datestr(datenum(year_star,'dd/mm/yyyy'),1);
daytime=' 00:00:00';
time=[year_star,daytime];

M=importdata('awi32rst.csv');%data rescource
% M=importdata('fmi0403td_2018-04-19_16-38-54(1).csv');%data rescource
M1=M.data;
M1=M1(:,9:248);


M1(abs(M1)>100)=nan;
M1(M1>50)=nan;

M2=M.textdata;
M2=cell2mat(M2(2:end,2));

pask=datenum(M2)-datenum(time);
pask=find(pask>0);

M1=M1(pask:end,:);
M2=M2(pask:end,:);

M2=datestr(M2);
M3=M2;
[m,n]=size(M2);

pask=[16,17,19,20];
zero_mrk=[];

for i=1:m
    if M1(i,240)==0 || M1(i,240)~=-99.9
        zero_mrk=[zero_mrk;i];
    end
end

M1H=M1(zero_mrk,:);
M2H=M2(zero_mrk,:);
M1=M1(:,1:150);
M1(zero_mrk,:)=[];
M2(zero_mrk,:)=[];
[m,n]=size(M2);

pask=(find(M1(:,150)~=-99.9));
find(diff(pask)==1);
park1=[];
park2=[0];

for i=2:m-1
    if abs(datenum(M2(i,:))-datenum(M2(i+1,:)))<0.0400 && ...
            abs(datenum(M2(i,:))-datenum(M2(i-1,:)))>0.0415
        park1=[park1;i;i+1];
    end 
end

park1=unique(park1);
M1=M1(park1,:);
M2=M2(park1,:);
park2=[];
M3=[];
M2T=[];
[m,n]=size(M2);

for i=1:2:m
    
    if abs(datenum(M2(i,:))-datenum(M2(i+1,:)))<0.0400
        park2=[park2;i];
        dataend1=M1(i,150);
        dataend2=M1(i+1,150);
    end
    
    if dataend1==-99.9 && ~ismember(i-1,park2)
        data1=[M1(i+1,:),M1(i,1:90)];
    else
        data1=[M1(i,:),M1(i+1,1:90)];
    end
    
    M3=[M3;data1];
    M2T=[M2T;M2(i,:)];
    
end

% 
heating_data=M1H;
heating_date=M2H;
date_processed={M2T,M3'};
hdata_processed={M1H,M2H};
save Date  date_processed;
%The SIMBA buoy data 
save Heatingdate hdata_processed;
%The SIMBA buoy heating data
display('Your SIMBA date have been processed!');
display('The file of Date.mat is the SIMBA sensor data!');
display('The file of Heatingdate.mat is the SIMBA sensor heating data!');

% run SIMBA_OPDdata_Calculation_step2.m