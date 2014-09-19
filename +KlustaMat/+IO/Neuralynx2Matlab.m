function [ waveStruct ] = Neuralynx2Matlab(dataPath)
% outputFiles = klustaMat.Import.Axona2Matlab(input_fnames)
%   Converts raw .# unit recording files from Axona to matlab workspace
%   variables.

% wchapman 20140822
    
    import KlustaMat.NL2Mat.*

    fname = dir(fullfile(dataPath, '*.ntt'));

    FieldSelectionArray = [1 1 0 1 1];
    ExtractHeader = 1;
    ExtractionMode = 1;

    for i = 1:length(fname)
        waveStruct(i) = KlustaMat.Internal.initWaveStruct();
        [waveStruct(i).ts, waveStruct(i).rem.sc, waveStruct(i).rem.params, waveStruct(i).wave, waveStruct(i).rem.header] = Nlx2MatSpike(fullfile(dataPath,fname(i).name), FieldSelectionArray,ExtractHeader,ExtractionMode);
        waveStruct(i).wave = permute(waveStruct(i).wave,[3 1 2]);
        waveStruct(i).name = fullfile(dataPath,fname(i).name);
        waveStruct(i).ChannelNumber = str2num(fname(i).name(3:end-4));

        hd = waveStruct(i).rem.header;
        hs = size(hd,1);

        for k = hs-8:hs-1
            waveStruct(i).rem.header{k} = [waveStruct(i).rem.header{k} '0 31'];
        end

        wave = waveStruct(i).wave;
        waveStruct(i).cellWave = mat2cell(double(wave),ones(size(wave,1),1),size(wave,2),ones(size(wave,3),1));
        fp = waveStruct(i).name(1:strfind(waveStruct(i).name,'.ntt')-1);
        waveStruct(i).fet = [fp '.fet.' num2str(waveStruct(i).ChannelNumber)];
        waveStruct(i).clu = [fp '.clu.' num2str(waveStruct(i).ChannelNumber)];
        waveStruct(i).out = [fp '.ntt'];
    end
    
    waveStruct = waveStruct(:);
    
end

