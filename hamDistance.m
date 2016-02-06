function hamDist = hamDistance( val1, val2, noOfBits )
%HAMDISTANCE get Ham Distance for 2 values till noOfBits
%   Detailed explanation goes here
    mask = 1;
    hamDist = 0;
    for posItr=1:noOfBits
        pos1 = bitand(mask,val1);
        pos2 = bitand(mask,val2);
        if(pos1 ~= pos2)
            hamDist = hamDist + 1;
        end
        mask = bitshift(mask,1);
    end

end

