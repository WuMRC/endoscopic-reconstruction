function [xBounds,yBounds] = declareCenter(image)
%DECLARECENTER Specify the center point, create square image
%   A user inputs an IMAGE, then gets the largest possible square region of
%   the image, centered at the point they specified.

% Display image and specify the center point
imshow(image)
[xCenter,yCenter] = getpts;
close

% Find the region of interest given the size and shape of the image
if size(image,2)-xCenter > size(image,1) - yCenter
    xBounds = uint16((xCenter - (size(image,1) - yCenter))+1:...
        (xCenter + size(image,1) - yCenter));
    yBounds = uint16((yCenter - (size(image,1) - yCenter))+1:...
        (yCenter + size(image,1) - yCenter));
else 
    xBounds = uint16((xCenter - (size(image,2) - xCenter))+1:...
        (xCenter + size(image,2) - xCenter));
    yBounds = uint16((yCenter - (size(image,2) - xCenter))+1:...
        (yCenter + size(image,2) - xCenter));
end

end

