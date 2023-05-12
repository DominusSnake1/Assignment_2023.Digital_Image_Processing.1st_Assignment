clc; close all; clear all;

function filteredImage = createFilteredImage(fft, fftNoisy, order)
  cutOff = 0.1 * min(size(fft, 1), size(fft, 2));

  filter = 1 ./ (1 + (fft ./ cutOff) .^ (2 * order));

  filteredImage = real(ifft2(fftNoisy .* filter));
end

inputImage = imread("lenna.bmp");
inputImage = im2double(inputImage);

imageWithNoise = imnoise(inputImage, 'gaussian', 0, 0.01);

figure;
subplot(1, 2, 1);
imshow(inputImage); title("Before adding noise (Original)");
subplot(1, 2, 2);
imshow(imageWithNoise); title("After adding noise");

fft = fft2(inputImage);
fftNoisy = fft2(imageWithNoise);

filteredImage_3 = createFilteredImage(fft, fftNoisy, 3);
filteredImage_5 = createFilteredImage(fft, fftNoisy, 5);
filteredImage_7 = createFilteredImage(fft, fftNoisy, 7);

figure;
subplot(2, 2, 1);
imshow(inputImage); title("Original Image");
subplot(2, 2, 2);
imshow(filteredImage_3); title("Filter of Order 3");
subplot(2, 2, 3);
imshow(filteredImage_5); title("Filter of Order 5");
subplot(2, 2, 4);
imshow(filteredImage_7); title("Filter of Order 7");
