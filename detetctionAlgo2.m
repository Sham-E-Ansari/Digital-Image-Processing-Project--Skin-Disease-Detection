close all;
I = imread('ISIC_0000013.jpg');
I = rgb2gray(I);
I = imresize(I,[256,256]);
b = imsharpen(I,'Radius',2,'Amount',1,'Threshold',0.5);
b = medfilt2(b);
Kaverage = filter2(fspecial('average',3),b)/255;
figure;
imshow(Kaverage);
im = im2bw(Kaverage);
figure;
imshow(im);

mask = zeros(size(im));
mask( 110: end-110,110:end-110)=1;

B = activecontour(im,mask,200);
figure;
imshow(B);
title('Detection2');
B=1-B;
B = bwareaopen(B,4000);
figure;
imshow(B);
title('Detection');
if(any(B(:)))
    disp('Detected');
else
    disp('Not Detected');
end
bw_perim = bwperim(B);
overlay1 = imoverlay(I,bw_perim, [.3 1 .3]);
figure;
imshow(overlay1);
title('Overlay');