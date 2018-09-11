
ss1=snow_ice(1);
sss1=ss1;

while ss1(end)>26
    ss1=ss1-25;
sss1=[sss1;ss1];
end
sss1=sort(sss1);
ss2=snow_ice(1);
sss2=ss2;
while sss2(end)<216
    ss2=ss2+25;
sss2=[sss2;ss2];
end
sss3=-0.02*(sss1-snow_ice(1));

sss4=-0.02*(sss2-snow_ice(1));
sss5=[sss1;sss2(2:end)];
sss6=[sss3;sss4(2:end)];
sss6=round(sss6,1);



actime_data=deldata0_data(:,1:pontned);
actime_date=deldata0_time(1:pontned,:);
topnum_now=air_ice2(1:pontned)-15;
TOPNUM_now=icebottom3(1:pontned,:)-3;
topnum_his=topnum;
TOPNUM_his=TOPNUM;
for i=1:length(topnum_now)
    if topnum_now(i)<topnum_his
        topnum_now(i)=topnum_his;
    end
end
% calculation_part1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%       searching air-ice interface searching          %%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if pontned<mstar+1
%     air_ice_actual=air_ice2(1:pontned-1);
% end
air_ice_actual=[];
pom_actual=[];

for i=1:pontned
    SDT=diff(actime_data(topnum_now(i):minsefs,i));%rewrited need
    x=find(abs(SDT)>=0.1875);
    xa=find(abs(SDT)>=0.125);
    SDT=diff(actime_data(topnum_now(i):minsefs+11,i));
    SDTA=diff(actime_data(topnum_now(i):minsefs+11,i));
    if i==1
        air_ice_actual=[air_ice_actual;as_surface-topnum_now(i)];
        pom_actual=[pom_actual;i];
        
    elseif i>1 && isempty(x) && isempty(xa)
        air_ice_actual=[air_ice_actual;air_ice_actual(end)];
        pom_actual=[pom_actual;i];
    elseif i>1 && isempty(x) && isempty(xa)+1==1
        for j=1:length(xa)
            if SDTA(xa(j))<0
                if length(find(SDTA(xa(j)+1:xa(j)+7)<-0.0625))>4 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+7)<-0.0625))>3 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+5)<-0.0625))>2 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+6)<0))>3 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+5)<0))>2
                    air_ice_actual=[air_ice_actual;(xa(j))];
                    pom_actual=[pom_actual;i];
                end
            elseif SDTA(xa(j))>0
                if  length(find(SDTA(xa(j)+1:xa(j)+7)>0.0625))>4 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+7)>0.0625))>3 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+5)>0.0625))>2 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+6)>0))>3 ...
                        ||length(find(SDTA(xa(j)+1:xa(j)+5)>0))>2
                    air_ice_actual=[air_ice_actual;(xa(j))];
                    pom_actual=[pom_actual;i];
                end
            end
            if max(pom_actual)==i
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
                    air_ice_actual=[air_ice_actual;(x(j))];
                    pom_actual=[pom_actual;i];
                    
                end
            elseif SDT(x(j))>0
                if  length(find(SDT(x(j)+1:x(j)+6)>0.3125))>3 ...
                        || length(find(SDT(x(j)+1:x(j)+5)>0.3125))>2 ...
                        || length(find(SDT(x(j)+1:x(j)+7)>0.125))>4 ...
                        || length(find(SDT(x(j)+1:x(j)+7)>0.125))>3 ...
                        || length(find(SDT(x(j)+1:x(j)+6)>0.1875))>3 ...
                        || length(find(SDT(x(j)+1:x(j)+5)>0.25))>2  ...
                        ||  length(find(SDT(x(j)+1:x(j)+4)>0.25))>1
                    air_ice_actual=[air_ice_actual;(x(j))];
                    pom_actual=[pom_actual;i];
                    
                end
            end
            if max(pom_actual)==i
                break
            end
        end
    end
    
    
    if i>1 && isempty(x)+1==1 && isempty(xa)+1==1 && isempty(pom_actual)
        for j=1:length(xa)
            if SDTA(xa(j))<0
                if length(find(SDTA(xa(j)+1:xa(j)+7)<-0.0625))>4 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+7)<-0.0625))>3 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+5)<-0.0625))>2 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+6)<0))>3 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+5)<0))>2
                    air_ice_actual=[air_ice_actual;(xa(j))];
                    pom_actual=[pom_actual;i];
                end
            elseif SDTA(xa(j))>0
                if  length(find(SDTA(xa(j)+1:xa(j)+7)>0.0625))>4 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+7)>0.0625))>3 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+5)>0.0625))>2 ...
                        || length(find(SDTA(xa(j)+1:xa(j)+6)>0))>3 ...
                        ||length(find(SDTA(xa(j)+1:xa(j)+5)>0))>2
                    air_ice_actual=[air_ice_actual;(xa(j))];
                    pom_actual=[pom_actual;i];
                end
            end
            if max(pom_actual)==i
                break
            end
        end
    end
    if max(pom_actual)<i
        air_ice_actual=[air_ice_actual;air_ice_actual(end)];
        pom_actual=[pom_actual;i];
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

air_ice_actual=air_ice_actual+topnum_now;%rewrited need
y=find(air_ice_actual>as_surface+5);

for i=1:length(y)
    air_ice_actual(y(i))=as_surface;
end

air_ice_actualdiff=diff(air_ice_actual);
x=find(abs(air_ice_actualdiff)>=15);

if max(x)+2>pontned
    x=x(1:end-1);
end

for i=2:length(x)
    if abs(air_ice_actualdiff(x(i)-1)-air_ice_actualdiff(x(i)+1))<3
        air_ice_actual(x+1)=int8((air_ice_actual(x)+air_ice_actual(x+2))/2);
    end
end



if TOPNUM_now<TOPNUM_his
    TOPNUM_now=TOPNUM_his;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%     searching ice-seawater interface searching       %%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% if pontned<mstar+1
%     icebottom_actual=icebottom2(1:pontned-1);
% end
icebottom_actual=[];
for i=1:pontned
    if i==1
        icebottom_actual=[icebottom_actual;iw_surface-TOPNUM_now(i)]
    else
        test=actime_data(TOPNUM_now(i):end,i);%rewrited needed
        tt=0.0625*ceil(min(test)/0.0625):0.0625:0.0625*ceil(max(test)/0.0625);
        c = histc(test,tt);
        [max_num, max_index] = max(c);
        max_element = tt(max_index);
        x=find(test==max_element);
        if isempty(x) && isempty(icebottom_actual)
            x=0;
        elseif isempty(x)
            x=icebottom_actual(end);
        end
        icebottom_actual=[icebottom_actual;x(1)];
    end
end

icebottom_actual=icebottom_actual+TOPNUM_now(1:length(icebottom_actual));%%%%%%need correction
icebottom_actual=[];
for i=1:pontned
    if i==1
        icebottom_actual=[icebottom_actual;iw_surface-TOPNUM_now(i)]
    else
        test=actime_data(TOPNUM_now(i):end,i);%rewrited needed
        tt=0.0625*ceil(min(test)/0.0625):0.0625:0.0625*ceil(max(test)/0.0625);
        c = histc(test,tt);
        [max_num,max_index]=max(c);
        max_element=tt(max_index);
        x=find(test==max_element);
        if isempty(x) && isempty(icebottom_actual)
            x=0;
        elseif isempty(x)
            x=icebottom_actual(end);
        end
        icebottom_actual=[icebottom_actual;x(1)];
    end
end

icebottom_actual=icebottom_actual+TOPNUM_now(1:length(icebottom_actual));%%%%%%need correction

record=[];

for i=pontned:pontned
    x=diff(air_ice_actual);
    y=find(x>20);
    x=diff(icebottom_actual);
    z=find(x>20) ;
end


snow_ice_acutal=0*air_ice_actual+sti;

air_ice3_actual=ceil(smooth(air_ice_actual,30));
icebottom3_acutal=ceil(smooth(icebottom_actual,30));
atsn=min(air_ice_actual);
itwn=max(icebottom_actual);
tdn=ceil((atsn/10)-1)*10-10;
bdn=ceil((itwn/10))*10+10;

redata_actual=actime_data(:,1:pontned);

for i=1:pontned
    redata_actual(1:air_ice_actual(i)-1,i)=nan;
    redata_actual(icebottom_actual(i)+1:end,i)=nan;
    
end
redata0_actual=actime_data;
redata1_acutal=actime_data;

for i=pontned-1:pontned-1
    redata1_actual(1:air_ice3_actual(i)-1,i)=nan;
    redata1_actual(icebottom3_acutal(i)+1:end,i)=nan;
    
end

redata2_actual=actime_data;

for i=pontned-1:pontned
    redata2_actual(1:air_ice_actual(i)-1,i)=nan;
    redata2_actual(icebottom3_acutal(i)+1:end,i)=nan;
end

pas=find(redata_actual>maxsitemp);
redata_actual(pas)=nan;
pas=find(redata1_acutal>maxsitemp);
redata1_acutal(pas)=nan;
pas=find(redata2_actual>maxsitemp);
redata2_actual(pas)=nan;
redata;

actual_date=redata_actual;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            piece-wise smooth actual time up surface result             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axx=deldata0_data(sti,1:pontned);
axi=find(isnan(axx));
daxi=find(diff(axi)>1);
    air_ice_actual2=[];
icebottom_actual2=[];


if isempty(axi)
    air_ice_actual2=ceil(smooth(air_ice_actual,30));
    icebottom_actual2=ceil(smooth(icebottom_actual,30));
elseif axi(1)==1
    diy=sort([axi(1);axi(daxi)+1;axi(daxi+1);axi(end)+1]);
    if max(diy)<length(air_ice_actual)
        diy=[diy;length(air_ice_actual)];
    end
    for i=1:length(diy)-1
        if i<length(diy)-1
            air_ice_actual2=[air_ice_actual2;ceil(smooth(air_ice_actual(diy(i):diy(i+1)-1),30))];
                    icebottom_actual2=[icebottom_actual2;ceil(smooth(icebottom_actual(diy(i):diy(i+1)-1),30))];

        else
            air_ice_actual2=[air_ice_actual2;ceil(smooth(air_ice_actual(diy(i):diy(end)),30))];
                    icebottom_actual2=[icebottom_actual2;ceil(smooth(icebottom_actual(diy(i):diy(end)),30))]

        end
        
    end
    
else
    diy=sort([1,axi(1),axi(daxi)+1,axi(daxi+1),axi(end)+1])';
    if max(diy)<length(air_ice_actual)
        diy=[diy;length(air_ice_actual)];
    end
    air_ice_actual2=[];
    for i=1:length(diy)-1
        if i<length(diy)-1
            air_ice_actual2=[air_ice_actual2;ceil(smooth(air_ice_actual(diy(i):diy(i+1)-1),30))];
                    icebottom_actual2=[icebottom_actual2;ceil(smooth(icebottom_actual(diy(i):diy(i+1)-1),30))];

        else
            air_ice_actual2=[air_ice_actual2;ceil(smooth(air_ice_actual(diy(i):diy(end)),30))];
                    icebottom_actual2=[icebottom_actual2;ceil(smooth(icebottom_actual(diy(i):diy(end)),30))]

        end
        
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           piece-wise smooth actual time down surface result            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% icebottom_actual2=ceil(smooth(icebottom_actual,30));
actual_date2=deldata0_data;
actual_date3=deldata0_data;
actual_date4=deldata0_data;

for i=1:pontned
    actual_date(1:air_ice_actual(i)-1,i)=nan;
    actual_date(icebottom_actual(i)+1:end,i)=nan;   
end
for i=1:pontned
    actual_date2(1:air_ice_actual2(i)-1,i)=nan;
    actual_date2(icebottom_actual2(i)+1:end,i)=nan;   
end
for i=1:pontned
    actual_date3(1:air_ice_actual(i)-1,i)=nan;
    actual_date3(icebottom_actual2(i)+1:end,i)=nan;   
end
for i=1:pontned
    actual_date4(1:air_ice_actual2(i)-1,i)=nan;
    actual_date4(icebottom_actual(i)+1:end,i)=nan;   
end
air_temp=nan*zeros(max(air_ice2)-1,pontned);
for i=1:pontned
    air_temp(1:air_ice2(i)-1,i)=clean_data(1:air_ice2(i)-1,i);
end
air_temp1=nan*zeros(max(air_ice_actual)-1,pontned);
for i=1:pontned
    air_temp1(1:air_ice_actual(i)-1,i)=clean_data(1:air_ice_actual(i)-1,i);
end
seawater_temp=nan*zeros(240,pontned);
for i=1:pontned
    seawater_temp(icebottom2(i)+1:end,i)=clean_data(icebottom2(i)+1:end,i);
end
seawater_temp1=nan*zeros(240,pontned);
for i=1:pontned
    seawater_temp1(icebottom_actual(i)+1:end,i)=clean_data(icebottom_actual(i)+1:end,i);
end
mean_air_rough=[];
mean_air_rough1=[];
mean_seawater_rough=[];
mean_seawater_rough1=[];
for i=1:pontned
    mean_air_rough=[mean_air_rough,nanmean(air_temp(:,i))];
end

for i=1:pontned
    mean_air_rough1=[mean_air_rough1,nanmean(air_temp1(:,i))];
end
for i=1:pontned
    mean_seawater_rough=[mean_seawater_rough,nanmean(seawater_temp(:,i))];
end
for i=1:pontned
    mean_seawater_rough1=[mean_seawater_rough1,nanmean(seawater_temp1(:,i))];
end
xxs=[];
for i=1:pontned
    xxs=clean_data(air_ice_actual2,i)';
end

g1=figure('Color',[1 1 1]);
plot(0.02*(snow_ice(1:pontned)-air_ice_actual(1:pontned)),'b','linewidth',2);
hold on
plot(0.02*(snow_ice(1:pontned)-air_ice2(1:pontned)),'r','linewidth',2);
set(gcf,'Position',[000 100 1200 300]);
% title([titlename],'fontsize',30);
xlabel('Time','fontsize',30);
ylabel('Snow Thickness(m)','fontsize',30);
set(gca,'Xtick',timenum);
set(gca,'xticklabel',time,'fontsize',30);
s1=legend('Up Surface(Actual Time)','Up Suface(Time Series)','location','southwest');
f=getframe(gcf);
% imwrite(f.cdata,[directory,'/1','.bmp']);


g2=figure('Color',[1 1 1]);
plot(-0.02*(icebottom_actual(1:pontned)-snow_ice(1:pontned)),'b','linewidth',2);
hold on
plot(-0.02*(icebottom2(1:pontned)-snow_ice(1:pontned)),'r','linewidth',2);
set(gcf,'Position',[000 100 1200 300]);
% title([titlename],'fontsize',30);
xlabel('Time','fontsize',30);
ylabel('Ice Thickness(m)','fontsize',30);
set(gca,'Xtick',timenum);
set(gca,'xticklabel',time,'fontsize',30);
s1=legend('Down Surface(Actual Time)','Down Suface(Time Series)','location','southwest');
f=getframe(gcf);
% imwrite(f.cdata,[directory,'/2','.bmp']);


g3=figure('Color',[1 1 1]);
plot(0.02*(snow_ice(1:pontned)-air_ice_actual2(1:pontned)),'b','linewidth',2);
hold on
plot(0.02*(snow_ice(1:pontned)-air_ice3(1:pontned)),'r','linewidth',2);
set(gcf,'Position',[000 100 1200 300]);
% title([titlename],'fontsize',30);
xlabel('Time','fontsize',30);
ylabel('Snow Thickness(m)','fontsize',30);
set(gca,'Xtick',timenum);
set(gca,'xticklabel',time,'fontsize',30);
s1=legend('Up Surface(Actual Time Smoothed)','Up Suface(Time Series Smoothed)','location','southwest');

f=getframe(gcf);
% imwrite(f.cdata,[directory,'/3','.bmp']);


g4=figure('Color',[1 1 1]);
plot(-0.02*(icebottom_actual2(1:pontned)-snow_ice(1:pontned)),'b','linewidth',2);
hold on
plot(-0.02*(icebottom3(1:pontned)-snow_ice(1:pontned)),'r','linewidth',2);
set(gcf,'Position',[000 100 1200 300]);
% title([titlename],'fontsize',30);
xlabel('Time','fontsize',30);
ylabel('Ice Thickness(m)','fontsize',30);
set(gca,'Xtick',timenum);
set(gca,'xticklabel',time,'fontsize',30);
s1=legend('Down Surface(Actual Time Smoothed)','Down Suface(Time Series Smoothed)','location','southwest');

f=getframe(gcf);
% imwrite(f.cdata,[directory,'/4','.bmp']);




S1=figure('Color',[1 1 1]);
set(gcf,'outerposition',get(0,'screensize'));
g1=pcolor(actual_date(1:end,2:pontned));%rewrited need
hold on
ylabel(colorbar,'Temperature(^oC)','fontsize',30);

colormap(jet);
set(g1,'LineStyle','none');
% title([titlename],'fontsize',30);
%rewrited needed
xlabel('Time','fontsize',30);
ylabel('Sensor Number','fontsize',30);
view(180,180);
hold on

view([0 0 -90])
plot(air_ice_actual(2:pontned),'b','linewidth',2);
hold on
plot(snow_ice(2:pontned),'k','linewidth',2);
hold on
plot(icebottom_actual(2:pontned)+1,'y','linewidth',2);

s1=legend('Data','Up Surface(Actual Time)','Snow-Ice Interface(Developed)','Down Surface(Actual Time)','location','SouthWest');
set(s1,'Fontsize',30);
set(gca,'Xtick',timenum);
set(gca,'xticklabel',time,'fontsize',30);

f=getframe(gcf);
ylabel('Deep(m)','fontsize',30);
set(gca,'YTick',sss5); 
set(gca,'YTickLabel',sss6,'fontsize',30) 
set(gcf, 'position', get(0,'ScreenSize'));
f=getframe(gcf);
% imwrite(f.cdata,[directory,'/5','.bmp']);
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S2=figure('Color',[1 1 1]);
set(gcf,'outerposition',get(0,'screensize'));
g1=pcolor(actual_date2(1:end,2:pontned));%rewrited need
hold on
ylabel(colorbar,'Temperature(^oC)','fontsize',30);
colormap(jet);
set(g1,'LineStyle','none');
% title([titlename],'fontsize',30);
%rewrited needed

xlabel('Time','fontsize',30);
ylabel('Sensor Number','fontsize',30);
view(180,180);
hold on
view([0 0 -90])
plot(air_ice_actual2(2:pontned),'b','linewidth',2);
hold on
plot(snow_ice(2:pontned),'k','linewidth',2);
hold on
plot(icebottom_actual2(2:pontned)+1,'y','linewidth',2);

s1=legend('Data','Up Surface(Actual Time Smoothed)','Snow-Ice Interface(Developed)','Down Surface(Actual Time Smoothed)','location','SouthWest');
set(s1,'Fontsize',30);
set(gca,'Xtick',timenum);
set(gca,'xticklabel',time,'fontsize',30);
f=getframe(gcf);
ylabel('Deep(m)','fontsize',30);
set(gca,'YTick',sss5); 
set(gca,'YTickLabel',sss6,'fontsize',30);
set(gcf, 'position', get(0,'ScreenSize'));
f=getframe(gcf);
% imwrite(f.cdata,[directory,'/6','.bmp']);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S3=figure('Color',[1 1 1]);
set(gcf,'outerposition',get(0,'screensize'));
g1=pcolor(actual_date3(1:end,2:pontned));%rewrited need
hold on
ylabel(colorbar,'Temperature(^oC)','fontsize',30);
colormap(jet);
set(g1,'LineStyle','none');
% title([titlename],'fontsize',30);
%rewrited needed

xlabel('Time','fontsize',30);
ylabel('Sensor Number','fontsize',30);
view(180,180);
hold on

plot(air_ice_actual(2:pontned),'b','linewidth',2);
hold on
plot(snow_ice(2:pontned),'k','linewidth',2);
hold on
plot(icebottom_actual2(2:pontned)+1,'y','linewidth',2);
hold on
% plot(sex,'g','linewidth',2);
view([0 0 -90])

s2=legend('Data','Up Surface(Actual Time)','Snow-Ice Interface(Developed)','Down Surface(Actual Time Smoothed)','location','SouthWest');

set(s2,'Fontsize',30);
set(gca,'Xtick',timenum);
set(gca,'xticklabel',time,'fontsize',30);
f=getframe(gcf);
ylabel('Deep(m)','fontsize',30);
set(gca,'YTick',sss5); 
set(gca,'YTickLabel',sss6,'fontsize',30);
set(gcf, 'position', get(0,'ScreenSize'));
f=getframe(gcf);
% imwrite(f.cdata,[directory,'/7','.bmp']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure maker
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S4=figure('Color',[1 1 1]);
set(gcf,'outerposition',get(0,'screensize'));
g1=pcolor(actual_date4(1:end,2:pontned));%rewrited need
ylabel(colorbar,'Temperature(^oC)','fontsize',30);
colormap(jet);
set(g1,'LineStyle','none');
% title([titlename],'fontsize',30);
%rewrited needed



view(180,180);
hold on

view([0 0 -90])
plot(air_ice_actual2(2:pontned),'b','linewidth',2);
hold on
plot(snow_ice(2:pontned),'k','linewidth',2);
hold on
plot(icebottom_actual(2:pontned)+1,'y','linewidth',2);

s1=legend('Data','Up Surface(Actual Time Smoothed)','Snow-Ice Interface(Developed)','Down Surface(Actual Time)','location','SouthWest');
set(s1,'Fontsize',30);
set(gca,'Xtick',timenum);
set(gca,'xticklabel',time,'fontsize',30);
f=getframe(gcf);
xlabel('Time','fontsize',30);
ylabel('Deep(m)','fontsize',30);
set(gca,'YTick',sss5); 
set(gca,'YTickLabel',sss6,'fontsize',30);
set(gcf, 'position', get(0,'ScreenSize'));
f=getframe(gcf);
% imwrite(f.cdata,[directory,'/8','.bmp']);


timeD

redata2
% icebottom2=icebottom2-2;

% snowdifference1=2*abs(mean(air_ice2-air_ice_actual))
% snowdifference2=2*abs(mean(air_ice3-air_ice_actual2))
% icedifference1=2*abs(mean(icebottom2-icebottom_actual))
% icedifference2=2*abs(mean(icebottom3-icebottom_actual2))
% run colormaker1
run SIMBA_OPDdata_Calculation_step7
