files= dir('*.wav');
numfiles=length(files);

sum=0;
for i=1:numfiles
    disp(files(i));
    [x, fs] = audioread(files(i).name);
    f0raw = MulticueF0v14(x,fs);
    ap = exstraightAPind(x,fs,f0raw);
    [n3sgram,param]=exstraightspec(x,f0raw,fs);
    subplot(4,2,2);
    synthesized_signal = exstraightsynth(f0raw,n3sgram,ap,fs);
    
    f0raw2 = MulticueF0v14(synthesized_signal,fs);
    
    f0raw=f0raw(1:min(size(f0raw,1),size(f0raw2,1)));
    f0raw2=f0raw2(1:min(size(f0raw,1),size(f0raw2,1)));
    f0=sqrt(mean((f0raw-f0raw2).^2));
    sum=sum+f0;
end

sum=sum/numfiles;