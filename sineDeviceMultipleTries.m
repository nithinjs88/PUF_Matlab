clc;
pause('on');
%fclose(ser);
%clearvars
clearvars -except val byte* byte_* rand board* legend* dev*;

disp Starting_Communication

%Parameters start
noOfTries = 6;
val = 100;
valStr = int2str(val);
comID = 'COM6';
%Parameters end

prompt = 'Enter devno(0-plot ip vs op,-2 plot last bytes) ';
deviceNo = input(prompt);

%Comment from here to get the values for the first time
% valArray = getSineValues(val);
% rand =strcat(valStr,{' '});
% 
%  for i=1:val
%      rand = strcat(rand,'0x',dec2hex(valArray(i), 3),{' '});
%  end
%  rand=char(rand);
%  display(rand);
%Comment till here

if(deviceNo == -1)
    %plot inter hd graph
    plotInterHD( noOfTries, val, byte);
    return;
elseif(deviceNo == -2)
    %output last bits
    plotOutputLastBits(noOfTries, val, legendCellArr, byte);
    return;
elseif(deviceNo == 0)
    %plot graph
    for i=1:val
        byte((noOfTries+1),i) = byte2(i);
    end
    plot(1:val,byte);
    legend(legendInpCellArr);
    titleStr = strcat('Temp Graph for Device ID:',num2str(devID));
    title(titleStr);
    return;
elseif(deviceNo > 0)
%     prompt = 'Enter dev ID ';
%     devID= input(prompt);
%     legendCellArr{1,deviceNo} = num2str(devID);
%     legendInpCellArr{1,(deviceNo)} = num2str(devID);
%end
%Connect to Device
    prompt = 'Enter dev ID ';
    devID= input(prompt);
    for tryItr=1:noOfTries
        pause(1);
        tryStr = strcat('Try ',num2str(tryItr));
        legendCellArr{1,tryItr} = tryStr;
        legendInpCellArr{1,(tryItr)} = tryStr;
        ser=serial(comID,'BAUDRATE',115200);
        ser.OutputBufferSize=50096;
        ser.InputBufferSize=50096;
        fopen(ser);
        disp Connection_established
        fwrite(ser,rand);

        %Get ADC Output
        [deviceOutput,byte2]=getADC_DAC(ser);
        for i=1:val
            byte(tryItr,i) = deviceOutput(i);
        end
        fclose(ser);

        %Plot output of current device vs input
        plot(1:val,byte(tryItr,1:val),1:val,byte2),legend(legendCellArr{1,tryItr},'Input');
    end
end