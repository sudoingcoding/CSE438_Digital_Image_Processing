img = imread("Picture3.jpg");
gray_img = im2gray(img);
noisy_img = imnoise(gray_img, 'gaussian', 0, 0.02); 
box_filter = fspecial('average', [3,3]);
box_filtered_img = imfilter(noisy_img, box_filter, 'same');
average_filter = fspecial('average', [5,5]);
average_filtered_img = imfilter(noisy_img, average_filter, 'same');
median_filtered_img = medfilt2(noisy_img, [3,3]);
figure;
subplot(2,3,1), imshow(gray_img), title('Original Image');
subplot(2,3,2), imshow(noisy_img), title('Noisy Image (Gaussian)');
subplot(2,3,3), imshow(box_filtered_img), title('Box Filtered Image');
subplot(2,3,4), imshow(average_filtered_img), title('Average Filtered Image');
subplot(2,3,5), imshow(median_filtered_img), title('Median Filtered Image');

