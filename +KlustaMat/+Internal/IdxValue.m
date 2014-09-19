function fet = IdxValue(waveStruct)

    fet = cell(size(ww,3),1);
    for k = 1:size(ww,3)
        fet{k} = cellfun(@(x) findpeaks(x(idx), ww(:,:,k));
    end
    
end