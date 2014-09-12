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

    % TODO: remove this try catch, figure out why it couldn't load
    for i = 1:length(fname)
        try
            [waveStruct(i).ts, waveStruct(i).rem.sc, waveStruct(i).rem.params, waveStruct(i).wave, waveStruct(i).rem.header] = Nlx2MatSpike(fullfile(dataPath,fname(i).name), FieldSelectionArray,ExtractHeader,ExtractionMode);
            waveStruct(i).wave = permute(waveStruct(i).wave,[3 1 2]);
            waveStruct(i).name = fullfile(dataPath,fname(i).name);
            waveStruct(i).ChannelNumber = str2num(fname(i).name(3:end-4));
            
            hd = waveStruct(i).rem.header;
            hs = size(hd,1);
            
            for k = hs-8:hs-1
                waveStruct(i).rem.header{k} = [waveStruct(i).rem.header{k} '0 31'];
            end
        catch
            waveStruct(i).ts = [];
            waveStruct(i).wave = [];
            waveStruct(i).name = [];
            waveStruct(i).ChannelNumber = [];
            waveStruct(i).rem.params = [];
            waveStruct(i).rem.sc = [];
            waveStruct(i).rem.header = [];
        end
    end
    
    waveStruct = waveStruct(:);
    
end

