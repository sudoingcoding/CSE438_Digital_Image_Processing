img = imread("Picture2.jpg");
gray_img = im2gray(img);
noisy_img = imnoise(gray_img, 'gaussian', 0, 0.01);
gaussian_filter = fspecial('gaussian', [3,3], 0.5);
filtered_img = imfilter(noisy_img, gaussian_filter, 'same');
figure;
subplot(1,3,1), imshow(gray_img), title('Original Image');
subplot(1,3,2), imshow(noisy_img), title('Gaussian Noisy Image');
subplot(1,3,3), imshow(filtered_img), title('Gaussian Filtered Image');
