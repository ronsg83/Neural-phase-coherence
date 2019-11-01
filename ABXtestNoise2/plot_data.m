
clear
close all

%fname = 'DJO11MAY06_pTest';
%fname = 'MT12MAY06_pTest';
%fname = 'GR12MAY06_pTest';
fname = 'AM19MAY06_pTest';
%fname = 'ggh19MAY06_pTest';
%fname = 'dl19MAY06_pTest';
%fname = 'mo19MAY06_pTest';

%taskN ={'B','Pup','Bafter','Pdown'}
%taskN = {'Before','PTB','After'};
taskN = {'Before','After'};

xdata = [1:10];
x0 = [1 1 1];

for inum = 1:length(taskN)
str = [fname,char(taskN(inum))];
load(str)

temp = logFun(xR,xdata);
yE(:,inum) = temp';
yData(:,inum) = ydata;

%boundV(inum) = fzero(@(x) logFun(xR,x)-0.5,5);

end

%return

figure(1)

sNum = 1:length(taskN);
plb = plot(xdata,yE(:,sNum));
hold on
plot(xdata,yData(:,1),'b*')
plot(xdata,yData(:,2),'go')
%plot(xdata,yData(:,3),'rx')

%plot(boundV(sNum),0.5,'rs')
%text(boundV+0.2,0.5,num2str(boundV))
hold off
grid on
xlabel('head <-> had')
%title([subName,todayDD])
legend(plb,taskN,4)
title(fname)