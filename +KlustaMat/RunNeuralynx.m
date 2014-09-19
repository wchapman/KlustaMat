function waveStruct = RunNeuralynx(dataPath, waveStructOp)
% Wrapper to run 

waveStruct = KlustaMat.IO.Neuralynx2Matlab(dataPath);

if exist('waveStructOp','var')
    for i = 1:size(waveStruct)
        waveStruct(i).useFeatures = waveStructOp(i).useFeatures;
    end
end

%% Run each one
for i = 1:length(waveStruct)
    waveStruct(i) = KlustaMat.Internal.badChannels(waveStruct(i));
    waveStruct(i) = KlustaMat.Internal.Features(waveStruct(i));
    waveStruct(i) = KlustaMat.IO.Matlab2fet(waveStruct(i));
    waveStruct(i) = KlustaMat.External.KlustaKwik(waveStruct(i));
    KlustaMat.IO.Matlab2NTT(waveStruct(i));
end


end