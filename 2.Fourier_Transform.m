clc; close all; clear all;

function reconstructedImage = reconstruct(dft, precentage)
  [M, N] = size(dft);
  dft(1:round(precentage * M * N)) = 0;

  reconstructedImage = real(ifft2(dft));
end

function mse = calculateMSE(inputImage, reconstructedImage)
  mse = mean((double(inputImage(:)) - double(reconstructedImage(:))).^2);
end

inputImage = imread("cameraman.bmp");
inputImage = im2double(inputImage);

dft = fft2(inputImage);

magnitude = abs(dft);
phase = angle(dft);

figure;
subplot(1,2,1);
imshow(log10(1 + magnitude), []); title('Magnitude');
subplot(1,2,2);
imshow(phase, []); title('Transform Phase');

reconstructed_20 = reconstruct(dft, 0.2);
reconstructed_40 = reconstruct(dft, 0.4);
reconstructed_60 = reconstruct(dft, 0.6);
reconstructed_80 = reconstruct(dft, 0.8);

mse_20 = calculateMSE(inputImage, reconstructed_20);
mse_40 = calculateMSE(inputImage, reconstructed_40);
mse_60 = calculateMSE(inputImage, reconstructed_60);
mse_80 = calculateMSE(inputImage, reconstructed_80);

figure;
subplot(2, 2, 1);
imshow(reconstructed_20); title(['Reconstructed Image at 20% [MSE = ' num2str(mse_20) ']']);
subplot(2, 2, 2);
imshow(reconstructed_40); title(['Reconstructed Image at 40% [MSE = ' num2str(mse_40) ']']);
subplot(2, 2, 3);
imshow(reconstructed_60); title(['Reconstructed Image at 60% [MSE = ' num2str(mse_60) ']']);
subplot(2, 2, 4);
imshow(reconstructed_80); title(['Reconstructed Image at 80% [MSE = ' num2str(mse_80) ']']);
