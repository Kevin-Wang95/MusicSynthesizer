function music = make_music_sameharmon(f_sample, tones, beat, rising)
    load tone_base_harmonic.mat

    beats_time = 0.5;
    
    fre = [349.23,392,440,466.16,523.25,587.33,659.25];
    tone2fre = zeros(1,length(tones));
    for i=1:length(tones)
        tone2fre(i) = fre(tones(i))* 2^(rising(i));
    end
    
    standard_time = linspace(0, 4*(1-1/f_sample),4*f_sample);
    music=zeros(size(standard_time));
    
    t_start = 0;
    
    for i=1:length(tone2fre)
        music = refine_guitar_toneshape(standard_time, t_start, beats_time*beat(i), tone2fre(i) ,music, ...
            [1.4572 0.9587 1.0999 0 0]);
        t_start = t_start + beats_time*beat(i);
    end
    
    % Make sure the maxium is lower than 1
    music = music/max(music);
        