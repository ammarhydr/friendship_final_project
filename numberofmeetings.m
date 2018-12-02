%%number of meetings
alldata1=alldata(1:10000,:);
allusers=alldata1(:,1);
dates1=dates(1:10000,1);
users=unique(alldata1(:,1));
meeting=zeros(100000,3);
m=1;
for i=1:length(users)
    index1=find(allusers==users(i));
    user1=alldata1(index1,:);
    time1=dates(index1);
    for s=2:length(user1(:,1))
        for j=1:length(users)
            index2=find(allusers==users(j));
            user2=alldata1(index2,:);
            time2=dates(index2);
            for t=1:length(user2(:,1))
                if i~=j
                dist=deg2km(distance(user1(s,2:3), user2(t,2:3)));
                    if dist <= 0.05 && abs(time1(s)-time2(t))<= hours(1)
                        meeting(m,1)=1;
                        meeting(m,2)=users(i,1);
                        meeting(m,3)=users(j,1);
                        meettime(m,1)=time1(s);
                        m=m+1;
                    end
                end
            end
        end
    end
    i
end