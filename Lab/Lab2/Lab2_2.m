img = imread("Picture2.jpg");

gray_img = im2gray(img);

[r, c] = size(gray_img);

bit_planes = zeros(r, c, 8);

for i = 1:8
    bit_planes(:,:,i) = bitget(gray_img, 9-i);
end

figure;
subplot(3,3,1), imshow(gray_img), title('Original Grayscale Image');

for i = 1:8
    subplot(3,3,i+1), imshow(bit_planes(:,:,i)), title(['Bit Plane ', num2str(9-i)]);
end
