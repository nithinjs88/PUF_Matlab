function [ inp ] = getPyramidValuesStartZeroes( noOfVal, noOfZeroes )
%GETSINEVALUES Summary of this function goes here
%noOfVal - number of values including zeroes
%noOfZeroes - no of zeroes at start
%Detailed explanation goes here
prompt = 'Enter the start value to be transmitted ';
start= input(prompt);

prompt = 'Enter the step value to be transmitted ';
step= input(prompt);

prompt = 'Enter the max value ';
max= input(prompt);

prompt = 'Enter the min value ';
min= input(prompt);

inp = zeros(noOfVal);
%if increase ==1,values will be incremented.
increase = 1;
for i=1:noOfZeroes
    inp(i) = 0;
end
for i=(noOfZeroes+1):noOfVal
     inp(i) = start;
     if(increase == 1)
         start = start + step;
         if(start > max)
             start = start - 2*step;
             increase = 0;
         end
     else
         start = start - step;
         if(start < min)
             start = start + 2*step;
             increase = 1;
         end
     end
 end

