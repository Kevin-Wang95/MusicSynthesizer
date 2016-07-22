clear all;close all;

% Parameters
f_sample = 8e3;
divede = 150;
diff_t = 1.35;
min_len = 0.15;
permit_error = 0.05;

% Music Signal
fmt = audioread('fmt.wav');
lengthNum = ceil(size(fmt,1)/divede);
fmt_resize = [fmt; zeros(lengthNum * divede-size(fmt,1),1)];
max_sample.value = zeros(lengthNum, 1);
max_sample.position = zeros(lengthNum, 1);
for i=1:lengthNum
    [value, position] = max(fmt_resize((i - 1)*divede + 1:i*divede,1));
    max_sample.value(i) = value;
    max_sample.position(i) = position + divede * (i - 1);
end
figure(1)
plot(1:length(fmt_resize),fmt_resize);
hold on;
plot(max_sample.position,max_sample.value,'r-o');
hold off;

% Divide to small divisions
n = 0;
for i=6:lengthNum
    temp = max_sample.value(i)/mean(max_sample.value(i-5:i-1));
    if(temp > diff_t)
        n = n + 1;
        result_pos(n) = max_sample.position(i);
        result_val(n) = max_sample.value(i);
    end
end

% Get the beats point
j = 2;
while(j<length(result_pos))
    if(result_pos(j+1)-result_pos(j) < min_len * f_sample);
        if(result_val(j+1)<= result_val(j))
            result_pos(j+1) = [];
            result_val(j+1) = [];
        else
            result_pos(j) = [];
            result_val(j) = [];
        end
    else
        j = j + 1;
    end;
end
figure(2)
plot(1:length(fmt_resize),fmt_resize);
hold on;
for i=1:length(result_pos)
    plot([result_pos(i) result_pos(i)],[-0.6 0.6],'r');
    hold on;
end
hold off;

% Ananlyze the frequency
for i=1:length(result_pos)
    if i==length(result_pos)
        aimwav = fmt(result_pos(i):length(fmt));
    else
        aimwav = fmt(result_pos(i):result_pos(i + 1));
    end
    figure(3);
    subplot(4,8,i);
    plot(1:length(aimwav),aimwav);
    
%     signal = aimwav;
%     F = abs(fft(signal));
%     len = length(signal);
%     f = ((0:len-1) /len * f_sample)'; 
%     figure(4);
%     subplot(4,8,i);
%     plot(f,F);
    
    [tone(i), basefre(i), tempharmonicfre] = GetBaseandHarmonic( f_sample, aimwav, permit_error, [4;8;i], 4); 
    harmonicfre(i) = {tempharmonicfre};
end

% Get the beats
for i=1:length(result_pos)-1
    beat(i) = round((result_pos(i+1)-result_pos(i))/(0.5 * 0.5 * f_sample));
end
beat(length(result_pos)) = round((length(fmt)-result_pos(length(result_pos)))/(0.5 * 0.5 * f_sample));
beat = beat /2;
save tone_base_harmonic.mat tone basefre harmonicfre;

% Save file
 fid = fopen('data.txt','wt');
 for i=1:length(result_pos)-1
    fprintf(fid,'%s\t%g\t%g\t',tone{i}, basefre(i), beat(i));
    fprintf(fid,'%g\t',harmonicfre{i});
    fprintf(fid,'\n');
 end
 fclose(fid); 