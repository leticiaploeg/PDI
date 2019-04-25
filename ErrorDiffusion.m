function [imgDith] = ErrorDiffusion(img, M, N, centroids)
% Calculates error difusion using Floyd-Steinberg Algorithm
% Filter:  [ -     x  7/16
%           3/16 5/16 1/16]

    img = double(img);
    imgDith = img;
    
    for r = 1:M
        for c = 1:N   
            
            pixel = imgDith(r, c, :);
            qtzdPixel = findClosestColorDith(pixel, centroids);
            imgDith(r, c, :) = qtzdPixel;
            error = pixel - qtzdPixel;
            
            if (r ~= M) % Case is not the bottom line
                
                if c == 1 % Deal with left-most pixels case
                    imgDith(r, c+1, :)   = imgDith(r, c+1, :) + error * 7/13.0;
                    imgDith(r+1, c, :)   = imgDith(r+1, c, :) + error * 5/13.0;
                    imgDith(r+1, c+1 ,:) = imgDith(r+1, c+1, :) + error * 1/13.0;

                elseif c == N % Deal with right-most pixels case
                    imgDith(r+1, c, :) = imgDith(r+1, c, :) + error * 5/8.0;
                    imgDith(r+1, c-1, :) = imgDith(r+1, c-1, :) + error * 3/8.0;

                else % Deal with 'has all neighbors' pixels case
                    imgDith(r, c+1, :)   = imgDith(r, c+1, :) + error * 7/16.0;
                    imgDith(r+1, c-1, :) = imgDith(r+1, c-1, :) + error * 3/16.0;
                    imgDith(r+1, c, :)   = imgDith(r+1, c, :) + error * 5/16.0;
                    imgDith(r+1, c+1 ,:) = imgDith(r+1, c+1, :) + error * 1/16.0;
                end
                
            else % Case bottom line
                imgDith(r, c, :) = imgDith(r, c, :);
                if c ~= N
                    imgDith(r, c+1, :) = imgDith(r, c+1, :) + error * 1.0;
                end
            end
        end     
    end 
    
end

