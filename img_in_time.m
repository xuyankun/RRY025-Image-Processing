function img_t = img_in_time( img )
% separate whole frame into 5 frames in time sequence
t = 5;
row = size(img,1)/t;

img_1 = img(1:row,:);
img_2 = img(1+row:row*2,:);
img_3 = img(1+row*2:row*3,:);
img_4 = img(1+row*3:row*4,:);
img_5 = img(1+row*4:row*5,:);

img_t = cat(3, img_1, img_2, img_3, img_4, img_5);
end

