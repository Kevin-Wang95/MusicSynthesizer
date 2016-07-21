function preproceeded = PreProcess( realwave, times )
    % 10倍插值
    ten_times = resample(realwave, times, 1);
    % 取平均降噪
    noise_reduction = mean(reshape(ten_times, length(realwave), times), 2);
    % 恢复原10周期的波形
    preproceeded = resample(repmat(noise_reduction,times,1),1,times);
end

