function fet = SpikeWidth(ww)
    % Fixme
    fet = cell(size(ww,3),1);
    for k = 1:size(ww,3)
        fet{k} = cellfun(@(x) findpeaks(x,'NPEAKS',1), ww(:,:,k));
    end
    
end