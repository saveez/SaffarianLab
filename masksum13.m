function [sum]=masksum13(I,x,y)
x=int16(x);
y=int16(y);
[ls,ks]=size(I);
if ((4<x)&&(x<(ls-4)))&&((4<y)&&(y<(ks-4)))
    I2=I;
    sum=0;
    sum=double(sum);
    I2=double(I2);
    for k=-1:1
        for l=-1:1
            sum=sum+I2(x+k,y+l);
        end
    end
    sum=sum+I2(x,y-2)+I2(x,y+2)+I2(x-2,y)+I2(x+2,y);
    sum=double(sum);
    b(1)=double(I(x-2,y-2));
    b(2)=double(I(x-2,y-1));
    b(3)=double(I(x-1,y-2));
    b(4)=double(I(x+2,y-2));
    b(5)=double(I(x+2,y-1));
    b(6)=double(I(x+1,y-2));
    b(7)=double(I(x-2,y+2));
    b(8)=double(I(x-2,y+1));
    b(9)=double(I(x-1,y+2));
    b(10)=double(I(x+2,y+2));
    b(11)=double(I(x+2,y+1));
    b(12)=double(I(x+1,y+2));    
    bkg=mean(b);
    exstd=sqrt(bkg);
    sum=sum-13*bkg;
else
    sum=0;
end

