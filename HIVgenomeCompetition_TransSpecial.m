suminfectivity(1:100)=0;
totalproteinpackaged=2000;
nproteinsretained=200;
nproteinneededforinfectivity=200;
ncytosolicproteinspackaged=totalproteinpackaged-2*nproteinsretained;
for k=1:100
    frmax=100;
    fr=k;
    cDNA=30;
    gRNAtranscritionfactor=500;
    gRNAtranslationfactor=100;
    NgRNAWT=gRNAtranscritionfactor*cDNA*fr/frmax;
    NgRNAmut=gRNAtranscritionfactor*cDNA*(frmax-fr)/frmax;
    ncytosolicproteinwt=NgRNAWT*gRNAtranslationfactor;
    ncytosolicproteinmut=NgRNAmut*gRNAtranslationfactor;
    nvirions=(NgRNAWT+NgRNAmut)/2;
    for i=1:nvirions
        %initializing virions
        virion(i).gRNAwt=0;
        virion(i).gRNAmut=0;
        virion(i).nproteinwt=0;
        virion(i).nproteinmut=0;
        virion(i).ntransproteinwt=0;
        virion(i).ntransproteinmut=0;
        virion(i).infectivity=0;
    end
    for i=1:nvirions
        %packaging genomes
        p=rand;
        if p<=fr/frmax
            virion(i).gRNAwt=virion(i).gRNAwt+1;
        else
            virion(i).gRNAmut=virion(i).gRNAmut+1;
        end
        p=rand;
        if p<=fr/frmax
            virion(i).gRNAwt=virion(i).gRNAwt+1;
        else
            virion(i).gRNAmut=virion(i).gRNAmut+1;
        end
        %end packaging genmes
        %packaging proteins
        virion(i).nproteinwt=virion(i).gRNAwt*nproteinsretained;
        virion(i).nproteinmut=virion(i).gRNAmut*nproteinsretained;
        virion(i).ntransproteinwt=virion(i).gRNAwt*nproteinsretained;
        virion(i).ntransproteinmut=virion(i).gRNAmut*nproteinsretained;        
        for j=1:ncytosolicproteinspackaged
            p=rand;
            if p<=fr/frmax
                virion(i).nproteinwt=virion(i).nproteinwt+1;
            else
                virion(i).nproteinmut=virion(i).nproteinmut+1;
            end
        end
        %end protein packaging
        %asses infectivity
        if virion(i).ntransproteinwt>=nproteinneededforinfectivity
            virion(i).infectivity=1;
        end
    end
    suminfectivity(k)=0;
    for i=1:nvirions
        suminfectivity(k)=suminfectivity(k)+virion(i).infectivity;
    end
end
suminfectivity=suminfectivity*1000000/max(suminfectivity);
plot(suminfectivity)
set(gca,'xscale','log')
set(gca,'yscale','log')