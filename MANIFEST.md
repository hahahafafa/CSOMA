# Manifest

This file lists the files intended for the CSOMA MATLAB package and software
paper supplement.

## Package Files

- `README.md`: package overview and quick-start instructions.
- `CONTRIBUTING.md`: contributor and issue-reporting guide.
- `csoma_setup.m`: root-level MATLAB path setup helper.
- `LICENSE`: MIT license text.
- `LICENSE.txt`: duplicate MIT license file for submission systems that expect
  a `.txt` license filename.
- `MANIFEST.md`: this manifest.

## Source

- `src/csoma.m`: CSO-MA optimizer.
- `src/csoma_addpaths.m`: path helper.

## Fast Examples

- `examples/basic/run_basic.m`
- `examples/logistic_design/Logistic_D_Opt2.m`
- `examples/logistic_design/Sen_fun_log2.m`
- `examples/logistic_design/run_logistic_design.m`
- `examples/copula_design/Copula_D_Opt_Gaussian.m`
- `examples/copula_design/Copula_MLE_Gaussian.m`
- `examples/copula_design/gaussian_copula_info.m`
- `examples/copula_design/run_copula_design.m`
- `examples/copula_design/run_copula_mle.m`
- `examples/wasserstein_regression/Wasserstein_Regression_Objective.m`
- `examples/wasserstein_regression/run_wasserstein_regression.m`
- `examples/riemannian_design/Riemannian_Sphere_D_Opt.m`
- `examples/riemannian_design/run_riemannian_sphere_design.m`
- `examples/tsp/TSP.m`
- `examples/tsp/run_tsp.m`

## Heavier Examples

- `examples/high_dim_d_optimal/glm_fisher.m`
- `examples/high_dim_d_optimal/run_glm_fisher.m`
- `examples/bayesian_hiv/F_1.m`
- `examples/bayesian_hiv/F_2.m`
- `examples/bayesian_hiv/F_3.m`
- `examples/bayesian_hiv/lgwt.m`
- `examples/bayesian_hiv/md_gauss.m`
- `examples/bayesian_hiv/run_hiv_demo.m`
- `examples/fractional_polynomial/*.m`

## Replication

- `replication/run_all.m`: reviewer-facing fast replication entry point.

## Tests

- `tests/run_tests.m`: lightweight setup and optimizer smoke test.

## Documentation

- `FILE_EXCHANGE_SUBMISSION.md`
- `docs/developer.md`
- `docs/MATLAB_FILE_EXCHANGE_SUBMISSION.md`
- `docs/original_github_README.md`
- `docs/manuscript_code_fragments/*.m`

## Project Templates

- `.github/ISSUE_TEMPLATE/bug_report.md`
- `.github/ISSUE_TEMPLATE/feature_request.md`
- `.github/ISSUE_TEMPLATE/reproducibility_report.md`
