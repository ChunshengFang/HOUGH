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

%���ò�����  

%����Բ�뾶����Ϊ1  

Step_r = 0.5;  

%�ǶȲ���0.1����λΪ����  

Step_angle = 0.1;  

%��СԲ�뾶2  

minr =5;  

%���Բ�뾶30  

maxr = 20;  

%��thresh*hough_space�����ֵΪ��ֵ��threshȡ0-1֮�����  

thresh = 0.8;  

circleParaXYR=[];  

%---------------------------------------------------------------------------------  

%��ʼ���  

[Hough_space,Hough_circle_result,Para] = Hough_circle(BW,Step_r,Step_angle,minr,maxr,thresh);  

circleParaXYR=Para;  

axis equal  

figure(2);  

imshow(BW,[]),title('��Ե');  

axis equal  

figure(3);  

imshow(Hough_circle_result,[]),title('�����');  

axis equal  

figure(4),imshow(I,[]),title('����ͼ�е�Բ')  

hold on;  

%---------------------------------------------------------------------------------  

%�Ժ�ɫ�߱�ǳ��ļ��Բ����Բ  

plot(circleParaXYR(:,2), circleParaXYR(:,1), 'r+');  

for k = 1 : size(circleParaXYR, 1)  

    t=0:0.01*pi:2*pi;  

    x=cos(t).*circleParaXYR(3,k)+circleParaXYR(2,k);  

    y=sin(t).*circleParaXYR(3,k)+circleParaXYR(1,k);  

    plot(x,y,'r-');  

end  
