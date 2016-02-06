function [ inp ] = getPyramidValues( noOfVal )
%GETSINEVALUES Summary of this function goes here
%   Detailed explanation goes here
prompt = 'Enter the start value to be transmitted ';
start= input(prompt);

prompt = 'Enter the step value to be transmitted ';
step= input(prompt);

prompt = 'Enter the max value ';
max= input(prompt);

prompt = 'Enter the min value ';
min= input(prompt);

%inp = zeros(noOfVal);
increase = 1;
for i=1:noOfVal
     % rand = strcat(rand,'0x',dec2hex(start, 3),{' '});
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
% rand=char(rand);
% display(rand);
end

