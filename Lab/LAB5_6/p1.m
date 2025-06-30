original_img = imread('Picture1.jpg');
gray_img = rgb2gray(original_img);
gray_img = im2double(gray_img);

% Fourier Transform
F = fft2(gray_img);                    % Apply 2D Fourier Transform
F_shifted = fftshift(F);              % Shift zero-frequency to the center

% Magnitude Spectrum for visualization
magnitude_spectrum = log(1 + abs(F_shifted));

% Inverse Fourier Transform
F_ishifted = ifftshift(F_shifted);    % Inverse shift
reconstructed_img = ifft2(F_ishifted);% Apply Inverse Fourier Transform
reconstructed_img = abs(reconstructed_img); % Take magnitude (real part)

% Display Results
figure('Name','Fourier Transform and Inverse', 'NumberTitle','off');
subplot(1,3,1), imshow(gray_img, []), title('Original Image');
subplot(1,3,2), imshow(magnitude_spectrum, []), title('Magnitude Spectrum');
subplot(1,3,3), imshow(reconstructed_img, []), title('Reconstructed Image');
