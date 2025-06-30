
img1 = imread('Picture1.png'); 
img2 = imread('Picture2.png');

gray_img1 = im2gray(img1);
gray_img2 = im2gray(img2);



figure;
subplot(3,4,1); imshow(img1); title('Original Image 1');
subplot(3,4,2); imshow(img2); title('Original Image 2');



bw_local1 = gray_img1 > 120;
bw_local2 = gray_img2 > 120;
subplot(3,4,3); imshow(bw_local1); title('Local Thresholding 1');
subplot(3,4,4); imshow(bw_local2); title('Local Thresholding 2');


level1 = graythresh(gray_img1);
level2 = graythresh(gray_img2);
bw_global1 = imbinarize(gray_img1, level1);
bw_global2 = imbinarize(gray_img2, level2);
subplot(3,4,5); imshow(bw_global1); title('Global Thresholding 1');
subplot(3,4,6); imshow(bw_global2); title('Global Thresholding 2');


adaptive_thresh1 = adaptthresh(gray_img1, 0.5);
adaptive_thresh2 = adaptthresh(gray_img2, 0.5);
bw_variable1 = imbinarize(gray_img1, adaptive_thresh1);
bw_variable2 = imbinarize(gray_img2, adaptive_thresh2);
subplot(3,4,7); imshow(bw_variable1); title('Variable Thresholding 1');
subplot(3,4,8); imshow(bw_variable2); title('Variable Thresholding 2');


bw_dynamic1 = imbinarize(gray_img1, adaptthresh(gray_img1));
bw_dynamic2 = imbinarize(gray_img2, adaptthresh(gray_img2));
subplot(3,4,9); imshow(bw_dynamic1); title('Dynamic Thresholding 1');
subplot(3,4,10); imshow(bw_dynamic2); title('Dynamic Thresholding 2');



edges_sobel1 = edge(gray_img1, 'sobel');
edges_sobel2 = edge(gray_img2, 'sobel');
subplot(3,4,11); imshow(edges_sobel1); title('Sobel Edge Detection 1');
subplot(3,4,12); imshow(edges_sobel2); title('Sobel Edge Detection 2');

figure;


edges_canny1 = edge(gray_img1, 'canny');
edges_canny2 = edge(gray_img2, 'canny');
subplot(2,3,1); imshow(edges_canny1); title('Canny Edge Detection 1');
subplot(2,3,2); imshow(edges_canny2); title('Canny Edge Detection 2');


edges_prewitt1 = edge(gray_img1, 'prewitt');
edges_prewitt2 = edge(gray_img2, 'prewitt');
subplot(2,3,3); imshow(edges_prewitt1); title('Prewitt Edge Detection 1');
subplot(2,3,4); imshow(edges_prewitt2); title('Prewitt Edge Detection 2');


tumor_outline1 = bwperim(bw_dynamic1);
tumor_outline2 = bwperim(bw_dynamic2);

overlay1 = imoverlay(gray_img1, tumor_outline1, [1 0 0]); % Red outline
overlay2 = imoverlay(gray_img2, tumor_outline2, [1 0 0]); % Red outline
subplot(2,3,5); imshow(overlay1); title('Tumor Outline 1');
subplot(2,3,6); imshow(overlay2); title('Tumor Outline 2');

disp('Tumor detection and segmentation complete!');
