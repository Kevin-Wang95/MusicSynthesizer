function [tone, fre] = find_tone(frequen)
    load tones_data.mat
    
    tones_fre = abs(tones_fre -frequen);
    pos = find(tones_fre==min(tones_fre));
    tone = tones_names(pos);
    fre = frequen;
    
end