function P = logFun(x,t)

a = x(1);
m = x(2);
n = x(3);
%tau = x(4);
tau = 1;
P = a*(1+m*exp(-t/tau))./(1+n*exp(-t/tau));