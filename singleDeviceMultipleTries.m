clc;
%fclose(ser);
%clearvars
clearvars -except val byte* byte_* rand board* legend* inputArr* valArray reqdValArray output no* total* entire*;

disp Starting_Communication

%Parameters start
%noOfVals = 100;

%Total no of values in one try. Include zeroes at start
val = 110;
%no of Zeroes at start
noOfZeroes = 20;
%no of values we are interested. Starts from noOfZeroes + 1
noOfReqdValues = val - noOfZeroes;
valStr = int2str(val);

totalNoOfTries = 110;
noOfUnwantedTries = 10;
noOfReqdValues = totalNoOfTries - noOfUnwantedTries;
comID = 'COM8';
%Parameters end

%Comment from here to get the values for the first time
valArray = getSineValuesStartZeroes(val,noOfZeroes);
for i=1:noOfReqdValues
   reqdValArray(i) = valArray(i + noOfZeroes);
end
rand =strcat(valStr,{' '});

 for i=1:val
     rand = strcat(rand,'0x',dec2hex(valArray(i), 3),{' '});
 end
 rand=char(rand);
 display(rand);
%Comment till here

ser=serial(comID,'BAUDRATE',115200);
ser.OutputBufferSize=50096;
ser.InputBufferSize=50096;
fopen(ser);
disp Connection_established
%fwrite(ser,rand);

%Get ADC Output
for i=1:totalNoOfTries
    fwrite(ser,rand);
    [deviceOutput,byte2]=getADC_DAC(ser);
    if i>noOfUnwantedTries
        for j=noOfZeroes+1:val
        entireOp(i-noOfUnwantedTries,j-noOfZeroes) = deviceOutput(j);
        end
        %entireOp(i-noOfUnwantedTries) = deviceOutput;
    end
    disp 'One Try over'
end
%display(byte2);
%disp 'Output'
% display(deviceOutput);
% for i=noOfZeroes+1:val
%     output(deviceNo,i-noOfZeroes) = deviceOutput(i);
% end
% for i=noOfZeroes+1:val
%     inputArr(i-noOfZeroes) = byte2(i);
% end
fclose(ser);