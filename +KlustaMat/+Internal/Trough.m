function fet = Trough(ww)
    % Voltage(Trough)
    fet = cell(size(ww,3),1);
    for k = 1:size(ww,3)
        fet{k} = cellfun(@(x) min(x), ww(:,:,k));
    end
    
end