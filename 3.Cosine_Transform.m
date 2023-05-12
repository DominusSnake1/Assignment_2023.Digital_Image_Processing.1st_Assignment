clc; close all; clear all;

% The function for DCT and IDCT is the same so I merged them.
function imageDCT_IDCT = myDCT_IDCT(image)
  N = size(image,1);
  F = zeros(N);

  for k = 0:N-1
    for n = 0:N-1
      if k == 0
        F(k+1, n+1) = (sqrt(1/N)) * cos(pi * (2*n+1) * k/(2*N));
      else
        F(k+1, n+1) = (sqrt(2/N)) * cos(pi * (2*n+1) * k/(2*N));
      end
    end
  end

  imageDCT_IDCT = F * image * F';
end

function imageDCT_precent = myDCT_precent(image, precentage)
  [rows, cols] = size(image);
  imageDCT_precent = image;
  imageDCT_precent(ceil(rows * precentage):rows, :) = 0;
  imageDCT_precent(:, ceil(cols * precentage):cols) = 0;
end

function mse = calculateMSE(inputImage, reconstructedImage)
  mse = mean((double(inputImage(:)) - double(reconstructedImage(:))).^2);
end

inputImage = imread('cameraman.bmp');
inputImage = im2double(inputImage);

imageDCT = myDCT_IDCT(inputImage);
spectrum = abs(imageDCT);

imageIDCT = myDCT_IDCT(imageDCT);

figure;
imshow(log10(spectrum + 1), []); title("Spectrum");
colormap(gca, hot);
colorbar;

figure;
subplot(1, 2, 1);
imshow(inputImage); title("Original Image");
subplot(1, 2, 2);
imshow(imageIDCT); title("Reconstructed Image");

imageDCT_20 = myDCT_IDCT(myDCT_precent(imageDCT, 0.2));
imageDCT_40 = myDCT_IDCT(myDCT_precent(imageDCT, 0.4));
imageDCT_60 = myDCT_IDCT(myDCT_precent(imageDCT, 0.6));
imageDCT_80 = myDCT_IDCT(myDCT_precent(imageDCT, 0.8));

mse_20 = calculateMSE(inputImage, imageDCT_20);
mse_40 = calculateMSE(inputImage, imageDCT_40);
mse_60 = calculateMSE(inputImage, imageDCT_60);
mse_80 = calculateMSE(inputImage, imageDCT_80);

figure;
subplot(2, 2, 1);
imshow(imageDCT_20); title(['Reconstructed Image at 20% [MSE = ' num2str(mse_20) ']']);
subplot(2, 2, 2);
imshow(imageDCT_40); title(['Reconstructed Image at 40% [MSE = ' num2str(mse_40) ']']);
subplot(2, 2, 3);
imshow(imageDCT_60); title(['Reconstructed Image at 60% [MSE = ' num2str(mse_60) ']']);
subplot(2, 2, 4);
imshow(imageDCT_80); title(['Reconstructed Image at 80% [MSE = ' num2str(mse_80) ']']);
