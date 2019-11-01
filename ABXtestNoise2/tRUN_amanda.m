%%
%%
%% sound L: subject stimulus, R: trigger
%%
clear
close all
clear all;


taskN = {'Before','Ptb','After'};
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
% ppp = input('Which condition? [Before : 1, PTB : 2, After : 3]');
% taskN(ppp)
%%
%% stimulus sound
%%
%clickS = wavread('click');

ptm=2.5*60;

ppp=1;qqq=1;
knoise=0.1;
test_speech_noise;

tTestXn0
disp('End of Round 1');
close all

knoise=0.1;
test_speech_noise;
pause(ptm)

ppp=1;qqq=2;
tTestXn0
disp('End of Round 2');
close all

% pause(ptm)
% 
% ppp=1;qqq=3;
% tTestXn0
% disp('End of Round 3');
% close all
% 
% pause(ptm)
% 
% ppp=1;qqq=4;
% tTestXn0
% disp('End of Round 4');
% close all
% 
% pause(ptm)
% 
% ppp=1;qqq=5;
% tTestXn0
% disp('End of Round 5');
% close all
% 
% pause(ptm)
% 
% ppp=1;qqq=6;
% tTestXn0
% disp('End of Round 6');
% pause(ptm)
% 
% ppp=1;qqq=7;
% tTestXn0
% disp('End of Round 7');
% close all
% 
% pause(ptm)
% 
% ppp=1;qqq=8;
% tTestXn0
% disp('End of Round 8');
% close all
% 
% pause(ptm)
% 
% ppp=1;qqq=9;
% tTestXn0
% disp('End of Round 9');
% close all
% knoise=0.9;
% test_speech_noise;
% pause(ptm)
% ppp=1;qqq=10;
% tTestXn0
% disp('End of Round 10');
disp('End of Session')
close all
