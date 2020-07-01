function [maxintensity, maxx, maxy]=optimizeposition13(I,x,y)
for i=1:3
    for j=1:3
        int(i,j)=masksum13(I,y+j-2,x+i-2);
    end
end
max=0;
maxintensity=0;
maxx=x;
maxy=y;
for i=1:3
    for j=1:3
        if int(i,j)>max;
            maxx=x+i-2;
            maxy=y+j-2;
            maxintensity=int(i,j);
            max=maxintensity;
        end
    end
end
