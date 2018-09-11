imark=[];
for i=1:pontned
%     test1=deldata0_data(sti:icebottom2(i),i)-deldata0_data(icebottom2(i),i);
    test2=diff(deldata0_data(sti:icebottom2(i),i));
    
    %    test2=diff(test1);
    if max(abs(test2))>6*0.0625
        imark=[imark,i];
    end
end
if isempty(imark)
else
    deldata0_data(:,imark)=nan;
%     run SIMBA_OPDdata_Calculation_step4_2
end
% data1=[air_ice2(1:pontned),snow_ice(1:pontned),icebottom2(1:pontned)];
data1=[air_ice3(1:pontned),snow_ice(1:pontned),icebottom3(1:pontned)];
data2=[air_ice_actual2(1:pontned),snow_ice(1:pontned),icebottom_actual2(1:pontned)];
% data4=[air_ice_actual3(1:pontned),snow_ice(1:pontned),icebottom_actual3(1:pontned)];
date_ned=deldata0_time(1:pontned,:);
data_ned=deldata0_data(:,1:pontned);
data_SIMBA={date_ned,data_ned,data1,data2};
save SIMBA_RESULT.mat data_SIMBA