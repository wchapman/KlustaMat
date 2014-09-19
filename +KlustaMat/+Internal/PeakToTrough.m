function fet = PeakToTrough(waveStruct)
    % Voltage(Peak) - Voltage(Trough)
    ww = waveStruct.cellWave;
    fet = cell(size(ww,3),1);
    for k = 1:size(ww,3)
        pks = cellfun(@(x) max(x), ww(:,:,k));
        trs = cellfun(@(x) min(x), ww(:,:,k));
        fet{k} = pks-trs;
    end
    
end