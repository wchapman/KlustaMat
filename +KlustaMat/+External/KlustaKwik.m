function [ClusterNum] = KlustaKwik(waveStruct,varargin)

    %% Parse
    p = inputParser;
    p.addParamValue('InstallDir',   [], @(x) ischar(x));                   % Where to run from
    p.addParamValue('FileBase', [], @(x) ischar(x));                       % Which Files
    p.addParamValue('ElecNo',  1,  @(x) floor(x) == x);                    % Which shank number?
    p.addParamValue('MinClusters', 1,  @(x) floor(x) == x);               % Force at least  
    p.addParamValue('MaxClusters', 30,  @(x) floor(x) == x);               % Upper limit
    p.addParamValue('MaxPossibleClusters', 100, @(x) floor(x) == x);       % Putative Upper Limit
    p.addParamValue('nStarts', 1, @(x) floor(x)==x);                       % Number of times to run
    p.addParamValue('RandomSeed', 1, @(x) floor(x)==x);                    % Random start?
    p.addParamValue('Debug', 0, @(x) (x==0)||(x==1));                      %
    p.addParamValue('Verbose', 0, @(x) (x==0)||(x==1))                     %
    p.addParamValue('UseFeatures', 1);                                    % Which features to use to cluster
    p.addParamValue('DistDump', 0, @(x) (x==0)||(x==1));                   %
    p.addParamValue('DistThresh', 6.907755, @(x) numel(x)==1);             %
    p.addParamValue('FullStepEvery', 20, @(x) floor(x) == x);              % 
    p.addParamValue('ChangedThresh', 0.05);                                %
    p.addParamValue('Log',  1,  @(x) (x==0)||(x==1));                      %
    p.addParamValue('Screen', 0, @(x) (x==0)||(x==1));                     %
    p.addParamValue('MaxIter',  500, @(x) floor(x)==x);                    %
    p.addParamValue('SplitEvery', 40, @(x) floor(x)==x);                   %
    p.addParamValue('PenaltyMix', 1, @(x) numel(x)==1);                    %
    p.addParamValue('Subset', 1, @(x) numel(x)==1);                        %
    p.addParamValue('UseDistributional', 0, @(x) (x==0)||(x==1));          % Backwards compatibility
    p.parse(varargin{:});
    
    fn = fieldnames(p.Results);
    for i = 1:length(fn)
        eval([fn{i} ' = p.Results.' fn{i} ';']);
    end
    
    %if isempty(InstallDir)
    %    if isunix
    %        [~,name] = system('whoami');
    %        InstallDir = ['/home/' name(1:end-1) filesep 'git/klustakwik/klustakwik'];
    %    else
            InstallDir = 'klustakwik';
    %    end
    %end
    
    %% Run
    
    cm  = [InstallDir ' ' FileBase ...             
          ' ' num2str(ElecNo) ...                   
          ' -MinClusters ' num2str(MinClusters) ... 
          ' -MaxClusters ' num2str(MaxClusters) ... 
          ' -MaxPossibleClusters ' num2str(MaxPossibleClusters) ...
          ' -nStarts ' num2str(nStarts) ...
          ' -RandomSeed ' num2str(RandomSeed) ... 
          ' -Debug ' num2str(Debug) ... 
          ' -Verbose ' num2str(Verbose) ... 
          ' -UseFeatures ' num2str(UseFeatures) ... 
          ' -DistDump ' num2str(DistDump) ... 
          ' -DistThresh ' num2str(DistThresh) ... 
          ' -FullStepEvery ' num2str(FullStepEvery) ... 
          ' -ChangedThresh ' num2str(ChangedThresh) ... 
          ' -Log ' num2str(Log) ... 
          ' -Screen ' num2str(Screen) ... 
          ' -MaxIter ' num2str(MaxIter) ... 
          ' -SplitEvery ' num2str(SplitEvery) ... 
          ' -UseDistributional ' num2str(UseDistributional)];

    disp(cm)
    system(cm);

    %% Read .clu.# and return vector:
    clu = [FileBase '.clu.' num2str(ElecNo)];
    fid = fopen(clu);
    dat = [];
    
    while ~feof(fid)
        dat = [dat;str2num(fgetl(fid))];
    end

    nClust = dat(1); dat(1) = [];
    nClust = nClust - 1; % Because 0 stray spike
    
    ClusterNum = dat -1 ;
    
end