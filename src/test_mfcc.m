files= dir('*.wav');
numfiles=length(files);

sum=0;
for i=1:1
    disp(files(i));
    [x, fs] = audioread(files(i).name);
    m1=mfcc(x,fs);
    f0raw = MulticueF0v14(x,fs);
    ap = exstraightAPind(x,fs,f0raw);
    [n3sgram,param]=exstraightspec(x,f0raw,fs);
    synthesized_signal = exstraightsynth(f0raw,n3sgram,ap,fs);
    
    m2=mfcc(synthesized_signal,fs);
    
    
    m0=sqrt(mean((m1-m2).^2));
    sum=sum+m0;
end

sum=sum/numfiles;