---
name: bioconductor-factdesign
description: This tool analyzes factorial designed microarray experiments using linear models to identify genes affected by experimental factors and their interactions. Use when user asks to detect outliers in small factorial designs, fit linear models to microarray data, identify interaction effects between factors, or perform contrast tests for complex experimental conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/factDesign.html
---


# bioconductor-factdesign

name: bioconductor-factdesign
description: Analysis of factorial designed microarray experiments using linear models. Use this skill to identify genes affected by specific experimental factors (e.g., treatment, time) and their interactions, perform outlier detection in small factorial designs, and execute contrast tests to calculate fold changes and statistical significance for complex experimental conditions.

# bioconductor-factdesign

## Overview

The `factDesign` package provides tools for the analysis of factorial designed microarray experiments. It leverages linear modeling to disentangle effects from multiple factors (e.g., a 2x2 design with "Treatment" and "Time"). Unlike simple fold-change methods, `factDesign` accounts for variability between replicates and allows for the testing of specific biological hypotheses through linear contrasts. It is particularly useful for identifying interaction effects where the impact of one factor depends on the level of another.

## Core Workflow

### 1. Data Preparation and Outlier Detection
Before modeling, identify potential outliers in small factorial designs based on replicate differences.

```r
library(factDesign)
data(estrogen) # Example ExpressionSet

# Identify outlier pairs for a specific probe
# INDEX should be the phenoData or a factor representing experimental conditions
op <- outlierPair(exprs(estrogen)["33379_at", ], INDEX = pData(estrogen), p = 0.05)

# Check if an outlier was found and which pair
op$test      # TRUE if outlier detected
op$whichPair # Indices of the replicate pair

# Filter using Median Absolute Deviation to identify the single outlier index
so <- madOutPair(exprs(estrogen)["33379_at", ], op$whichPair)
# If !is.na(so), that specific observation can be set to NA
```

### 2. Defining and Fitting Linear Models
Fit models to every gene in an `ExpressionSet` using `esApply`.

```r
# Define functions for full and reduced models
# Full: includes factors and interaction
lm.full <- function(y) lm(y ~ ES + TIME + ES:TIME)
# Reduced: e.g., only time effect
lm.time <- function(y) lm(y ~ TIME)

# Apply to ExpressionSet
lm.f <- esApply(estrogen, 1, lm.full)
lm.t <- esApply(estrogen, 1, lm.time)
```

### 3. Selecting Genes via ANOVA
Compare models to find genes affected by the factor of interest (e.g., Estrogen).

```r
# Calculate F-test p-values comparing full vs reduced
Fpvals <- sapply(1:length(lm.f), function(i) anova(lm.t[[i]], lm.f[[i]])$P[2])

# Adjust for multiple comparisons (using multtest package)
library(multtest)
F.res <- mt.rawp2adjp(Fpvals, "BH")
F.adjps <- F.res$adjp[order(F.res$index), ]
Fsub <- which(F.adjps[, "BH"] < 0.15)

# Subset the data
estrogen.Fsub <- estrogen[Fsub]
lm.f.Fsub <- lm.f[Fsub]
```

### 4. Contrast Testing
Use contrasts to test specific hypotheses, such as the effect of a treatment at a specific time point.

```r
# Get coefficient names from the model
betaNames <- names(coef(lm.f[[1]]))

# Create a lambda matrix for a contrast (e.g., Main Estrogen Effect)
# par2lambda(names, coefficients_to_include, weights)
lambda <- par2lambda(betaNames, c("ESP"), c(1))

# Test the contrast
mainES <- function(x) contrastTest(x, lambda, p = 0.05)[[1]]
results <- sapply(lm.f.Fsub, mainES) # Returns "REJECT" or "FAIL TO REJECT"

# Complex Contrast: Estrogen effect at 48h (Main effect + Interaction)
# H0: beta_ES + beta_ES:TIME = 0
lambdaEST <- par2lambda(betaNames, list(c("ESP", "ESP:TIME48h")), list(c(1, 1)))
ESTresults <- sapply(lm.f.Fsub, function(x) contrastTest(x, lambdaEST, p = 0.10)[[1]])
```

### 5. Calculating Fold Change from Models
Calculate biologically relevant fold changes for specific contrasts.

```r
# Define Numerator (Intercept + Estrogen) and Denominator (Intercept)
lNum <- par2lambda(betaNames, list(c("(Intercept)", "ESP")), list(c(1, 1)))
lDenom <- par2lambda(betaNames, list(c("(Intercept)")), list(c(1)))

# Find Fold Change for a specific gene
fc <- findFC(lm.f.Fsub[[1]], lNum, lDenom, logbase = 2)
```

## Tips for Success
- **Log Scale**: Ensure expression data is in log base 2 scale (standard for `rma` output) before fitting linear models.
- **Interaction Terms**: Always include the interaction term (`FactorA:FactorB`) if you suspect the response to one factor changes depending on the other.
- **Visualization**: Use `heatmap()` on the `exprs()` of subsetted `ExpressionSet` objects to visualize the patterns of genes that rejected specific null hypotheses.
- **Filtering**: Combine statistical significance (p-values from `contrastTest`) with biological significance (thresholds from `findFC`) to reduce false positives.

## Reference documentation
- [factDesign](./references/factDesign.md)