img = imread('Picture1.png');
gray_img = im2gray(img);
gray_img = double(gray_img);

gray_img = imgaussfilt(gray_img, 1);

gray_img = (gray_img - min(gray_img(:))) / (max(gray_img(:)) - min(gray_img(:)));

[M, N] = size(gray_img);

min_region_size = 8;  % Minimum region size
split_threshold = 0.1; % Threshold for splitting

function should_split = needSplit(img_region, threshold)
    if isempty(img_region)
        should_split = false;
        return;
    end
    region_std = std(img_region(:));
    should_split = region_std > threshold;
end

regions = {[1, 1, M, N]};
homogeneous_regions = {};

while ~isempty(regions)
    current_region = regions{1};
    regions(1) = [];
    
    r_start = current_region(1);
    c_start = current_region(2);
    height = current_region(3);
    width = current_region(4);
    
    img_region = gray_img(r_start:r_start+height-1, c_start:c_start+width-1);
    
    if height <= min_region_size || width <= min_region_size || ~needSplit(img_region, split_threshold)
        homogeneous_regions{end+1} = current_region;
    else
        h_half = floor(height/2);
        w_half = floor(width/2);
        
        regions{end+1} = [r_start, c_start, h_half, w_half]; 
        regions{end+1} = [r_start, c_start+w_half, h_half, width-w_half];
        regions{end+1} = [r_start+h_half, c_start, height-h_half, w_half];
        regions{end+1} = [r_start+h_half, c_start+w_half, height-h_half, width-w_half];
    end
end

region_intensities = zeros(length(homogeneous_regions), 1);
for i = 1:length(homogeneous_regions)
    region = homogeneous_regions{i};
    r_start = region(1);
    c_start = region(2);
    height = region(3);
    width = region(4);
    
    img_region = gray_img(r_start:r_start+height-1, c_start:c_start+width-1);
    region_intensities(i) = mean(img_region(:));
end

% Get user input for tumor seed point
figure('Name', 'Select Tumor Seed Point', 'NumberTitle', 'off');
imshow(gray_img, []);
title('Click on the tumor to select a seed point, then press Enter');
[seed_y, seed_x] = ginput(1);
seed_x = round(seed_x);
seed_y = round(seed_y);
close(gcf);

seed_region_idx = -1;
for i = 1:length(homogeneous_regions)
    region = homogeneous_regions{i};
    r_start = region(1);
    c_start = region(2);
    height = region(3);
    width = region(4);
    
    if seed_y >= r_start && seed_y < r_start+height && ...
       seed_x >= c_start && seed_x < c_start+width
        seed_region_idx = i;
        break;
    end
end

seed_intensity = region_intensities(seed_region_idx);
merge_threshold = 0.15;

tumor_mask = false(M, N);

for i = 1:length(homogeneous_regions)
    region = homogeneous_regions{i};
    r_start = region(1);
    c_start = region(2);
    height = region(3);
    width = region(4);
    
    if abs(region_intensities(i) - seed_intensity) <= merge_threshold
        tumor_mask(r_start:r_start+height-1, c_start:c_start+width-1) = true;
    end
end

se = strel('disk', 2);
tumor_mask = imopen(tumor_mask, se);
tumor_mask = imclose(tumor_mask, se);
tumor_mask = bwareaopen(tumor_mask, 50);

CC = bwconncomp(tumor_mask);
pixelIdxList = CC.PixelIdxList;
seed_idx = sub2ind(size(tumor_mask), seed_y, seed_x);

component_with_seed = -1;
for i = 1:CC.NumObjects
    if any(pixelIdxList{i} == seed_idx)
        component_with_seed = i;
        break;
    end
end

final_mask = false(M, N);
if component_with_seed > 0
    final_mask(pixelIdxList{component_with_seed}) = true;
else
    num_pixels = cellfun(@numel, pixelIdxList);
    [~, largest_idx] = max(num_pixels);
    final_mask(pixelIdxList{largest_idx}) = true;
end

tumor_outline = bwperim(final_mask);
rgb_img = repmat(gray_img, [1, 1, 3]);
overlay = rgb_img;
overlay(:,:,1) = overlay(:,:,1) + tumor_outline * 0.7;
overlay(:,:,2) = overlay(:,:,2) - tumor_outline * 0.3;
overlay(:,:,3) = overlay(:,:,3) - tumor_outline * 0.3;
overlay = min(max(overlay, 0), 1);

figure('Name', 'Tumor Segmentation Using Region Splitting and Merging', 'NumberTitle', 'off');
subplot(2, 2, 1), imshow(img), title('Original Image');
subplot(2, 2, 2), imshow(gray_img, []), title('Preprocessed Image');
subplot(2, 2, 3), imshow(final_mask), title('Tumor Mask');
subplot(2, 2, 4), imshow(overlay), title('Tumor Outline');

disp('Tumor segmentation using Region Splitting and Merging complete!');