function root = csoma_setup()
%CSOMA_SETUP Add CSOMA package folders to the MATLAB path.
%
%   ROOT = CSOMA_SETUP() adds the package root, src, examples, tests, and
%   replication folders to the MATLAB path. ROOT is the absolute path to
%   this package.

    root = fileparts(mfilename('fullpath'));

    addpath(root);
    addpath(fullfile(root, 'src'));

    examples_dir = fullfile(root, 'examples');
    if exist(examples_dir, 'dir')
        addpath(genpath(examples_dir));
    end

    tests_dir = fullfile(root, 'tests');
    if exist(tests_dir, 'dir')
        addpath(tests_dir);
    end

    replication_dir = fullfile(root, 'replication');
    if exist(replication_dir, 'dir')
        addpath(replication_dir);
    end

    fprintf('CSOMA paths added from: %s\n', root);
end
