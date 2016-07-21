clear all; close all;

f_sample = 8e3;

tones = [5, 5, 6, 2, 1, 1, 6, 2];
rising = [0, 0, 0, 0, 0, 0, -1, 0];
beat = [1,0.5,0.5,2,1,0.5,0.5,2];
    
music = make_music_diffharmon(f_sample, tones, beat, rising, 'F');
%music = make_music_sameharmon(f_sample, tones, beat, rising);
sound(music,f_sample);
