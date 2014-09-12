%% Axona example
dataPath = [pwd filesep 'exampleData' filesep 'axona'];
prefix = '110128_1400_openfield';

waveStruct = KlustaMat.IO.Axona2Matlab(dataPath, prefix);
waveStruct(end).pca = [];
waveStruct(end).features = [];
waveStruct(end).numChans = [];
waveStruct(end).numFeats = [];
waveStruct(end).ClusterNum = [];

for i = 1:length(waveStruct)
    waveStruct(i) = KlustaMat.Internal.badChannels(waveStruct(i));
    disp(['Calc PCA ' num2str(i) '/' num2str(length(waveStruct))])
    waveStruct(i) = KlustaMat.Internal.PCA(waveStruct(i));
    disp(['Calc FETS ' num2str(i) '/' num2str(length(waveStruct))])
    waveStruct(i) = KlustaMat.Internal.Features(waveStruct(i));
    disp(['Write FET ' num2str(i) '/' num2str(length(waveStruct))])
    waveStruct(i) = KlustaMat.IO.Matlab2fet(waveStruct(i),'numPCA',0);
    disp(['Klusta ' num2str(i) '/' num2str(length(waveStruct))])
    waveStruct(i).ClusterNum = KlustaMat.External.KlustaKwik(waveStruct(i),'FileBase',[dataPath filesep prefix],'ElecNo',waveStruct(i).ChannelNumber);
    disp(['Write .Cut ' num2str(i) '/' num2str(length(waveStruct))])
    KlustaMat.IO.Matlab2Cut(waveStruct(i));
end

%

%% Neuralynx Example (windows & mac only)

dataPath = [pwd filesep 'exampleData' filesep 'neuralynx'];
waveStruct = KlustaMat.IO.Neuralynx2Matlab(dataPath);
waveStruct(end).pca = [];
waveStruct(end).features = [];
waveStruct(end).numChans = [];
waveStruct(end).numFeats = [];
waveStruct(end).ClusterNum = [];

for i = 1%:16
    waveStruct(i) = KlustaMat.Internal.badChannels(waveStruct(i));
    waveStruct(i) = KlustaMat.Internal.PCA(waveStruct(i));
    waveStruct(i) = KlustaMat.Internal.Features(waveStruct(i));
    waveStruct(i) = KlustaMat.IO.Matlab2fet(waveStruct(i));
    waveStruct(i).ClusterNum = KlustaMat.External.KlustaKwik('FileBase',[dataPath filesep 'TT'],'ElecNo',waveStruct(i).ChannelNumber);
    KlustaMat.IO.Matlab2NTT(waveStruct(i));
end