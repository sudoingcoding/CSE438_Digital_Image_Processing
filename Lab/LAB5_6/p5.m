img = imread('Picture5.png');       
img = im2double(img);
noisy_img = imnoise(img, 'gaussian', 0, 0.01); 
padsize = 1;
geo_filtered = img;
[M, N] = size(noisy_img);
geo_filtered = zeros(M, N);
padded = padarray(noisy_img, [padsize padsize], 'symmetric');
for i = 2:M+1
    for j = 2:N+1
        block = padded(i-1:i+1, j-1:j+1);
        product = prod(block(:));
        geo_filtered(i-1,j-1) = product^(1/9);
    end
end
harm_filtered = zeros(M, N);
for i = 2:M+1
    for j = 2:N+1
        block = padded(i-1:i+1, j-1:j+1);
        harm_filtered(i-1,j-1) = 9 / sum(1 ./ (block(:) + eps)); 
    end
end
Q = 1.5; 
charm_filtered = zeros(M, N);
for i = 2:M+1
    for j = 2:N+1
        block = padded(i-1:i+1, j-1:j+1);
        num = sum(block(:).^(Q + 1));
        den = sum(block(:).^Q) + eps;
        charm_filtered(i-1,j-1) = num / den;
    end
end
figure;
sgtitle('Gaussian Noise Restoration using Mean Filters');
subplot(2,3,1); imshow(img, []); title('Original Image');
subplot(2,3,2); imshow(noisy_img, []); title('Noisy Image (Gaussian)');
subplot(2,3,3); imshow(geo_filtered, []); title('Geometric Mean Filter');
subplot(2,3,4); imshow(harm_filtered, []); title('Harmonic Mean Filter');
subplot(2,3,5); imshow(charm_filtered, []); title('Contra-harmonic Mean Filter (Q=1.5)');