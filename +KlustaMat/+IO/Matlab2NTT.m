function Matlab2NTT(waveStruct)
% Write out the contents of waveStruct to the NTT file

KlustaMat.NL2Mat.Mat2NlxTT(waveStruct.out, ...             % where to save
                           0, ...                          % new file
                           1, ...                          % all entries
                           1, ...                          % ?                  
                           size(waveStruct.wave,1), ...    % how many spikes
                           [1 1 1 1 1 1], ...              % which fields
                           waveStruct.ts, ...              % timestamps
                           waveStruct.rem.sc, ...          % Sc numbers?
                           waveStruct.ClusterNum', ...     % Klusts
                           waveStruct.rem.params, ...      % params from cheetah    
                           permute(waveStruct.wave, [2 3 1]), ...     % Waveforms
                           waveStruct.rem.header);
end