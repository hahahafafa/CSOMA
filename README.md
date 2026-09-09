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
- `replication/verify_round2.m`: one-command release verifier that records the
  MATLAB/OS environment, Git state, timings, and both automated test suites.
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

### Parameter Selection

The values of `swarmsize`, `phi`, and `maxiter` used in the bundled examples
are problem-specific, illustrative settings; they are not universal defaults
or generally optimal recommendations. `swarmsize` controls how many candidate
solutions are explored per iteration, `maxiter` sets the optimization budget,
and `phi` controls the pull toward the current swarm center. For a new problem,
users should increase the swarm size or iteration budget when solutions or
problem-specific diagnostics are unstable across seeds. The appropriate value
of `phi` is also problem dependent and should be checked together with variable
scaling, objective stability, and the available computational budget.

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

<!-- ROUND-2 RELEASE GATE: Before tagging v0.1.4, replace this comment with a
verified environment paragraph giving the exact MATLAB release, operating
system and version, commands run, and pass result. Do not claim untested
platforms as verified. -->

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

For a complete release or reviewer verification from a clean Git worktree,
start with:

```matlab
csoma_setup
log_file = verify_round2()
```

The verifier records the full MATLAB version, release, operating-system
details, installed MATLAB products, exact Git commit, clean-worktree status,
and elapsed time for each suite. It writes a timestamped diary to the system
temporary directory, prints the path as `ROUND2_LOG_FILE`, and runs
`tests/run_tests.m` followed by `replication/run_all.m`. The direct commands
remain useful when diagnosing a failed phase.

### Numerical Acceptance Criteria

The release verification is successful only when the log contains
`CSOMA smoke tests passed.`,
`All fast replication acceptance checks passed.`, and
`ROUND2_RELEASE_VERIFICATION=PASS` without an assertion failure.
The checks distinguish deterministic repeatability from cross-platform
numerical agreement:

- Repeated core-optimizer calls with the same package, MATLAB release,
  numerical environment, and seed must be exactly equal, as checked by
  `tests/run_tests.m`.
- Across MATLAB releases or operating systems, exact equality is not required.
  Each fast workflow must instead satisfy the explicit criteria below.

| Workflow | Acceptance criterion |
| --- | --- |
| Basic optimizer | Finite bounded result; best-so-far history does not increase beyond `1e-10`. |
| Logistic D-optimal design | Finite non-penalty criterion; support points in `[-1, 1]^2`; nonnegative weights summing to one within `1e-10`; maximum centered sensitivity on the documented `201 x 201` grid no greater than `0.3`. |
| Gaussian copula design | Finite non-penalty criterion; support points in `[-1, 1]`; nonnegative weights summing to one within `1e-10`. |
| Gaussian copula MLE | Finite objective and correlation in `(-1, 1)`; absolute error from the seeded true correlation `0.55` no greater than `0.15`. |
| Wasserstein regression | Finite output; loss no greater than `0.02`; maximum absolute coefficient error no greater than `0.35`. |
| Riemannian sphere design | Finite non-penalty criterion; unit-norm support points and nonnegative weights summing to one within `1e-10`. |
| Traveling-salesman example | Finite valid permutation of all ten cities; independently recomputed closed-tour length agrees with the reported value within the scaled `1e-10` tolerance. |

These thresholds are release-verification criteria for the seeded, lightweight
examples. They are not claims that a stochastic optimizer must return the same
solution on every unseeded run, and they are not substitutes for
problem-specific optimality diagnostics in new applications. In particular,
the `0.3` logistic bound is a smoke-level guard for the reduced-iteration fast
workflow; the manuscript separately reports the much stronger centered-
sensitivity diagnostic for the publication-quality design shown in Figure 1.

## Benchmarks

`tests/run_tests.m` is the fastest health check and should complete quickly on a
standard laptop. `replication/run_all.m` is the reviewer-facing benchmark suite;
it intentionally uses reduced swarm sizes and iteration counts compared with
large simulation studies so that package functionality can be checked without a
long Monte Carlo run. `replication/verify_round2.m` is the release-facing logged
wrapper that invokes both automated suites. The replication script evaluates
the criteria above and stops with a named assertion if a workflow fails.

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
