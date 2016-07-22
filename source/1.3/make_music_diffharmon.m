function music = make_music_diffharmon(f_sample, tones, beat, rising, major)
    load tone_base_harmonic.mat
    load tones_data.mat
    beats_time = 0.5;
    
    for i=1:length(tones_names)
        flag = false;
        tmp = [major '4'];
        if(length(tones_names{i})==length(tmp))
            flag = true;
            for j =1:length(tones_names{i})
                if(tones_names{i}(j)~=tmp(j))
                    flag = false;
                end
            end
        end
        if(flag)
            p = i;
            break;
        end
    end
    base = tones_fre(p);
    fre = base * (2 .^ ([0, 2, 4, 5, 7, 9, 11]/12));
    tone2fre = zeros(1,length(tones));
    for i=1:length(tones)
        tone2fre(i) = fre(tones(i))* 2^(rising(i));
    end
    
    standard_time = linspace(0, 4*(1-1/f_sample),4*f_sample);
    music=zeros(size(standard_time));
    
    t_start = 0;
    
    for i=1:length(tone2fre)
        [~, temp_pos] = min(abs(basefre-tone2fre(i)));
        music = make_guitar_toneshape(standard_time, t_start, beats_time*beat(i), tone2fre(i) ,music, ...
            harmonicfre{temp_pos});
        t_start = t_start + beats_time*beat(i);
    end
    
    % Make sure the maxium is lower than 1
    music = music/max(music);
        