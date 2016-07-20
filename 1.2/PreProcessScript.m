clear all;
load Guitar.MAT;

theorypreprocess = PreProcess(realwave, 10);
residual = norm(theorypreprocess - wave2proc);