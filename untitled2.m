clear getdist1
clear dist
getdist1=zeros(length(users(:,1)),1);
dist=zeros(length(users(:,1)),1);
for i=1:length(users(:,1))
    parfor j=1:length(users(:,1))
        if i==j
            getdist1(j,1)=10e10;
        else
            getdist1(j,1)=deg2km(distance(homesID(i,3:4), homesID(j,3:4)));
        end
    end
    dist(i,1)=min(getdist1);
end