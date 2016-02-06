clc;
%fclose(ser);
%clearvars
clearvars -except val byte* byte_* rand board* legend* ;

disp Starting_Communication

%Parameters start
noOfDevices = 6;
val = 120;
valStr = int2str(val);
comID = 'COM7';
%Parameters end

prompt = 'Enter devno(0-plot ip vs op,-1 plot inter ham dist,-2 plot last bytes) ';
deviceNo = input(prompt);

%Comment from here to get the values for the first time
valArray = getRampInput(val);
rand =strcat(valStr,{' '});

 for i=1:val
     rand = strcat(rand,'0x',dec2hex(valArray(i), 3),{' '});
 end
 rand=char(rand);
 display(rand);
%Comment till here

if(deviceNo == -1)
    %plot inter hd graph
    plotInterHD( noOfDevices, val, byte);
    return;
elseif(deviceNo == -2)
    %output last bits
    plotOutputLastBits(noOfDevices, val, legendCellArr, byte);
    return;
elseif(deviceNo == 0)
    %plot graph
    for i=1:val
        byte((noOfDevices+1),i) = byte2(i);
    end
    plot(1:val,byte);
    legend(legendInpCellArr);
    return;
elseif(deviceNo > 0)
    prompt = 'Enter dev ID ';
    devID= input(prompt);
    legendCellArr{1,deviceNo} = num2str(devID);
    legendInpCellArr{1,(deviceNo)} = num2str(devID);
end
%Connect to Device
ser=serial(comID,'BAUDRATE',115200);
ser.OutputBufferSize=50096;
ser.InputBufferSize=50096;
fopen(ser);
disp Connection_established
fwrite(ser,rand);

%Get ADC Output
[deviceOutput,byte2]=getADC_DAC(ser);
for i=1:val
    byte(deviceNo,i) = deviceOutput(i);
end
fclose(ser);

%Plot output of current device vs input
plot(1:(val-20),byte(deviceNo,20:val),20:val,byte2(20:val)),legend(legendCellArr{1,deviceNo},'Input');