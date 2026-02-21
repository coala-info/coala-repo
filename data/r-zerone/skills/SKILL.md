---
name: r-zerone
description: R package zerone (documentation from project home).
homepage: https://cran.r-project.org/web/packages/zerone/index.html
---

# r-zerone

## Overview
The `zerone` package is designed to discretize ChIP-seq data by classifying genomic windows into two states: background (0) and enriched (1). It is unique in its ability to handle multiple replicates simultaneously, resolving conflicts between them to produce a unified discretization. It includes a built-in quality control (QC) system that provides a reliability score for the discretization.

## Installation
To install the package from source (as it is often distributed via GitHub or local source):
```R
# From the package directory
# R CMD INSTALL ZeroneRPackage

# Or via devtools if available on GitHub
# devtools::install_github("nanakiksc/zerone/ZeroneRPackage")
```

## Main Functions and Workflows

### Data Preparation
The primary input for the `zerone` function is a `data.frame`.
- **Structure**: The first three columns must be genomic coordinates (Chromosome, Start, End).
- **Control/Mock**: The fourth column should contain the summed read counts of control/mock profiles.
- **Replicates**: Subsequent columns contain read counts for each ChIP-seq replicate.
- **Example Data**: The package includes `ZeroneExampleData` to demonstrate this format.

### Basic Discretization
To perform discretization and obtain the Viterbi path (the sequence of 0s and 1s):
```R
library(zerone)
path <- zerone(ZeroneExampleData)
# Returns a vector of states (0 or 1) for each window
```

### Advanced Usage and Parameters
To retrieve model parameters, QC scores, and posterior probabilities, use `returnall = TRUE`:
```R
listinfo <- zerone(ZeroneExampleData, returnall = TRUE)

# Accessing results:
# listinfo$viterbi      # The discretized path
# listinfo$loglik       # Log-likelihood of the model
# listinfo$posteriors   # Probability of being enriched for each window
# listinfo$qc           # Quality control score and features
```

### Quality Control (QC)
The QC system evaluates the discretization:
- **QC Score > 0**: Accept discretization.
- **QC Score < 0**: Reject discretization.
- **Reliability**: Scores > 1 or < -1 are considered extremely reliable.
- **Note**: QC requires at least two replicates. If only one replicate is provided, the QC score will be `NaN`.

## Tips and Best Practices
- **Window Size**: The default window size is 300bp. Ensure your input counts are binned consistently.
- **Input Formats**: While the R function takes a `data.frame`, ensure the counts represent actual read counts per window for the Hidden Markov Model (HMM) to fit correctly.
- **Merging Results**: For downstream analysis, you can merge the Viterbi path back with your coordinate columns to create a BED-like file of enriched regions.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)