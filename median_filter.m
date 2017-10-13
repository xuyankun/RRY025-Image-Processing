function img = median_filter( img1, img2, n)

% img1 is image what we want to filter
% img2 is the image between the img1 in the time sequence
% n is integer and >=1 ,  filter size = 2*n+1 * 2*n+1 , e.g. n=1 size = 3*3

diff = img2 - img1;
diff_bin = imbinarize(diff,0.1); % we set 0.1 level to keep more features of difference
% figure;
% imshow(diff,[])

sbh=[1 2 1; 0 0 0; -1 -2 -1];
sbv=[1 0 -1; 2 0 -2; 1 0 -1];

diff_v = filter2(sbv,diff_bin); 
diff_v_bin = imbinarize(diff_v);

diff_h = filter2(sbh,diff_bin);
diff_h_bin = imbinarize(diff_h,0.5);

% figure;
% subplot(1,2,1); imshow(diff_v_bin)
% subplot(1,2,2); imshow(diff_h_bin)

connect_4_v = bwlabel(diff_v_bin ,4);
num_connect = max(max(connect_4_v));

img = expand_img(img1,n);
for i = 1:num_connect
    if length(find(connect_4_v==i)) > 20 
        [row,col] = find(connect_4_v==i);
        for j = 1:length(row)
            img(row(j)+n,col(j)+n-1) = median(img(row(j)+n,col(j) : col(j)+2*n-1));
        end
    end
end

connect_4_h = bwlabel(diff_h_bin,4);
num_connect = max(max(connect_4_h));

for i = 1:num_connect
    if length(find(connect_4_h==i)) > 20
        [row,col] = find(connect_4_h==i);
        for j = 1:length(row)
            img(row(j)+n-1,col(j)+n) = median(img(row(j) : row(j)+2*n-1, col(j)+n)); 
        end
    end
end

img = img(1+n:size(img1,1)+n, 1+n:size(img1,2)+n);


end

