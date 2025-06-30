img = imread("Picture2.png");
gray_img = rgb2gray(img);
binary_img2 = imbinarize(gray_img, 0.5);
n4 = bwconncomp(binary_img2, 4);
n8 = bwconncomp(binary_img2, 8);
num_objects_4 = n4.NumObjects;
num_objects_8 = n8.NumObjects;
disp(["Number of objects with 4-connectivity: ", num2str(num_objects_4)]);
disp(["Number of objects with 8-connectivity: ", num2str(num_objects_8)]);