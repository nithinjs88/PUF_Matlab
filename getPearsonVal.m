function [ pearson ] = getPearsonVal( arr1, arr2 )
%GETPEARSONVAL Summary of this function goes here
%   Detailed explanation goes here
    covarArr = cov(arr1,arr2);
    covar = covarArr(2);
    pearson = covar/(std(arr1)*std(arr2));
end

