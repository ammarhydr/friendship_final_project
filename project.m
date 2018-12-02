%% Data loading and preprocessing

data=readtable('loc_gowalla_totalCheckins.txt');
allusers=table2array(data(:,1));
location=table2array(data(:,3:4));
locationID=table2array(data(:,5));
alldata(:,1)=allusers;
alldata(:,2:3)=location;
alldata(:,4)=locationID;
bbbb=table2cell(data(:,2));
d1=datenum(bbbb,'yyyy-mm-ddTHH:MM:SSZ');
dates=datetime(d1, 'ConvertFrom', 'datenum');

idz = find(location(:,1)>= 180); % remove outliers

allusers(idz,:)=[];
location(idz,:)=[];
locationID(idz,:)=[];
dates(idz,:)=[];


%% Sorting the dataset

data1=readtable('loc-gowalla_edges.txt');
data=table2array(data1);
[~,idx] = sort(data(:,1)); % sort just the first column
edges = data(idx,:);

 
%% Number of check-ins for each user.
users=unique(data(:,1));
total=zeros(length(users),2);
for i=1:size(users)
    sizeuser=length(find(allusers==users(i)));
    total(i,1)=users(i);
    total(i,2)=sizeuser; 
end

%% Distance between locations in one user

index=find(allusers==users(1));
user1loc(:,1:2)=location(index,:);
user1loc(:,3)=locationID(index,:);
n=length(user1loc(:,1));
uloc=unique(user1loc(:,3));
for i=1:n
    if i~=n
        getdist(i)=deg2sm(distance(user1loc(i,1:2), user1loc(i+1,1:2)));
    else
        break
    end
end

%% Most visited locations for each user

homesID=zeros(length(users),2);
for j=1:length(users)
    index=find(allusers==users(j));
    clear user1loc
    clear uloc
    clear uloctotal
    user1loc(:,1:2)=location(index,:);
    user1loc(:,3)=locationID(index,:);
    n=length(user1loc(:,1));
    uloc=unique(user1loc(:,3));
    uloctotal=zeros(length(uloc),2);
    for i=1:length(uloc)
        sizeloc=length(find(user1loc(:,3)==uloc(i)));
        uloctotal(i,1)=uloc(i);
        uloctotal(i,2)=sizeloc; 
    end

    
    indexxx=find(uloctotal(:,2)==max(uloctotal(:,2)));
    if length(indexxx) >= 2
        randomIndex = randi(length(indexxx), 1);
        homesID(j,1)=users(j);
        homesID(j,2)= uloctotal(randomIndex,1);
        index=find(locationID==homesID(j,2));
        homesID(j,3:4)=location(index(1),:);
    else
        homesID(j,1)=users(j);
        homesID(j,2)= uloctotal(indexxx,1);
        index=find(locationID==homesID(j,2));
        homesID(j,3:4)=location(index(1),:);
    end
end


%% Distance between most check in places



for i=1:length(users)
    index1=find(allusers==users(i));
    user1=alldata(index1,:);
    time1=dates(index1);
    for s=1:length(user1(:,1))
        for j=1:length(users)
            index2=find(allusers==users(j));
            user2=alldata(index2,:);
            time2=dates(index2);
            for t=1:length(user2(:,1))
                if i~=j
                distance=deg2km(distance(user1(s,2:3), user2(t,2:3)));
                if distance <= 0.05 && abs(time1(s)-time2(t))<= hours1
                    meeting=meeting+1;
                end
                end
            end
        end
    end
end



%% Distance between two user for each check in

index=find(allusers==users(1));
user1loc=(location(index,:));

index=find(allusers==users(66));
user2loc=(location(index,:));


getdist1=zeros(length(user1loc),length(user2loc));
for i=1:length(user1loc)
    for j=1:length(user2loc)
        getdist1(i,j)=deg2km(distance(user1loc(i,:), user2loc(j,:)));
    end
end

min(min(getdist1))
