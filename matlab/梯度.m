
detector=vision.CascadeObjectDetector('LeftEyeCART');

file_path1 ='C:\Users\dell\Desktop\1\';
img_path_list1 = dir(strcat(file_path1,'*.jpg'));
Len= length(img_path_list1); 
for k=1:Len
input_image= imread([file_path1,num2str(k),'.jpg'],'jpg');
figure();imshow(input_image);title('原图');
gauss_image=imgaussfilt(input_image,1);
eyes=step(detector,gauss_image);
size_eyes = size(eyes);%眼睛的狂
hold on;
for i =1:size_eyes(1);2
   eyes_final=eyes(i,1:2);%x,y
    image = imcrop(gauss_image,eyes(i,:));
    rectangle('Position',eyes(i,:),'edgeColor','b');
    image = rgb2gray(image);
    image = im2double(image);
    [grad_x,grad_y] = gradient(image);%计算梯度  
    g = grad_x.*grad_x + grad_y.*grad_y;
    g = sqrt(g);%眼睛区域的梯度图
    std_g = std(g(:));%计算标准差
    mean_g = mean(g(:));%计算平均值
    %其实这一步取得是< mean_g - 0.5*std_g和> mean_g + 0.5*std_g部分
    g_1 = g;
    g_1(g_1 < mean_g + 0.5*std_g) = 0;%梯度图中小于均值+0.5*标准差的设置为0   
    g_2 = g;
    g_2(g_2 > mean_g - 0.5*std_g) = 0;%梯度图中大于均值-0.5标准差的设置为0
    g = g_1 + g_2;
    temp_g = g;
    w = 1-image;
    temp_g(temp_g ~= 0) = 1;%将不等于0的设置为1 这该图只有0和1两个值
    grad_x = grad_x.*temp_g;%与梯度相成
    grad_y = grad_y.*temp_g;
    size_img = size(image);
    Dx = repmat(1:size_img(2),size_img(1),1);%每一行都是1-44
    Dy = repmat(transpose(1:size_img(1)),1,size_img(2));%转置
    C_max = 0;
    X = 0;
    Y = 0;
    %为了得出眼睛的中心位置
    for x = 1:size_img(2)
        for y = 1:size_img(1)
            D_x = Dx - x;
            D_y = Dy - y;   
            D_t = D_x.*D_x + D_y.*D_y;
            E = sqrt(D_t);
            D_x = D_x./E;
            D_y = D_y./E;         
            C_x = D_x.*grad_x;
            C_y = D_y.*grad_y;              
            C = w(y,x)*(C_x + C_y);
            C(C < 0) = 0;
            ind = find(isnan(C));
            C(ind)=0;
            % C(isNaN(C)) = 0;           
            total_C = sum(sum(C));            
            if(total_C > C_max)
                C_max = total_C;
                X = x;
                Y = y;
            end          
        end
    end
    plot(X+eyes_final(1),Y+eyes_final(2),'r+','MarkerSize',10);
    p(i,1)=X+eyes_final(1);
    p(i,2)=Y+eyes_final(2);
end
end
