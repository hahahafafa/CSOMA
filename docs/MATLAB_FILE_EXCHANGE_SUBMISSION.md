# MATLAB File Exchange Submission Notes

## Recommendation

MATLAB File Exchange is a natural public distribution channel for this package,
especially when it is linked to the GitHub repository and a tagged release. Keep
the File Exchange entry synchronized with the repository release used for the
software-paper submission.

## Suggested Title

CSOMA: Competitive Swarm Optimizer with Mutated Agents

## Suggested Summary

CSOMA is a MATLAB implementation of the competitive swarm optimizer with mutated
agents, a derivative-free optimization method for box-constrained objective
functions. The package includes examples for optimal experimental design,
Gaussian copula dependence-model design and maximum likelihood estimation,
Wasserstein regression, Riemannian-manifold design, Bayesian design for an HIV
dynamics model, and a continuous-key traveling salesman problem formulation.

## Suggested Description

This package provides the core `csoma` optimizer and reproducible MATLAB
examples accompanying the manuscript "CSOMA: A Reusable and Reproducible MATLAB
Toolkit for Derivative-Free Optimization in Optimal Experimental Design". The optimizer minimizes a scalar objective
function over user-specified lower and upper bounds. It is useful when gradients
are unavailable, objective functions are nonconvex, or candidate-set
discretization is undesirable.

Included examples:

- Basic smoke test for the optimizer.
- Locally D-optimal approximate design for a two-factor logistic model.
- Gaussian copula D-optimal design and maximum pseudo-likelihood estimation.
- Wasserstein regression estimation for distribution-valued responses.
- D-optimal design on the sphere as a Riemannian-manifold example.
- Traveling salesman problem using continuous random keys.
- High-dimensional D-optimal design.
- Bayesian HIV design example.
- Fractional polynomial design examples.

## Suggested Tags

optimization, optimal design, experimental design, swarm optimization,
derivative-free optimization, MATLAB, statistics, D-optimality, Bayesian design

## Suggested Products

- MATLAB
- Statistics and Machine Learning Toolbox, for some advanced examples only

The core optimizer uses base MATLAB functions.

## License

MIT License.

## Suggested Citation

Cui, E., Zhang, Z., and Wong, W. K. CSOMA: A MATLAB Package for Optimization
and Optimal Experimental Design. Software paper, submitted.

Before publication, replace "submitted" with the final citation.

## Preferred Publishing Route

Use the GitHub repository connection if possible:

1. Prepare a clean GitHub release, for example `v0.1.3` or `v1.0.0`.
2. Attach `CSOMA_MATLAB_FileExchange.zip` or a MATLAB toolbox file if one is
   later created in MATLAB.
3. Log in to MATLAB Central.
4. Open File Exchange and choose Publish.
5. Choose the GitHub repository connection.
6. Select the CSOMA repository and, preferably, the GitHub release.
7. Use the title, summary, description, tags, products, license, and citation
   text above.

Alternative direct upload:

1. Log in to MATLAB Central.
2. Open File Exchange and choose Publish.
3. Upload `CSOMA_MATLAB_FileExchange.zip`.
4. Use the title, summary, description, tags, products, license, and citation
   text above.

## Links

- File Exchange publishing help:
  https://www.mathworks.com/matlabcentral/content/fx/about.html
- GitHub connection help:
  https://www.mathworks.com/matlabcentral/fileexchange/my-file-exchange/github-app-installation-guide
