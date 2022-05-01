close all

%% Calling function for checking if predicted numbers are correct or not
[corrClassifiedArray, missClassifiedArray] = Classified(testlab, NN_pred, testv);
% Indixes of missclassified and correctly classified images 
missC = [116,196,242,269]; % Indixes found in missClassifiedArray, these correspond to the "NN_pred" matrix, which
                           % confirms that the classifier failed at classifying these numbers
corrC = [110,192,232,380]; % Indixes found in corrClassifiedArray, these correspond to the "known" matrix, which
                           % confirms that the classifier succeeded at classifying these numbers


knownsMissC = [4, 3, 9, 8]; % Arrays for labeling figures, these numbers are found by checking the row
predMissC = [9, 5, 8, 5];   % number and subtracting 1 to find either the predicted number or the
knownsCorrC = [4, 1, 3, 4]; % correct one in "knowns" matrix or "NN_pred"
predCorrC = [4, 1, 3, 4];


x = zeros(28,28);


%% Plot of missclassified pictures
figure(1)
%sgtitle("Missclassified Pictures")
for i = 1:size(missC, 2)
    x(:) = testv(missC(i),:);
    subp = 220 + i;
    subplot(subp);
    image(rot90(flip(x),3));
    subtitle("True value: " + knownsMissC(i) + ", Predicted value: " + predMissC(i));
end


%% Plot of correctly classified pictures
figure(2)
%sgtitle("Correct Classified Pictures")
for i = 1:size(corrC, 2)
    x(:) = testv(corrC(i),:);
    subp = 220 + i;
    subplot(subp);
    image(rot90(flip(x),3));

    subtitle("True value: " + knownsCorrC(i) + ", Predicted value: " + predCorrC(i));
end


%% Funtion for checking if predicted numbers are correct or not
function [corrClassifiedArray, missClassifiedArray] = Classified(labels, predictions, testvalues)
    correctNum = 0; % Initializing counters for number of missclassified               
    missNum = 0;    % or correctly classified numbers

    targets = zeros(10, size(testvalues,1)); % Creating zero matrix for targets with 10 rows (for numbers from 0-9) and the 
                                             % number of test values for columns
    for k = 1:size(testvalues,1)
        targets(labels(k)+1,k) = 1; % Placing 1s in the matrix for the correct numbers
        [~,i] = max(predictions(:,k)); % By finding the maximum values, we find the 1s in the matrix
        if labels(k)+1 == i % if there is a 1 in the matrix 
            correctNum = correctNum +1; % -> count one correct classified
        else % if there is not a 1 (basically a 0) in the matrix
            missNum = missNum +1; % -> count one missclassified
        end
    end
    
    % Generating array of indexes for missclassified or correctly classified numbers
    corrClassifiedArray = zeros(correctNum,1); % Creating zero matrix for correctly predicted numbers
    missClassifiedArray = zeros(missNum,1); % Creating zero matrix for missclassified numbers

    index = 1; % initializing counter

    for k = 1:size(testvalues,1) % going through the rows of testvalues
        [~,i] = max(predictions(:,k)); % finding 1s
        if labels(k)+1 == i
            corrClassifiedArray(index) = k; % adding k to the correct array
            index = index + 1;
        else
            missClassifiedArray(index) = k; % adding k to the incorrect array
            index = index + 1;
        end
    end
end