function preproceeded = PreProcess( realwave, times )
    % 10����ֵ
    ten_times = resample(realwave, times, 1);
    % ȡƽ������
    noise_reduction = mean(reshape(ten_times, length(realwave), times), 2);
    % �ָ�ԭ10���ڵĲ���
    preproceeded = resample(repmat(noise_reduction,times,1),1,times);
end

