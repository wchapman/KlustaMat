function fet = Energy(ww)
    % Sum voltage
    fet = cell(size(ww,3),1);
    for k = 1:size(ww,3)
        fet{k} = cellfun(@(x) sum(x), ww(:,:,k));
    end
    
end