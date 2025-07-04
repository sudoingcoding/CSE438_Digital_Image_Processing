img = imread("Picture3.png");
gray_img = rgb2gray(img);
normalized_image = double(gray_img) / 255;
c = 1; 
gamma = 2;
log_transformed_image = c * log(1 + normalized_image);
gamma_transformed_image = c * (normalized_image .^ gamma);
figure;
subplot(1, 3, 1);
imshow(gray_img);
title('Original GrayScale Image');
subplot(1, 3, 2);
imshow(log_transformed_image, []);
title('Logarithmic Transformation');
subplot(1, 3, 3);
imshow(gamma_transformed_image, []);
title('Power-Law Transformation');
