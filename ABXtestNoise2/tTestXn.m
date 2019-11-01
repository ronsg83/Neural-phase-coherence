%%
%%
%% sound L: subject stimulus, R: trigger
%%
%clear
close all

taskN = {'Before','PTB','After'};
kinten=0.1;
 outFlag = 0   % 1: with external deveice  0: internal device
%%
%% input subject name
%%
subName = input('Please input your initial : ','s');
todayDD = datestr(datenum(date),'ddmmmyy');
%%
%%
%%
ppp = input('Which condition? [Before : 1, PTB : 2, After : 3]');
taskN(ppp)
%%
%% stimulus sound
%%
%clickS = wavread('click');
clickS = wavread('claves');   %% for click
clickSaw = sawtooth(pi/2295:pi/2295:pi,0)';  %% for trigger

if outFlag
    clickMO = [zeros(2295,1) clickSaw ];
    clickST = [clickS,-clickSaw];
else
    clickMO = zeros(2295,1);
    clickST = clickS;
end

N = 4494;
winG = tukeywin(N,0.2);
for inum = 1:10
    fname = sprintf('SynNoise_%1d',inum);
    temp = wavread(fname);
    aStim(:,inum) = winG .* temp;
end
%%
%% reference sound
%%
if outFlag
    Bhad = [aStim(:,10),zeros(size(aStim(:,10)))]; 
    Bhead= [aStim(:,1),zeros(size(aStim(:,1)))];
else
    Bhad = aStim(:,10); 
    Bhead= aStim(:,1);
end

%%
%% randmize
%%
nb=8;
if 1
if ppp == 1
    %mnum = repmat([1:10]',10,1);
    %mnum = mnum(RanRan);
    mnum=[williams(nb),williams(nb)];
    mnum=[williams(nb)];
    knum=1;
    % mnum=reshape(mnum',1,size(mnum,1)*size(mnum,2));
    mnum=mnum';
    
    Bnum = [repmat([1 2],length(mnum)/2,1);repmat([2 1],length(mnum)/2,1)];
    
    xxx = [Bnum,mnum];
    xxxR = xxx(randperm(length(mnum)),:);
    %save([subName,todayDD,'_mnum'],'mnum');
    %clear mnum Bnum xxx
else
    load([subName,todayDD,'_pTestBefore'],'xxxR');
end
end


inum = 1;
penalTime = 1;
pFlag = 1;  % for key protection
%%
%% loop start
%%
while inum < length(mnum)+1
    
    if outFlag
        StimSig = [aStim(:,xxxR(inum,3)),zeros(size(aStim(:,1)))];
    else
        StimSig = aStim(:,xxxR(inum,3));
    end
    
    
    mm = aTestABXn(pFlag);   % show window
    switch mm
        case 'A'
            if ~pFlag
                if 0
                if xxxR(inum,1) == 1
                    tt(inum) = 0;
                else
                    tt(inum) = 1;
                end
                else
                    tt(inum) = 0;
                end
                
                tTime(inum) = penalTime*toc;

                inum = inum + 1;
                stFlag = 0;

                sound(kinten*clickST,44100) %% trigger for stop PTB   
                pFlag = 1;
            end

        case 'B'
            if ~pFlag
                if 0
                if xxxR(inum,1) == 1
                    tt(inum) = 1;
                else
                    tt(inum) = 0;
                end
                else
                    tt(inum) = 1;
                end
                
                tTime(inum) = penalTime*toc;

                inum = inum + 1;
                stFlag = 0;

                sound(kinten*clickST,44100) %% trigger for stop PTB       
                pFlag = 1;
            end

        case 'Listen'
            if pFlag
                tic
                pause(0.05);
                %%
                %% for reference
                %%
                if xxxR(inum,1) == 1
                    %sound(Bhead,10000);   %% first reference
                    stNum = toc;
                    tttt= 0.0;
                    while tttt < 0.05
                        edNum = toc;
                        tttt = edNum - stNum;
                    end
                    %%%
                    %sound(Bhad,10000);   %% second reference
                else
                    %sound(Bhad,10000);   %% first reference
                    stNum = toc;
                    tttt= 0.0;
                    while tttt < 0.05
                        edNum = toc;
                        tttt = edNum - stNum;
                    end
                    %sound(Bhead,10000);  %% second reference
                end

                stNum = toc;
                tttt= 0.0;
                while tttt < 0.15
                    edNum = toc;
                    tttt = edNum - stNum;
                end
                %%
                pause(0.1)
                sound(kinten*clickMO,44100) %% trigger for start PTB
                pause(0.1)
                %%
                stNum = toc;
                tttt= 0.0;
                while tttt < 0.15
                    edNum = toc;
                    tttt = edNum - stNum;
                end
                sound(StimSig,10000);   %% stimulus
                stFlag = 0;
                if ~pFlag
                    penalTime = penalTime + 1;
                end
                pFlag = 0;
            end

        otherwise
            disp('Unknown')
    end
    penalTime = 1;
end

closereq
disp('Finish ')
ss=[];uuu=[];
%return
for inum = 1:nb
    uuu = find(xxxR(:,3) == inum);
    ss(inum) = length(find(tt(uuu)));
    rTimeSum(inum) = sum(tTime(uuu));
end

%figure(1)
%plot(1:10,10-ss,'*')
%grid on

ydata = (ss)/(knum*nb);
xdata = [1:nb];
x0 = [1 1 1];
% [xR,bb] = lsqcurvefit(@logFun,x0,xdata,ydata);
% 
% yE = logFun(xR,xdata);
% 
% boundV = fzero(@(x) logFun(xR,x)-0.5,5);
% 
% if 0
%     
% figure(ppp)
% plot(xdata,ydata,'o--')
% hold on
% plot(xdata,yE,'b','Linewidth',2)
% plot(boundV,0.5,'rs')
% text(boundV,0.46,num2str(boundV))
% hold off
% grid on
% xlabel('head <-> had')
% title([subName,todayDD,char(taskN(ppp))])
% 
% figure(ppp+10)
% bar(rTimeSum)
% title('summation of response time')
% ylabel('sum of time')
% grid on
% end


%kkk = input('Do you save data? (Y/N)  : ','s')
%if kkk == 'y' | kkk == 'Y'
    save([subName,todayDD,'_pTest',char(taskN(ppp))],'ydata','mnum','tTime','tt','Bnum','xxxR')
%end


