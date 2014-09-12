function waveStruct = Features(waveStruct, idx)
% Currently slow (3.5 mins per session) ... should optimize before release 
% OR
% Make calculating each field not true until user says so

if ~exist('idx','var')
    idx = 1;
end
    
ww = waveStruct.wave;
for k = 1:size(ww,3)

    waveStruct.features.Energy{k} = sum(ww(:,:,k),2);
    waveStruct.features.Area{k} = sum(ww(:,:,k).^2,2);

    waveStruct.features.IdPeak{k} = NaN(size(ww,1),1);
    waveStruct.features.Peak{k} = NaN(size(ww,1),1);
    waveStruct.features.IdTrough{k} = NaN(size(ww,1),1);
    waveStruct.features.Trough{k} = NaN(size(ww,1),1);
    waveStruct.features.IdxValue{k} = NaN(size(ww,1),1);
    waveStruct.features.SpikeWidth{k} = NaN(size(ww,1),1);

    for n = 1:size(ww,1)

        try
        [waveStruct.features.Peak{k}(n), ...
             waveStruct.features.IdPeak{k}(n)] = findpeaks(ww(n,:,k),'NPEAKS',1);
        catch
             waveStruct.features.IdPeak{k}(n) = 1;
             waveStruct.features.Peak{k}(n) = ww(n,1,k);
        end

        try 
            [waveStruct.features.Trough{k}(n), ...
                 waveStruct.features.IdTrough{k}(n)] = findpeaks(-1*ww(n,:,k),'NPEAKS',1);
        catch
            waveStruct.features.IdTrough{k}(n) = length(ww(n,:,k));
            waveStruct.features.Trough{k}(n) = ww(n,end,k);
        end

        waveStruct.features.PeakToTrough{k}(n) = ...
            waveStruct.features.Peak{k}(n) - waveStruct.features.Trough{k}(n);

        waveStruct.features.IdxValue{k}(n) = ww(n,idx,k);

        waveStruct.features.SpikeWidth{k}(n) = ...
            waveStruct.features.IdPeak{k}(n) - waveStruct.features.IdTrough{k}(n);

    end
end

end
