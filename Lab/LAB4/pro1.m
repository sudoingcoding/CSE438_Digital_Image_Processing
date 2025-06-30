original_img = imread('Picture1.jpg');
original_img = im2double(original_img);

blurred_img = imgaussfilt(original_img, 2);

% a) Unsharp Masking
mask_unsharp = original_img - blurred_img;
unsharp_img = original_img + mask_unsharp;

% b) High Boost Filtering
A = 3;
highboost_img = original_img + A * mask_unsharp;

figure;
subplot(1, 3, 1), imshow(original_img), title('Original Image');
subplot(1, 3, 2), imshow(unsharp_img), title('Unsharp Masking');
subplot(1, 3, 3), imshow(highboost_img), title(['High Boost Filtering (A = ', num2str(A), ')']);
