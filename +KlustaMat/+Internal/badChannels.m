function waveStruct = badChannels(waveStruct)

    ww = waveStruct.wave;
    clear isA 

    for k = 1:size(ww,3)
        ww2 = ww(:,:,k);
        isA(k) = all(ww2(:) == ww2(1));
    end

    if any(isA)
        warning('Dropping Bad Channels')
    end
    
    ww(:,:,find(isA)) = [];

    waveStruct.wave = ww;
    if any(isA)
        waveStruct.cellWave(:,:,find(isA)) = [];
    end
    waveStruct.numChans = size(ww,3);

end