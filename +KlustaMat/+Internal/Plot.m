function plot(waveStruct, num)

figure
hold on

c = repmat(['k' 'b' 'g' 'r' 'c' 'm'],1,10);

for i = 1:length(num)
    inds = find(waveStruct.ClusterNum == num(i));
    plot(waveStruct.features{1,1}(inds,1), waveStruct.features{1,1}(inds,2), 'o', 'MarkerFaceColor', c(i),'MarkerEdgeColor',c(i), 'MarkerSize',3)
end

end