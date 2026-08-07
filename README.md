# CSOMA MATLAB Package

This directory contains a MATLAB code package prepared for the accompanying
software paper and MATLAB File Exchange release of the competitive swarm
optimizer with mutated agents (CSO-MA).

## Contents

- `src/csoma.m`: core CSO-MA optimizer.
- `src/csoma_addpaths.m`: helper to add package paths in MATLAB.
- `csoma_setup.m`: root-level setup helper for users and automated checks.
- `tests/run_tests.m`: lightweight setup and optimizer smoke test.
- `examples/basic`: a small smoke test.
- `examples/logistic_design`: two-factor logistic D-optimal design example.
- `examples/copula_design`: Gaussian copula D-optimal design and maximum
  pseudo-likelihood examples.
- `examples/wasserstein_regression`: Wasserstein regression estimation for
  distribution-valued responses.
- `examples/riemannian_design`: D-optimal design on the sphere as a simple
  Riemannian-manifold example.
- `examples/tsp`: traveling salesman example.
- `examples/high_dim_d_optimal`: high-dimensional D-optimal design code from
  the reference repository.
- `examples/bayesian_hiv`: Bayesian HIV design code from the reference
  repository, with a cleaned runnable driver.
- `examples/fractional_polynomial`: fractional polynomial design code from the
  reference repository.
- `replication/run_all.m`: fast replication entry point for reviewers.
- `docs/original_github_README.md`: README from the reference GitHub repository.
- `docs/manuscript_code_fragments`: code fragments extracted from the manuscript
  draft.
- `docs/developer.md`: maintainer notes for checks, releases, and examples.

## Quick Start

From MATLAB, run:

```matlab
cd CSOMA_MATLAB_FileExchange
csoma_setup
run(fullfile('tests', 'run_tests.m'))
run('replication/run_all.m')
```

The smoke test checks path setup, input validation, bounded output, monotone
best-so-far history, and deterministic behavior under a fixed seed. The fast
replication script runs lightweight examples for the optimizer, logistic design,
Gaussian copula design and MLE, Wasserstein regression, Riemannian sphere
design, and TSP formulation. Heavier Monte Carlo examples are provided under
`examples/` and should be run separately.

## Core Usage

```matlab
obj_fun = @(x)sum(x.^2);
lb = -ones(1, 5);
ub = ones(1, 5);
opts = struct('Seed', 2026, 'Display', false);
[best_value, best_x, history] = csoma(obj_fun, lb, ub, 32, 0.1, 100, opts);
```

`csoma` minimizes a scalar objective function over box constraints. The objective
function should accept one row vector and return one scalar value.

## When To Use CSOMA

CSOMA is a good fit when the objective function is a black box, gradients are
unavailable or unreliable, the feasible region can be expressed as finite box
bounds, and a stochastic global-search heuristic is acceptable. The examples
focus on optimal experimental design and related statistical optimization tasks,
but the core optimizer only requires a scalar objective and lower/upper bounds.

CSOMA is not the first choice for smooth convex problems where specialized
deterministic solvers, exact gradients, or convex optimization software are
available.

## Compatibility

The core optimizer uses base MATLAB functions only. It is written as ordinary
MATLAB `.m` files and does not require compiled extensions, external data files,
or a parallel computing setup. The package is intended for current supported
MATLAB releases. GNU Octave compatibility has not been verified.

Objectives are called with one row vector at a time. Bounds must be finite row
vectors of equal length, and the objective should return a finite scalar for
valid inputs or handle invalid model states by returning a finite penalty.

## Dependency Matrix

| Component | Required products | Notes |
| --- | --- | --- |
| `src/csoma.m` | MATLAB | Core optimizer; no toolbox dependencies. |
| `csoma_setup.m`, `tests/run_tests.m` | MATLAB | Smoke checks for setup, validation, and seeded reproducibility. |
| `examples/basic` | MATLAB | Minimal optimizer example. |
| `replication/run_all.m` fast examples | MATLAB | Runs the lightweight design, copula, Wasserstein, Riemannian, and TSP examples. |
| `examples/bayesian_hiv` | MATLAB; Statistics and Machine Learning Toolbox | Uses `mvnrnd`, `wishrnd`, `gamrnd`, and `normrnd`. |
| `examples/fractional_polynomial/hw3.m` | MATLAB; Global Optimization Toolbox for comparison blocks | Uses `particleswarm` in comparison code. The local `cso.m` examples do not require this toolbox. |
| Documentation and issue templates | None | Markdown files only. |

## Reproducibility And Seeds

`csoma` accepts an optional `opts.Seed` field. When supplied, the optimizer calls
`rng(opts.Seed)` before initializing the swarm. Examples that simulate data set
their data-generation seed explicitly and pass a separate optimizer seed where
needed. Running the same package version with the same seed should reproduce the
same optimizer trajectory within the same MATLAB random-number implementation;
small numerical differences can still occur across MATLAB releases or platforms.

For reviewer runs, start with:

```matlab
csoma_setup
run(fullfile('tests', 'run_tests.m'))
run(fullfile('replication', 'run_all.m'))
```

Record the MATLAB release, operating system, toolbox availability, and any
changed seeds when reporting reproducibility results.

## Benchmarks

`tests/run_tests.m` is the fastest health check and should complete quickly on a
standard laptop. `replication/run_all.m` is the reviewer-facing benchmark suite;
it intentionally uses reduced swarm sizes and iteration counts compared with
large simulation studies so that package functionality can be checked without a
long Monte Carlo run.

The Bayesian HIV, high-dimensional D-optimal, and fractional-polynomial examples
are heavier demonstration scripts. Run them separately when full example
coverage is needed, and report wall-clock time together with MATLAB release,
CPU, operating system, seed values, swarm size, and iteration count.

## Limitations

CSOMA is stochastic and does not provide a proof of global optimality for a
single finite run. Performance depends on the objective scaling, dimension,
bounds, swarm size, iteration count, seed, and stopping budget. The implementation
handles finite box constraints directly; equality constraints, nonlinear
constraints, integer variables, and multiobjective criteria must be encoded by
the user, usually through penalties or problem-specific parameterizations.

The package evaluates objectives serially and does not include automatic
parallelization. Examples are intended to be transparent reference scripts for
the software paper, not exhaustive performance claims for every problem class.

## Contributing

Please see `CONTRIBUTING.md` for issue-reporting, testing, and pull-request
guidelines. Maintainer-oriented notes are in `docs/developer.md`.

## License

The package is distributed under the MIT License.

## Reference Source

The code package is maintained in the public repository
`https://github.com/hahahafafa/CSOMA`. A public MATLAB File Exchange entry is
available at `https://www.mathworks.com/matlabcentral/fileexchange/183862-csoma`.
