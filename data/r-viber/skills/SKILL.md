---
name: r-viber
description: R package viber (documentation from project home).
homepage: https://cran.r-project.org/web/packages/viber/index.html
---

# r-viber

name: r-viber
description: Variational Bayesian model for fitting multi-variate Binomial mixtures. Use this skill when performing subclonal deconvolution or clustering of multi-variate count data, particularly sequencing counts (Variant Allele Frequencies) in cancer genomics.

# r-viber

## Overview
VIBER (Variational Inference for Binomial mixtures) is an R package for subclonal deconvolution using a semi-parametric variational mean-field approximation. It fits multivariate Binomial mixtures to model count data, such as those derived from multi-sample cancer sequencing experiments.

## Installation
To install the package from CRAN:
install.packages("viber")

To install the development version:
devtools::install_github("caravagnalab/VIBER")

## Main Workflow

### 1. Data Preparation
VIBER requires two matrices:
- **Successes (SNV counts)**: A matrix `counts` where rows are mutations and columns are samples.
- **Trials (Depth of coverage)**: A matrix `depths` where rows are mutations and columns are samples.

### 2. Model Fitting
The primary function is `variational_fit`. It uses a Dirichlet Process prior to automatically determine the number of clusters (up to a specified maximum `K`).

```r
library(viber)

# Fit the model
fit = variational_fit(
  counts, 
  depths, 
  K = 10,           # Maximum number of clusters
  samples = 1000,   # Number of ELBO iterations
  epsilon = 1e-5    # Convergence threshold
)
```

### 3. Inspection and Visualization
After fitting, you can inspect the cluster assignments and the Binomial parameters (theta).

```r
# Print summary
print(fit)

# Plot the clustering results (e.g., 2D density or VAF profiles)
plot(fit)

# Get cluster assignments
assignments = fit$cluster_assignments
```

## Key Tips
- **Multivariate Data**: VIBER excels at multi-sample (multi-region or longitudinal) data where each mutation is tracked across multiple biopsies.
- **Binomial Parameters**: The model estimates the probability of success (theta) for each cluster in each sample, which corresponds to the expected VAF.
- **Convergence**: Monitor the Evidence Lower Bound (ELBO) to ensure the variational approximation has converged.

## Reference documentation
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)