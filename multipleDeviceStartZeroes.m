%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%valArray - Input having dimension from 1..val(no of values). Has zeroes at
%start for noOfZeroes
%
%reqdValArray - Input having dimension from 1..reqdValues
%
%inputArr - Input having dimension from 1..reqdValues got as response from
%chip. Ideally it should be equal to reqdValArray
%
%output(1..noOfDevices+1,1..reqdValues) - ith row - corresponds to output device
%and where i=noOfDevices+1 corresponds to input only for reqdValues
%
%legendCellArr(1..noOfDevices)-device id
%legendCellArr(1..noOfDevices+1)-device id if i <=noOfDevices, If
%i=noOfDevices+1 it corr to input.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
fclose(ser);
%clearvars
clearvars -except val byte* byte_* rand board* legend* inputArr* valArray reqdValArray output;

disp Starting_Communication

%Parameters start
noOfDevices = 6;
%Total no of values. Include zeroes at start
val = 120;
%no of Zeroes at start
noOfZeroes = 20;
%no of values we are interested. Starts from noOfZeroes + 1
noOfReqdValues = val - noOfZeroes;
valStr = int2str(val);
comID = 'COM9';
%Parameters end

prompt = 'Enter devno(0-plot ip vs op,-1 plot inter ham dist,-2 plot last bytes,-3 pearson) ';
deviceNo = input(prompt);

%Comment from here to get the values for the first time
% valArray = getSineValuesStartZeroes(val,noOfZeroes);
% for i=1:noOfReqdValues
%    reqdValArray(i) = valArray(i + noOfZeroes);
% end
% rand =strcat(valStr,{' '});
% 
%  for i=1:val
%      rand = strcat(rand,'0x',dec2hex(valArray(i), 3),{' '});
%  end
%  rand=char(rand);
%  display(rand);
%Comment till here
legendInpCellArr{1,(noOfDevices+1)} = 'Input';
if(deviceNo == -1)
    %plot inter hd graph
    plotInterHD( noOfDevices, noOfReqdValues, output);
    return;
elseif(deviceNo == -2)
    %output last bits
    plotOutputLastBits(noOfDevices, noOfReqdValues, legendCellArr, output);
    return;
elseif(deviceNo == -3)
    %pearson
    prompt = 'Enter the first device you need to compare. Use noOfDevices + 1 for Input';
    dev1 = input(prompt);
     prompt = 'Enter the second device you need to compare. Use noOfDevices + 1 for Input';
    dev2 = input(prompt);
    if(dev1 == (noOfDevices+1))
        comp1 = inputArr;
    else
      comp1 = output(dev1,1:noOfReqdValues);
    end
    if(dev2 == (noOfDevices+1))
        comp2 = inputArr;
    else
        comp2 = output(dev2,1:noOfReqdValues);
    end
    %display(comp1);
    %display(comp2);
    pearsInfo = pearsonShift(comp1,comp2,legendInpCellArr{1,(dev1)},legendInpCellArr{1,(dev2)});
    return;
    %plotOutputLastBits(noOfDevices, noOfReqdValues, legendCellArr, output);
elseif(deviceNo == 0)
    %plot graph
    for i=1:noOfReqdValues
        output((noOfDevices+1),i) = inputArr(i);
    end
    plot(1:noOfReqdValues,byte);
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
disp 'Input'
%display(byte2);
%disp 'Output'
display(deviceOutput);
for i=noOfZeroes+1:val
    output(deviceNo,i-noOfZeroes) = deviceOutput(i);
end
for i=noOfZeroes+1:val
    inputArr(i-noOfZeroes) = byte2(i);
end
fclose(ser);

%Plot output of current device vs input
plot(1:noOfReqdValues,output(deviceNo,1:noOfReqdValues),1:noOfReqdValues,inputArr(1:noOfReqdValues)),legend(legendCellArr{1,deviceNo},'Input');