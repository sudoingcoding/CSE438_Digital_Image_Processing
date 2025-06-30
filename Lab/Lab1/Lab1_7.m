img3 = imread("Picture3.png");
gray_img3 = im2gray(img3);

num_of_levels = 128;
contrast_img = floor(gray_img3 / (256 / num_of_levels)) * (256 / num_of_levels);

figure;
subplot(1,2,1), imshow(gray_img3), title('Original Image');
subplot(1,2,2), imshow(contrast_img, []), title('Contrast Adjusted Image');
