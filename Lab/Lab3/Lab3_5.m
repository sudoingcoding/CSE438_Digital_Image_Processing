% a)
rgb_img = imread('Picture5.png');
gray_img = imread('Picture6.jpg');
ind_img = imread('Picture7.jpg');
[indexed_img, colormap] = rgb2ind(ind_img, 256);
figure;
subplot(2,2,1); imshow(rgb_img); title('RGB Image');
subplot(2,2,2); imshow(gray_img); title('Grayscale Image');
subplot(2,2,3); imshow(indexed_img, colormap); title('Indexed Image');
% b)
gray_from_rgb = rgb2gray(rgb_img);
figure;
imshow(gray_from_rgb);
subplot(1,2,1); imshow(rgb_img);title('Indexed Image');
subplot(1,2,2); imshow(gray_from_rgb);title('RGB image to Grayscale image');
% c)
gray_from_indexed = ind2gray(indexed_img, colormap);
figure;
imshow(gray_from_indexed);
subplot(1,2,1); imshow(indexed_img, colormap);title('Indexed Image');
subplot(1,2,2); imshow(gray_from_indexed);title('Indexed image to Grayscale image.');
% d)
rgb_from_indexed = ind2rgb(indexed_img, colormap);
figure;
imshow(rgb_from_indexed);
subplot(1,2,1); imshow(indexed_img, colormap);title('Indexed Image');
subplot(1,2,2); imshow(rgb_from_indexed);title('RGB Image from Indexed');
% e)
color_img = imread('Picture6.jpg');
if ndims(color_img) == 3
gray_img = rgb2gray(color_img);
else
gray_img = color_img;
end
binary_img = imbinarize(gray_img, 0.5);
figure;
subplot(1,2,1); imshow(gray_img); title('Grayscale Image');
subplot(1,2,2); imshow(binary_img); title('Grayscale image to a Binary image.');
% f)
inverted_binary_img = imcomplement(binary_img);
figure;
imshow(inverted_binary_img);
subplot(1,2,1); imshow(binary_img); title('Binary image.');
subplot(1,2,2); imshow(inverted_binary_img);title('Inverted Binary Image');
% g)
figure;
subplot(1,2,1); imshow(gray_img); title('Gray image.');
subplot(1,2,2); imhist(gray_img);title('Histogram of the Grayscale Image');
% h)
inverted_rgb_img = imcomplement(rgb_img);
figure;
imshow(inverted_rgb_img);
subplot(1,2,1); imshow(rgb_img); title('RGB image.');
subplot(1,2,2); imshow(inverted_rgb_img);title('Inverted RGB Image');
% i)
h = fspecial('average', [3 3]);
blurred_rgb_img = imfilter(rgb_img, h);
figure;
imshow(blurred_rgb_img);
subplot(1,2,1); imshow(rgb_img); title('RGB image.');
subplot(1,2,2); imshow(blurred_rgb_img);title('Blurred RGB Image');