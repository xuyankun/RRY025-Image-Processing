function img_new = filter_large_scratch( img_colour1,img_colour2, n )

% img_colour1 and img_colour2 are both 3-channel

img1R = img_colour1(:,:,1);
img1G = img_colour1(:,:,2);
img1B = img_colour1(:,:,3);

img2R = img_colour2(:,:,1);
img2G = img_colour2(:,:,2);
img2B = img_colour2(:,:,3);

img1R_bin = imbinarize(img1R,0.5);
img1G_bin = imbinarize(img1G,0.5);
img1B_bin = imbinarize(img1B,0.5);

img2R_bin = imbinarize(img2R,0.4);
img2G_bin = imbinarize(img2G,0.5);
img2B_bin = imbinarize(img2B,0.5);

diff = imbinarize(img2R_bin - img1R_bin) ; % we get rid of negatice values
% figure;
% imshow(diff,[])

sbh=-[-1 -1 -2 -1 -1;0 0 0 0 0;0 0 0 0 0;0 0 0 0 0;1 1 2 1 1]; % we set 5*5 firstly
sbh = sbh(:,2:end-1);  % we think 5*3 has better performance
diff_h = filter2(sbh,diff);
diff_h_bin = imbinarize(diff_h); % should be plotted
% figure;
% imshow(diff_h_bin,[])

threshold = 200;
connect_4 = bwlabel(diff_h_bin,4);
num_connect = max(max(connect_4));

imgR_new = expand_img(img1R,n);
for i = 1:num_connect
    if length(find(connect_4==i)) > threshold
        [row,col] = find(connect_4==i);
        for j = 1:length(row)
            imgR_new(row(j)+n-2,col(j)+n) = max(max(imgR_new(row(j) : row(j)+2*n-1 , col(j)+n))) ;
        end
    end
end
imgR_new = imgR_new(1+n:size(img1R,1)+n, 1+n:size(img1R,2)+n);

imgG_new = expand_img(img1G,n);
for i = 1:num_connect
    if length(find(connect_4==i)) > threshold
        [row,col] = find(connect_4==i);
        for j = 1:length(row)
            imgG_new(row(j)+n-2,col(j)+n) = mean(mean(imgG_new(row(j) : row(j)+2*n-1 , col(j)+n))) ;
        end
    end
end
imgG_new = imgG_new(1+n:size(img1G,1)+n, 1+n:size(img1G,2)+n);

imgB_new = expand_img(img1B,n);
for i = 1:num_connect
    if length(find(connect_4==i)) > threshold
        [row,col] = find(connect_4==i);
        for j = 1:length(row)
            imgB_new(row(j)+n-2,col(j)+n) = median(median(imgB_new(row(j) : row(j)+2*n-1 , col(j)+n))) ;
        end
    end
end
imgB_new = imgB_new(1+n:size(img1B,1)+n, 1+n:size(img1B,2)+n);

sbh = -sbh; 
diff_h = (filter2(sbh,diff));
diff_h_bin = imbinarize(diff_h);
connect_4 = bwlabel(diff_h_bin,4);
num_connect = max(max(connect_4));

imgR_new = expand_img(imgR_new ,n);
for i = 1:num_connect
    if length(find(connect_4==i)) > threshold
        [row,col] = find(connect_4==i);
        for j = 1:length(row)
            imgR_new(row(j)+n+2,col(j)+n) = max(max(imgR_new(row(j) : row(j)+2*n-1 , col(j)+n))) ;
        end
    end
end
imgR_new = imgR_new(1+n:size(img1R,1)+n, 1+n:size(img1R,2)+n);

imgG_new = expand_img(imgG_new,n);
for i = 1:num_connect
    if length(find(connect_4==i)) > threshold
        [row,col] = find(connect_4==i);
        for j = 1:length(row)
            imgG_new(row(j)+n+2,col(j)+n) = mean(mean(imgG_new(row(j) : row(j)+2*n-1 , col(j)+n))) ;
        end
    end
end
imgG_new = imgG_new(1+n:size(img1G,1)+n, 1+n:size(img1G,2)+n);

imgB_new = expand_img(imgB_new,n);
for i = 1:num_connect
    if length(find(connect_4==i)) > threshold
        [row,col] = find(connect_4==i);
        for j = 1:length(row)
            imgB_new(row(j)+n+2,col(j)+n) = median(median(imgB_new(row(j) : row(j)+2*n-1 , col(j)+n))) ;
        end
    end
end
imgB_new = imgB_new(1+n:size(img1B,1)+n, 1+n:size(img1B,2)+n);

img_new = cat(3, imgR_new, imgG_new, imgB_new);
end

