% Distance between most checkin locations for user pairs 
getdist2=zeros(length(maxhomes(:,1)),1);
dist=zeros(length(maxhomes(:,1)),1);

for i=1:length(maxhomes(:,1))
    parfor j=1:length(maxhomes(:,1))
        if i==j
            getdist1(j,1)=10e10;
        else
            getdist2(j,1)=deg2km(distance(maxhomes(i,3:4), maxhomes(j,3:4)));
        end
    end
    dist(i,1)=min(getdist2);
    i
end
%% Plot results

sortdist=sort(dist2);
m=mean(sortdist);
v=std(sortdist);
gm=gmdistribution(m,v);
X=pdf(gm,sortdist);
figure,plot(sortdist,X,'linewidth',2)
title('Most checkin pdf')
leg = legend('Gowalla','location','ne');
set(leg,'interpreter','latex','fontsize',13)
xlabel('Distance between most checkin locations (km)','fontsize',15)
ylabel('Probability','fontsize',15)


