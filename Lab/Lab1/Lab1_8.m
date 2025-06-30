img4 = imread("Picture4.jpg");
gray_img4 = im2gray(img4);
brightness_increase = 100;
brightened_img = min(gray_img4 + brightness_increase, 255);
figure;
subplot(1,2,1), imshow(gray_img4), title('Original Image (Picture4)');
subplot(1,2,2), imshow(brightened_img, []), title('Brightened Image');