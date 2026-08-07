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
2. Run `tests/run_tests.m`.
3. Run `replication/run_all.m` when MATLAB is available.
4. Confirm package-facing docs contain no stale journal-specific wording.
5. Confirm `MANIFEST.md` lists new files.
6. Build the archive from `CSOMA_MATLAB_FileExchange`, not from manuscript
   submission folders.

## Release Notes

For a MATLAB File Exchange refresh, use a tagged repository release when
possible. The File Exchange description should mention the core base-MATLAB
dependency, optional toolbox requirements for advanced examples, and the
reviewer smoke-test command.
