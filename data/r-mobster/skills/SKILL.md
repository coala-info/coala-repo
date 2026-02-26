---
name: r-mobster
description: r-mobster performs model-based subclonal deconvolution of bulk tumor sequencing data by integrating Dirichlet mixture models with population genetics. Use when user asks to perform subclonal reconstruction, cluster variant allele frequencies, or fit evolutionary models to distinguish between subclonal selection and neutral growth.
homepage: https://cran.r-project.org/web/packages/mobster/index.html
---


# r-mobster

name: r-mobster
description: Model-based tumour subclonal deconvolution using population genetics. Use this skill when analyzing cancer genome sequencing data (bulk DNA-seq) to perform subclonal reconstruction, clustering of variant allele frequencies (VAF), and fitting evolutionary models that combine Dirichlet mixture models with population genetics theory.

## Overview

mobster (Model-based tumour subclonal deconvolution) is an R package designed to infer the clonal architecture of tumors from bulk sequencing data. It integrates Machine Learning (Dirichlet mixture models) with theoretical population genetics (neutral tail models) to distinguish between subclonal selection and neutral tumor evolution. It is particularly effective for whole-genome sequencing (WGS) and whole-exome sequencing (WES) data.

## Installation

To install the package from GitHub:

```R
# install.packages("devtools")
devtools::install_github("caravagnalab/mobster")
```

## Core Workflow

### 1. Data Preparation
The input should be a data frame containing mutation data. At minimum, it requires a column for Variant Allele Frequency (VAF).

```R
library(mobster)

# Example data structure
# data should have a 'VAF' column (values between 0 and 1)
data("example_dataset", package = "mobster")
```

### 2. Model Fitting
Use the `mobster_fit` function to perform the deconvolution. This function searches for the best number of Beta components (subclones) and determines if a Power Law component (neutral tail) is present.

```R
# Fit models with 1 to 3 Beta components, with and without a neutral tail
fit <- mobster_fit(
  example_dataset, 
  K = 1:3, 
  samples = 5, 
  init = "random"
)
```

Key parameters:
- `K`: Vector of the number of Beta components to test.
- `samples`: Number of independent initializations for each K.
- `tail`: Boolean, whether to include the Power Law component (default is TRUE).

### 3. Model Selection
The package automatically selects the best model based on Information Criteria (re-scaled ICL by default).

```R
# Get the best model
best_model <- fit$best

# View model summary
print(best_model)
```

### 4. Visualization
mobster provides S3 methods for plotting the results, including VAF histograms with fitted density curves.

```R
# Plot the VAF distribution and the fit
plot(best_model)

# Plot the latent variables (assignments)
plot_latent_variables(best_model)
```

## Advanced Features

### Bootstrap Assessment
To assess the stability of the clusters and the confidence of parameter estimates, use the bootstrap functions:

```R
# Run bootstrap
boot_results <- mobster_bootstrap(best_model, n.resamples = 100)

# Plot bootstrap results
plot_bootstrap_model_selection(boot_results)
plot_bootstrap_parameters(boot_results)
```

### Evolutionary Parameters
The package allows for the estimation of evolutionary parameters such as the mutation rate and the time of subclone emergence based on the fitted Power Law.

## Tips for Success
- **Filtering**: Ensure data is filtered for high-quality variants. It is recommended to focus on mutations in diploid regions (copy-number neutral) to simplify VAF interpretation.
- **VAF Scaling**: If using non-diploid regions, VAFs should be adjusted for local copy number and purity before fitting.
- **Tail Detection**: The "neutral tail" (Power Law) typically appears at low VAFs. Ensure your sequencing depth is sufficient to capture low-frequency variants if you intend to model neutral evolution.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [NEWS.md](./references/NEWS.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)