
img = imread('Picture3.jpg'); 

gray_img = im2gray(img);


binary_mask = imbinarize(gray_img, adaptthresh(gray_img));


figure;
subplot(1,3,1); imshow(img); title('Original Image');
subplot(1,3,2); imshow(binary_mask); title('Binary Mask');


se = strel('disk', 5);


dilated_mask = imdilate(binary_mask, se);
subplot(1,3,3); imshow(dilated_mask); title('Dilated Mask');

figure;

eroded_mask = imerode(binary_mask, se);
subplot(1,2,1); imshow(dilated_mask); title('After Dilation');
subplot(1,2,2); imshow(eroded_mask); title('After Erosion');

disp('Binary mask and morphological processing completed!');
