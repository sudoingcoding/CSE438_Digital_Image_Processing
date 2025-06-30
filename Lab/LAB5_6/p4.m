clc; clear; close all;
% Load Images
img1 = imread('Picture5.png'); 
img2 = imread('Picture6.png'); 
img3 = imread('Picture7.png'); 
% Convert to grayscale
gray_img1 = im2gray(img1);
gray_img2 = im2gray(img2);
gray_img3 = im2gray(img3);
% Apply Discrete Cosine Transform (DCT)
DCT1 = dct2(double(gray_img1));
DCT2 = dct2(double(gray_img2));
DCT3 = dct2(double(gray_img3));
% Keep only a percentage of coefficients for compression
threshold = 20; % Adjust threshold for better compression
compressed_DCT1 = DCT1 .* (abs(DCT1) > threshold); 
compressed_DCT2 = DCT2 .* (abs(DCT2) > threshold);
compressed_DCT3 = DCT3 .* (abs(DCT3) > threshold);
% Apply Inverse DCT
reconstructed_DCT1 = uint8(idct2(compressed_DCT1));
reconstructed_DCT2 = uint8(idct2(compressed_DCT2));
reconstructed_DCT3 = uint8(idct2(compressed_DCT3));
% Resize to match original dimensions (to avoid PSNR errors)
reconstructed_DCT1 = imresize(reconstructed_DCT1, size(gray_img1));
reconstructed_DCT2 = imresize(reconstructed_DCT2, size(gray_img2));
reconstructed_DCT3 = imresize(reconstructed_DCT3, size(gray_img3));
% Apply Haar Transform
[H1, L1, H12, H21] = dwt2(double(gray_img1),'haar');
[H2, L2, H22, H23] = dwt2(double(gray_img2),'haar');
[H3, L3, H32, H33] = dwt2(double(gray_img3),'haar');
% Keep a percentage of coefficients
compressed_H1 = H1 .* (abs(H1) > threshold);  
compressed_H2 = H2 .* (abs(H2) > threshold);  
compressed_H3 = H3 .* (abs(H3) > threshold);  
% Apply Inverse Haar Transform
reconstructed_H1 = uint8(idwt2(compressed_H1, L1, H12, H21,'haar'));
reconstructed_H2 = uint8(idwt2(compressed_H2, L2, H22, H23,'haar'));
reconstructed_H3 = uint8(idwt2(compressed_H3, L3, H32, H33,'haar'));
% Resize to match original dimensions
reconstructed_H1 = imresize(reconstructed_H1, size(gray_img1));
reconstructed_H2 = imresize(reconstructed_H2, size(gray_img2));
reconstructed_H3 = imresize(reconstructed_H3, size(gray_img3));
% Apply DCT-Haar Hybrid Compression
DCT_H1 = dct2(H1);
DCT_H2 = dct2(H2);
DCT_H3 = dct2(H3);
compressed_DCT_H1 = DCT_H1 .* (abs(DCT_H1) > threshold);
compressed_DCT_H2 = DCT_H2 .* (abs(DCT_H2) > threshold);
compressed_DCT_H3 = DCT_H3 .* (abs(DCT_H3) > threshold);
% Apply Inverse DCT-Haar
reconstructed_DCT_H1 = uint8(idct2(compressed_DCT_H1));
reconstructed_DCT_H2 = uint8(idct2(compressed_DCT_H2));
reconstructed_DCT_H3 = uint8(idct2(compressed_DCT_H3));
% Resize to match original dimensions
reconstructed_DCT_H1 = imresize(reconstructed_DCT_H1, size(gray_img1));
reconstructed_DCT_H2 = imresize(reconstructed_DCT_H2, size(gray_img2));
reconstructed_DCT_H3 = imresize(reconstructed_DCT_H3, size(gray_img3));
% Compute Compression Ratio & PSNR
compression_ratio_DCT = nnz(compressed_DCT1) / numel(DCT1);
compression_ratio_Haar = nnz(compressed_H1) / numel(H1);
compression_ratio_DCT_Haar = nnz(compressed_DCT_H1) / numel(DCT_H1);
psnr_DCT = psnr(reconstructed_DCT1, gray_img1);
psnr_Haar = psnr(reconstructed_H1, gray_img1);
psnr_DCT_Haar = psnr(reconstructed_DCT_H1, gray_img1);
% Display Results
fprintf('Compression Ratio - DCT: %.2f\n', compression_ratio_DCT);
fprintf('Compression Ratio - Haar: %.2f\n', compression_ratio_Haar);
fprintf('Compression Ratio - DCT-Haar: %.2f\n', compression_ratio_DCT_Haar);
fprintf('PSNR - DCT: %.2f dB\n', psnr_DCT);
fprintf('PSNR - Haar: %.2f dB\n', psnr_Haar);
fprintf('PSNR - DCT-Haar: %.2f dB\n', psnr_DCT_Haar);
figure('Name', 'Compression Comparison');
sgtitle('Compression Results for Three Images');
% First image results
subplot(3,4,1), imshow(gray_img1, []), title('Original Image - 1');
subplot(3,4,2), imshow(reconstructed_DCT1, []), title('DCT Compressed - 1');
subplot(3,4,3), imshow(reconstructed_H1, []), title('Haar Compressed - 1');
subplot(3,4,4), imshow(reconstructed_DCT_H1, []), title('DCT-Haar Compressed - 1');
% Second image results
subplot(3,4,5), imshow(gray_img2, []), title('Original Image - 2');
subplot(3,4,6), imshow(reconstructed_DCT2, []), title('DCT Compressed - 2');
subplot(3,4,7), imshow(reconstructed_H2, []), title('Haar Compressed - 2');
subplot(3,4,8), imshow(reconstructed_DCT_H2, []), title('DCT-Haar Compressed - 2');
% Third image results
subplot(3,4,9), imshow(gray_img3, []), title('Original Image - 3');
subplot(3,4,10), imshow(reconstructed_DCT3, []), title('DCT Compressed - 3');
subplot(3,4,11), imshow(reconstructed_H3, []), title('Haar Compressed - 3');
subplot(3,4,12), imshow(reconstructed_DCT_H3, []), title('DCT-Haar Compressed - 3');