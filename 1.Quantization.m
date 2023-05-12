clc; close all; clear all;

function transform = transform(level)
  transform = zeros(1, 256);
  step = 256 / level;

  for i = 0:255
    transform(i+1) = floor(i / level) * level;
  end
endfunction

inputImage = imread('cameraman.bmp');

transform_7 = transform(7);

transform_11 = transform(11);

transform_15 = transform(17);

transform_19 = transform(19);

quantized_img_7 = zeros(size(inputImage));
quantized_img_11 = zeros(size(inputImage));
quantized_img_15 = zeros(size(inputImage));
quantized_img_19 = zeros(size(inputImage));

for i = 1:size(inputImage, 1)
  for j = 1:size(inputImage, 2)
    quantized_img_7(i, j) = transform_7(inputImage(i, j)+1);
    quantized_img_11(i, j) = transform_11(inputImage(i, j)+1);
    quantized_img_15(i, j) = transform_15(inputImage(i, j)+1);
    quantized_img_19(i, j) = transform_19(inputImage(i, j)+1);
  end
end

mse_7 = mean((double(inputImage(:))-double(quantized_img_7(:))).^2);
mse_11 = mean((double(inputImage(:))-double(quantized_img_11(:))).^2);
mse_15 = mean((double(inputImage(:))-double(quantized_img_15(:))).^2);
mse_19 = mean((double(inputImage(:))-double(quantized_img_19(:))).^2);

figure(1);
subplot(2,2,1);
imshow(uint8(quantized_img_7)); title('Quantized Image (7 levels)');

subplot(2,2,2);
imshow(uint8(quantized_img_11)); title('Quantized Image (11 levels)');

subplot(2,2,3);
imshow(uint8(quantized_img_15)); title('Quantized Image (15 levels)');

subplot(2,2,4);
imshow(uint8(quantized_img_19)); title('Quantized Image (19 levels)');

figure(2);
x = linspace(0, 1, 256);
y7 = round(x * 7) / 7;
y11 = round(x * 11) / 11;
y15 = round(x * 15) / 15;
y19 = round(x * 19) / 19;
plot(x, x, 'k-', x, y7, 'r-', x, y11, 'g-', x, y15, 'b-', x, y19, 'm-');
legend('Αρχική', '7 στάθμες', '11 στάθμες', '15 στάθμες', '19 στάθμες');
title('Συνάρτηση Μετασχηματισμού');

disp(['MSE (7 levels): ', num2str(mse_7)]);
disp(['MSE (11 levels): ', num2str(mse_11)]);
disp(['MSE (15 levels): ', num2str(mse_15)]);
disp(['MSE (19 levels): ', num2str(mse_19)]);
