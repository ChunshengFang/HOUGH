detector=vision.CascadeObjectDetector('LeftEyeCART');

file_path1 ='C:\Users\dell\Desktop\1\';
img_path_list1 = dir(strcat(file_path1,'*.jpg'));
Len= length(img_path_list1); 
for k=1:Len
input_image= imread([file_path1,num2str(k),'.jpg'],'jpg');
figure();imshow(input_image);title('Ô­Í¼');
gauss_image=imgaussfilt(input_image,1);
eyes=step(detector,gauss_image);
size_eyes = size(eyes);%ÑÛ¾¦µÄ¿ñ
hold on;

end