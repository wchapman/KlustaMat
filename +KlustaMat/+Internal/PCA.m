function fet = PCA(waveStruct)
    % Calculate principal components
    warning('off','stats:pca:ColRankDefX');
    
    ww = waveStruct.wave;
    for k = 1:size(ww,3)
        w = squeeze(ww(:,:,k));
        [~,t] = pca(w);
        fet{k} = t(:,waveStruct.useFeatures.PCA);
    end

    warning('on','stats:pca:ColRankDefX');
    
end