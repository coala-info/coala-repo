---
name: bioconductor-nparc
description: This tool performs non-parametric analysis of response curves to detect significant thermal shifts in thermal proteome profiling data. Use when user asks to fit sigmoid melting curves to protein abundance data, perform F-tests with empirical degrees of freedom, or identify drug-target binding through stability changes.
homepage: https://bioconductor.org/packages/release/bioc/html/NPARC.html
---


# bioconductor-nparc

name: bioconductor-nparc
description: Non-parametric analysis of response curves (NPARC) for thermal proteome profiling (TPP) data. Use this skill to fit sigmoid melting curves to protein abundance data, compare null and alternative models, and perform hypothesis testing to detect significant thermal shifts (e.g., drug-target binding).

## Overview
NPARC is designed to analyze TPP data by fitting non-linear models to melting curves. It addresses the challenge of correlated measurements across temperatures by using a non-parametric approach to estimate degrees of freedom for F-statistics. The package helps identify proteins that show significant stability changes between experimental conditions (e.g., vehicle vs. treatment).

## Typical Workflow

### 1. Data Preparation
Data should be in a "tidy" format with columns for protein ID, temperature, relative abundance, and experimental group (e.g., compound concentration).

```r
library(NPARC)
library(dplyr)

# Load example data
data("stauro_TPP_data_tidy")
df <- stauro_TPP_data_tidy %>%
  filter(uniquePeptideMatches >= 1, !is.na(relAbundance))
```

### 2. Model Fitting
The package provides `NPARCfit` to fit both null models (one curve for all data) and alternative models (separate curves for each group) across all proteins.

```r
# Fit models
# groupsNull = NULL fits one curve to all data
# groupsAlt = df$compoundConcentration fits separate curves per concentration
fits <- NPARCfit(x = df$temperature, 
                 y = df$relAbundance, 
                 id = df$uniqueID, 
                 groupsNull = NULL, 
                 groupsAlt = df$compoundConcentration,
                 returnModels = FALSE)

# Access results
metrics <- fits$metrics
predictions <- fits$predictions
```

### 3. Hypothesis Testing
Use `NPARCtest` to compute F-statistics and p-values. It is highly recommended to use `dfType = "empirical"` to estimate degrees of freedom from the data distribution rather than using theoretical values, which are often anti-conservative for TPP data.

```r
# Perform F-test with empirical degrees of freedom
fStats <- NPARCtest(metrics, dfType = "empirical")

# Identify significant hits (e.g., adjusted p-value < 0.01)
topHits <- fStats %>%
  filter(pAdj <= 0.01) %>%
  arrange(desc(fStat))
```

### 4. Single Protein Analysis
For detailed inspection of a specific protein, use the internal fitting function (accessible via `:::`) or filter the global results.

```r
# Fit a single sigmoid for one protein
# Note: fitSingleSigmoid is not exported, use NPARC:::fitSingleSigmoid
stk4 <- filter(df, uniqueID == "STK4_IPI00011488")
nullFit <- NPARC:::fitSingleSigmoid(x = stk4$temperature, y = stk4$relAbundance)
```

## Key Functions
- `NPARCfit()`: High-level function to fit sigmoid models to multiple proteins in parallel.
- `NPARCtest()`: Computes F-statistics and performs hypothesis testing using theoretical or empirical degrees of freedom.
- `runNPARC()`: Wrapper function that executes the entire pipeline (fitting and testing) in one call.

## Tips for Success
- **Full Curves**: Ensure proteins have measurements at all temperature points before fitting to improve model stability.
- **Parallelization**: `NPARCfit` supports `BiocParallel`. Use `BPPARAM = BiocParallel::MulticoreParam()` on Linux/Mac to speed up processing for large datasets.
- **Model Convergence**: Check the `conv` column in the metrics output; `FALSE` indicates the non-linear least squares (NLS) model failed to converge for that protein.
- **Degrees of Freedom**: Always visualize the p-value histogram. If the distribution is not flat (with a peak at 0), the empirical degree of freedom estimation is likely necessary.

## Reference documentation
- [Analysing thermal proteome profiling data with the NPARC package](./references/NPARC.md)