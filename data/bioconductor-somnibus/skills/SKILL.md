---
name: bioconductor-somnibus
description: SOMNiBUS identifies differentially methylated regions in targeted bisulfite sequencing data using a binomial regression framework within a generalized additive model. Use when user asks to identify differentially methylated regions, analyze targeted bisulfite sequencing data, or visualize smooth covariate effects across genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/SOMNiBUS.html
---


# bioconductor-somnibus

## Overview

SOMNiBUS is an R package designed for the regional analysis of targeted bisulfite sequencing data. It uses a binomial regression framework within a Generalized Additive Model (GAM) to identify Differentially Methylated Regions (DMRs). It is particularly effective because it borrows information across nearby CpG sites using regression splines and accounts for technical error rates (false positives/negatives) and over-dispersion.

## Data Preparation

### Input Format
The package requires a data frame where each row is a CpG site and a sample. The first four columns must be:
1. `Meth_Counts`: Number of methylated reads.
2. `Total_Counts`: Total read depth.
3. `Position`: Genomic position.
4. `ID`: Sample identifier.
5. `Covariates`: Columns 5+ should contain numeric phenotypes or traits (e.g., disease status, age).

### Formatting from Other Tools
If your data is in `BSseq`, `Bismark`, or `BSmooth` formats, use the following converters:
- `formatFromBSseq(bsseq_dat)`: Converts a BSseq object.
- `formatFromBismark(...)`: Wrapper for `bsseq::read.bismark`.
- `formatFromBSmooth(...)`: Wrapper for `bsseq::read.bsmooth`.

### Filtering
Filter out observations with zero total reads and samples with missing covariate data:
```r
data.filtered <- na.omit(data[data$Total_Counts != 0, ])
```

## Analysis Workflows

### Single Region Analysis
Use `binomRegMethModel` for a predefined genomic region.
```r
out <- binomRegMethModel(
  data = data.filtered, 
  n.k = rep(5, 3),    # Basis dimensions (approx unique CpGs / 20)
  p0 = 0.003,         # False positive rate (default)
  p1 = 0.9,           # True positive rate (default)
  Quasi = FALSE,      # Set TRUE for quasi-likelihood adjustment
  RanEff = FALSE      # Set TRUE for sample-specific random effects
)
```

### Multi-Region Analysis (Genome-wide/Large Scale)
Use `runSOMNiBUS` to automatically partition data into regions and analyze them.
```r
outs <- runSOMNiBUS(
  dat = data.filtered,
  split = list(approach = "region", gap = 100), # Options: region, density, gene, chromatin, bed, granges
  min.cpgs = 10,
  max.cpgs = 2000
)
```

## Interpreting Results

### Statistical Significance
Access the region-wide test results (p-values for each covariate):
```r
out$reg.out
```

### Visualization
Plot the smooth covariate effects (estimated methylation patterns across the region):
```r
# Plot all effects
binomRegMethModelPlot(BEM.obj = out)

# Plot specific covariates with same Y-axis scale
binomRegMethModelPlot(out, covs = c("RA", "T_cell"), same.range = TRUE)
```

### Prediction
Predict methylation levels for specific groups or new data:
```r
# Create new data for prediction
newdata <- expand.grid(Position = out$uni.pos, T_cell = c(0, 1), RA = c(0, 1))

# Predict proportions
pred_prop <- binomRegMethModelPred(out, newdata, type = "proportion")

# Plot predictions
binomRegMethPredPlot(pred = cbind(newdata, Prop = pred_prop), 
                     pred.type = "proportion", 
                     pred.col = "Prop")
```

## Key Parameters
- **p0 and p1**: Represent the false positive (incomplete conversion) and true positive (over-conversion) rates. Default values are 0.003 and 0.9.
- **n.k**: The basis dimension for splines. A good rule of thumb is `number of unique CpGs / 20`.
- **Covariates**: Must be numeric. Convert categorical factors to dummy variables (0/1) before analysis.

## Reference documentation
- [Analyzing Targeted Bisulfite Sequencing data with SOMNiBUS](./references/SOMNiBUS.md)
- [SOMNiBUS Rmarkdown Source](./references/SOMNiBUS.Rmd)