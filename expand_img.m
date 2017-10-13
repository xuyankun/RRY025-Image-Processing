function output_img = expand_img( input_img , n)

input_img1 = cat(1, flipud(input_img(1:n,:)),input_img, ...
    flipud(input_img(size(input_img,1)-n+1:end,:)) );

output_img = cat(2, fliplr(input_img1(:,1:n)), input_img1, ...
    fliplr(input_img1(:,size(input_img1,2)-n+1:end)));

end

