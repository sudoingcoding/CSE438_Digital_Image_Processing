img1 = imread("Picture1.png");
img2 = imread("Picture2.png");

img2 = imresize(img2, size(img1(:,:,1)));

gray_img1 = rgb2gray(img1);
gray_img2 = rgb2gray(img2);

img_and = bitand(gray_img1, gray_img2);
img_or = bitor(gray_img1, gray_img2);
img_not1 = bitcmp(gray_img1);
img_not2 = bitcmp(gray_img2);

figure;
subplot(2,2,1), imshow(img_and), title('AND Operation');
subplot(2,2,2), imshow(img_or), title('OR Operation');
subplot(2,2,3), imshow(img_not1), title('NOT Operation of Picture1');
subplot(2,2,4), imshow(img_not2), title('NOT Operation of Picture2');
