
clc  
clear all  
I=ones(256,256);  
file_path1 ='C:\Users\dell\Desktop\1\';
img_path_list1 = dir(strcat(file_path1,'*.jpg'));
Len= length(img_path_list1); 
for k=1:Len
input_image= imread([file_path1,num2str(k),'.jpg'],'jpg');
gauss_image=imgaussfilt(input_image,1); 
I=gauss_image
figure(1);  
imshow(I,[]),title('ԭͼ');  
end