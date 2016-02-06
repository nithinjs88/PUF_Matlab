function [ devOut, devInp ] = getADC_DAC( ser )
%GETADC_DAC Summary of this function goes here
%   Detailed explanation goes here
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
             devOut(i)=0;
        end
        while(temp~=(45-48)&&(temp==1||temp==0))%Till '-' appears compute the value
            devOut(i)=devOut(i)*2+temp;
            temp=(fread(ser,1)-48);
            n=n+1;
        end
        if(n==12)%Now all the values 12 binary numbers are read properly
            fprintf('%d - ',devOut(i));%print the number
                temp=fread(ser,1)-48;%read the next value
                if(temp==-48)
                    temp=fread(ser,1)-48;
                end
                devInp(i)=0;
                while(temp~=(45-48)&&(temp==1||temp==0))%Till '-' appears compute the value
                    devInp(i)=devInp(i)*2+temp;
                    temp=(fread(ser,1)-48);
                    n=n+1;
                end
                if(n==24)
                    fprintf('%d - ',devInp(i));%print the number
                end
              
                fprintf('\n');
            i=i+1;
        end
    end    
end

end

