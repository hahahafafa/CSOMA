%RUN_TESTS Lightweight CSOMA package smoke tests.
%
% Run from the package root with:
%   csoma_setup
%   run(fullfile('tests', 'run_tests.m'))

fprintf('Running CSOMA smoke tests...\n');

old_path = path;
old_rng = rng;
cleanup_path = onCleanup(@() path(old_path));
cleanup_rng = onCleanup(@() rng(old_rng));

root = fileparts(fileparts(mfilename('fullpath')));
addpath(root);
setup_root = csoma_setup();

assert(strcmp(setup_root, root), 'csoma:test:SetupRoot', ...
    'csoma_setup returned an unexpected package root.');
assert(exist('csoma', 'file') == 2, 'csoma:test:MissingCore', ...
    'csoma.m is not available on the MATLAB path after setup.');

obj_fun = @(x)sum((x - [0.20, -0.40]).^2);
lb = [-1, -1];
ub = [1, 1];
swarmsize = 20;
phi = 0.10;
maxiter = 30;
opts = struct('Seed', 1234, 'Display', false);

[best_value_1, best_x_1, history_1] = csoma(obj_fun, lb, ub, swarmsize, phi, maxiter, opts);
[best_value_2, best_x_2, history_2] = csoma(obj_fun, lb, ub, swarmsize, phi, maxiter, opts);

assert(isfinite(best_value_1), 'csoma:test:BestValueFinite', ...
    'Best objective value must be finite.');
assert(all(isfinite(best_x_1)), 'csoma:test:BestXFinite', ...
    'Best point must contain finite coordinates.');
assert(all(best_x_1 >= lb) && all(best_x_1 <= ub), 'csoma:test:Bounds', ...
    'Best point must respect the supplied bounds.');
assert(numel(history_1) == maxiter + 1, 'csoma:test:HistoryLength', ...
    'History length must be maxiter + 1.');
assert(history_1(end) <= history_1(1) + 1e-12, 'csoma:test:HistoryImproves', ...
    'Best-so-far history should not worsen over the run.');
assert(isequal(best_value_1, best_value_2) && isequal(best_x_1, best_x_2) ...
    && isequal(history_1, history_2), 'csoma:test:SeedDeterminism', ...
    'Repeated runs with the same seed should be deterministic.');

try
    csoma(obj_fun, [-1, -1], 1, swarmsize, phi, maxiter, opts);
    error('csoma:test:ExpectedFailureMissing', ...
        'Expected bounds-length validation to fail.');
catch ME
    assert(strcmp(ME.identifier, 'csoma:BoundsLengthMismatch'), ...
        'csoma:test:UnexpectedError', ...
        'Expected csoma:BoundsLengthMismatch, received %s.', ME.identifier);
end

fprintf('CSOMA smoke tests passed.\n');
