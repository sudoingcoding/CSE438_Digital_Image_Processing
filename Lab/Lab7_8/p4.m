img = imread('Picture4.jpg');
gray_img = rgb2gray(img);
edges = edge(gray_img, 'Canny');
[H, theta, rho] = hough(edges);
peaks = houghpeaks(H, 10, 'Threshold', ceil(0.3 * max(H(:))));  
lines = houghlines(edges, theta, rho, peaks, 'FillGap', 20, 'MinLength', 30);
figure;
subplot(1,3,1);
imshow(img);
title('Original X-ray');
subplot(1,3,2);
imshow(edges);
title('Edge Detection');
subplot(1,3,3);
imshow(img);
title('Detected Lines');
hold on;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    line(xy(:,1), xy(:,2), 'Color','green','LineWidth',2);
end
hold off;