
load('edgesandmeetings.mat');
t=1;
meetusers=unique(meet(:,1));
for i=1:length(meetusers)
    idx=find(edges(:,1)==meetusers(i));
    filt=edges(idx,:);
    idx1=find(meet(:,1)==meetusers(i));
    filt1=meet(idx1,:);
    a=unique(filt1(:,2));
    for j=1:length(a)
        b=find(filt(:,2)==a(j));
        if ~isempty(b)
            test(t)=1;
            t=t+1;
        else
            test(t)=0;
            t=t+1;
        end
    end   
end

true=sum(test,2);
false=length(test)-true;
