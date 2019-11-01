function stim=williams(n)
%n=8;
stim=[];
st=randperm(n);
%st=[1:10];
st=mod(st,n);
stt=st';st1=st;
for i=1:n-1
    st1=st1+1;
    st1=mod(st1,n);
    stt=[stt,st1'];
end

rstt=fliplr(stt);

for i=1:n
    stim=[stim,stt(:,i),rstt(:,i)];
end

stim=stim(:,n+1:2*n);
% 
  stim(find(stim==0))=n;
% 
 stim=stim+1;
 stim=stim';
 stim=reshape(stim,1,n*n);