clear all;
load Guitar.MAT;

theorypreprocess = PreProcess(realwave, 10);
residual = norm(theorypreprocess - wave2proc)

subplot(211);
plot(1:length(wave2proc),wave2proc);
subplot(212);
plot(1:length(theorypreprocess),theorypreprocess);