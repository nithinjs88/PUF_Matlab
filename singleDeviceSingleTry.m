clc;
%fclose(ser);
%clearvars
clearvars -except inp val byte* byte_* rand board* legend* inputArr* valArray reqdValArray output no* total* entire*;

disp Starting_Communication

noOfVal = 100;
comID = 'COM6';
inp = zeros(noOfVal);
inp = getRandomValues(noOfVal);
valStr = int2str(noOfVal);
rand =strcat(valStr,{' '});

 for i=1:noOfVal
     rand = strcat(rand,'0x',dec2hex(inp(i), 3),{' '});
 end
rand=char(rand);

prompt = 'Enter devno(0-plot ip vs op,-1 plot last bytes) ';
deviceNo = input(prompt);
if(deviceNo == -1)
    plotOutputLastBitsSingleDevSingleTry(inp,output,noOfVal);
    return;
elseif(deviceNo == 0)
    
    %Connect to Device
ser=serial(comID,'BAUDRATE',115200);
ser.OutputBufferSize=50096;
ser.InputBufferSize=50096;
fopen(ser);
disp Connection_established
fwrite(ser,rand);

%Get ADC Output
[output,byte2]=getADC_DAC(ser);
fclose(ser);

plot(1:noOfVal,inp(1:noOfVal),1:noOfVal,output(1:noOfVal));
%str=['Input';'Output'];
%str(2) = 'Output';
legend('Input','Output');
title('Input Vs Ouput');
end
