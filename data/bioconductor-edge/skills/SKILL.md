---
name: bioconductor-edge
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/edge.html
---

# bioconductor-edge

name: bioconductor-edge
description: Differential gene expression analysis using the Optimal Discovery Procedure (ODP) and Likelihood Ratio Test (LRT). Use this skill for analyzing genome-wide expression studies, specifically for static group comparisons, independent time course experiments, and longitudinal time course studies.

## Overview

The `edge` package (Extraction of Differential Gene Expression) is designed for significance analysis of genome-wide expression data. Its primary advantage is the Optimal Discovery Procedure (ODP), which improves power over traditional gene-specific tests (like t-tests or F-tests) by utilizing information across all genes. It also provides specialized frameworks for modeling time-course data using splines.

## Core Workflow

The standard analysis follows these steps:
1.  **Data Preparation**: Organize expression data into a matrix and metadata into a data frame.
2.  **Model Building**: Create a `deSet` object containing the data and the null/full hypothesis models.
3.  **Significance Testing**: Run the ODP or LRT algorithm.
4.  **Result Extraction**: Extract p-values, q-values, and local False Discovery Rates (lfdr).

### 1. Creating the deSet Object

You can initialize the analysis using either `build_study` (easier for standard designs) or `build_models` (for custom formulas).

**Using build_study**:
```r
# For time-course data
de_obj <- build_study(data = exp_matrix, adj.var = sex_vector, 
                      tme = age_vector, sampling = "timecourse", basis.df = 4)

# For static group comparisons
de_obj <- build_study(data = exp_matrix, adj.var = batch_vector, 
                      grp = group_vector, sampling = "static")
```

**Using build_models**:
```r
library(splines)
cov_df <- data.frame(sex = sex, age = age)
null_mdl <- ~sex
full_mdl <- ~sex + ns(age, df = 4)
de_obj <- build_models(data = exp_matrix, cov = cov_df, 
                       null.model = null_mdl, full.model = full_mdl)
```

### 2. Significance Testing

**Optimal Discovery Procedure (ODP)**:
Recommended for maximum power. Use `n.mods` to speed up computation via k-means clustering.
```r
de_odp <- odp(de_obj, bs.its = 50, n.mods = 50)
```

**Likelihood Ratio Test (LRT)**:
Standard parametric approach.
```r
de_lrt <- lrt(de_obj, nullDistn = "normal")
```

### 3. Extracting Results

Use `qvalueObj` to access the statistical results stored in the `deSet` object.
```r
sig_res <- qvalueObj(de_odp)
pvals <- sig_res$pvalues
qvals <- sig_res$qvalues
pi0 <- sig_res$pi0

# Identify significant genes at 5% FDR
sig_genes <- which(qvals < 0.05)
```

## Study Design Patterns

### Static Experiments
Used to compare distinct biological groups (e.g., Treatment vs. Control).
*   **Null Model**: Includes only adjustment variables (e.g., `~batch + sex`).
*   **Full Model**: Includes adjustment variables plus the group variable (e.g., `~batch + sex + group`).

### Time Course Experiments
*   **Independent**: One group sampled over time. The goal is to find genes changing over time.
    *   Full model typically uses a natural spline: `~ns(time, df = 4)`.
*   **Longitudinal**: Multiple groups sampled over time. The goal is to find genes that behave differently over time between groups.
    *   Full model includes an interaction: `~grp + ns(tme, df=2) + grp:ns(tme, df=2)`.

## Advanced Features

### Surrogate Variable Analysis (SVA)
Use `apply_sva` to identify and remove hidden batch effects or unwanted variation.
```r
de_sva <- apply_sva(de_obj, n.sv = 3)
# The surrogate variables (SV1, SV2, etc.) are automatically added to the models
de_odp <- odp(de_sva)
```

### Model Fitting
To inspect the fitted values or residuals without running the full significance test:
```r
fit_obj <- fit_models(de_obj, stat.type = "lrt")
fitted_values <- fitFull(fit_obj)
residuals <- resFull(fit_obj)
```

## Tips for Success
*   **Memory/Speed**: For large datasets, always set `n.mods` (e.g., 50) in `odp()` to avoid long computation times.
*   **Spline Degrees of Freedom**: For time-course data, `df = 2` to `df = 4` is usually sufficient.
*   **Object Compatibility**: `deSet` inherits from `ExpressionSet`. You can use `exprs(de_obj)` and `pData(de_obj)` to access data.

## Reference documentation
- [edge](./references/edge.md)