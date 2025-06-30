img = imread('Picture3.jpg');
gray_img = rgb2gray(img); 

roberts_edge = edge(gray_img, 'roberts');
sobel_edge = edge(gray_img, 'sobel');
prewitt_edge = edge(gray_img, 'prewitt');

figure;

subplot(2,2,1), imshow(gray_img), title('Original Grayscale Image');
subplot(2,2,2), imshow(roberts_edge), title('Roberts Edge Detection');
subplot(2,2,3), imshow(sobel_edge), title('Sobel Edge Detection');
subplot(2,2,4), imshow(prewitt_edge), title('Prewitt Edge Detection');
