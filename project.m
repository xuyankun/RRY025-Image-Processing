clear; close; clc; close all

%% preprocess data
img_oringin = im2double(imread('film1_big.jpg'));
img_middle = img_oringin(:,size(img_oringin,2)/3 : 2*size(img_oringin,2)/3,:);
img_right = img_oringin(:,2*size(img_oringin,2)/3 : end,:);
img_left = img_oringin(:,1:size(img_oringin,2)/3,:);
img_middle1 = img_middle(3:size(img_middle)/5-3,4:end-4,:);
img_middle2 = img_middle(size(img_middle)/5+4:2*size(img_middle)/5-2,4:end-4,:);
img_middle3 = img_middle(2*size(img_middle)/5+4:3*size(img_middle)/5-2,4:end-4,:);
img_middle4 = img_middle(3*size(img_middle)/5+4:4*size(img_middle)/5-2,4:end-4,:);
img_middle5 = img_middle(4*size(img_middle)/5+4:end-2,4:end-4,:);
img_middle_cut= cat(1,img_middle1,img_middle2,img_middle3,img_middle4,img_middle5);
imgR = img_middle_cut(:,:,1);
imgG = img_middle_cut(:,:,2);
imgB = img_middle_cut(:,:,3);
figure;imshow(img_middle_cut,[])
%% get time squence img in each layer
imgR_in_time = img_in_time( imgR );
imgG_in_time = img_in_time( imgG );
imgB_in_time = img_in_time( imgB );

%% median filtering
imgR1 = median_filter(imgR_in_time(:,:,1),imgR_in_time(:,:,2),3);
imgG1 = median_filter(imgG_in_time(:,:,1),imgG_in_time(:,:,2),3);
imgB1 = median_filter(imgB_in_time(:,:,1),imgB_in_time(:,:,2),3);

imgR2 = median_filter(imgR_in_time(:,:,2),imgR_in_time(:,:,1),3);
imgG2 = median_filter(imgG_in_time(:,:,2),imgG_in_time(:,:,1),3);
imgB2 = median_filter(imgB_in_time(:,:,2),imgB_in_time(:,:,1),3);

imgR3 = median_filter(imgR_in_time(:,:,3),imgR_in_time(:,:,2),3);
imgG3 = median_filter(imgG_in_time(:,:,3),imgG_in_time(:,:,2),3);
imgB3 = median_filter(imgB_in_time(:,:,3),imgB_in_time(:,:,2),3);

imgR4 = median_filter(imgR_in_time(:,:,4),imgR_in_time(:,:,5),3);
imgG4 = median_filter(imgG_in_time(:,:,4),imgG_in_time(:,:,5),3);
imgB4 = median_filter(imgB_in_time(:,:,4),imgB_in_time(:,:,5),3);

imgR5 = median_filter(imgR_in_time(:,:,5),imgR_in_time(:,:,4),3);
imgG5 = median_filter(imgG_in_time(:,:,5),imgG_in_time(:,:,4),3);
imgB5 = median_filter(imgB_in_time(:,:,5),imgB_in_time(:,:,4),3);

img1 = cat(3,imgR1,imgG1,imgB1);
img2 = cat(3,imgR2,imgG2,imgB2);
img3 = cat(3,imgR3,imgG3,imgB3);
img4 = cat(3,imgR4,imgG4,imgB4);
img5 = cat(3,imgR5,imgG5,imgB5);

img = cat(1,img1,img2,img3,img4,img5);
figure;
imshow(img,[])
%% filter large scratch
img1_new = filter_large_scratch(img1,img2,5);
img2_new = filter_large_scratch(img2,img3,5);
img3_new = filter_large_scratch(img3,img2,5);
img4_new = filter_large_scratch(img4,img5,5);
img5_new = filter_large_scratch(img5,img4,5);

img_middle_new = cat(1,img1_new,img2_new,img3_new,img4_new,img5_new);
figure; imshow(img3_new,[])
%% plot
figure;
subplot(1,3,1);imshow(img_middle_cut,[])
title('Original image');set(gca,'fontsize', 15);
subplot(1,3,2);imshow(img_middle_new,[])
title('Our performence');set(gca,'fontsize', 15);
subplot(1,3,3);imshow(img_right,[])
title('Given perfomance');set(gca,'fontsize', 15);
