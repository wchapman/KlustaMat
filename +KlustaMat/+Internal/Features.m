function waveStruct = Features(waveStruct)

    fn = fieldnames(waveStruct.useFeatures);
    fets = structfun(@(x) ~all(x==0), waveStruct.useFeatures);
    fets = find(fets); % indices into useFeatures which we are using.
    fn = fn(fets);

    for i = 1:length(fn)
        eval(['t(:,' num2str(i) ')=KlustaMat.Internal.' fn{i} '(waveStruct);'])
    end
    
    waveStruct.features = t;

end
