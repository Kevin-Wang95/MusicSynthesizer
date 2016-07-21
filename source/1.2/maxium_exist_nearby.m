function [val, pos] = maxium_exist_nearby(frequency_pos, Ffigure, permit_error)
    start = ceil(frequency_pos * (1 - permit_error));
    to = floor(frequency_pos * (1 + permit_error));
    [val, pos] = max(Ffigure(start:to));
    pos = pos + start - 1;
end