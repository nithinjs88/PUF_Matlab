function [ ] = plotOutputLastBitsSingleDevSingleTry(input1, output1, noOfVal )
%PLOTOUTPUTLASTBITS Summary of this function goes here
%   Detailed explanation goes here

    opLastBits = zeros(noOfVal);
    ipLastBits = zeros(noOfVal);
    prompt2 = 'Enter no of last bits to check ';
    bitNo= input(prompt2);
    power = 2 ^ bitNo;

    for valItr1=1:noOfVal
        ipLastBits(valItr1)=  mod(uint16(input1(valItr1)),power);
        opLastBits(valItr1)=  mod(uint16(output1(valItr1)),power);
    end
    plot(1:noOfVal,ipLastBits(1:noOfVal),1:noOfVal,opLastBits(1:noOfVal));
    %
    %xlabelStr = strcat('Challenge last ',num2str(bitNo), ' bits');
    %xlabel(xlabelStr);
    %ylabelStr = strcat('Output last ',num2str(bitNo), ' bits');
    %ylabel(ylabelStr);
    legend('Challenge','Output');
end
