---
name: lcfit
description: lcfit approximates phylogenetic likelihood functions using nonlinear least squares to enable rapid branch length estimation and posterior sampling. Use when user asks to fit surrogate functions to log-likelihood data, estimate maximum-likelihood branch lengths, or perform efficient posterior sampling in phylogenetic workflows.
homepage: https://github.com/matsengrp/lcfit
metadata:
  docker_image: "quay.io/biocontainers/lcfit:0.5--h20b91ae_3"
---

# lcfit

## Overview
lcfit is a specialized toolset designed to approximate phylogenetic likelihood functions using nonlinear least squares. By fitting surrogate functions to empirical log-likelihood data, it enables rapid maximum-likelihood branch length estimation and efficient posterior sampling. It is primarily utilized as a C/C++ library, providing developers with the mathematical framework to bypass the high computational costs of repeated full-likelihood calculations in phylogenetic workflows.

## Installation and Setup
The most efficient way to install lcfit is through Bioconda:
`conda install bioconda::lcfit`

For manual compilation from source, the following dependencies are required:
- CMake
- GNU Scientific Library (GSL)
- NLopt
- Bio++ (specifically bpp-core, bpp-seq, and bpp-phyl for the `lcfit-compare` utility)

## Implementation Patterns

### C API: Fitting a Model
To fit a model to an empirical log-likelihood function, use the `lcfit_fit_auto` function declared in `lcfit_select.h`.

1.  **Define Context**: Create a struct to hold your tree data and node identifiers.
2.  **Callback Function**: Implement a callback with the signature `double callback(double branch_length, void *data)` that returns the log-likelihood.
3.  **Initialize Model**: Use the `DEFAULT_INIT` macro for the `bsm_t` model structure.
4.  **Execute Fit**: Call `lcfit_fit_auto(&callback, &data_struct, &model, min_t, max_t)`. This returns the estimated maximum-likelihood branch length.

### C++ API: Posterior Sampling
The C++ interface provides a rejection sampler for sampling from an unnormalized posterior given an exponential prior.

1.  **Setup RNG**: Allocate a GSL random number generator (`gsl_rng_alloc`).
2.  **Initialize Sampler**: Instantiate `lcfit::rejection_sampler` using the RNG, a previously fitted `bsm_t` model, and an exponential rate parameter (`lambda`).
3.  **Generate Samples**:
    -   Single sample: `sampler.sample()`
    -   Multiple samples: `sampler.sample_n(1000)`
4.  **Analysis**: Use the sampler's built-in functions to compute density or cumulative density at specific branch lengths.

## Best Practices and Tips
- **Search Bounds**: When using `lcfit_fit_auto`, ensure the `min_t` and `max_t` values strictly bracket the region of interest. Providing narrow, realistic bounds improves optimization speed and prevents convergence on local minima.
- **Callback Optimization**: The fitting process involves repeated calls to the log-likelihood callback. Ensure this function is optimized and avoids unnecessary memory allocations.
- **Model Validation**: Before sampling, verify that the `bsm_t` model was successfully fitted. The library relies on GSL for numerical integration; ensure GSL is properly linked during the build process.
- **Tooling**: Use the `lcfit-compare` tool (built via `make lcfit-compare`) to validate the surrogate function's accuracy against true likelihood values for your specific dataset.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_matsengrp_lcfit.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_lcfit_overview.md)