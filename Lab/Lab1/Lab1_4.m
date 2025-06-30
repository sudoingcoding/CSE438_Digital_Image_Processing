i3 = imread("Picture2.png");

imshow(i3);
title('Select two points on the image');

[x, y] = ginput(2);

distance = norm([x(2) - x(1), y(2) - y(1)]);

fprintf('The Euclidean distance between the points is: %.2f\n', distance);

hold on;
plot(x, y, 'r-', 'LineWidth', 2);
text(mean(x), mean(y), sprintf('Distance: %.2f', distance), 'Color', 'red', 'FontSize', 12, 'HorizontalAlignment', 'center');
hold off;

title('Distance Line Added');
