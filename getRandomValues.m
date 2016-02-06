function [ inp ] = getRandomValues( noOfVal )
%GETSINEVALUES Summary of this function goes here
%   Detailed explanation goes here
%inp = zeros(noOfVal);
inp = randi([0,4095],1,noOfVal);
%increase = 1;
% for i=1:noOfVal
%      % rand = strcat(rand,'0x',dec2hex(start, 3),{' '});
%     inp(i) = start;
%     start = start + step;
% end
% rand=char(rand);
% display(rand);
end

