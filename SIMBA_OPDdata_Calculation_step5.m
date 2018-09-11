%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%                step3 results correction              %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%            check up surface daily growth .           %%%%%%%%%
%%%%%%%%        if there is exceeding of Limit snowfall,      %%%%%%%%%
%%%%%%%%         reset the up surfaces searching range,       %%%%%%%%%
%%%%%%%%           and run step2 for up surface again         %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if max(diff(air_ice2))>Limtsnowfall;
    topnum=topnum+1;
    cycle1=cycle1+1 
    close all
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%    record up surface iteration times with cycle1     %%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if cycle1==0
        cycle2=1
    else
        cycle2=cycle1;
    end
    run SIMBA_OPDdata_Calculation_step4_2
    break
end

close all

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
% run colormarker
run SIMBA_OPDdata_Calculation_step6_2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%                     results note                     %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% air_ice2;%air-snow interface position?without smooth?
%%%%%%%% air_ice3;%air-snow interface position?without smooth?
%%%%%%%% snow_ice;%snow-ice interface position?SIMBA developed?
%%%%%%%% snow_icel;%snow-ice interface position?SIMBA developed?
%%%%%%%% icebottom2%sea ice-seawater interface position?without smooth?
%%%%%%%% icebottom3%sea ice-seawater interface position?smooth?
%%%%%%%% silayer%freeboard position?without smooth?
%%%%%%%% silayer1%freeboard position?smooth?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


