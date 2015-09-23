%% Cylindrical reconfiguration


%%
clear, close, clc
%% Pick file and show image
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
    mov(:,:,ind) = originalImage(yBounds(10:end-10),xBounds(10:end-10));
    
    waitbar(ind/vidFrames,h)
end

close(h)



%% Convert selected radius to "slice"

radiusOfImage = size(mov,1)/2;

outerOffset = 20;
innerOffset = 2;

radiusOfCrop_outer = radiusOfImage-outerOffset;
radiusOfCrop_inner = radiusOfCrop_outer-innerOffset;

rMin = radiusOfCrop_inner/radiusOfImage;
rMax = radiusOfCrop_outer/radiusOfImage;
reconstructedHeight = radiusOfCrop_outer-radiusOfCrop_inner;
% reconstructedWidth = floor((radiusOfCrop_outer+radiusOfCrop_inner)*2*pi/2);
reconstructedWidth = floor(radiusOfCrop_outer*2*pi);

im1_convert = ImToPolar(mov(:,:,1),rMin,rMax,...
    reconstructedHeight,reconstructedWidth);

figure, mesh(im1_convert)
%%
clear movSlices
h = waitbar(0);
for ind = 1:vidFrames-1
    movSlices(:,:,ind) = ImToPolar(mov(:,:,ind),rMin,rMax,...
        reconstructedHeight,reconstructedWidth);
        waitbar(ind/vidFrames,h)
end
close(h)

%% Effects of Kalman filtering
filteredStack = kalmanStack(movSlices,0.8,0.5);
implay(uint8(movSlices))
implay(uint8(filteredStack))

%%
roughnessMap = permute(mean(movSlices),[2 3 1]);
imagesc(roughnessMap)
% surf(roughnessMap(60:513,78:300),'EdgeColor','none')
colormap gray

set(gca,'FontSize',16)
xlabel('Pixel index')
ylabel('Pixel index')
% zlabel('Pixel intensity')

%%
xlimit = 653;%size(roughnessMap,2);
ylimit = 792;
x = cat(1,roughnessMap(ylimit:end,1:xlimit),roughnessMap(1:ylimit,1:xlimit));
imagesc(x)

%%
plot(roughnessMap(:,200),'Color',[0.6 0.6 0.6],'LineWidth',2)
hold on
plot(smooth(roughnessMap(:,200),20),'k','LineWidth',2)

set(gca,'FontSize',16)
xlabel('Pixel index')
ylabel('Pixel intensity')

%%
plot(roughnessMap(800,:),'Color',[0.6 0.6 0.6],'LineWidth',2)
hold on
plot(smooth(roughnessMap(800,:),20),'k','LineWidth',2)
set(gca,'FontSize',16)
xlabel('Pixel index')
ylabel('Pixel intensity')

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





%% 
[xx yy] = meshgrid(1:size(mov,1));
R = sqrt(xx.^2 + yy.^2);

%%
middle = 348/2;
for ind = 1:348/2-1
    
    images(middle-ind:middle+ind,middle-ind:middle+ind,ind) = mov(middle-ind:middle+ind,middle-ind:middle+ind,1);
    
    images1(middle-ind:middle+ind,middle-ind,ind) = ...
        mov(middle-ind:middle+ind,middle-ind,1);
    images1(middle-ind:middle+ind,middle+ind,ind) = ...
        mov(middle-ind:middle+ind,middle+ind,1);
    images1(middle-ind,middle-ind:middle+ind,ind) = ...
        mov(middle-ind,middle-ind:middle+ind,1);
    images1(middle+ind,middle-ind:middle+ind,ind) = ...
        mov(middle+ind,middle-ind:middle+ind,1);
    
    images1(middle-ind:middle+ind,middle-ind,ind) = ...
        mov(middle-ind:middle+ind,middle-ind,1);
    images1(middle-ind:middle+ind,middle+ind,ind) = ...
        mov(middle-ind:middle+ind,middle+ind,1);
    images1(middle-ind,middle-ind:middle+ind,ind) = ...
        mov(middle-ind,middle-ind:middle+ind,1);
    images1(middle+ind,middle-ind:middle+ind,ind) = ...
        mov(middle+ind,middle-ind:middle+ind,1);
    
    wall1 = linspace(1,12.5,ind*2+1);
    wallSurf1 = double(images1(middle-ind,middle-ind:middle+ind,ind));
    
    wallStretch1(:,ind) = spline(wall1,wallSurf1,linspace(1,12.5,347));
    
end


%%

wall = linspace(1,10,length(51:347-50))
wallSurf = double(images1(347-50,51:347-50,173-50))

wallStretch = spline(wall,wallSurf,linspace(1,10,347))



