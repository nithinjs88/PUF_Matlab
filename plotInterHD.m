function [ ] = plotInterHD( noOfDevices, noOfVal, output )
%PLOTINTERHD Summary of this function goes here
%   Detailed explanation goes here

    prompt = 'Enter no of last bits to check ';
    bitNo= input(prompt);
    %hamArrayPerc = zeros(noOfVal);
    %sumOfInterHD = 0.0;
    %sumOfInterHDSquare = 0.0;
    multFactorPerc = (2*100)/(noOfDevices*(noOfDevices-1)*bitNo);
    for valItr=1:noOfVal
        sumForDist = 0;
        for deviceItr1=1:noOfDevices
            for deviceItr2=1:noOfDevices
                if(deviceItr1 < deviceItr2) 
                    dist = hamDistance(output(deviceItr1,valItr),output(deviceItr2,valItr),bitNo);
                    %display(dist);
                    sumForDist = sumForDist + dist;
                end
            end
        end
        hamDist = sumForDist*multFactorPerc;
        hamArrayPerc(valItr) = hamDist;
        %sumOfInterHD = sumOfInterHD + hamDist;
        %sumOfInterHDSquare = sumOfInterHDSquare + hamDist*hamDist;
    end
    %meanInterHD = sumOfInterHD/noOfVal;
    %meanInterHDSquare = sumOfInterHDSquare/noOfVal;
    %var = meanInterHDSquare - meanInterHD*meanInterHD;
    %sd = sqrt(var);
    meanInterHD = mean(hamArrayPerc);
    %display(meanInterHD);
    sd = std(hamArrayPerc);
    %display(sd);
    titleStr = 'InterHD last bits: ';
    bitNoStr = num2str(bitNo);
    sdStr = num2str(sd);
    meanStr = num2str(meanInterHD);
    %varStr = num2str(var);
    %display(hamArray);
    titleStr2 = strcat(titleStr,bitNoStr,',Mean ',meanStr,',Standard Devn ',sdStr);
    plot(1:noOfVal,hamArrayPerc(1:noOfVal));
    title(titleStr2);
end

