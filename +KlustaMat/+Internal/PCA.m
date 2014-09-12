function [waveStruct] = PCA(waveStruct) 
% KlustaMat.PCA(waveStruct)
%
% Does a bunch of principle-component analysis stuff that is then exported
% to klustaKwik for sorting.

% wchapman 20140822


%%
warning('off','stats:pca:ColRankDefX');

n_samples = 50; 
    
for k = 1:size(waveStruct.wave,3)
    wv = squeeze(waveStruct.wave(:,:,k));    % The local wavevariable for verbosity

    % ------------------------------------------------- Perform PCA

    [pcav.coeff{k}, pcav.score{k}, pcav.latent{k}, pcav.tsquared{k}, pcav.explained{k}, pcav.mu{k}] = pca(wv);
    warning('on','stats:pca:ColRankDefX');

    peak_valley = max(wv,[],2) - min(wv,[],2); 
    energy = sum(wv.^2,2)/n_samples;
    NormMat = zeros(size(wv));

    % ------------------------------------------------ Normalized PCA
    for m = 1:size(wv,1)
      pcav.NormMat(m,:) = energy(m,1)^-1;
    end
    wv_norm = wv./NormMat; % Normalize waveform by energy

    warning('off','stats:pca:ColRankDefX');
    [pcav.norm_coeff{k}, pcav.norm_score{k}, pcav.norm_latent{k}, pcav.norm_tsquared{k}, pcav.norm_explained{k}, pcav.norm_mu{k}] = pca(wv_norm); % PCA on normalized waveforms 

    %waveStruct.spikeInfo.peak_valley{k} = peak_valley;
    %waveStruct.spikeInfo.energy{k} = energy;
end

waveStruct.pca = pcav;


clear pcav


warning('on','stats:pca:ColRankDefX');