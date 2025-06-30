img = imread("Picture1.jpg");
gray_img = im2gray(img);
noisy_img = imnoise(gray_img, 'salt & pepper', 0.05); 
se = ones(3,3);
min_filtered_img = ordfilt2(noisy_img, 1, se); 
max_filtered_img = ordfilt2(noisy_img, 9, se); 
figure;
subplot(2,3,1), imshow(gray_img), title('Original Image');
subplot(2,3,2), imshow(noisy_img), title('Salt & Pepper Noisy Image');
subplot(2,3,3), imshow(min_filtered_img), title('Min Filtered Image');
subplot(2,3,4), imshow(max_filtered_img), title('Max Filtered Image');

