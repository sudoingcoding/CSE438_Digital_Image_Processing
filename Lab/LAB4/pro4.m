original_img = imread('Picture3.jpg');
gray_img = im2double(rgb2gray(original_img));

%% 1. Unsharp Masking + Sobel
blurred = imgaussfilt(gray_img, 1);
mask = gray_img - blurred;
unsharp_img = gray_img + mask;
unsharp_sobel = edge(unsharp_img, 'sobel');

%% 2. High Boost Filtering + Sobel
k = 1.5;  % High boost factor (>1)
high_boost_img = gray_img + k * mask;
highboost_sobel = edge(high_boost_img, 'sobel');

%% 3. Laplacian Filtering + Sobel
laplacian_filter = fspecial('laplacian', 0.2);
laplacian_img = imfilter(gray_img, laplacian_filter, 'replicate');
laplacian_sharpened = gray_img - laplacian_img;
laplacian_sobel = edge(laplacian_sharpened, 'sobel');

%% 4. Edge Detection Operators
roberts_edge = edge(gray_img, 'roberts');
sobel_edge = edge(gray_img, 'sobel');
prewitt_edge = edge(gray_img, 'prewitt');
canny_edge = edge(gray_img, 'canny');


figure('Name','Edge Detection & Sharpening Comparison (4x2)', 'NumberTitle','off');

subplot(2,4,1), imshow(gray_img), title('Original Grayscale');
subplot(2,4,2), imshow(unsharp_sobel), title('Unsharp + Sobel');
subplot(2,4,3), imshow(highboost_sobel), title('High Boost + Sobel');
subplot(2,4,4), imshow(laplacian_sobel), title('Laplacian + Sobel');
subplot(2,4,5), imshow(roberts_edge), title('Roberts Edge');
subplot(2,4,6), imshow(sobel_edge), title('Sobel Edge');
subplot(2,4,7), imshow(prewitt_edge), title('Prewitt Edge');
subplot(2,4,8), imshow(canny_edge), title('Canny Edge');
