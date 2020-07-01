function [sum]=masksum36(I,x,y)
x=int16(x);
y=int16(y);
[ls,ks]=size(I);
if ((4<x)&&(x<(ls-4)))&&((4<y)&&(y<(ks-4)))
    I2=I;
    sum=0;
    sum=double(sum);
    I2=double(I2);
    for k=-2:2
        for l=-2:2
            sum=sum+I2(x+k,y+l);
        end
    end
    sum=sum+I2(x,y-3)+I2(x,y+3)+I2(x-3,y)+I2(x+3,y);
    sum=double(sum);
    b(1)=double(I(x-3,y-3));
    b(2)=double(I(x-2,y-3));
    b(3)=double(I(x-1,y-3));
    b(4)=double(I(x+1,y-3));
    b(5)=double(I(x+2,y-3));
    b(6)=double(I(x+3,y-3));
    b(7)=double(I(x-3,y+3));
    b(8)=double(I(x-2,y+3));
    b(9)=double(I(x-1,y+3));
    b(10)=double(I(x+1,y+3));
    b(11)=double(I(x+2,y+3));
    b(12)=double(I(x+3,y+3));
    b(13)=double(I(x-3,y-2));
    b(14)=double(I(x-3,y-1));
    b(15)=double(I(x-3,y+1));
    b(16)=double(I(x-3,y+2));
    b(17)=double(I(x+3,y-2));
    b(18)=double(I(x+3,y-1));
    b(19)=double(I(x+3,y+1));
    b(20)=double(I(x+3,y+2));
    bkg=mean(b);
    exstd=sqrt(bkg);
    sum=sum-29*bkg;
else
    sum=0;
end

