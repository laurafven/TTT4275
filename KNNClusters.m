close all

load('data_all.mat');
load('clusters.mat');
load('confKNNCluster.mat');

K = 7; % Specified in task, K is number of nearest neighbors to search for
classes = 10; % Still numbers 0-9

tic
predictedNumbers = zeros(classes, num_test);
for i = 1:num_test
    idx = knnsearch(clusters, testv(i,:), 'K', K);  % matlab-function knnsearch for finding K=7 nearest neighbors in clusters
    countNumbers = zeros(classes,1);    % empty array with dim: 10 x 1 
    
    for j = 1:K % Iterating through the number of neighbors
        number = clusterClass(idx(j)); % row where nearest neighbor (cluster class) is
        countNumbers(number+1) = countNumbers(number+1) + 1;
    end
    
    [~,index] = max(countNumbers);
    predictedNumbers(index,i) = 1;   
end
toc

knowns =  zeros(classes, num_test); % same as in NNClassifier.m
for k = 1:num_test
    knowns(testlab(k)+1,k) = 1;
end

% Plot confusion matrix
plotconfusion(knowns, predictedNumbers, 'ClusterKNN');
title("KNN with clustering");
xlabel("Targets");
ylabel("Predictions");
xticklabels({'0','1','2','3','4','5','6','7','8','9'});
yticklabels({'0','1','2','3','4','5','6','7','8','9'});

% Error Rate 
errorRate = numErrors(knowns, predictedNumbers)/size(knowns,2)*100;
disp('Error Rate - KNN with clustering:')
disp(errorRate);
