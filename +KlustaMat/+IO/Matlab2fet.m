function waveStruct =  Matlab2fet(waveStruct,varargin)
    
%% Parse input
    p = inputParser;
    p.addParamValue('numPCA', 2, @(x) floor(x)==x);
    p.addParamValue('adFields', {'PeakToTrough'},  @(x) iscell(x));
    
    p.parse(varargin{:});
    
    numPCA = p.Results.numPCA;
    adFields = p.Results.adFields;
    
    
    %% Initialize the folder
    fetFolder = waveStruct(1).name;
    inds = strfind(fetFolder,filesep);
    fetFolder = [fetFolder(1:inds(end)-1)];
    % mkdir(fetFolder)
    
    %%{
    prefix = waveStruct(1).name(inds(end)+1:end);
    inds = strfind(prefix ,'.');
    prefix = prefix(1:inds(1)-1);
    
    inds = strfind(fetFolder,filesep);
    num = waveStruct(1).name(inds(end)+1:end);
    inds = strfind(num ,'.');
    num = num(inds(end)+1:end);
    %}
    % neuralynx version:
    
    %%
        
    clear flds
    
    %fetFile = [fetFolder filesep 'TT.fet.' num2str(waveStruct.ChannelNumber)];
    fetFile = [fetFolder filesep prefix '.fet.' num];
    fid = fopen(fetFile,'wt+');

    % extract aditional fields:
    for k = 1:length(adFields)
        flds = waveStruct.features.(adFields{k});
    end

    % Filter out desired pcas:
		if numPCA > 0
			pcas = waveStruct.pca.score;
			pcas = cellfun(@(x) x(:,1:numPCA), pcas,'UniformOutput',0);
			 if exist('flds','var')
				 flds = cellfun(@(x,y) [x y], pcas,flds, 'UniformOutput',0);
			 else
				 flds = pcas;
			 end
		else
			 
		end
			
   

    % Get nums:
    nChannels = size(waveStruct.wave,3);
    nflds = length(flds);
    nSpk = size(flds{1},1);

    % Write first line:
    fprintf(fid,'%d\n%f\n',(nflds*nChannels)+1);

    fclose(fid);
    fid = fopen(fetFile,'at');

    % for each spike:
    for k = 1:nSpk
        txt = [];
        for m = 1:nChannels
            txt = [txt flds{m}(k,:)];
        end
        txt = [txt waveStruct.ts(k)];

        
        % REALLY need to get rid of for loop for large files...
        fprintf(fid, num2str(txt(1)));
        for m = 2:length(txt)   % Stupid problem with negative signs
            fprintf(fid, ' ');
            t=num2str(txt(m));
            fprintf(fid, t);
        end
        fprintf(fid,'\n');

    end

    fclose(fid);


    waveStruct.numChans = nChannels;
    waveStruct.numFeats = length(flds);

    

end