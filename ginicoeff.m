function [coeff] = ginicoeff(pred,K)
    %sort pred
    [m,n] = size(pred);
    [~,sat] = sort(pred,2);
    rec_matrix = zeros(m,n);
    for i = 1:m
        temp = sat(i, n - K + 1 : n);
        rec_matrix(i, temp) = 1;
    end
    %popularity for every item
    In(1,:) = sum(rec_matrix, 1);
    if isvector(In); In = In(:); dim = 1; end
    % Sort In
    In = sort(In,dim,'ascend');

    N = length(In);
    % Totals
    tot = sum(In,dim);

    % Gini's coefficient
    % coeff = N+1-2*(sum(In.*freq,dim)./tot);
    coeff = 0;
    for i = 1:N
        G = (2*i - N -1) .* (In(i,1) ./ tot);
        coeff = coeff + G; 
    end
    % Sample correction
    coeff = coeff./(N-1);
end


