function [sum]=masksum77(I,x,y)
x=int16(x);
y=int16(y);
[ls,ks]=size(I);
if ((5<x)&&(x<(ls-5)))&&((5<y)&&(y<(ks-5)))
    I2=I;
    sum=0;
    sum=double(sum);
    I2=double(I2);
    for k=-4:4
        for l=-4:4
            sum=sum+I2(x+k,y+l);
        end
    end
    sum=sum-I2(x+4,y+4)-I2(x+4,y-4)-I2(x-4,y+4)-I2(x-4,y-4);
    sum=double(sum);
    for k=-5:5
        b(k+6)=I2(x+5,y+k);
    end
    for k=-5:5
        b(k+17)=I2(x-5,y+k);
    end
    for k=-4:4
        b(k+28)=I2(x+k,y+5);
    end
    for k=-4:4
        b(k+37)=I2(x+k,y-5);
    end
    bkg=mean(b);
    exstd=sqrt(bkg);
    sum=sum-77*bkg;
else
    sum=0;
end

