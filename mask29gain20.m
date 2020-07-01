function[Intensity,Noise,LocalBackground] = mask29gain20(ImageIntensity, x, y)

SumIntensity = double(0.0);   %total intensity of that 9*9 square
MaskIntensity = double(0.0);   %intensity of the mask points before background correction
SquareNoise = double(0.0);
BG_20 = 100.274;  %background in EM gain 20
SD_20 = 2.080;    %standard deviation of background in EM gain 20

x0 = round(y + 1);
y0 = round(x + 1);
    
%compute total intensity
for a = (x0 - 4):(x0 + 4)
	for b = (y0 - 4):(y0 + 4)
        SumIntensity = SumIntensity + ImageIntensity(a,b);%add intensity
    end
end

%compute intensity of mask-point prior to background correction
for a = (x0 - 2):(x0 + 2)
	for b = (y0 - 2):(y0 + 2)
		MaskIntensity = MaskIntensity + ImageIntensity(a,b);       
    end
end
MaskIntensity = MaskIntensity + ImageIntensity(x0,(y0 - 3)) +...
                                ImageIntensity(x0,(y0 + 3)) +...
                                ImageIntensity((x0 - 3),y0) +...
                                ImageIntensity((x0 + 3),y0);

%compute noise of mask-point
PointNoise = (sqrt(abs(double(ImageIntensity) - BG_20))) * 1.07864 -...
             ((double(ImageIntensity) - BG_20).^1) * 0.01221 - 2.0772;  %for single point, use the formular got from the beads' data
for a =(x0 - 2):(x0 + 2)
    for b = (y0 - 2):(y0 + 2)
        SquareNoise = SquareNoise + (PointNoise(a,b))^2;
    end
end
SquareNoise = SquareNoise + (PointNoise(x0,(y0-3)))^2 +...
                            (PointNoise(x0,(y0+3)))^2 +...
                            (PointNoise((x0-3),y0))^2 +...
                            (PointNoise((x0+3),y0))^2 + (SD_20)^2;

%result 1: Local Background
    LocalBackground = (SumIntensity - MaskIntensity)/52.0;
%result 2: Intensity of the 29 mask points
    Intensity = MaskIntensity - LocalBackground * 29.0;
%result 3: Noise
    Noise = (SquareNoise)^0.5 + Intensity * 0.06;
               
end
