img = imread('Picture1.png');
gray_img = im2gray(img);
gray_img = double(gray_img);

gray_img = imgaussfilt(gray_img, 1);

gray_img = (gray_img - min(gray_img(:))) / (max(gray_img(:)) - min(gray_img(:)));

[M, N] = size(gray_img);

figure('Name', 'Select Tumor Seed Point', 'NumberTitle', 'off');
imshow(gray_img, []);
title('Click on the tumor to select a seed point, then press Enter');
[seed_y, seed_x] = ginput(1);
seed_x = round(seed_x(1));
seed_y = round(seed_y(1));
close(gcf);

seed_intensity = gray_img(seed_y, seed_x);
threshold = 0.2;

bw = false(M, N);
bw(seed_y, seed_x) = true;
stack = [seed_y, seed_x];

neighbors = [-1, -1; -1, 0; -1, 1; 0, -1; 0, 1; 1, -1; 1, 0; 1, 1];

while ~isempty(stack)
    current = stack(end, :);
    stack(end, :) = [];
    y = current(1);
    x = current(2);
    
    for k = 1:size(neighbors, 1)
        ny = y + neighbors(k, 1);
        nx = x + neighbors(k, 2);
        if ny >= 1 && ny <= M && nx >= 1 && nx <= N && ~bw(ny, nx)
            if abs(gray_img(ny, nx) - seed_intensity) <= threshold
                bw(ny, nx) = true;
                stack = [stack; ny, nx];
            end
        end
    end
end

se = strel('disk', 2);
bw = imopen(bw, se);
bw = imclose(bw, se);
bw = bwareaopen(bw, 30);

tumor_outline = bwperim(bw);
overlay = imoverlay(gray_img * 255, tumor_outline, [1 0 0]);

figure('Name', 'Tumor Segmentation Using Region Growing', 'NumberTitle', 'off');
subplot(1, 2, 1), imshow(img), title('Original Image');
subplot(1, 2, 2), imshow(bw), title('Tumor Mask');
disp('Tumor segmentation using Region Growing complete!');