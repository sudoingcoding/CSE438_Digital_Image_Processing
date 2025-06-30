img = imread('Picture1.png'); 
gray = rgb2gray(img); 
gray = medfilt2(gray, [3 3]); 
gray_resized = imresize(gray, [512 512]); 
threshold_std = 15; 
predicate = @(block) std2(block) > threshold_std; 
S = qtdecomp(gray_resized, predicate);  
mask = zeros(size(gray_resized)); 
block_sizes = [512 256 128 64 32 16 8 4];  
for k = 1:length(block_sizes) 
   bsize = block_sizes(k); 
   [vals_x, vals_y] = find(S == bsize); 
   for i = 1:length(vals_x) 
       x = vals_x(i); y = vals_y(i); 
       if x + bsize - 1 <= size(gray_resized,1) && y + bsize - 1 <= size(gray_resized,2) 
           block = gray_resized(x:x+bsize-1, y:y+bsize-1); 
           if mean(block(:)) > 100 
               mask(x:x+bsize-1, y:y+bsize-1) = 1; 
           end 
       end 
   end 
end 
mask = bwareaopen(mask, 50);                  
mask = imfill(mask, 'holes');                   
mask = imclose(mask, strel('disk', 3));        
mask = imerode(mask, strel('disk', 1));        
mask_resized = imresize(mask, size(gray), 'nearest'); 
figure('Name', 'Quadtree Tumor Segmentation'); 
subplot(1, 2, 1); 
imshow(gray); title('Original MRI Image'); 
subplot(1, 2, 2); 
imshow(gray); hold on; 
redMask = cat(3, ones(size(gray)), zeros(size(gray)), zeros(size(gray))); 
h = imshow(redMask); 
set(h, 'AlphaData', double(mask_resized) * 0.4);  
boundaries = bwboundaries(mask_resized); 
for k = 1:length(boundaries) 
   boundary = boundaries{k}; 
   plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 1.5); 
end 
title('Tumor Segmentation using Quadtree');