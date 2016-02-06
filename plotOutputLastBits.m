function [ ] = plotOutputLastBits( noOfDevices, noOfVal,legendCellArr,output )
%PLOTOUTPUTLASTBITS Summary of this function goes here
%   Detailed explanation goes here

    opLastBits = zeros(noOfDevices,noOfVal);
    prompt = 'Enter no of last bits to check ';
    bitNo= input(prompt);
    power = 2 ^ bitNo;
    for deviceItr1=1:noOfDevices
        for valItr1=1:noOfVal
            opLastBits(deviceItr1,valItr1)=  mod(uint16(output(deviceItr1,valItr1)),power);
        end
    end
    plot(20:noOfVal,opLastBits);
    legend(legendCellArr);
end

