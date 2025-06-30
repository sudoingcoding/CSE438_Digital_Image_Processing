img = imread("Picture5.png");
gray_img = im2gray(img);
quantized_img = gray_img;
[r, c] = size(quantized_img);
for i = 1:r
    for j = 1:c
        f = quantized_img(i, j);
        if f <= 32
            quantized_img(i, j) = 16;
        elseif f > 32 && f <= 64
            quantized_img(i, j) = 48;
        elseif f > 64 && f <= 96
            quantized_img(i, j) = 80;
        elseif f > 96 && f <= 128
            quantized_img(i, j) = 112;
        elseif f > 128 && f <= 160
            quantized_img(i, j) = 144;
        elseif f > 160 && f <= 192
            quantized_img(i, j) = 176;
        elseif f > 192 && f <= 224
            quantized_img(i, j) = 208;
        else
            quantized_img(i, j) = 240;
        end
    end
end
figure;
subplot(1,2,1), imshow(gray_img), title('Original Image');
subplot(1,2,2), imshow(quantized_img, []), title('Quantized Grayscale image by 8 levels');
