clc; close all; clear all;

function filteredImage = filterImage(image, filterSize)
  filter = ones(filterSize) / filterSize^2;
  filteredImage = conv2(image, filter, 'same');
end

pkg load image;

inputImage = imread('lenna.bmp');
inputImage = im2double(inputImage);

imageWithNoise = imnoise(inputImage, 'salt & pepper', 0.05);

figure;
subplot(1, 2, 1);
imshow(inputImage); title("Before adding noise (Original)");
subplot(1, 2, 2);
imshow(imageWithNoise); title("After adding noise");

filteredImage_3x3 = filterImage(imageWithNoise, 3);
filteredImage_5x5 = filterImage(imageWithNoise, 5);
filteredImage_7x7 = filterImage(imageWithNoise, 7);

figure;
subplot(1, 3, 1);
imshow(filteredImage_3x3); title("3x3 Filter");
subplot(1, 3, 2);
imshow(filteredImage_5x5); title("5x5 Filter");
subplot(1, 3, 3);
imshow(filteredImage_7x7); title("7x7 Filter");
