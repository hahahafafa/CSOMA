# Contributing To CSOMA

Thank you for helping improve CSOMA. This package is small by design, so changes
should keep the public optimizer interface stable unless there is a clear reason
to revise it.

## Reporting Issues

Please include:

- MATLAB release and operating system.
- Toolbox availability when running advanced examples.
- The exact script or command that failed.
- Seed values, swarm size, `phi`, iteration count, and bounds for optimization
  issues.
- A minimal objective function when possible.
- The observed output and the expected output.

Use the reproducibility issue template for reviewer runs or manuscript-example
checks.

## Development Checks

Before proposing a change, run the lightweight test:

```matlab
cd CSOMA_MATLAB_FileExchange
csoma_setup
run(fullfile('tests', 'run_tests.m'))
```

When a change affects examples or documentation claims, also run:

```matlab
run(fullfile('replication', 'run_all.m'))
```

The Bayesian HIV, high-dimensional D-optimal, and fractional-polynomial examples
can be slow and should be run separately when they are affected by a change.

## Pull-Request Guidelines

- Keep changes focused on one bug fix, example, or documentation improvement.
- Preserve the `csoma` call signature unless the change is intentionally a
  compatibility break.
- Prefer finite penalties inside objectives over uncaught `NaN` or `Inf` values.
- Document any new random seed or stochastic benchmark setting.
- Update `README.md`, `MANIFEST.md`, and `docs/developer.md` when the package
  layout or dependencies change.

## Style

Use clear MATLAB function names, row-vector bounds, finite scalar objective
values, and short comments only where they clarify non-obvious optimization or
modeling choices.
