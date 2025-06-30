img = imread('Picture4.jpg'); 
if size(img,3) == 3  
    gray_img = img(:,:,1)*0.2989 + img(:,:,2)*0.5870 + img(:,:,3)*0.1140;
else
    gray_img = img; 
end

F = fft2(double(gray_img)); 
F_shifted = fftshift(F); 
[M, N] = size(gray_img); 
D0 = 90; 
[X, Y] = meshgrid(1:N, 1:M);
D = sqrt((X - N/2).^2 + (Y - M/2).^2); 

% Gaussian Low Pass Filter
GLPF = exp(-(D.^2)/(2*(D0^2)));

% Apply filter in frequency domain
F_filtered = F_shifted .* GLPF; 
F_ishifted = ifftshift(F_filtered); 
processed_img = abs(ifft2(F_ishifted)); 

% Visualization
figure("Name","Gaussian Low Pass Filter","NumberTitle","on");
sgtitle('Gaussian Low Pass Filter','FontSize', 18); 
subplot(2,3,1), imshow(gray_img, []); 
xlabel('(a) Original Image', 'FontSize', 12);
subplot(2,3,2), imshow(log(1+abs(F_shifted)), []), xlabel('(b) Centered Fourier Spectrum', 'FontSize', 12);
subplot(2,3,3), imshow(GLPF, []), xlabel('(c) Gaussian Low Pass Filter', 'FontSize', 12);
subplot(2,3,4), mesh(GLPF), xlabel('(d) Gaussian Low Pass Filter', 'FontSize', 12);
axis tight;
subplot(2,3,5), imshow(log(1+abs(F_filtered)), []), xlabel('(e) Filtered Fourier Spectrum', 'FontSize', 12);
subplot(2,3,6), imshow(processed_img, []), xlabel('(f) Processed Image', 'FontSize', 12);