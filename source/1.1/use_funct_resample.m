f_sample = 8e3;

tone = [5, 5, 6, 2, 1, 1, 6, 2];
rising = [0, 0, 0, 0, 0, 0, -1, 0];
beat = [1,0.5,0.5,2,1,0.5,0.5,2];

[Q, P] = rat(2^(1/12), 10^(-9));  % Find the rational approximation.
music = make_music(f_sample, tone, beat, rising);
sound(music, f_sample);
% sound(resample(music, P, Q), f_sample);

