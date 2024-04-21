function [v]=getvviaeig(X)
    [V,D] = eig(X);
    [value,num] = max(diag(D));
    v = sqrt(value)*V(:,num);
end
