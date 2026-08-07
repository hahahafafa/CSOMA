function distance = TSP(route, n, DM)
%TSP Continuous-key objective for the traveling salesman problem.

    [~, order] = sort(route(:));
    order = order(1:n);
    distance = 0;
    for i = 1:n-1
        distance = distance + DM(order(i), order(i+1));
    end
    distance = distance + DM(order(end), order(1));
end
