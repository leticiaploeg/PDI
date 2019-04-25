function [qtzdPixel] = findClosestColorDith(pixel, centroids)
    
    nColors = size(centroids, 2);
    dist = zeros(1, nColors);
    centroids = cat(3, centroids(1,:), centroids(2,:), centroids(3,:));

    for j = 1:nColors
        pX = pixel; 
        pY = centroids(:, j, :); 
        dist(1,j) = sqrt(sum((pX - pY).^ 2)); % Calculates euclidean distance to each centroid
    end
    [~, idx] = min(dist);
    qtzdPixel = centroids(:, idx, :);
  
end

