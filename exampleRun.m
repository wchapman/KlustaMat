%% Axona example
dataPath = [pwd filesep 'exampleData' filesep 'axona'];
prefix = '110411_1349_openfield';

% This is how to specify options:
ops = KlustaMat.Internal.initWaveStruct();
ops.useFeatures.PeakToTrough = 1;
ops = repmat(ops,[4, 1]);

waveStruct = KlustaMat.RunAxona(dataPath, prefix, ops);


%% Neuralynx Example (windows & mac only)

dataPath = [pwd filesep 'exampleData' filesep 'neuralynx'];

% This is how to specify options:
ops = KlustaMat.Internal.initWaveStruct();
ops.useFeatures.PeakToTrough = 1;
ops = repmat(ops,[1,1]);

waveStruct = KlustaMat.RunNeuralynx(dataPath, ops);