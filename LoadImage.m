function [img, M, N] = LoadImage(imgFileName)
    
    img = imread(imgFileName);
    [M, N, ~] = size(img);
    [~, msgid] = lastwarn;
    figure
    if (strcmp(msgid,'images:initSize:adjustingMag'))
        subplot(1, 3, 1), imshow(imresize(img, 0.5));
    else
        subplot(1, 3, 1), imshow(img);
    end
    title({'\fontsize{16} Original Image';[num2str(M),' x ', num2str(N)]});
    
end

