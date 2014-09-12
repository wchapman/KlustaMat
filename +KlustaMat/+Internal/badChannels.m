function waveStruct = badChannels(waveStruct)

    ww = waveStruct.wave;
    clear isA 

    for k = 1:size(ww,3)
        ww2 = ww(:,:,k);
        isA(k) = all(ww2(:) == ww2(1));
    end

    ww(:,:,find(isA)) = [];

    waveStruct.wave = ww;


end