clc;
clear all;
close all;
fc=20;
fm=2;
fs=1000;
t=1;
n=[0:1/fs:t]
n=n(1:end-1)
duty=20;
s= square(2*pi*fc*n,duty);
s(find(s<0)) = 0;
figure(1);
m=sin(2*pi*fm*(n-1));
period_samp=length(n)/fc;
ind=1:period_samp:length(n);
on_samp=ceil(period_samp*duty/100);
on_samp
pam=zeros(1,length(n));
for i=1:length(ind)
pam(ind(i):ind(i)+on_samp) = m(ind(i));
end
subplot(3,1,1);plot(n,s);ylim([-0.2 1.2]);
subplot(3,1,2);plot(n,m);ylim([-1.2 1.2]);
subplot(3,1,3);plot(n,pam);ylim([-1.2 1.2]);