function [ shift1Arr,shift2Arr ] = getShifted( shift, dev1Output, dev2Output )
%GETSHIFTED Summary of this function goes here
%   Detailed explanation goes here
    display(shift);
    absVal = abs(shift);
    [row,sizeOfOrg] = size(dev1Output);
    lengthOfShiftedArr = sizeOfOrg - absVal;
    display(lengthOfShiftedArr);
    if(shift > 0)
        itrArr1 = absVal;
        itrArr2 = 0;
        %right shift
        %for(i:1:)
    elseif(shift < 0)
         %left shift 
         itrArr1 = 0;
         itrArr2 = absVal;
    end
    for i=1:lengthOfShiftedArr
        shift1Arr(i) = dev1Output(itrArr1 + i);
        shift2Arr(i) = dev2Output(itrArr2 + i);
    end
end

