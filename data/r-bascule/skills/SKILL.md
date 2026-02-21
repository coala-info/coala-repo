---
name: r-bascule
description: R package bascule (documentation from project home).
homepage: https://cran.r-project.org/web/packages/bascule/index.html
---

# r-bascule

name: r-bascule
description: Bayesian inference and clustering of somatic mutational signatures using the bascule R package. Use this skill when performing mutational signature analysis, including fitting known COSMIC signatures, discovering de novo signatures, and performing joint tensor clustering of multiple signature types (SBS, DBS, ID) across patient cohorts.

## Overview

bascule is a Bayesian framework for mutational signature analysis. It leverages pre-existing catalogues (like COSMIC) while allowing for the discovery of novel signatures. Key features include:
- Variational inference for fast, scalable model fitting.
- Support for multiple signature types (Single Base Substitutions, Doublet Base Substitutions, Indels).
- Joint tensor clustering to identify latent groups of patients based on their signature exposures.
- Integration with the `pybascule` Python backend for efficient non-negative matrix factorization.

## Installation

To install the package from GitHub:

```R
# install.packages("devtools")
devtools::install_github("caravagnalab/bascule")
```

Note: This package requires a working Python environment with `pybascule` installed, as it uses `reticulate` to interface with the Python implementation.

## Main Functions and Workflow

### 1. Data Preparation
Input data should typically be a mutational catalogue (counts of mutation types across samples).

```R
# Load example data or create a counts matrix
data("simulated_counts")

# Create a bascule object
input_data <- bascule::create_input(counts = simulated_counts, type = "SBS96")
```

### 2. Model Fitting
Use `fit()` to perform signature extraction. You can specify a fixed number of signatures or a range to explore.

```R
# Fit model with a known catalogue (e.g., COSMIC v3)
fit_results <- bascule::fit(
  input_data, 
  k = 2:10,                   # Range of signatures to test
  clusters = 1:3,             # Range of patient clusters to test
  catalogue = "cosmic_v3",    # Reference signatures
  method = "vi"               # Variational Inference
)
```

### 3. Signature Discovery
BASCULE can identify signatures present in the catalogue and "de novo" signatures simultaneously.

```R
# Access discovered signatures
signatures <- bascule::get_signatures(fit_results)

# Access patient exposures
exposures <- bascule::get_exposures(fit_results)
```

### 4. Clustering and Visualization
BASCULE performs tensor clustering to group patients with similar mutational processes.

```R
# Plot the fit results
bascule::plot_signatures(fit_results)
bascule::plot_exposures(fit_results)
bascule::plot_clusters(fit_results)
```

## Tips for Effective Usage
- **Signature Types**: You can combine different mutation types (SBS, DBS, ID) into a single joint analysis to improve clustering resolution.
- **Hyperparameters**: Pay attention to the `alpha` and `beta` priors if the default variational inference results do not converge or seem over-fitted.
- **Python Backend**: Ensure your `reticulate` configuration points to the correct Python environment where `pybascule` is installed. Use `bascule::install_pybascule()` if available to automate setup.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)