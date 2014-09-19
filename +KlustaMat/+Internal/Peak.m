function fet = Peak(ww)
    % Peak voltage
    fet = cell(size(ww,3),1);
    for k = 1:size(ww,3)
        fet{k} = cellfun(@(x) max(x), ww(:,:,k));
    end
    
end