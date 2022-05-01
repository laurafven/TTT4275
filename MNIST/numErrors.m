%% Same function as used in the iris case
% Calculate the error rate between the true values and the predicted values
function error = numErrors(true, pred)
    error = 0;
    [rows, columns] = size(true);   % Creating an empty matrix with the same size as the matrix for true value
    
    for i = 1:rows                  % Going through the rows
        for j = 1:columns           % Going through the columns for each row
             if true(i,j) == 1 && pred(i,j) ~= 1    % If the the same posititions in true and pred, both is 1
                error = error + 1;                  % the error increase with 1
             end
        end
    end          
end