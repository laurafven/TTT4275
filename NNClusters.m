load('clusters.mat');
load('confNNCluster.mat');

classes = 10; % numbers from 0 to 9

tic
predictedNumbers = zeros(classes,num_test);

for i = 1:num_test 
    distances = dist(clusters, testv(i,:).'); % Same as in NNClassifier.m, except now using "clusters" and "clusterClass"
    [~,index] = min(distances); 
    numberClass = clusterClass(index); % row where nearest neighbor (cluster class) is
    predictedNumbers(numberClass+1,i) = 1; 
end
toc

knowns =  zeros(classes, num_test); % As in NNClassifier.m
for k = 1:num_test
    knowns(testlab(k)+1,k) = 1;
end

% Plot confusion matrix
plotconfusion(knowns, predictedNumbers)
title("NN with clustering");
xlabel("Targets");
ylabel("Predictions");
xticklabels({'0','1','2','3','4','5','6','7','8','9'});
yticklabels({'0','1','2','3','4','5','6','7','8','9'});

% Error rate 
errorRate = numErrors(knowns, predictedNumbers)/size(knowns,2)*100; % Finding the error rate by using numErrors-function
disp('Error Rate - NN without clustering:')
disp(errorRate);
