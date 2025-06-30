img = imread("Picture6.png");
gray_img = im2gray(img);
negative_img = 255 - gray_img;
figure;
subplot(1,2,1), imshow(gray_img), title('Original Grayscale Image');
subplot(1,2,2), imshow(negative_img), title('Digital Negative Image');
