original_img = imread('Picture2.jpg');
gray_img = im2double(rgb2gray(original_img));

laplacian_filter = fspecial('laplacian', 0.9);

laplacian_img = imfilter(gray_img, laplacian_filter, 'replicate');

sharpened_img = gray_img - laplacian_img;

figure;
subplot(1, 2, 1), imshow(gray_img), title('Original Grayscale Image');
subplot(1, 2, 2), imshow(sharpened_img), title('Sharpened Image with Laplacian');
