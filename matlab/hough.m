clc;
clear;  
circleParaXYR=[];  
I = imread('C:\Users\dell\Desktop\1\1.jpg');  
[m,n,L] = size(I);  
if L>1  
    I = rgb2gray(I);  
end  
BW = edge(I,'sobel');  

BW = edge(I,'sobel');  

%---------------------------------------------------------------------------------  

%设置参数：  

%检测的圆半径步长为1  

Step_r = 0.5;  

%角度步长0.1，单位为弧度  

Step_angle = 0.1;  

%最小圆半径2  

minr =5;  

%最大圆半径30  

maxr = 20;  

%以thresh*hough_space的最大值为阈值，thresh取0-1之间的数  

thresh = 0.8;  

circleParaXYR=[];  

%---------------------------------------------------------------------------------  

%开始检测  

[Hough_space,Hough_circle_result,Para] = Hough_circle(BW,Step_r,Step_angle,minr,maxr,thresh);  

circleParaXYR=Para;  

axis equal  

figure(2);  

imshow(BW,[]),title('边缘');  

axis equal  

figure(3);  

imshow(Hough_circle_result,[]),title('检测结果');  

axis equal  

figure(4),imshow(I,[]),title('检测出图中的圆')  

hold on;  

%---------------------------------------------------------------------------------  

%以红色线标记出的检测圆心与圆  

plot(circleParaXYR(:,2), circleParaXYR(:,1), 'r+');  

for k = 1 : size(circleParaXYR, 1)  

    t=0:0.01*pi:2*pi;  

    x=cos(t).*circleParaXYR(3,k)+circleParaXYR(2,k);  

    y=sin(t).*circleParaXYR(3,k)+circleParaXYR(1,k);  

    plot(x,y,'r-');  

end  
