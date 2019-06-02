function [ gini_matrix ] = giniCoeff( train_data)
%GINICOFF Summary of this function goes here
%train_data is a m*n matrix where each row is for a user and the value 0/1 for each element represents selected/unselected.
    %sort pred
    [m,~] = size(train_data);
    train_col_du = sum(train_data,1); % popularity of items
    train_row_du = sum(train_data,2); % activity of users
    train_col_du_matrix = repmat(train_col_du,[m,1]);
    user_item_degree_matrix = train_data .* train_col_du_matrix;
    clear train_data train_col_du train_col_du_matrix;
    gini_matrix = zeros(m,1); 
    for i = 1:m
        item_degrees = user_item_degree_matrix(i,find(user_item_degree_matrix(i,:)~= 0));
        [A,~] = sort(item_degrees,2);
        [freq, diff_degrees] = hist(A,unique(A));
        gini = 0; n = length(A);
        for rank = 1:1:n
            item_degree = A(rank);
            item_count = freq(find(diff_degrees == item_degree));
            gini = gini + (n+1-rank)/(n+1) * (item_count/n);
        end
        gini_matrix(i) = gini; 
    end
end

