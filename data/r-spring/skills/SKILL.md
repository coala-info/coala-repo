---
name: r-spring
description: The r-spring tool estimates sparse microbial association networks from quantitative or compositional microbiome data using a semi-parametric rank-based approach. Use when user asks to infer graphical models, estimate latent correlations, or perform rank-based network analysis on microbiome datasets.
homepage: https://cran.r-project.org/web/packages/spring/index.html
---


# r-spring

name: r-spring
description: Use when Claude needs to estimate sparse microbial association networks from quantitative microbiome data using the SPRING (Semi-Parametric Rank-based approach for INference in Graphical model) R package. This skill is ideal for rank-based correlation and partial correlation estimation, particularly for handling the compositional and zero-inflated nature of microbiome datasets.

# r-spring

## Overview
The `SPRING` package implements a semi-parametric rank-based approach for inferring graphical models from microbiome data. It is designed to handle quantitative microbiome data (like QMP - Quantitative Microbiome Profiling) by using latent correlations and sparse graphical modeling (specifically the Meinshausen-Bühlmann "mb" neighborhood selection) to estimate association networks.

## Installation
To install the package from GitHub:
```R
# install.packages("devtools")
devtools::install_github("GraceYoon/SPRING")
```

## Core Workflow
The primary function is `SPRING()`, which integrates data transformation, correlation estimation, and model selection.

### Basic Usage
```R
library(SPRING)
data("QMP") # Example dataset provided in the package

# Run SPRING estimation
fit.spring <- SPRING(QMP, 
                     Rmethod = "approx", 
                     quantitative = TRUE,
                     lambdaseq = "data-specific", 
                     nlambda = 50, 
                     rep.num = 50)
```

### Key Parameters
- `Rmethod`: Use `"approx"` for significantly faster computation (latent correlation) or `"original"` for the standard method.
- `quantitative`: Set to `TRUE` if the input data is quantitative (e.g., absolute abundances/QMP). Set to `FALSE` for compositional data (relative abundances).
- `lambdaseq`: Method for generating the lambda sequence; `"data-specific"` is recommended.
- `nlambda`: Number of lambda values for the penalty path.
- `rep.num`: Number of subsampling iterations for StARS (Stability Approach to Regularization Selection).

## Extracting Results
After fitting the model, you can extract the optimal network based on StARS selection.

```R
# 1. Get the optimal lambda index
opt.K <- fit.spring$output$stars$opt.index

# 2. Extract the Adjacency Matrix (1 = edge, 0 = no edge)
adj.matrix <- as.matrix(fit.spring$fit$est$path[[opt.K]])

# 3. Extract Partial Correlation Coefficients
# Uses SpiecEasi::symBeta to symmetrize the MB neighborhood selection results
pcor.matrix <- as.matrix(SpiecEasi::symBeta(fit.spring$output$est$beta[[opt.K]], mode = 'maxabs'))
```

## Tips for Success
- **Performance**: The `"approx"` method is roughly 10x faster than `"original"` with minimal loss in accuracy. Use it for larger OTU tables.
- **Data Type**: Ensure `quantitative = TRUE` only if your data has been adjusted for total microbial load (e.g., via flow cytometry or qPCR). For standard 16S relative abundance data, use `quantitative = FALSE`.
- **Dependencies**: `SPRING` relies on `SpiecEasi` for certain matrix operations and stability selection logic.

## Reference documentation
- [README.Rmd](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)