img1 = imread("Picture1.png");
img2 = imread("Picture2.png");

img2 = imresize(img2, size(img1(:,:,1)));

gray_img1 = rgb2gray(img1);
gray_img2 = rgb2gray(img2);

img_add = imadd(gray_img1, gray_img2);
img_subtract = imsubtract(gray_img1, gray_img2);
img_multiply = immultiply(gray_img1, gray_img2);
img_divide = imdivide(gray_img1, gray_img2);

figure;
subplot(2,2,1), imshow(img_add), title('Addition');
subplot(2,2,2), imshow(img_subtract), title('Subtraction');
subplot(2,2,3), imshow(img_multiply), title('Multiplication');
subplot(2,2,4), imshow(img_divide, []), title('Division');