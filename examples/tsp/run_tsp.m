% Traveling salesman example using continuous random keys.

root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(fullfile(root, 'src'));
addpath(fileparts(mfilename('fullpath')));

DM = [ ...
     0 36 29 64 48 46  6 73 50 38;
    36  0 29 28 33 28  6 33 30 26;
    29 29  0 36 40 38  7 36 43 31;
    64 28 36  0 37 41  7 56 53 36;
    48 33 40 37  0 40  7 55 55 52;
    46 28 38 41 40  0  7 46 42 47;
     6  6  7  7  7  7  0  6  9  8;
    73 33 36 56 55 46  6  0 57 58;
    50 30 43 53 55 42  9 57  0 33;
    38 26 31 36 52 47  8 58 33  0];

n = size(DM, 1);
obj_fun = @(route)TSP(route, n, DM);
lb = zeros(1, n);
ub = ones(1, n);
swarmsize = 64;
phi = 0.10;
maxiter = 200;
opts = struct('Seed', 2026, 'Display', false);

[min_route_length, min_route] = csoma(obj_fun, lb, ub, swarmsize, phi, maxiter, opts);
[~, min_route_idx] = sort(min_route);

fprintf('Route length: %.4f\n', min_route_length);
fprintf('Route: %s -> %d\n', sprintf('%d -> ', min_route_idx), min_route_idx(1));
