%
% Universidade de Brasilia, PPGEE
% Author: Leticia Camara van der Ploeg
% Color quantization with Kmeans Algorithm and error diffusion with
% Floyd-Steinberg Algorithm

clear
close all
clc
lastwarn('')

% User's input
prompt = '*** Color Quantization ***\n\n Image name requested (with extension): ';
imgFileName = input(prompt,'s');
prompt = '\n Number of colors (8, 16, 64, 256, 4096): ';
nColors = input(prompt); % Number of clusters 
prompt = '\n*** Floyd-Steinberg Dithering ***\n\nDo you want to compare results using error diffusion? [y/n]:  ';
errorDiffusion = input(prompt,'s');

% Main code
if exist(imgFileName, 'file')
    
    [img, M, N] = LoadImage(imgFileName); % Loads and shows original image
    nPixels = M*N;
    rM = double(img(:,:,1));
    gM = double(img(:,:,2));
    bM = double(img(:,:,3));
    r = reshape(rM, 1, nPixels);
    g = reshape(gM, 1, nPixels);
    b = reshape(bM, 1, nPixels);
    mapRGB = [r; g; b]; % Creates RGB map
    %RGBCube(r, g, b); % Shows RGB values of each pixel 
    
    % K-means
    [remapRGB, centroids] = CreateNewPalette(mapRGB, nColors, nPixels);
    imgQtzd = NewPalette(remapRGB, M, N, nColors); % Creates and shows image based on the new palette
  
    % Floyd-Steinberg error diffusion
    if errorDiffusion == 'y'
        [imgDith] = ErrorDiffusion(img, M, N, centroids);
        [~, msgid] = lastwarn;
        if (strcmp(msgid,'images:initSize:adjustingMag'))
            subplot(1, 3, 3), imshow(imresize(uint8(imgDith), 0.5));
        else
            subplot(1, 3, 3), imshow(uint8(imgDith));
        end
        title({'\fontsize{16} Floyd-Steinberg', 'Dithering'});
    end
    
else
	fprintf('File %s does not exist.\n', imgFileName);
end