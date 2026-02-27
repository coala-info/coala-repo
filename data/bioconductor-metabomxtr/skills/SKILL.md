---
name: bioconductor-metabomxtr
description: This tool performs mixture model analysis and normalization for non-targeted metabolomics data with missing values. Use when user asks to analyze metabolite data using Bernoulli/lognormal mixture models, perform batch normalization using control samples, or conduct likelihood ratio tests for metabolite significance.
homepage: https://bioconductor.org/packages/release/bioc/html/metabomxtr.html
---


# bioconductor-metabomxtr

name: bioconductor-metabomxtr
description: Mixture model analysis and normalization for non-targeted metabolomics data. Use when analyzing metabolite data with missing values (NAs) using Bernoulli/lognormal mixture models, or when performing batch normalization using control samples.

# bioconductor-metabomxtr

## Overview

The `metabomxtr` package provides tools for metabolite-by-metabolite analysis using Bernoulli/lognormal mixture models. This approach is specifically designed for non-targeted metabolomics data where missing values (NAs) are common. It simultaneously models the probability of a metabolite being present (discrete portion) and the mean abundance of observed values (continuous portion). The package also includes a mixture model-based normalization method (`mixnorm`) to account for batch effects and technical variability using control samples.

## Mixture Model Analysis Workflow

Use this workflow to determine if phenotype or other covariates significantly affect metabolite levels while accounting for missing data.

### 1. Prepare Data
Data can be a `data.frame`, `matrix`, or `ExpressionSet`. Ensure metabolites are in columns (for data frames) or rows (for ExpressionSet `exprs`).

```r
library(metabomxtr)
data(metabdata)

# Define metabolites of interest
yvars <- c("malonic.acid", "ribose", "phenylalanine", "pyruvic.acid")

# Set reference levels for categorical predictors
metabdata$PHENO <- relevel(metabdata$PHENO, ref="MomLowFPG")
```

### 2. Specify and Run Models
Models use the formula syntax `~ discrete_covariates | continuous_covariates`.

```r
# Full model: PHENO affects both presence/absence and mean abundance
fullModel <- ~ PHENO | PHENO + age_ogtt_mc + storageTimesYears_mc

# Reduced model: Remove PHENO to test its significance
reducedModel <- ~ 1 | age_ogtt_mc + storageTimesYears_mc

# Run models
fullResults <- mxtrmod(ynames=yvars, mxtrModel=fullModel, data=metabdata)
redResults <- mxtrmod(ynames=yvars, mxtrModel=reducedModel, data=metabdata, fullModel=fullModel)
```

### 3. Likelihood Ratio Testing
Compare models to calculate p-values.

```r
# Perform LRT with Benjamini-Hochberg adjustment
finalResult <- mxtrmodLRT(fullmod=fullResults, redmod=redResults, adj="BH")
```

## Normalization Workflow

Use `mixnorm` to remove technical artifacts (batch, run-order) based on quality control (QC) pool samples.

### 1. Execute Normalization
Requires experimental data and a separate QC/control dataset.

```r
# batchTvals: batch-specific thresholds of detectability (optional)
# qc.sd.outliers: SD threshold for excluding QC outliers (default is 2)
normOut <- mixnorm(ynames = c('pyruvic_acid', 'malonic_acid'), 
                   batch = "batch", 
                   mxtrModel = ~ pheno + batch | pheno + batch,
                   cData = euMetabCData, 
                   data = euMetabData, 
                   qc.sd.outliers = 2)

# Access normalized experimental data
normalized_data <- normOut$obsNorm
```

### 2. Visualize Results
Assess normalization performance by comparing raw and normalized distributions.

```r
metabplot(metabolite = "malonic_acid", 
          batch = "batch", 
          raw.obs.data = euMetabData, 
          raw.cont.data = euMetabCData,
          norm.obs.data = normOut$obsNorm, 
          norm.cont.data = normOut$ctlNorm,
          color.var = "pheno")
```

## Key Functions and Parameters

- `mxtrmod()`: Fits the mixture model.
    - `ynames`: Character vector of metabolite names.
    - `mxtrModel`: Formula `~ discrete | continuous`.
- `mixnorm()`: Performs normalization.
    - `removeCorrection`: Use this to include a covariate in the model (to estimate batch effects accurately) but NOT remove its effect from the final normalized data (e.g., `removeCorrection="pheno"`).
- `mxtrmodLRT()`: Compares two `mxtrmod` objects.
- `metabplot()`: Generates diagnostic plots showing batch-specific means and outliers.

## Tips for Success

- **Convergence**: Check the `conv` column in results. A value of `0` indicates successful convergence.
- **Missing Batch Data**: If a batch is entirely missing data for a metabolite, `mixnorm` will return `NA` for that batch effect and set experimental values for that batch to `Inf`.
- **Formula Consistency**: When running reduced models, always pass the `fullModel` object to the `fullModel` parameter in `mxtrmod()` to ensure both models use the same set of observations.
- **Outliers**: Use `qc.sd.outliers` in `mixnorm` to prevent extreme QC samples from skewing batch effect estimates.

## Reference documentation
- [An Introduction to the metabomxtr package](./references/Metabomxtr_Vignette.md)
- [An Introduction Mixture Model Normalization with the metabomxtr Package](./references/mixnorm_Vignette.md)