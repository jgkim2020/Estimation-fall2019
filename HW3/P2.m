close all; clear all; clc;

rng(0);

numbers = zeros(1000,1);
for i=1:length(numbers)
    numbers(i) = sum(unifrnd(0,1,12,1)) - 6;
end
figure(1);
histfit(numbers, 25);
