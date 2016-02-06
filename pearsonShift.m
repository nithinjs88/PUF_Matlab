%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%dev2Output - will stay constant
%dev1Output - will be shifted. left - means dev1Output will occur left to
%dev2Output, right means dev1Output will occur right to dev2Output
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [pearsInfo] = pearsonShift( dev1Output, dev2Output ,str1,str2)
prompt = 'Enter max shift to left';
leftShift = input(prompt);
%leftShift = str2num(leftShiftStr);
prompt = 'Enter max shift to right';
%rightShiftStr = input(prompt);
rightShift = input(prompt);

size = leftShift + 1 + rightShift;

itr = 1;
for i=leftShift:-1:1
    [shift1Out,shift2Out] = getShifted(-i,dev1Output,dev2Output);
    pears = getPearsonVal(shift1Out,shift2Out);
    pearsInfo(itr,1) = -i;
    pearsInfo(itr,2) = pears;
    itr = itr+1;
end
pears = getPearsonVal(dev1Output,dev2Output);
pearsInfo(itr,1) = 0;
pearsInfo(itr,2) = pears;
itr = itr+1;
for i=1:rightShift
    [shift1Out,shift2Out] = getShifted(i,dev1Output,dev2Output);
    pears = getPearsonVal(shift1Out,shift2Out);
    pearsInfo(itr,1) = i;
    pearsInfo(itr,2) = pears;
    itr = itr + 1;
end
%PEARSONSHIFT Summary of this function goes here
%   Detailed explanation goes here
str1 = strcat('Shifts of ',str1, ' vs ', str2);
plot(pearsInfo(1:size,1),pearsInfo(1:size,2));
title(str1);
end

