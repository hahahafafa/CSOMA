function log_file = verify_round2()
%VERIFY_ROUND2 Run and log the SoftwareX second-round release verification.
%
%   LOG_FILE = VERIFY_ROUND2() records the exact MATLAB release, operating
%   system, Git commit, worktree state, installed MATLAB products, smoke
%   tests, and fast replication checks. The log is written to the system
%   temporary directory so that running the verifier does not dirty the
%   repository.

    root = fileparts(fileparts(mfilename('fullpath')));
    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
    log_file = fullfile(tempdir, ...
        ['csoma_round2_verification_' timestamp '.txt']);

    original_dir = pwd;
    cleanup_dir = onCleanup(@() cd(original_dir)); %#ok<NASGU>
    diary(log_file);
    cleanup_diary = onCleanup(@() diary('off')); %#ok<NASGU>

    cd(root);
    fprintf('CSOMA_ROUND2_RELEASE_VERIFICATION\n');
    fprintf('VERIFICATION_LOCAL_TIME=%s\n', datestr(now, 31));
    fprintf('MATLAB_FULL_VERSION=%s\n', version);
    fprintf('MATLAB_RELEASE=R%s\n', version('-release'));
    fprintf('COMPUTER_ARCH=%s\n', computer);

    if ismac
        os_command = 'sw_vers';
    elseif ispc
        os_command = 'ver';
    else
        os_command = 'uname -sr';
    end
    [os_status, os_details] = system(os_command);
    fprintf('OS_COMMAND_STATUS=%d\n', os_status);
    fprintf('OS_DETAILS_BEGIN\n%s\nOS_DETAILS_END\n', strtrim(os_details));

    quoted_root = ['"', root, '"'];
    [git_commit_status, git_commit] = system( ...
        ['git -C ', quoted_root, ' rev-parse HEAD']);
    [git_state_status, git_state] = system( ...
        ['git -C ', quoted_root, ' status --porcelain']);
    assert(git_commit_status == 0 && git_state_status == 0, ...
        'csoma:verification:GitUnavailable', ...
        'Git commit or worktree state could not be determined.');
    fprintf('GIT_COMMIT=%s\n', strtrim(git_commit));
    if isempty(strtrim(git_state))
        fprintf('GIT_WORKTREE_CLEAN=YES\n');
    else
        fprintf('GIT_WORKTREE_CLEAN=NO\n');
        fprintf('GIT_STATUS_BEGIN\n%s\nGIT_STATUS_END\n', strtrim(git_state));
        error('csoma:verification:DirtyWorktree', ...
            'Commit or stash local changes before release verification.');
    end

    fprintf('MATLAB_PRODUCT_LIST_BEGIN\n');
    ver;
    fprintf('MATLAB_PRODUCT_LIST_END\n');

    round2_phase = 'smoke tests';
    try
        smoke_timer = tic;
        run(fullfile(root, 'tests', 'run_tests.m'));
        fprintf('SMOKE_TEST_STATUS=PASS\n');
        fprintf('SMOKE_TEST_SECONDS=%.3f\n', toc(smoke_timer));

        round2_phase = 'fast replication checks';
        fast_timer = tic;
        run(fullfile(root, 'replication', 'run_all.m'));
        fprintf('FAST_REPLICATION_STATUS=PASS\n');
        fprintf('FAST_REPLICATION_SECONDS=%.3f\n', toc(fast_timer));
    catch ME
        fprintf('ROUND2_RELEASE_VERIFICATION=FAIL\n');
        fprintf('FAILED_PHASE=%s\n', round2_phase);
        fprintf('%s\n', getReport(ME, 'extended', 'hyperlinks', 'off'));
        rethrow(ME);
    end

    fprintf('ROUND2_RELEASE_VERIFICATION=PASS\n');
    fprintf('ROUND2_LOG_FILE=%s\n', log_file);

end
