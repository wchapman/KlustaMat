function waveStruct =  Matlab2fet(waveStruct)
   
    % Open fet file:
    fetFile = waveStruct.fet;
    fid = fopen(fetFile,'wt+');

    % Concatinate features:
    fets = waveStruct.features';
    fets = fets(:)';
    fets = cell2mat(fets);
    fets(:,end+1) = waveStruct.ts(:);
    
    % rearrange to be by feature instead of by tetrode
    %{
    nf = (size(fets,2)-1)/waveStruct.numChans;
    for i = 1:size(fets,1)
        f = reshape(fets(i,1:end-1), [nf waveStruct.numChans]);
        t = [];
        for k = 1:size(f,1)
            t = [t f(k,:)];
        end
        t = [t fets(i,end)];
        fets2(i,:) = t;
    end
    
    fets = fets2;
    %}
    % Get nums:
    nChannels = size(waveStruct.wave,3);

    % Write first line:
    fprintf(fid,'%d\n%f\n',size(fets,2));

    fclose(fid);
    fid = fopen(fetFile,'at');

    for i = 1:numel(waveStruct.ts) 
        fprintf(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f', fets(i,:));
        fprintf(fid, '\r\n');
    end
    fclose(fid);

    waveStruct.numChans = nChannels;

end