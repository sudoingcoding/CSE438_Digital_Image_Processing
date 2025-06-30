img = imread('image.jpg');
red_channel = img(:,:,1); 
green_channel = img(:,:,2); 
blue_channel = img(:,:,3); 
imshow(red_channel); 
imshow(green_channel);
imshow(blue_channel);