img = imread("Picture1.png");
imshow(img);
bin_img = imbinarize(img);
n4 = bwperim(bin_img, 4);
n8 = bwperim(bin_img, 8);
subplot(1,2,1),imshowpair(bin_img,n4,'montage');
title("4 Neighborhoods");
subplot(1,2,2),imshowpair(bin_img,n8,'montage');
title("8 Neighborhoods");