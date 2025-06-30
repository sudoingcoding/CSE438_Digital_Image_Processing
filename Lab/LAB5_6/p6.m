% Load and prepare the image
img = imread('Picture8.png');
if size(img, 3) == 3
    img = img(:,:,1)*0.2989 + img(:,:,2)*0.5870 + img(:,:,3)*0.1140; % Convert to grayscale
end
img = double(img);
[M, N] = size(img);

% Add Gaussian noise
noise_mean = 0;
noise_variance = 0.01 * (max(img(:))^2); % Variance scaled to image intensity
img_noisy = img + sqrt(noise_variance) * randn(M, N) + noise_mean;
img_noisy = max(0, min(255, img_noisy)); % Clip to valid range

% Filter parameters
window_size = 3; % 3x3 window
alpha = 2; % For alpha-trimmed filter (trim 2 pixels from each end)
trimmed_count = 1; % For trimmed filter (trim 1 pixel from each end)

% Initialize output images
img_median = zeros(M, N);
img_max = zeros(M, N);
img_min = zeros(M, N);
img_midpoint = zeros(M, N);
img_alpha_trimmed = zeros(M, N);
img_trimmed = zeros(M, N);

% Pad image to handle borders
pad_size = floor(window_size / 2);
img_padded = padarray(img_noisy, [pad_size pad_size], 'replicate');

% Apply filters
for i = 1:M
    for j = 1:N
        % Extract window
        window = img_padded(i:i+window_size-1, j:j+window_size-1);
        window_sorted = sort(window(:));
        n = length(window_sorted);
        
        % Median filter
        img_median(i, j) = window_sorted(floor((n+1)/2));
        
        % Maximum filter
        img_max(i, j) = window_sorted(n);
        
        % Minimum filter
        img_min(i, j) = window_sorted(1);
        
        % Midpoint filter
        img_midpoint(i, j) = (window_sorted(1) + window_sorted(n)) / 2;
        
        % Alpha-trimmed filter
        if alpha > 0 && alpha < floor(n/2)
            trimmed_window = window_sorted(alpha+1:n-alpha);
            img_alpha_trimmed(i, j) = mean(trimmed_window);
        else
            img_alpha_trimmed(i, j) = img_median(i, j); % Fallback to median
        end
        
        % Trimmed filter (trim 1 pixel from each end, take median)
        if trimmed_count > 0 && trimmed_count < floor(n/2)
            trimmed_window = window_sorted(trimmed_count+1:n-trimmed_count);
            img_trimmed(i, j) = median(trimmed_window);
        else
            img_trimmed(i, j) = img_median(i, j); % Fallback to median
        end
    end
end

% Compute PSNR for each restored image
mse_median = mean((img(:) - img_median(:)).^2);
psnr_median = 10 * log10((255^2) / mse_median);
mse_max = mean((img(:) - img_max(:)).^2);
psnr_max = 10 * log10((255^2) / mse_max);
mse_min = mean((img(:) - img_min(:)).^2);
psnr_min = 10 * log10((255^2) / mse_min);
mse_midpoint = mean((img(:) - img_midpoint(:)).^2);
psnr_midpoint = 10 * log10((255^2) / mse_midpoint);
mse_alpha_trimmed = mean((img(:) - img_alpha_trimmed(:)).^2);
psnr_alpha_trimmed = 10 * log10((255^2) / mse_alpha_trimmed);
mse_trimmed = mean((img(:) - img_trimmed(:)).^2);
psnr_trimmed = 10 * log10((255^2) / mse_trimmed);

% Display results
figure('Name', 'Order Statistic Filters for Noise Removal', 'NumberTitle', 'on');
sgtitle('Gaussian Noise Removal with Order Statistic Filters', 'FontSize', 18);
subplot(2, 4, 1), imshow(uint8(img)), title('Original Image');
subplot(2, 4, 2), imshow(uint8(img_median)), title(sprintf('Median Filter\nPSNR: %.2f dB', psnr_median));
subplot(2, 4, 3), imshow(uint8(img_max)), title(sprintf('Maximum Filter\nPSNR: %.2f dB', psnr_max));
subplot(2, 4, 4), imshow(uint8(img_min)), title(sprintf('Minimum Filter\nPSNR: %.2f dB', psnr_min));
subplot(2, 4, 5), imshow(uint8(img_midpoint)), title(sprintf('Midpoint Filter\nPSNR: %.2f dB', psnr_midpoint));
subplot(2, 4, 6), imshow(uint8(img_alpha_trimmed)), title(sprintf('Alpha-trimmed Filter\nPSNR: %.2f dB', psnr_alpha_trimmed));
subplot(2, 4, 7), imshow(uint8(img_trimmed)), title(sprintf('Trimmed Filter\nPSNR: %.2f dB', psnr_trimmed));

% Print PSNR results
fprintf('PSNR Results for Order Statistic Filters:\n');
fprintf('Median Filter: %.2f dB\n', psnr_median);
fprintf('Maximum Filter: %.2f dB\n', psnr_max);
fprintf('Minimum Filter: %.2f dB\n', psnr_min);
fprintf('Midpoint Filter: %.2f dB\n', psnr_midpoint);
fprintf('Alpha-trimmed Filter: %.2f dB\n', psnr_alpha_trimmed);
fprintf('Trimmed Filter: %.2f dB\n', psnr_trimmed);