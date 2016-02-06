function [ inp ] = getRampInput( noOfVal )
%GETSINEVALUES Summary of this function goes here
%   Detailed explanation goes here
prompt = 'Enter the start value to be transmitted ';
start= input(prompt);

prompt = 'Enter the step value to be transmitted ';
step= input(prompt);

inp = zeros(noOfVal);
%increase = 1;
for i=1:noOfVal
     % rand = strcat(rand,'0x',dec2hex(start, 3),{' '});
    inp(i) = start;
    start = start + step;
end
% rand=char(rand);
% display(rand);
end

