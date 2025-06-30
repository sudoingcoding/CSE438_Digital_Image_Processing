input_img = imread("Picture4.jpg");
reference_img = imread("Picture5.png");

input_gray = im2gray(input_img);
reference_gray = im2gray(reference_img);

matched_img = imhistmatch(input_gray, reference_gray);

figure;

subplot(3,2,1), imshow(input_gray), title('Original Input Image');
subplot(3,2,2), imhist(input_gray), title('Histogram of Input Image');

subplot(3,2,3), imshow(reference_gray), title('Reference Image');
subplot(3,2,4), imhist(reference_gray), title('Histogram of Reference Image');

subplot(3,2,5), imshow(matched_img), title('Histogram Matched Image');
subplot(3,2,6), imhist(matched_img), title('Histogram of Matched Image');
