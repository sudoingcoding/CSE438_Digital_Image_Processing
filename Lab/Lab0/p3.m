img = imread('image.jpg');
gray_img = rgb2gray(img); 
imwrite(gray_img, 'grayscale_image.png');
binary_img = imbinarize(gray_img, 0.5); 
imwrite(binary_img, 'binary_image.png');