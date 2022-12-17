clc;
clear;  
circleParaXYR=[];  
I = imread('C:\Users\dell\Desktop\1\1.jpg');  
[m,n,L] = size(I);  
if L>1  
    I = rgb2gray(I);  
end  
BW = edge(I,'sobel');  