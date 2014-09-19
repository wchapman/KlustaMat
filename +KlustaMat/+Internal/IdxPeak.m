function fet = IdxPeak(ww)
    % Index of the peak
    fet = cell(size(ww,3));
    for k = 1:size(ww,3)
        [~,fet{k}] = cellfun(@(x) max(x), ww(:,:,k));
    end
    

end