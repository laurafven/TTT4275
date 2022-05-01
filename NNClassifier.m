load("data_all.mat");   % num_test, num_train, testlab, testv, trainlab, trainv, vec_size
load('NN_pred.mat');    % resulting prediction 
load('NN_conf.mat');    % confusion matrix NN classifier          

% Constants
classes = 10; 
pred = zeros(10, num_test);

% NN Classifier - Run once and save the data in NN_pred
% tic
% [NN_pred] = NNclassifier(pred, num_test, trainv, testv, trainlab);
% toc

% Filling the knowns matrix with the correct data
knowns =  zeros(classes, num_test); % Creating an empty matrix with zeros with same dimensions as NN_pred
for k = 1:size(NN_pred,2)             % index k go through the columns (10000)
    knowns(testlab(k)+1,k) = 1;       % Putting the numbers as 1s in the knowns-matrix using the testlab matrix,
                                      % which is the matrix with the digits-data
end

% Plot confusion matrix 
figure(1)
plotconfusion(knowns, NN_pred);
title("NN without clustering");
xlabel("Targets");
ylabel("Predictions");
xticklabels({'0','1','2','3','4','5','6','7','8','9'});
yticklabels({'0','1','2','3','4','5','6','7','8','9'});

% Error Rate 
errorRate = numErrors(knowns, NN_pred)/size(knowns,2)*100;  % Finding the error rate by using numErrors-function
disp('Error Rate - NN without clustering:')
disp(errorRate);



%% The NN Classifier
% 
function [pred] = NNclassifier(pred, num_test, trainv, testv, trainlab)
    for i = 1:num_test % num_test = 10 000
        distances = dist(trainv, testv(i,:).'); % Using the dist-function in matlab (which uses Euclidian distance) to 
                                                % find the distance between the trainset and the testset (referance point
        [~, index] = min(distances);            % Finding nearest neighbor by finding the smallest distance from the referance point
        predNum = trainlab(index);              % predNum = the number of the row where the nearest neighbor is
        pred(predNum + 1,i) = 1;                % Putting 1s where the predicted numbers are. Same as when filling the knowns matrix
    end
end
