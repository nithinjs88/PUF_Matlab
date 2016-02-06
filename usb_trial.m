clc;
%fclose(ser);
%return;
clearvars -except byte_* rand board*;
ser=serial('COM7','BAUDRATE',115200);
fclose(ser);
return;
ser.OutputBufferSize=50096;
ser.InputBufferSize=50096;
disp Starting_Communication
% disp 'Generating random strings'
% prompt = 'Enter the no of value to be transmitted ';
% val= input(prompt, 's');
%  rand =strcat(val,{' '});
%  for i=1:str2num(val)
%      rand = strcat(rand,'0x',randsample(' 0123456789abcdef',3,true),{' '});
%  end
%  rand=char(rand);
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
             byte(i)=0;
        end
        while(temp~=(45-48)&&(temp==1||temp==0))%Till '-' appears compute the value
            byte(i)=byte(i)*2+temp;
            temp=(fread(ser,1)-48);
            n=n+1;
        end
        if(n==12)%Now all the values 12 binary numbers are read properly
            fprintf('%d - ',byte(i));%print the number
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
               % while(temp~=(45-48))%read till '-' appears
                %    fprintf('%d',temp);
                 %   temp=(fread(ser,1)-48);
                %end
                fprintf('\n');
            i=i+1;
        end
    end    
end
%plot(byte);
fclose(ser);
plot(1:length(byte2),byte(1:length(byte2)),1:length(byte2),byte2)