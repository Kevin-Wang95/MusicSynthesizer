function music = make_music(f_sample, tone, beat, rising)
    beats_time = 0.5;
    
    fre = [349.23,392,440,466.16,523.25,587.33,659.25];
    tone2fre = zeros(1,length(tone));
    for i=1:length(tone)
        tone2fre(i) = fre(tone(i))* 2^(rising(i));
    end
    
    standard_time = linspace(0, 4*(1-1/f_sample),4*f_sample);
    music=zeros(size(standard_time));
    
    t_start = 0;
    
    for i=1:length(tone2fre)
        music = make_toneshape(standard_time, t_start, beats_time*beat(i), tone2fre(i) ,music);
        t_start = t_start + beats_time*beat(i);
    end
    
    % Make sure the maxium is lower than 1
    music = music/max(music);
        