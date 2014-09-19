function fet = Area(ww)
    % Sum square voltage
    for k = 1:size(ww,3)
        fet{k} = cellfun(@(x) sum(x).^2, ww(:,:,k));
    end
    
end