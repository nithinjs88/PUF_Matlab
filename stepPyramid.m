clc;
%fclose(ser);
%clearvars
clearvars -except val byte* byte_* rand board*;

disp Starting_Communication
%disp 'Generating random strings'
noOfDevices = 3;
prompt = 'Enter device no(Press 0 to calculate inter chip HD and plot graph) ';
deviceNo = input(prompt);

%Comment from here
% prompt = 'Enter the no of value to be transmitted ';
% val= input(prompt, 's');
% prompt = 'Enter the start value to be transmitted ';
% start= input(prompt);
% 
% prompt = 'Enter the step value to be transmitted ';
% step= input(prompt);
% 
% prompt = 'Enter the max value ';
% max= input(prompt);
% 
% prompt = 'Enter the min value ';
% min= input(prompt);
% 
% 
% rand =strcat(val,{' '});
% %if increase ==1,values will be incremented.
% increase = 1;
%  for i=1:str2num(val)
%      rand = strcat(rand,'0x',dec2hex(start, 3),{' '});
%      if(increase == 1)
%          start = start + step;
%          if(start > max)
%              start = start - 2*step;
%              increase = 0;
%          end
%      else
%          start = start - step;
%          if(start < min)
%              start = start + 2*step;
%              increase = 1;
%          end
%      end
%  end
%  rand=char(rand);
%  display(rand);
%
%byte = zeros(noOfDevices,100);
%Comment till here
if(deviceNo == 0)
    %hamArrayPerc = zeros();
    multFactorPerc = (2*100)/(noOfDevices*(noOfDevices-1)*8);
    noOfValues = str2num(val);
    for valItr=1:noOfValues
        sumForDist = 0;
        for deviceItr1=1:noOfDevices
            for deviceItr2=1:noOfDevices
                if(deviceItr1 < deviceItr2) 
                    dist = hamDistance(byte(deviceItr1,valItr),byte(deviceItr2,valItr),12);
                    display(dist);
                    sumForDist = sumForDist + dist;
                end
            end
        end
        hamArrayPerc(valItr) = sumForDist*multFactorPerc;
    end
    %display(hamArray);
    plot(1:noOfValues,hamArrayPerc(1:noOfValues));
    return;
end

ser=serial('COM4','BAUDRATE',115200);
ser.OutputBufferSize=50096;
ser.InputBufferSize=50096;
fopen(ser);
disp Connection_established
fwrite(ser,rand);

while(ser.BytesAvailable<=0)
end
if(ser.BytesAvailable>0)
    while(fread(ser,1)~=83)%Wait for signal 'S' in UART
    end
    i=1;
    while(1)
        temp=fread(ser,1)-48;%read the first value
        n=0;
        if(temp==69-48)%break if the read end signal 'E' is given
            break;
        end
        if(temp~=(45-48))
             deviceOutput(i)=0;
        end
        while(temp~=(45-48)&&(temp==1||temp==0))%Till '-' appears compute the value
            deviceOutput(i)=deviceOutput(i)*2+temp;
            temp=(fread(ser,1)-48);
            n=n+1;
        end
        if(n==12)%Now all the values 12 binary numbers are read properly
            fprintf('%d - ',deviceOutput(i));%print the number
                temp=fread(ser,1)-48;%read the next value
                if(temp==-48)
                    temp=fread(ser,1)-48;
                end
                byte2(i)=0;
                while(temp~=(45-48)&&(temp==1||temp==0))%Till '-' appears compute the value
                    byte2(i)=byte2(i)*2+temp;
                    temp=(fread(ser,1)-48);
                    n=n+1;
                end
                if(n==24)
                    fprintf('%d - ',byte2(i));%print the number
                end
              
                fprintf('\n');
            i=i+1;
        end
    end    
end
for i=1:str2num(val)
    byte(deviceNo,i) = deviceOutput(i);
end

fclose(ser);
plot(1:length(byte2),byte(1,1:length(byte2)),1:length(byte2),byte(2,1:length(byte2)),1:length(byte2),byte(3,1:length(byte2)),1:length(byte2),byte2),legend('ID:209','ID:217','ID:254','Input');