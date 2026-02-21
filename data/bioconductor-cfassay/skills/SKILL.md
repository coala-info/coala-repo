---
name: bioconductor-cfassay
description: The package provides functions for calculation of linear-quadratic cell survival curves and for ANOVA of experimental 2-way designs along with the colony formation assay.
homepage: https://bioconductor.org/packages/release/bioc/html/CFAssay.html
---

# bioconductor-cfassay

name: bioconductor-cfassay
description: Statistical analysis of the Colony Formation Assay (CFA). Use this skill to fit linear-quadratic (LQ) cell survival curves, perform two-way ANOVA for experimental designs (e.g., treatment vs. control), and compare survival curves between different cell lines or conditions using Maximum-Likelihood or Least-Squares methods.

## Overview

The `CFAssay` package provides specialized tools for analyzing colony formation assays, commonly used in radiation biology and oncology research. It focuses on two main statistical tasks:
1. **Linear-Quadratic (LQ) Model Fitting**: Modeling cell survival ($S$) as a function of radiation dose ($D$) using the formula $S = e^{c + \alpha D + \beta D^2}$.
2. **Two-Way ANOVA**: Analyzing experiments with two factors (e.g., a pretreatment and a drug) to identify effects and potential interactions (chemosensitization).

The package prefers Maximum-Likelihood (ML) estimation with a Poisson distribution, which is more robust for colony count data than simple linear regression on log-transformed survival fractions.

## Data Requirements

Input data frames must contain specific column names for the functions to work:
- `Exp`: Experiment identifier (replicates).
- `dose`: Radiation dose (numeric).
- `ncells`: Number of cells seeded.
- `ncolonies`: Number of colonies counted.
- `cline` (optional): Used to distinguish different cell lines or groups.

## Workflow: Cell Survival Curves

### 1. Fitting a Model
Use `cellsurvLQfit` to calculate $\alpha$ and $\beta$ parameters.

```r
library(CFAssay)
# Filter data for a single cell line
df_sub <- subset(datatab, cline == "cell_line_A")

# Fit the model (default method="ml", PEmethod="fit")
fit <- cellsurvLQfit(df_sub)

# View results
print(fit)
```

### 2. Comparing Two Curves
Use `cellsurvLQdiff` to test if two survival curves are statistically different (ANOVA F-test).

```r
# curvevar specifies the column distinguishing the two groups
comp <- cellsurvLQdiff(datatab, curvevar = "cline")
print(comp)
```

### 3. Visualization
- `plot(fit)`: Plots the mean survival curve with error bars.
- `plotExp(fit)`: Generates diagnostic plots for each individual experiment replicate.
- `sfpmean(df, S0)`: Calculates mean survival fractions and standard deviations.

## Workflow: Two-Way ANOVA

Used for experiments with a treatment factor (e.g., siRNA) and a dose factor (usually 0 or 1 level of a drug).

```r
# A and B are the names of the factor columns
# param="A/B" uses nested parametrization to show treatment effect in control vs treated
fit_2way <- cfa2way(datatab, A = "siRNA", B = "drug", param = "A/B")

# Print results with descriptive labels
print(fit_2way, labels = c(A = "siRNA", B = "Cisplatin"))
```

## Key Parameters and Tips

- **PEmethod**: 
  - `"fit"` (default): Treats plating efficiencies as random observations (intercepts). Recommended for better overall statistics.
  - `"fix"`: Normalizes data to measured plating efficiencies.
- **method**: 
  - `"ml"` (default): Generalized linear model (GLM) with Poisson link.
  - `"ls"`: Least squares (LM) on logarithmic values.
- **Dispersion Parameter**: In the `print()` output, a dispersion parameter significantly higher than 1.0 indicates overdispersion. For `PEmethod="fit"`, values > 9.0 may suggest problematic replicates that should be inspected via `plotExp`.
- **Interaction**: In `cfa2way`, the F-test indicates whether the effect of factor B depends on factor A (e.g., if a drug is more effective after siRNA knockdown).

## Reference documentation

- [CFAssay: Statistics of the Colony Formation Assay](./references/cfassay.md)