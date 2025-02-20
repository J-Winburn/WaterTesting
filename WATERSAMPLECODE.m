
% VISION SYSTEM FOR WATER SAMPLES %


%clear workspace
clear
clc
%get webcam list
camList = webcamlist;

cam = webcam('HD Web Camera');
pause(2);
%preview camera image
preview(cam)


%Take picture with camera
pause(3) %give time for camera to turn on 
img=snapshot(cam); %take picture
%imshow(img); %show the picture
%imtool(img);

imwrite(img,"Water.jpg"); %save picture

% Read in and show image 
original = imread('Water.jpg');
%imshow(original);

%crop image to gather just cup and background
rect = [515,80,800,780];
smaller = imcrop(img, rect);
imshow(smaller)
imwrite(smaller, "WaterCropped.jpg" );

% RGB values for inpsecting image colors
imtool("WaterCropped.jpg");

% use imtool to differentiate the image color values


r_channel=smaller(:,:,1);
g_channel=smaller(:,:,2);
b_channel=smaller(:,:,3);

RG_Ratio = double(r_channel)./double(g_channel);  %RED GREEN RATIO
RB_Ratio = double(r_channel)./double(b_channel);  %RED BLUE RATIO
GB_Ratio = double(g_channel)./double(b_channel);  %GREEN BLUE RATIO

RG_Ratio(isnan(RG_Ratio))=0;
RB_Ratio(isnan(RB_Ratio))=0;
GB_Ratio(isnan(GB_Ratio))=0;

bin= ((RG_Ratio < .8)| r_channel < 75 & g_channel < 75 & b_channel < 75);
imshow(bin);

black_and_white=bwareaopen(bin,6000);

imshow(black_and_white)

Bounding_Boxes = regionprops('table',black_and_white,'BoundingBox');
Bounding_Boxes = Bounding_Boxes{:,:};
figure,imshow(smaller),title('Bounding Box Around Sludge and Pipette Tip')
hold on 
for k = 1:size(Bounding_Boxes,1)
    Sticker_Bounding = Bounding_Boxes(k,:);
    rectangle('Position',Sticker_Bounding,'EdgeColor','r','LineWidth',2)
end
hold off
Distance = Bounding_Boxes(1,2)-Bounding_Boxes(2,2) - Bounding_Boxes(2,4);
MMDistance = Distance * .07;
Cm_distance = MMDistance / 10;
%print results of distance 
fprintf("The Distance from the pipette to the sludge is %.2f Millimeters", MMDistance);
fprintf('\n');
fprintf("Or %.2f Centimeters", Cm_distance);
fprintf('\n');
%print results of pixel ratios 
Pipette_Width_Inch = .01 ;
Pipette_Width_Pixels = Bounding_Boxes(2,3);
Ratio_inch = Pipette_Width_Inch / Pipette_Width_Pixels;
Ratio_mm = Ratio_inch * 25.4;
fprintf('The Ratio of Pixels to Distance is  %f inches/pixel or %f mm/pixel\n' ...
    ,Ratio_inch,Ratio_mm);


%%LIFT ARM CONTROL%%-------------------------------------------------------
if MMDistance >= 1.5

    %move lift down%

%repeat process of taking a picture and gathering data%

    pause(3) %give time for camera to turn on 
    img=snapshot(cam); %take picture
    %imshow(img); %show the picture
    %imtool(img);
    
    imwrite(img,"Water.jpg"); %save picture
    
    % Read in and show image 
    original = imread('Water.jpg');
    %imshow(original);
    
    %crop image to gather just cup and background
    rect = [515,80,800,780];
    smaller = imcrop(img, rect);
    imshow(smaller)
    imwrite(smaller, "WaterCropped.jpg" );
    
    % RGB values for inpsecting image colors
    imtool("WaterCropped.jpg");
    
    % use imtool to differentiate the image color values
    
    
    r_channel=smaller(:,:,1);
    g_channel=smaller(:,:,2);
    b_channel=smaller(:,:,3);
    
    RG_Ratio = double(r_channel)./double(g_channel);  %RED GREEN RATIO
    RB_Ratio = double(r_channel)./double(b_channel);  %RED BLUE RATIO
    GB_Ratio = double(g_channel)./double(b_channel);  %GREEN BLUE RATIO
    
    RG_Ratio(isnan(RG_Ratio))=0;
    RB_Ratio(isnan(RB_Ratio))=0;
    GB_Ratio(isnan(GB_Ratio))=0;
    
    bin= ((RG_Ratio < .8)| r_channel < 75 & g_channel < 75 & b_channel < 75);
    imshow(bin);
    
    black_and_white=bwareaopen(bin,6000);
    
    imshow(black_and_white)
    
    Bounding_Boxes = regionprops('table',black_and_white,'BoundingBox');
    Bounding_Boxes = Bounding_Boxes{:,:};
    figure,imshow(smaller),title('Bounding Box Around Sludge and Pipette Tip')
    hold on 
    for k = 1:size(Bounding_Boxes,1)
        Sticker_Bounding = Bounding_Boxes(k,:);
        rectangle('Position',Sticker_Bounding,'EdgeColor','r','LineWidth',2)
    end
    hold off
    Distance = Bounding_Boxes(1,2)-Bounding_Boxes(2,2) - Bounding_Boxes(2,4);
    MMDistance = Distance * .07;
    Cm_distance = MMDistance / 10;
    %print results of distance 
    fprintf("The Distance from the pipette to the sludge is %.2f Millimeters", MMDistance);
    fprintf('\n');
    fprintf("Or %.2f Centimeters", Cm_distance);
    fprintf('\n');
    %print results of pixel ratios 
    Pipette_Width_Inch = .01 ;
    Pipette_Width_Pixels = Bounding_Boxes(2,3);
    Ratio_inch = Pipette_Width_Inch / Pipette_Width_Pixels;
    Ratio_mm = Ratio_inch * 25.4;
    fprintf('The Ratio of Pixels to Distance is  %f inches/pixel or %f mm/pixel\n' ...
        ,Ratio_inch,Ratio_mm);


elseif MMDistance < 1

    %move lift up 
    pause(3) %give time for camera to turn on 
    img=snapshot(cam); %take picture
    %imshow(img); %show the picture
    %imtool(img);
    
    imwrite(img,"Water.jpg"); %save picture
    
    % Read in and show image 
    original = imread('Water.jpg');
    %imshow(original);
    
    %crop image to gather just cup and background
    rect = [515,80,800,780];
    smaller = imcrop(img, rect);
    imshow(smaller)
    imwrite(smaller, "WaterCropped.jpg" );
    
    % RGB values for inpsecting image colors
    imtool("WaterCropped.jpg");
    
    % use imtool to differentiate the image color values
    
    
    r_channel=smaller(:,:,1);
    g_channel=smaller(:,:,2);
    b_channel=smaller(:,:,3);
    
    RG_Ratio = double(r_channel)./double(g_channel);  %RED GREEN RATIO
    RB_Ratio = double(r_channel)./double(b_channel);  %RED BLUE RATIO
    GB_Ratio = double(g_channel)./double(b_channel);  %GREEN BLUE RATIO
    
    RG_Ratio(isnan(RG_Ratio))=0;
    RB_Ratio(isnan(RB_Ratio))=0;
    GB_Ratio(isnan(GB_Ratio))=0;
    
    bin= ((RG_Ratio < .8)| r_channel < 75 & g_channel < 75 & b_channel < 75);
    imshow(bin);
    
    black_and_white=bwareaopen(bin,6000);
    
    imshow(black_and_white)
    
    Bounding_Boxes = regionprops('table',black_and_white,'BoundingBox');
    Bounding_Boxes = Bounding_Boxes{:,:};
    figure,imshow(smaller),title('Bounding Box Around Sludge and Pipette Tip')
    hold on 
    for k = 1:size(Bounding_Boxes,1)
        Sticker_Bounding = Bounding_Boxes(k,:);
        rectangle('Position',Sticker_Bounding,'EdgeColor','r','LineWidth',2)
    end

hold off
Distance = Bounding_Boxes(1,2)-Bounding_Boxes(2,2) - Bounding_Boxes(2,4);
MMDistance = Distance * .07;
Cm_distance = MMDistance / 10;
%print results of distance 
fprintf("The Distance from the pipette to the sludge is %.2f Millimeters", MMDistance);
fprintf('\n');
fprintf("Or %.2f Centimeters", Cm_distance);
fprintf('\n');
%print results of pixel ratios 
Pipette_Width_Inch = .01 ;
Pipette_Width_Pixels = Bounding_Boxes(2,3);
Ratio_inch = Pipette_Width_Inch / Pipette_Width_Pixels;
Ratio_mm = Ratio_inch * 25.4;
fprintf('The Ratio of Pixels to Distance is  %f inches/pixel or %f mm/pixel\n' ...
    ,Ratio_inch,Ratio_mm);
else
  %%HARD CODED STEPS%%
  
% establish connection to base
s1 = serialport('COM4',9600);
pause(4);
% rotate base 180 degrees to allow pipette squeeze to dispense
distance = 1026;
write(s1, int2str(distance),'string');
pause(30);
end




