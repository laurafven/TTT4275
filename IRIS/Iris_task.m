clear all
close all

% --------------- Preparing the data --------------------------------------

classes = 3;
features = 4;

class1 = load('class_1');
class2 = load('class_2');
class3 = load('class_3');

numTrain = 30;
numTest = 20;

numData = 50;



% --------------- Defining the testSets for different cases ---------------

% First 30 data points for training and the last 20 for testing
% trainSet = [class1(1:numTrain,:).', class2(1:numTrain,:).', class3(1:numTrain,:).'];
% testSet = [class1(numTrain+1:numData,:).', class2(numTrain+1:numData,:).', class3(numTrain+1:numData,:).'];

% Last 30 data points for training and the first 20 for testing
% trainSet = [class1(numTest+1:numData,:).',class2(numTest+1:numData,:).', class3(numTest+1:numData,:).'];
% testSet = [class1(1:numTest,:).', class2(1:numTest,:).', class3(1:numTest,:).'];

% Removing feature number 2 (petal width)
% trainSet = [class1(1:numTrain,[1 3 4]).', class2(1:numTrain, [1 3 4]).', class3(1:numTrain, [1 3 4]).'];
% testSet = [class1(numTrain+1:numData, [1 3 4]).', class2(numTrain+1:numData, [1 3 4]).', class3(numTrain+1:numData, [1 3 4]).'];

% Removing feature number 2 and 1 (sepal lenght)
% trainSet = [class1(1:numTrain,[3 4]).', class2(1:numTrain, [3 4]).', class3(1:numTrain, [3 4]).'];
% testSet = [class1(numTrain+1:numData, [3 4]).', class2(numTrain+1:numData, [3 4]).', class3(numTrain+1:numData, [3 4]).'];

% Removing feature number 2, 1 and 3 (petal lenght)
trainSet = [class1(1:numTrain, 4).', class2(1:numTrain, 4).', class3(1:numTrain, 4).'];
testSet = [class1(numTrain+1:numData, [4]).', class2(numTrain+1:numData, 4).', class3(numTrain+1:numData, 4).'];

% Bruker dette til prediction
true_class_test = [ones(numTest); 2*ones(numTest); 3*ones(numTest)];
true_class_train = [ones(numTrain); 2*ones(numTrain); 3*ones(numTrain)];




% --------------- Removing features ---------------------------------------

%Removing feature 2
class1(:,2) = [];
class2(:,2) = [];
class3(:,2) = [];
features = features - 1;

% Removing feature 1
class1(:,1) = [];
class2(:,1) = [];
class3(:,1) = [];
features = features - 1;

% Removing feature 3
% After removing feature 1 and 2, feature 3 is now in column 1
class1(:,1) = [];
class2(:,1) = [];
class3(:,1) = [];
features = features - 1;



% --------------- Linear classifier ----------------------------

% Targets
e1 = [1 0 0].';
e2 = [0 1 0].';
e3 = [0 0 1].';
targets = [repmat(e1, 1, numTrain), repmat(e2, 1, numTrain), repmat(e3, 1, numTrain)];

% A matrix with the known data
testKnown = [kron(ones(1, numTest),e1), kron(ones(1, numTest),e2), kron(ones(1, numTest), e3)];
trainKnown = [kron(ones(1, numTrain),e1), kron(ones(1, numTrain),e2), kron(ones(1, numTrain), e3)];

% Train classifier
W = zeros(classes,features+1);
W = MSE_training(W, trainSet, trainKnown, classes, numTrain);

% Predictions
predTest = predClasses(W, testSet, testKnown);
predTrain = predClasses(W, trainSet, trainKnown);



% ---------------- Plot confusion matrix -----------------------

figure(1)
plotconfusion(testKnown, predTest);
%title('Test Cases with the first 20 samples');
%title('Test Cases with the last 20 samples')
title('Test Case: Feature 2, 1 and 3 removed')
xlabel("Classifier output",'FontSize', 12, 'FontWeight', 'bold');
ylabel("True label",'FontSize', 12, 'FontWeight', 'bold');
xticklabels({'Setosa','Versicolour','Virginica'});
yticklabels({'Setosa','Versicolour','Virginica'});


figure(2)
plotconfusion(trainKnown, predTrain);
%title("Training Cases with the last 30 samples");
%title('Training Cases with the first 30 samples');
title('Training Case: Feature 2, 1 and 3 removed')
xlabel("Classifier output",'FontSize', 12, 'FontWeight', 'bold');
ylabel("True label",'FontSize', 12, 'FontWeight', 'bold');
xticklabels({'Setosa','Versicolour','Virginica'});
yticklabels({'Setosa','Versicolour','Virginica'});

% --------------- Error rates ---------------------------------------------

errorTest = numErrors(testKnown, predTest)/length(testKnown)*100;
errorTrain = numErrors(trainKnown, predTrain)/length(trainKnown)*100;
disp('Training Error rate: ');
disp(errorTrain);
disp('Testing Error rate: ');
disp(errorTest);

% --------------- Functions -----------------------------------------------

function pred = predClasses(W, xt, trueClasses)
        pred = zeros(size(trueClasses));
        for i = 1:length(xt)
            x = [xt(:,i); 1];
            g = sigmoidfunction(W*x);
            [k,j] = max(g);
            pred(j,i) = 1;
        end
end

function W = MSE_training(W, xTraining, knownTrain, classes, training)
    alpha = 0.005;
    W_previous = W;
    g_MSE = 1;
    w0 = zeros(3,1);
    while norm(g_MSE) >= 0.1
        g_MSE = 0;
        for k=1:classes*training
            xk = [xTraining(:,k); 1];
            tk = knownTrain(:,k);
            zk = W_previous*xk + w0;
            gk = sigmoidfunction(zk);
            g_MSE = g_MSE + ((gk-tk).*gk.*(1-gk))*xk';
        end
        W = W_previous - alpha*g_MSE;
        W_previous = W;  
    end
end

function error = numErrors(trueClasses, pred)
    error = 0;
    [rows, columns] = size(trueClasses);
    
    for i = 1:rows
        for j = 1:columns
             if trueClasses(i,j) == 1 && pred(i,j) ~= 1
                error = error + 1;
             end
        end
    end          
end








