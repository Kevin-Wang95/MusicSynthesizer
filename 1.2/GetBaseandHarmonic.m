function [ tone, basefre, harmonicoeff ] = GetBaseandHarmonic( f_sample, wave2proc, permit_error, subplotpar, figureno, plotpar)
%GETBASEFRETONE Summary of this function goes here
    if (nargin==3)
        plotpar = 1;
        subplotpar = [1;1;1];
        figureno = 1;
    else
        if nargin == 5
            plotpar = 1;
        end
    end

    load tones_data.mat;
    signal = repmat(wave2proc, [8, 1]);
    F = abs(fft(signal));
    len = length(signal);
    f = ((0:len-1) /len * f_sample)'; 
    if(plotpar)
        figure(figureno);
        subplot(subplotpar(1),subplotpar(2),subplotpar(3));
        plot(f,F);
    end

    [localmax_val, localmax_pos] = max(F);
    F(F<0.1 * localmax_val) = 0;
    basefre = f(localmax_pos-1);
    basecoeff = localmax_val;
    for i = 2:16
        [tempmax_val, tempmax_pos] = maxium_exist_nearby((localmax_pos-1)/i, F, permit_error);
        if(tempmax_val > 0.5 * localmax_val)
            basefre = f(tempmax_pos-1); 
            basecoeff = tempmax_val;
        end
    end

    [tone, basefre] = find_tone(basefre);
    
    for i=2:4
        temp(i-1) = maxium_exist_nearby(round(basefre*i/f(2)), F, 0.1)/basecoeff;
    end
    harmonicoeff = temp;
