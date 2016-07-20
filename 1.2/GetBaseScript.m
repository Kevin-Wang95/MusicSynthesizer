clear all; close all;
load Guitar.MAT;

f_sample = 8e3;
permit_error = 0.1;
[ tone, basefre, harmonic ] = GetBaseandHarmonic( f_sample, wave2proc, permit_error );
disp('Tone:');
disp(tone); 
disp('Frequency:');
disp(basefre);
disp('Harmonic Coeff:');
disp(harmonic);

