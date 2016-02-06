function [ inp ] = getSineValues( noOfVal )
%GETSINEVALUES Summary of this function goes here
%   Detailed explanation goes here
prompt = 'Enter the start value to be transmitted ';
start= input(prompt);

prompt = 'Enter the step value to be transmitted ';
step= input(prompt);

prompt = 'Enter the max sine value ';
max= input(prompt);

prompt = 'Enter the min sine value ';
min= input(prompt);

inp = zeros(noOfVal);
for i=1:noOfVal
     sineVal = sin(start);
     %display(sineVal);
     incRatio = ((max - min)/(2));
     %display(incRatio);
     finalVal = min + incRatio*(sineVal + 1);
     %display(finalVal);
     finalInt = cast(finalVal,'int16');
     inp(i) = finalInt;
     %rand = strcat(rand,'0x',dec2hex(finalInt, 3),{' '});
     start = start + step;
 end
% rand=char(rand);
% display(rand);
end

