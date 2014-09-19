function fet = IdxTrough(ww)
    % Index of the trough
    fet = cell(size(ww,3));
    for k = 1:size(ww,3)
        [~,fet{k}] = cellfun(@(x) min(x), ww(:,:,k));
    end
    

end