# Developer Notes

These notes are for maintainers preparing reviewer packages, MATLAB File
Exchange uploads, or small code changes.

## Package Layout

- `src/csoma.m`: public optimizer entry point.
- `src/csoma_addpaths.m`: legacy path helper kept for compatibility.
- `csoma_setup.m`: root-level path helper recommended for users and tests.
- `tests/run_tests.m`: deterministic smoke test for setup and core optimizer
  behavior.
- `replication/run_all.m`: reviewer-facing fast replication suite.
- `replication/verify_round2.m`: release-facing wrapper that records the exact
  environment, Git state, timings, and complete automated-test output.
- `examples/`: standalone scripts grouped by application.
- `docs/manuscript_code_fragments/`: manuscript fragments retained as reference
  material.

## Compatibility Policy

The core optimizer should remain base-MATLAB only. Do not add toolbox calls to
`src/csoma.m` or to the smoke test unless the README dependency matrix is updated
and the dependency is unavoidable.

Advanced examples may use optional toolboxes when the dependency is documented.
Current optional dependencies are:

- Statistics and Machine Learning Toolbox for `examples/bayesian_hiv`.
- Global Optimization Toolbox for the `particleswarm` comparison blocks in
  `examples/fractional_polynomial/hw3.m`.

GNU Octave is not part of the verified support matrix.

## Reproducibility

`csoma` supports `opts.Seed`, which calls `rng` before swarm initialization.
Example scripts that generate synthetic data should set a data seed explicitly
before data generation and pass a separate optimizer seed when useful. Avoid
changing published example seeds unless the change is intentional and documented.

When reporting benchmark or replication results, record:

- MATLAB release and operating system.
- CPU model when wall-clock time is discussed.
- Toolbox availability.
- Package version or repository commit.
- Seed values, swarm size, `phi`, and iteration count.

The release-verification policy has two levels:

- `tests/run_tests.m` requires exact repeatability for two calls made with the
  same seed in the same MATLAB process.
- `replication/run_all.m` uses explicit finite-value, feasibility, and
  problem-specific acceptance criteria. Cross-release or cross-platform output
  does not have to be bitwise identical when those criteria pass.

Run `verify_round2` only from a committed, clean Git worktree. The verifier
fails on a dirty worktree, writes its diary outside the repository, and records
the full 40-character commit so the log can be tied to an immutable release.

Do not change an acceptance threshold merely to make a failing release pass.
Investigate the failure, record the environment and output, and change a
threshold only when the scientific or numerical justification is documented in
the README and reviewer response.

## Smoke Test

Run:

```matlab
cd CSOMA_MATLAB_FileExchange
csoma_setup
run(fullfile('tests', 'run_tests.m'))
```

The smoke test verifies:

- `csoma_setup` returns the package root and exposes `csoma`.
- Repeated runs with the same `opts.Seed` are deterministic.
- The best-so-far history has the expected length and does not worsen.
- Returned coordinates respect finite lower and upper bounds.
- Invalid bound lengths throw the documented `csoma:BoundsLengthMismatch`
  error.

## Reviewer Package Checklist

1. Remove stale journal-specific wording from package-facing docs.
2. Commit the candidate code and run `verify_round2` from a clean worktree.
3. Use the first log to add the exact tested MATLAB/OS environment to README
   and update release-facing metadata.
4. Commit those metadata edits and run `verify_round2` again. Retain the second
   log, whose `GIT_COMMIT` must match the commit used for the release tag.
5. Require all three pass markers and no assertion failure in the retained log.
6. Confirm package-facing docs contain no stale journal-specific wording.
7. Confirm `MANIFEST.md` lists new files.
8. Build the archive from `CSOMA_MATLAB_FileExchange`, not from manuscript
   submission folders.

## Release Notes

For a MATLAB File Exchange refresh, use a tagged repository release when
possible. The File Exchange description should mention the core base-MATLAB
dependency, optional toolbox requirements for advanced examples, and the
reviewer smoke-test command.

Do not move or recreate an existing release tag after publication. If package
documentation or executable checks change after a tag, increment the patch
version, create a new release, and update the manuscript, `CITATION.cff`, README,
MATLAB File Exchange entry, and submission archive to that exact version.
