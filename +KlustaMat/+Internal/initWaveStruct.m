function waveStruct = initWaveStruct()

    %% Data variables
    waveStruct.wave = [];
    waveStruct.name = [];
    waveStruct.ts = [];
    waveStruct.ChannelNumber = [];
    waveStruct.features = [];
    waveStruct.numChans = [];
    waveStruct.ClusterNum = [];
    waveStruct.cellWave = [];
    waveStruct.fet = [];
    waveStruct.out = [];
    waveStruct.clu = [];
    waveStruct.rem = [];
    
    %% Which features to use:
    useFeatures.Energy = 0;                 % sum(V)
    useFeatures.Area = 0;                   % sum(V.^2)
    useFeatures.IdxPeak = 0;                % Index of peak
    useFeatures.Peak = 0;                   % V(peak)
    useFeatures.IdxTrough = 0;              % Index of minimum
    useFeatures.Trough = 0;                 % V(trough)
    useFeatures.IdxValue = 0;               % Special: If Nonzero then index
    useFeatures.SpikeWidth = 0;             % 
    useFeatures.PeakToTrough = 1;           % V(Peak)-V(Trough)
    useFeatures.PCA = [1 3];                % Special, zero or vector

    waveStruct.useFeatures = useFeatures;
    
    %% KlustaKwik Parameters:
    % Where to run from
    if isunix
        [~,name] = system('whoami');
        waveStruct.KlustaParams.InstallDir = ['/home/' name(1:end-1) filesep 'git/klustakwik/klustakwik'];
    else
         waveStruct.KlustaParams.InstallDir = 'klustakwik';
    end
    
    waveStruct.KlustaParams.MinClusters = 1;            % Force at least  
    waveStruct.KlustaParams.MaxClusters = 30;           % Upper limit
    waveStruct.KlustaParams.MaxPossibleClusters = 100;  % Putative Upper Limit
    waveStruct.KlustaParams.nStarts = 1;                % Number of times to run
    waveStruct.KlustaParams.RandomSeed = 1;             % Random start?
    waveStruct.KlustaParams.Debug = 0;
    waveStruct.KlustaParams.Verbose = 0;
    waveStruct.KlustaParams.DistDump = 0;
    waveStruct.KlustaParams.DistThresh = 6.907755;
    waveStruct.KlustaParams.FullStepEvery = 20;
    waveStruct.KlustaParams.ChangedThresh = 0.05;
    waveStruct.KlustaParams.Log = 1; 
    waveStruct.KlustaParams.Screen = 0;
    waveStruct.KlustaParams.MaxIter = 500;             % Maximum iterations
    waveStruct.KlustaParams.SplitEvery = 40;
    waveStruct.KlustaParams.PenaltyMix = 1;
    waveStruct.KlustaParams.Subset = 1;
    waveStruct.KlustaParams.UseDistributional = 0;     % Backwards compatiblity
    

    %% Post Klusta Cleanup:
    waveStruct.post.reNum = 0;
    
end