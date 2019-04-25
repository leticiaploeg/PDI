function [imgQtzd] = NewPalette(remapRGB, M, N, nColors)
    
    newR = reshape(remapRGB(1,:), M, N);
    newG = reshape(remapRGB(2,:), M, N);
    newB = reshape(remapRGB(3,:), M, N);
    imgQtzd = cat(3, newR, newG, newB);
    [~, msgid] = lastwarn;
    if (strcmp(msgid,'images:initSize:adjustingMag'))
        subplot(1, 3, 2), imshow(imresize(uint8(imgQtzd), 0.5));
    else
        subplot(1, 3, 2), imshow(uint8(imgQtzd));
    end
    title({'\fontsize{16} Color Quantization for ';[num2str(nColors),' colors']});
   
end

