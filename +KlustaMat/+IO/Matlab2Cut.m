function CutFile = Matlab2Cut(waveStruct)
% Will take in a waveStruct and generate a *.cut file:

toks = strfind(waveStruct.name,'.'); toks = toks(end)-1;
CutFile = waveStruct.out;
delete(CutFile);
fid = fopen(CutFile,'w+');

%% Write the header:
numFeats = sum(cellfun(@(x) size(x,2), waveStruct.features(1,:)));
fprintf(fid, ['n_clusters: ' num2str(max(waveStruct.ClusterNum)) ' \n']); %num2str(max(waveStruct(1).ClusterNum)]
fprintf(fid, ['n_channels: ' num2str(waveStruct.numChans) ' \n']);
fprintf(fid, ['n_params: ' num2str(numFeats) ' \n']);
fprintf(fid, ['times_used_in_Vt: ' num2str(zeros(1,waveStruct.numChans)) ' \n']);

nc = waveStruct.numChans;
nf = numFeats;

for i = 0:max(waveStruct.ClusterNum)
    fprintf(fid, [' cluster: ' num2str(i) ' center:' num2str(zeros(1,nc*nf),'    %d') ' \n']);
    fprintf(fid, ['              min:' num2str(zeros(1,nc*nf),'    %d') ' \n']);
    fprintf(fid, ['              max:' num2str(zeros(1,nc*nf),'    %d') ' \n']);
end

toks = strfind(waveStruct.name, filesep);
n = waveStruct.name(toks(end)+1:end);
toks = strfind(n, '.');
n = n(1:toks-1);

fprintf(fid, ['\nExact_cut_for: ' n ' spikes: ' num2str(size(waveStruct.ClusterNum,1)) ' \n']);

%% Write the data:
isOver = 0;
c = 1;
while isOver == 0
    % Exit condition
    
    % minus 1 because 0 = uncut 
    if c+24 > size(waveStruct.ClusterNum,1)
        isOver = 1;
        txt = ['  ' num2str((waveStruct.ClusterNum(c:end))','%d  ') ' \n'];
    else
        txt = ['  ' num2str((waveStruct.ClusterNum(c:c+24))','%d  ') ' \n'];
    end
    
    fprintf(fid, txt);
    c = c+25;
end

fclose(fid);


end