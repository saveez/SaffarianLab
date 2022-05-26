clear

% Real Data
Dilutions=[0.00391
0.015625
0.0625
0.125
];
Greenper=[0.35779962
0.250278087
0.06630517
0.003246753
];
Redper=[0.309606848
0.14557842
0.050584279
0.023587524
];
Bothper=[0.345751427
0.604143493
0.883110551
0.973165723
];
savg=(Redper+Greenper);
% Simulation Parameter Setup
mu1=40; % left peak average
mu2=80;% right peak average
mu3=200;% right peak average
sigma1=3*sqrt(mu1); % left peak std
sigma2=6*sqrt(mu2); % right peak std
sigma3=8*sqrt(mu3); % right peak std
probl=0.25; % Probability of low distribution
probh=0.7;% 1-Probability of high distribution
frg=[0.00391
0.015625
0.0625
0.125]; % the specific fractions for the experiment
frr=frg;
frd=1-frg-frr;
ncells=5000; %number of cells in the simulation
%initiation of parameters
ncellsgreen(1)=0;
ncellsred(1)=0;
ncellsredgreen(1)=0;
cell=[];
cell(1).np=0;
cell(1).g=0;
cell(1).r=0;
cell(1).d=0;
%start of code
for i=1:4
    ncellsgreen(i)=0;
    ncellsred(i)=0;
    ncellsredgreen(i)=0;
    for j=1:ncells
        m=rand;
        if m<=probl
           n=int16(normrnd(mu1,sigma1)); % left peak
        end
        if (m>probl)&&(m<probh)
           n=int16(normrnd(mu2,sigma2)); % middle peak
        end
        if (m>=probh)
           n=int16(normrnd(mu3,sigma3)); % right peak
        end  
        if n>0
            cell(j).np=n;
            plasmidn=cell(j).np;
            cell(j).g=0;
            cell(j).r=0;
            cell(j).d=0;
            for k=1:plasmidn
                p=rand;
                if p<frg(i)
                    cell(j).g=cell(i).g+1;
                end
                if (p>=frg(i))&&(p<frg(i)+frr(i))
                     cell(j).r=cell(j).r+1;
                end
                if (p>=frg(i)+frr(i))
                     cell(j).d=cell(j).d+1;
                end
            end
            if (cell(j).g==0)&&((cell(j).r>0))
                ncellsred(i)=ncellsred(i)+1;
            end
            if (cell(j).g>0)&&((cell(j).r==0))
                ncellsgreen(i)=ncellsgreen(i)+1;
            end        
            if (cell(j).g>0)&&((cell(j).r>0))
                ncellsredgreen(i)=ncellsredgreen(i)+1;
            end  
        end
    end
end
% Percentage calculations
ntot=ncellsgreen+ncellsred+ncellsredgreen;
npg=ncellsgreen./ntot;
npr=ncellsred./ntot;
npb=ncellsredgreen./ntot;
nps=npr+npg;
% Plotting Simulation Data
scatter(frg, nps,'red');
hold on;
scatter(frg, npb,'blue');
% Plotting Real Data
scatter(Dilutions, savg,'red', "filled");
scatter(Dilutions, Bothper,'blue','filled');
set(gca,'xscale','log')
%set(gca,'yscale','log')
xlabel('Dilutions')
ylabel('Percentage of Fluorescing Cells by Color')
title('Model(o) and Real 293 Data')
ylim([0.001 1.016])
figure
numberofplasmids=[];
j=0;
for i=1:ncells
    numberofplasmids(i)=cell(i).np;
    if numberofplasmids(i)<50
        j=j+1;
    end
end
hist(numberofplasmids,100);
xlim([0 400])
