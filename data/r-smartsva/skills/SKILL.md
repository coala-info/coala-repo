---
name: r-smartsva
description: This tool performs fast and robust Surrogate Variable Analysis to identify and estimate unknown sources of variation in high-dimensional genomic or transcriptomic datasets. Use when user asks to estimate surrogate variables, account for batch effects in large-scale data, or perform efficient SVA for differential expression analysis.
homepage: https://cran.r-project.org/web/packages/smartsva/index.html
---

# r-smartsva

name: r-smartsva
description: Fast and robust Surrogate Variable Analysis (SVA) for high-dimensional data. Use this skill to identify and estimate surrogate variables for unknown sources of variation (batch effects) in large-scale genomic or transcriptomic datasets. It is specifically optimized for speed compared to the standard sva package.

## Overview
The `smartsva` package provides an efficient implementation of the Surrogate Variable Analysis (SVA) algorithm. It is designed to capture variation from unknown sources in high-dimensional datasets while being significantly faster than the traditional Iteratively Reweighted Surrogate Variable Analysis (IRW-SVA) found in the `sva` package, without sacrificing accuracy.

## Installation
Install the package from CRAN:
```R
install.packages("smartsva")
```

## Core Workflow
The primary function is `smartsva.cpp()`. The workflow typically involves:
1. Defining the full model (including the variable of interest) and the null model.
2. Estimating the number of surrogate variables (SVs).
3. Running `smartsva.cpp()` to obtain the SVs.
4. Including the SVs as covariates in downstream differential expression analysis.

### Main Function: smartsva.cpp
```R
smartsva.cpp(dat, mod, mod0, n.sv, B = 100, alpha = 0.25, epsilon = 1e-03, verbose = FALSE)
```
- `dat`: A matrix where rows are features (e.g., genes) and columns are samples.
- `mod`: Full model matrix.
- `mod0`: Null model matrix.
- `n.sv`: Number of surrogate variables to estimate.
- `B`: Maximum number of iterations.
- `alpha`: Momentum parameter (default 0.25).

## Usage Example
```R
library(smartsva)
library(sva)

# 1. Prepare data (example using random data)
n <- 50; m <- 1000
edata <- matrix(rnorm(m * n), nrow = m)
pheno <- data.frame(group = as.factor(rep(c(0, 1), each = n/2)))

# 2. Create model matrices
mod <- model.matrix(~group, data = pheno)
mod0 <- model.matrix(~1, data = pheno)

# 3. Estimate number of SVs (using isva or sva methods)
# n.sv <- isva::EstDimRMT(edata, conf.level = 0.95)$number
n.sv <- 5 

# 4. Run SmartSVA
sv_obj <- smartsva.cpp(dat = edata, mod = mod, mod0 = mod0, n.sv = n.sv)

# 5. Use SVs in downstream analysis
mod_with_sv <- cbind(mod, sv_obj$sv)
# fit <- lmFit(edata, mod_with_sv) # e.g., with limma
```

## Tips for Efficiency
- **Dimensionality**: `smartsva` is particularly beneficial for datasets with a large number of samples or features where `sva::irwsva.build` becomes computationally expensive.
- **Convergence**: The `alpha` parameter controls the update speed. If convergence is slow, check the `epsilon` and `B` parameters.
- **Pre-filtering**: While `smartsva` is fast, removing features with zero variance or extremely low expression before running SVA is still recommended.

## Reference documentation
- [SmartSVA Home Page](./references/home_page.md)