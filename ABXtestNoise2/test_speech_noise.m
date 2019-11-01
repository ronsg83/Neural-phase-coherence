[s1,f]=wavread('EHtoAE_01.wav');
[s2,f]=wavread('EHtoAE_02.wav');
[s3,f]=wavread('EHtoAE_03.wav');
[s4,f]=wavread('EHtoAE_04.wav');
[s5,f]=wavread('EHtoAE_05.wav');
[s6,f]=wavread('EHtoAE_06.wav');
[s7,f]=wavread('EHtoAE_07.wav');
[s8,f]=wavread('EHtoAE_08.wav');
[s9,f]=wavread('EHtoAE_09.wav'); %use sound to hear the sample
[s10,f]=wavread('EHtoAE_10.wav');


syn=[s1';s2';s3';s4';s5';s6';s7';s8';s9';s10'];

sr=f;

% hs=spectrum.burg;
% psd(hs,s1,'Fs',f);
% hold on;psd(hs,s10,'Fs',f);

% [p1,w1]=pburg(s1,14,[],f); %%% use Burg's method to compute psd
% [p2,w2]=pburg(s,14,[],f);
%figure(1);hold on;plot(w1,log(p1),'b');hold on;plot(w2,log(p2),'r');

syn1=[];
for i=1:size(syn,1)
s=syn(i,:);
randn('state',0);
n1=randn(size(s));ff=[0:1/49:1];b=cfirpm(80,ff,exp(-4*ff));n1r=filter(b,1,n1);

rmsWin = 20;%in msec
rmsThr = .2;
mu = 0.98;
wSize = 25;
nSamps = length(s);
win = round(rmsWin*f/1000);
b = 2 * hamming(win)/win;
rms = sqrt(abs(filtfilt(b,1,s.^2)));

rmsThr = max(rms)*rmsThr;
ns=n1r.*rms;
ns=ns*sqrt(sum(s.^2)/sum(ns.^2));
% ns=n1r;
% ns=8*ns*sum(s.^2)/sum(ns.^2);
%[p1,w1]=pburg(ns,14,[],f);figure;plot(w1,log(p1));[p1,w1]=pburg(s,14,[],f);hold on;plot(w1,log(p1),'r');
ns=(knoise)*ns+(1-knoise)*s;
name=strcat('SynNoise_',int2str(i));
wavwrite(ns,f,name);
syn1=[syn1;ns];
end
% k = find(diff(rms > rmsThr));			% above-threshold regions to analyze
% if rms(1) > rmsThr, k = [1 ; k]; end;
% if rms(end) > rmsThr, k = [k ; nSamps]; end;
% bnds = reshape(k, 2, length(k)/2)';
% 
% 
% %pre-emphasis
% 
% urS = s;
% urBnds = bnds;
% dur = 1000*(nSamps-1)/f;
% if mu > 0,
%     s = filter([1 -mu], 1, s);				% s[n] = s[n] - mu*s[n-1]
%     s = [s(2:end);s(end)];					% fix filter delay
% end;
% % 
%  s = s - mean(s);
% 
% 
% % remove DC bias
% wSizeS = floor(wSize*f/1000);				% analysis frame length (samps)
% win = hamming(wSizeS);						% window
% %win=win/sum(win);
% shift = 1;						% overlap (fractional samples)
% nFrames = round(nSamps/shift);				% number of analysis frames
% fmts = repmat(NaN,nFrames,1);	
% fmts1 = repmat(NaN,nFrames,1);
% % [nFrames x F1..F5]
% bw = fmts;
% k = find(diff(bnds,1,2) < shift*2);
% 
% es=[];es1=[];
% for fi = 1 : nFrames-wSizeS,							
% 
% if (fi>=bnds(1)&fi<=bnds(end)-wSizeS)
%     
%     ss=s(fi:fi+wSizeS-1);
%     ss=ss.*win;
%     a=arburg(ss,14);
%     r = flipud(sort(roots(a)));	
%     r1=r(1);% roots
% %     f = angle(r(find(imag(r(1)) > 0)))' * sr/(2*pi);
%     ff = angle(r(1))' * sr/(2*pi);
%     ff1=ff;
%     r1=abs(r1).*exp(j*2*pi*ff1/sr)';
%     r1=real(r1)+j*abs(imag(r1));
%     ff2=ff+147;
%     r2=abs(r1).*exp(j*2*pi*ff2/sr)';
%     r2=real(r2)+j*abs(imag(r2));
%     
%     r1=[r1;conj(r1);r2;conj(r2);r(3:end)];
%     %r1=[r1;conj(r1);r(3:end)];
%     %a=poly(r);
%     a1=poly(r1);a1=real(a1);
%     
%     bb=[r(1);conj(r(1))];
%     bb=real(poly(bb));
%     
%     
%     ss0=filter([0 -a(2:end)],1,ss);
%     e=ss-ss0;
% %     ss1=filter([0 -a1(2:end)],[1 bb(2:end)],ss);
% %     ss1=ss1+ss-ss0;
%     %ss1=ss-ss0;
% %     ss1=filter([0 -a1(2:end)],[1 bb(2:end)],ss1);
%     ss1=filter(bb,a1,e);
%     
%     es1=[es1;ss1(wSizeS/2)];es=[es;ss0(wSizeS/2)];
%     
%     a0=arburg(ss,14);
%     
%   r = flipud(sort(roots(a0)));					
%   f = angle(r(find(imag(r) > 0)))' * sr/(2*pi);	
%   b = -log(abs(r(find(imag(r) > 0))))' * sr/pi;	
%   [f,idx] = sort(f);											
%     bwClip=600;
%           b = b(idx);
%   		k = find(b >= bwClip);						
%   		f(k) = [];      
%   
%   
%   fmts(fi,1:1) = f(1:1);	
%          
%   a11=arburg(ss1,14);
%          r = flipud(sort(roots(a11)));					% roots
%   f = angle(r(find(imag(r) > 0)))' * sr/(2*pi);	% formants
%   b = -log(abs(r(find(imag(r) > 0))))' * sr/pi;	% bandwidths
%   [f,idx] = sort(f);	
%    bwClip=600;
%           b = b(idx);
%   		k = find(b >= bwClip);						% clip formants with excessive BW
%   		f(k) = [];
%  
%   
%          fmts1(fi,1:1) = f(1:1);	
% 
% end   
% end
% 
% 
% 
% es_s=[s(1:bnds(1)+wSizeS/2);es;s(bnds(end)-wSizeS/2:end)];
% es_s1=[s(1:bnds(1)+wSizeS/2-2);es1;s(bnds(end)-wSizeS/2:end)];
% es_s1=es_s1.*sum(es_s.^2)/sqrt(sum(es_s1.^2));
% 
% sound(2*es_s,sr),sound(2*es_s1,sr)
% sound(s1,sr),sound(s10,sr)
% 
%   [p1,w1]=pburg(s,14,[],sr); %%% use Burg's method to compute psd
%   [p2,w2]=pburg(es_s1,14,[],sr);
% % figure(1);hold on;plot(w1,log(p1),'b');hold on;plot(w2,log(p2),'r');
% % figure(2);hold on;plot(fmts);hold on;plot(fmts1,'r');
% 
% 
% %%%COMPUTING SPECGRAM
% 
% [s1,f]=wavread('EHtoAE_01.wav');
% [s5,f]=wavread('EHtoAE_05.wav'); %use sound to hear the sample
% [s10,f]=wavread('EHtoAE_10.wav');
% 
% [y,f,t,p] = spectrogram(s1,96,94,4096,10000);figure(1);imagesc(t,f,10*log10(abs(p)));axis xy; axis tight; colormap(jet);
% get(gca,'clim');
% set(gca,'CLim',[-75 -45]);ylim([0 3000]);
% 
% [y,f,t,p] = spectrogram(s5,96,94,4096,10000);figure(2);imagesc(t,f,10*log10(abs(p)));axis xy; axis tight; colormap(jet);
% get(gca,'clim');
% set(gca,'CLim',[-75 -45]);ylim([0 3000]);
% 
% [y,f,t,p] = spectrogram(s10,96,94,4096,10000);figure(3);imagesc(t,f,10*log10(abs(p)));axis xy; axis tight; colormap(jet);
% get(gca,'clim');
% set(gca,'CLim',[-75 -45]);ylim([0 3000]);
% 
% %%%%DIRECTORY EA
% fid=fopen('ta_omega_percept_force0_05.audio','rb');soundf=fread(fid,inf,'int16');fclose(fid);
% yy1=readomegadatafile('ta_omega_percept_force0_05.omega');
% xx1=yy1.position_xyz;fs=round(length(soundf)/size(xx1,1)); ss1=yy1.scratch1;
% s=soundf(round(fs*0.72*10000):round(fs*0.82*10000));
% %s1=s(25000:65000);
% [b7,a7]=butter(8,2*5000/(fs*1000));
% s1f=filtfilt(b7,a7,s);
% 
% s11f=decimate(s,5);
% %s11f=filtfilt(b7,a7,s11f);
% s11f=s11f/sqrt(sum(s11f.^2)/11.235);
% 
% 
% 
% [y,f,t,p] = spectrogram(s11f,96,94,1024,10000);figure(4);imagesc(t,f,10*log10(abs(p)));axis xy; axis tight; colormap(jet);
% get(gca,'clim');
% set(gca,'CLim',[-75 -45]);ylim([0 3000]);
% 

