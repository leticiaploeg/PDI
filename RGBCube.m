function [] = RGBCube(r, g, b)

    figure
    plot3(r, g, b, '.');
    %, 'Color', [reshape(img(:,:,1), 1, M * N)./255 reshape(img(:,:,2), 1, M * N)./255 
    %reshape(img(:,:,3), 1, M * N)./255]
    xlabel('Red'), ylabel('Green'), zlabel('Blue')
    grid on
    rotate3d on

end

