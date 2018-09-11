% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%  step2 time range selsction & data quality control   %%%%%%%%%
% %%%%%%%%          & up and down surfaces searching            %%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% deldata0_data=[];
% deldata0_time=[];
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%% remove the sensor temperature above 2*maxsitemp?12??%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% pas=find(M1>2*maxsitemp);
% M1(pas)=nan;
% deldata0_data=M1;
% deldata0_time1=M2;
% [m,n]=size(deldata0_data);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%     different daily data selection for alculation     %%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% deldata0_time2=datevec(deldata0_time1);
% deldata0_time3=[];
% delt=deldata0_time2(:,1)*10000+deldata0_time2(:,2)*100+deldata0_time2(:,3);
% [difout,a,b]=(unique(delt));
% deldata0_data=deldata0_data';
% deldata0_time3=deldata0_time1(a,:);
% deldata0_data1=deldata0_data(:,a)';
% deldata0_time=deldata0_time3;
% deldata0_data=deldata0_data1;
% [m,n]=size(deldata0_data);
% pontned=m-Daycut;
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%          abnormal data points smoothing              %%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% for ii=1:pontned+1
%     for jj=3:n-3;%make sure again needed
%         y=[deldata0_data(ii, jj-2 ),deldata0_data(ii, jj-1 ),deldata0_data(ii,jj+1),deldata0_data(ii, jj )];
%         mean_y=mean(y);
%         if abs(deldata0_data(ii,jj)-mean_y)>=5;
%             deldata0_data(ii,jj)=mean_y;
%         end
%     end
%
% end
%
% for ii=1:pontned+1
%     for jj=3:n-3;%make sure again needed
%         y=[deldata0_data(ii, jj-1 ),deldata0_data(ii,jj+1)];
%         mean_y=mean(y);
%         if abs(deldata0_data(ii,jj)-mean_y)>=2;
%             deldata0_data(ii,jj)=mean_y;
%         end
%     end
%
% end
%
% for ii=1:pontned+1
%     for jj=3:n-3;%make sure again needed
%         y=[deldata0_data(ii, jj-1 ),deldata0_data(ii,jj+1)];
%         mean_y=mean(y);
%         if abs(deldata0_data(ii,jj)-mean_y)>=1.5;
%             deldata0_data(ii,jj)=mean_y;
%         end
%     end
%
% end
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%           abnormal data points removing              %%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% x=[];
%
% for ii=1:pontned+1;
%     x=find(abs(deldata0_data(ii,:))>40);
%     deldata0_data(ii,x)=nan;
%     y=find(deldata0_data(ii,30:end)>10);
%     deldata0_data(ii,y)=nan;
% end
%
% deldata0_data=deldata0_data';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%                data adjustment                       %%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dpk=diff(datenum(deldata0_time))-1;
% [dpk1,dpk2]=find(dpk>0);
% if isempty(dpk1)
%
% else dpk1=[0;dpk1;dpk1(end)];
%     pas=[];
%     pas1=[];
%     pas2=[];
%
%     if length(dpk1)==2
%         pas=nan*zeros(240,dpk(dpk1(2)));
%         pas1=deldata0_data(:,dkp1(1)+1:dpk1(2));
%         pas2=[pas1,pas];
%         deldata0_data=[pas2,deldata0_data(:,dkp1(2)+1,end)];
%     elseif length(dpk1)>2
%         for i=1:length(dpk1)-2
%             pas=nan*zeros(240,dpk(dpk1(i+1)));
%             pas1=deldata0_data(:,dpk1(i)+1:dpk1(i+1));
%             pas2=[pas2,pas1,pas];
%         end
%         pas2=[pas2,deldata0_data(:,dpk1(end)+1:end)];
%
%     end
%     deldata0_data=pas2;
%     deldata0_time=datenum(deldata0_time);
%     deldata0_time=datestr([deldata0_time(1):1:deldata0_time(end)]);
%
% end
%
% [m,n]=size(deldata0_data);
% clean_data=deldata0_data;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%       searching air-ice interface searching          %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

air_ice2=[];
pom=[];
KT1=[];
for i=1:pontned+1
    SDT=diff(deldata0_data(topnum:minsefs,i));%rewrited need
    x=find(abs(SDT)>=0.1875);
    xa=find(abs(SDT)>=0.125);
    SDT=diff(deldata0_data(topnum:minsefs+11,i));
    SDTA=diff(deldata0_data(topnum:minsefs+11,i));
    if i==1
        air_ice2=[air_ice2;as_surface-topnum];
        pom=[pom;i];
        
    elseif i>1 && isempty(x) && isempty(xa)
        air_ice2=[air_ice2;air_ice2(end)];
        pom=[pom;i];
    elseif i>1 && isempty(x) && isempty(xa)+1==1
        for j=1:length(xa)
            if SDTA(xa(j))<0
                if length(find(SDTA(xa(j)+1:xa(j)+7)<-0.0625))>4 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+7)<-0.0625))>3 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+5)<-0.0625))>2 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+6)<0))>3 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+5)<0))>2
                    air_ice2=[air_ice2;(xa(j))];
                    pom=[pom;i];
                end
            elseif SDTA(xa(j))>0
                if  length(find(SDTA(xa(j)+1:xa(j)+7)>0.0625))>4 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+7)>0.0625))>3 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+5)>0.0625))>2 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+6)>0))>3 ...
                        ||length(find(SDTA(xa(j)+1:xa(j)+5)>0))>2
                    air_ice2=[air_ice2;(xa(j))];
                    pom=[pom;i];
                end
            end
            if max(pom)==i
                break
            end
        end
    elseif i>1 && isempty(x)+1==1
        
        for j=1:length(x)
            if SDT(x(j))<0
                if length(find(SDT(x(j)+1:x(j)+6)<-0.3125))>3 ...
                        || length(find(SDT(x(j)+1:x(j)+5)<-0.3125))>2 ...
                        || length(find(SDT(x(j)+1:x(j)+7)<-0.125))>4 ...
                        || length(find(SDT(x(j)+1:x(j)+7)<-0.125))>3 ...
                        || length(find(SDT(x(j)+1:x(j)+6)<-0.1875))>3 ...
                        || length(find(SDT(x(j)+1:x(j)+5)<-0.25))>2 ...
                        || length(find(SDT(x(j)+1:x(j)+4)<-0.25))>1
                    air_ice2=[air_ice2;(x(j))];
                    pom=[pom;i];
                    
                end
            elseif SDT(x(j))>0
                if  length(find(SDT(x(j)+1:x(j)+6)>0.3125))>3 ...
                        || length(find(SDT(x(j)+1:x(j)+5)>0.3125))>2 ...
                        || length(find(SDT(x(j)+1:x(j)+7)>0.125))>4 ...
                        || length(find(SDT(x(j)+1:x(j)+7)>0.125))>3 ...
                        || length(find(SDT(x(j)+1:x(j)+6)>0.1875))>3 ...
                        || length(find(SDT(x(j)+1:x(j)+5)>0.25))>2  ...
                        ||  length(find(SDT(x(j)+1:x(j)+4)>0.25))>1
                    air_ice2=[air_ice2;(x(j))];
                    pom=[pom;i];
                    
                end
            end
            if max(pom)==i
                break
            end
        end
    end
    
    
    if i>1 && isempty(x)+1==1 && isempty(xa)+1==1 && max(pom)<i
        for j=1:length(xa)
            if SDTA(xa(j))<0
                if length(find(SDTA(xa(j)+1:xa(j)+7)<-0.0625))>4 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+7)<-0.0625))>3 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+5)<-0.0625))>2 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+6)<0))>3 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+5)<0))>2
                    air_ice2=[air_ice2;(xa(j))];
                    pom=[pom;i];
                end
            elseif SDTA(xa(j))>0
                if  length(find(SDTA(xa(j)+1:xa(j)+7)>0.0625))>4 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+7)>0.0625))>3 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+5)>0.0625))>2 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+6)>0))>3 ...
                        ||length(find(SDTA(xa(j)+1:xa(j)+5)>0))>2
                    air_ice2=[air_ice2;(xa(j))];
                    pom=[pom;i];
                end
            end
            if max(pom)==i
                break
            end
        end
    end
    if max(pom)<i
        air_ice2=[air_ice2;(air_ice2(end))];
        pom=[pom;i];
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

air_ice2=air_ice2+topnum;%rewrited need
y=find(air_ice2>as_surface+5)

for i=1:length(y)
    air_ice2(y(i))=as_surface
end

air_ice2diff=diff(air_ice2);
x=find(abs(air_ice2diff)>=15);

if max(x)+2>pontned
    x=x(1:end-1);
end

for i=2:length(x)
    
    if abs(air_ice2diff(x(i)-1)-air_ice2diff(x(i)+1))<3
        air_ice2(x+1)=int8((air_ice2(x)+air_ice2(x+2))/2);
    end
    
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%     searching ice-seawater interface searching       %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

icebottom2=[];

for i=1:pontned+1
    if i==1
        icebottom2=iw_surface-TOPNUM;
    else
        test=deldata0_data(TOPNUM:end,i);%rewrited needed
        tt=0.0625*ceil(min(test)/0.0625):0.0625:0.0625*ceil(max(test)/0.0625);
        c = histc(test,tt);
        [max_num, max_index] = max(c);
        max_element = tt(max_index);
        x=find(test==max_element);
        if isempty(x)
            x=icebottom2(end);
        end
        icebottom2=[icebottom2;x(1)];
    end
end

icebottom2=icebottom2+TOPNUM;%%%%%%need correction

record=[];

for i=1:pontned+1
    x=diff(air_ice2);
    y=find(x>20);
    x=diff(icebottom2);
    z=find(x>20) ;
end


snow_ice=0*air_ice2+sti;

% air_ice3=ceil(smooth(air_ice2,30));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            piece-wise smooth actual time up surface result             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axx=deldata0_data(sti,1:pontned);
axi=find(isnan(axx));
daxi=find(diff(axi)>1);
air_ice3=[];
icebottom3=[];


if isempty(axi)
    air_ice3=ceil(smooth(air_ice2,30));
    icebottom3=ceil(smooth(icebottom2,30));
elseif axi(1)==1
    diy=sort([axi(1);axi(daxi)+1;axi(daxi+1);axi(end)+1]);
    if max(diy)<length(air_ice2)
        diy=[diy;length(air_ice2)];
    end
    for i=1:length(diy)-1
        if i<length(diy)-1
            air_ice3=[air_ice3;ceil(smooth(air_ice2(diy(i):diy(i+1)-1),30))];
            icebottom3=[icebottom3;ceil(smooth(icebottom2(diy(i):diy(i+1)-1),30))];
            
        else
            air_ice3=[air_ice3;ceil(smooth(air_ice2(diy(i):diy(end)),30))];
            icebottom3=[icebottom3;ceil(smooth(icebottom2(diy(i):diy(end)),30))]
            
        end
        
    end
    
else
    %     diy=sort([1;axi(1);axi(daxi)+1;axi(daxi+1);axi(end)+1]);
    diy=sort([1,axi(1),axi(daxi)+1,axi(daxi+1),axi(end)+1])';
    
    if max(diy)<length(air_ice2)
        diy=[diy;length(air_ice2)];
    end
    
    for i=1:length(diy)-1
        if i<length(diy)-1
            air_ice3=[air_ice3;ceil(smooth(air_ice2(diy(i):diy(i+1)-1),30))];
            icebottom3=[icebottom3;ceil(smooth(icebottom2(diy(i):diy(i+1)-1),30))];
            
        else
            air_ice3=[air_ice3;ceil(smooth(air_ice2(diy(i):diy(end)),30))];
            icebottom3=[icebottom3;ceil(smooth(icebottom2(diy(i):diy(end)),30))]
            
        end
        
    end
end
% icebottom3=ceil(smooth(icebottom2,30));
atsn=min(air_ice2);
% stin=max(snow_ice);
itwn=max(icebottom2);
tdn=ceil((atsn/10)-1)*10-10;
bdn=ceil((itwn/10))*10+10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% redata is the valid data between up and down surface %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

redata=deldata0_data;

for i=1:pontned
    redata(1:air_ice2(i)-1,i)=nan;
    redata(icebottom2(i)+1:end,i)=nan;
    
end
redata0=deldata0_data;
redata1=deldata0_data;

for i=1:pontned
    redata1(1:air_ice3(i)-1,i)=nan;
    redata1(icebottom3(i)+1:end,i)=nan;
    
end

redata2=deldata0_data;


for i=1:pontned
    redata2(1:air_ice2(i)-1,i)=nan;
    redata2(icebottom3(i)+1:end,i)=nan;
    
end

redata3=deldata0_data;

for i=1:pontned
    redata3(1:air_ice3(i)-1,i)=nan;
    redata3(icebottom2(i)+1:end,i)=nan;
    
end

pas=find(redata>maxsitemp);
redata(pas)=nan;
pas=find(redata1>maxsitemp);
redata1(pas)=nan;
pas=find(redata2>maxsitemp);
redata2(pas)=nan;
pas=find(redata3>maxsitemp);
redata3(pas)=nan;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%                time format adjustment                %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

timenum=[];
month1=find(deldata0_time(:,1)=='0'&deldata0_time(:,2)=='1');
timenum=month1;

time=deldata0_time([month1],:);
time=datestr(time,26);
time=time(:,3:7);
timenum=round(timenum);
% actualD=actual_date3;
timeD=redata2;
run SIMBA_OPDdata_Calculation_step5

