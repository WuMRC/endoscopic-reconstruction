%% Cylindrical reconfiguration


%%
clear, close, clc
%% Pick file and show image
% filename = 'Video_13140024_2014-12-03-13-32-36-0000-WL-patient E.avi';

[filename, pathname] = uigetfile('*.*','Pick a movie file');
addpath(genpath(pathname));
cd(pathname)

vidObj = VideoReader(filename);
get(vidObj)

vidWidth = vidObj.Width;    
vidHeight = vidObj.Height;
vidFrames = vidObj.NumberOfFrames;

im1 = rgb2gray(read(vidObj,1));

% imshow(im1)

%% Select region of interest

% % imROI = selectroi(im1);
% shift = 35;
% 
% im1_crop = im1(1:426, 215-shift:640-shift);
% imshow(im1_crop)

[xBounds,yBounds] = declareCenter(im1);

%%
h = waitbar(0);
for ind = 1:vidFrames-1
    originalImage = rgb2gray(read(vidObj,ind));
    %     mov(:,:,ind) = x(1:426, 215-shift:640-shift);
    mov(:,:,ind) = originalImage(yBounds,xBounds);
    
    waitbar(ind/vidFrames,h)
end

close(h)



%% Convert selected radius to "slice"

radiusOfImage = size(im1_crop,1)/2;

radiusOfCrop_outer = radiusOfImage;
radiusOfCrop_inner = radiusOfImage-2;

rMin = radiusOfCrop_inner/radiusOfImage;
rMax = radiusOfCrop_outer/radiusOfImage;
reconstructedHeight = radiusOfCrop_outer-radiusOfCrop_inner;
reconstructedWidth = (radiusOfCrop_outer+radiusOfCrop_inner)/2;

im1_convert = ImToPolar(im1_crop,rMin,rMax,...
    reconstructedHeight,reconstructedWidth);

mesh(im1_convert)
%%
clear movSlices
h = waitbar(0);
for ind = 1:vidFrames-1
    movSlices(:,:,ind) = ImToPolar(mov(:,:,ind),rMin,rMax,...
        reconstructedHeight,reconstructedWidth);
        waitbar(ind/vidFrames,h)
end
close(h)

%%
imagesc(permute(mean(movSlices),[2 3 1]))
colormap parula

%%
% Need function to convert intensity/contrast to pixel height
% Will fudge one for now.
w = permute(mean(movSlices),[2 3 1]);

% Assumed function
w = log(w)-mean(log(w(:)));

time = (0:size(w,2)-1)/vidObj.FrameRate; % sec
movingRate = 1; % mm/s

height = time*movingRate;

pixelsPerMM = 10;

width = (1:size(w,1))/pixelsPerMM; % Need to rename, fix

mesh(height(1:length(height)/3),width,w(:,1:length(height)/3))
xlabel('Distance pulled along vessel [mm]','FontSize',16)
ylabel('Length along radius [mm]','FontSize',16)
zlabel('Surface height [unitless]','FontSize',16)
% colormap gray
set(gca,'FontSize',16)