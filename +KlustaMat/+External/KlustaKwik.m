function [waveStruct] = KlustaKwik(waveStruct)
    
    %% Run
    
    cm  = [waveStruct.KlustaParams.InstallDir ' ' strtok(waveStruct.fet,'.') ...             
          ' ' num2str(waveStruct.ChannelNumber) ...                   
          ' -MinClusters ' num2str(waveStruct.KlustaParams.MinClusters) ... 
          ' -MaxClusters ' num2str(waveStruct.KlustaParams.MaxClusters) ...
          ' -MaxPossibleClusters ' num2str(waveStruct.KlustaParams.MaxPossibleClusters) ...
          ' -nStarts ' num2str(waveStruct.KlustaParams.nStarts) ...
          ' -RandomSeed ' num2str(waveStruct.KlustaParams.RandomSeed) ... 
          ' -Debug ' num2str(waveStruct.KlustaParams.Debug) ... 
          ' -Verbose ' num2str(waveStruct.KlustaParams.Verbose) ... 
          ' -UseFeatures ' num2str(ones(1,1+waveStruct.numChans*sum(structfun(@(x) sum(x>0), waveStruct(1).useFeatures,'UniformOutput',1))),'%d') ... % num2str(UseFeatures) ... 
          ' -DistDump ' num2str(waveStruct.KlustaParams.DistDump) ... 
          ' -DistThresh ' num2str(waveStruct.KlustaParams.DistThresh) ... 
          ' -FullStepEvery ' num2str(waveStruct.KlustaParams.FullStepEvery) ... 
          ' -ChangedThresh ' num2str(waveStruct.KlustaParams.ChangedThresh) ... 
          ' -Log ' num2str(waveStruct.KlustaParams.Log) ... 
          ' -Screen ' num2str(waveStruct.KlustaParams.Screen) ... 
          ' -MaxIter ' num2str(waveStruct.KlustaParams.MaxIter) ... 
          ' -SplitEvery ' num2str(waveStruct.KlustaParams.SplitEvery) ... 
          ' -UseDistributional ' num2str(waveStruct.KlustaParams.UseDistributional)];
      
    disp(cm)
    system(cm);

    %% Read .clu.# and return vector:
    fid = fopen(waveStruct.clu);
    dat = [];
    
    while ~feof(fid)
        dat = [dat;str2num(fgetl(fid))];
    end

    nClust = dat(1); dat(1) = [];
    nClust = nClust; % Because 0 stray spike
    
    waveStruct.ClusterNum = dat;
    
end