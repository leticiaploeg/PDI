function [remapRGB, centroids] = CreateNewPalette(mapRGB, nColors, nPixels)
    
    if (nColors ~= 4096)
        nIterations = 10;
    else
        nIterations = 2;
    end

    remapRGB = zeros(3, nPixels); % New RGB map to be created based on the new palette
    centroids = randi([0 255], 3, nColors); % Initializes centroids
    dist = zeros(1, nColors);
    idClusters = zeros(1, nPixels); % Creates array to store cluster for each pixel
    for i = 1:nIterations
        for j = 1:nPixels
            pX = mapRGB(:,j); 
            for k = 1:nColors
                pY = centroids(:,k);
                dist(1,k) = sqrt(sum((pX - pY).^ 2)); % Calculates euclidean distance to each centroid
            end
            [~, idx] = min(dist);
            idClusters(1,j) = idx;
        end
        
        for l = 1:nColors
            centroids(:, l) = sum(mapRGB(:, idClusters == l), 2) ./ sum(idClusters == l);
            if sum(isnan(centroids(:,l))) ~= 0
                centroids(:,l) = [randi([0 255]); randi([0 255]); randi([0 255])];
            end
        end
    end
    
    for m = 1:nPixels
        for n = 1:nColors
            if idClusters(m) == n
                remapRGB(:,m) = centroids(:,n);
            end
        end
    end

end

