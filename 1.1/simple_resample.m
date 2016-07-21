f_sample = 8e3;

tone = [5, 5, 6, 2, 1, 1, 6, 2];    % Tone
rising = [0, 0, 0, 0, 0, 0, -1, 0]; % Rising add 1 each eight degrees
beat = [1,0.5,0.5,2,1,0.5,0.5,2];   % Beats
    
music = make_music(f_sample, tone, beat, rising);
sound(music,f_sample);
pause(5);
sound(music,2 * f_sample);
pause(3);
sound(music,0.5 * f_sample);