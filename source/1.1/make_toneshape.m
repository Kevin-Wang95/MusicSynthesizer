function signal_AP = make_toneshape(t, t_start, duration, tonefre ,signal)
    if nargin ==5
        harmonic = [0.2 0.3 0.2 0.15 0.2 0.25 0.2];
    end
    % Init
    t_local = t - t_start;
    signal_AP = zeros(size(signal));
    
    % Parameter
    implus_ratio = 0.15;
    decay_ratio = 0.1;
    stay_ratio = 0.6;
    peak_level = 1;
    stay_level = 0.8;
    dissolve_level = 9;
    
    % Time end
    implus_end = duration * implus_ratio;
    decay_end = implus_end + duration * decay_ratio;
    stay_end = decay_end + duration * stay_ratio;
    
    % Time inversal
    implus = (t_local >= 0 & t_local <implus_end);
    decay = (t_local >= implus_end & t_local < decay_end);
    stay = (t_local >= decay_end & t_local < stay_end);
    dissolve = (t_local >= stay_end);
    
    % Process
    signal_AP(implus)=linspace(0, peak_level, sum(implus));
    signal_AP(decay)=linspace(peak_level, stay_level, sum(decay));
    signal_AP(stay)=stay_level; 
    signal_AP(decay)=linspace(peak_level, stay_level, sum(decay));
    signal_AP(dissolve)=stay_level*exp(dissolve_level * (stay_end - t_local(dissolve)) / duration);
    
%     plot(1:length(signal_AP),signal_AP);
%     set(gca,'XLim',[0 10000]);
%     set(gca,'YLim',[0 1.2]);
    
    % Add Harmonic and Get wave (contain f 2f 3f)
    temp = 0;
    for i = 1:length(harmonic)
        temp = temp + sin(2 * (i + 1) * pi * tonefre * t) * harmonic(i);
    end
    temp = temp + sin(2 * pi * tonefre * t);
    signal_AP = signal_AP .* temp + signal;
    plot(1:length(signal_AP),signal_AP);
end

