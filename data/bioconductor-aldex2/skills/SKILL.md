---
name: bioconductor-aldex2
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ALDEx2.html
---

# bioconductor-aldex2

name: bioconductor-aldex2
description: Differential abundance analysis for high-throughput sequencing data (RNA-Seq, 16S, metagenomics, SELEX) using a compositional data analysis approach. Use when Claude needs to perform differential expression or abundance testing while accounting for the compositional nature of sequencing data, technical variation via Dirichlet Monte-Carlo sampling, or scale uncertainty.

# bioconductor-aldex2

## Overview
ALDEx2 (ANOVA-Like Differential Expression) is an R package designed for the analysis of high-throughput sequencing count data. Unlike methods that rely on library size normalization, ALDEx2 treats data as compositional. It uses Dirichlet Monte-Carlo (DMC) sampling to model technical variation and Centred Log-Ratio (CLR) transformations to linearize the data. It is robust against sparsity and varying sequencing depths, providing expected values for statistical tests and effect sizes.

## Core Workflow

### 1. Data Preparation
Input data must be a data frame or matrix of non-negative integers (counts) where rows are features (genes, OTUs) and columns are samples.

```r
library(ALDEx2)
data(selex)
# Define conditions vector matching the columns of the count table
conds <- c(rep("NS", 7), rep("S", 7))
```

### 2. The All-in-One Approach
For simple two-group comparisons, use the wrapper function `aldex`.

```r
# mc.samples: 128 is recommended for production; 16 for quick checks
# test: "t" for Welch's t and Wilcoxon; "kw" for ANOVA
# effect: TRUE to calculate effect sizes (highly recommended)
result <- aldex(selex, conds, mc.samples=128, test="t", effect=TRUE, denom="all")
```

### 3. The Modular Approach
For power users or complex designs, use the modular functions to expose intermediate values.

```r
# Step 1: Generate CLR Monte-Carlo instances
# denom: "all" (default), "iqlr" (for asymmetric data), or "zero"
x <- aldex.clr(selex, conds, mc.samples=128, denom="all")

# Step 2: Perform statistical tests
x.tt <- aldex.ttest(x, paired.test=FALSE)

# Step 3: Estimate effect sizes (Difference between vs Difference within)
x.effect <- aldex.effect(x, CI=TRUE)

# Step 4: Combine results
x.all <- data.frame(x.tt, x.effect)
```

## Complex Designs (GLM)
Use `aldex.glm` for complex study designs involving multiple covariates or continuous variables.

```r
covariates <- data.frame("A" = sample(0:1, 14, replace = TRUE), "B" = c(rep(0, 7), rep(1, 7)))
mm <- model.matrix(~ A + B, covariates)

x.glm.clr <- aldex.clr(selex, mm, mc.samples=16, denom="all")
glm.test <- aldex.glm(x.glm.clr, mm)
glm.eff <- aldex.glm.effect(x.glm.clr)
```

## Scale Uncertainty
To account for scale uncertainty (e.g., when one group has a higher total biomass/mRNA load), use the `gamma` parameter or a scale matrix.

```r
# mu represents the log-ratio of the scale between groups
mu.mod <- c(rep(1, 7), rep(8, 7)) 
scale.model <- aldex.makeScaleMatrix(gamma=0.5, mu=mu.mod, conditions=conds, mc.samples=128)

x.scaled <- aldex.clr(selex, conds, gamma=scale.model)
```

## Visualization
ALDEx2 provides specialized plotting functions to interpret results.

- **Bland-Altman (MA) Plot**: `aldex.plot(result, type="MA", test="welch")` - Shows abundance vs. difference.
- **Effect Plot (MW)**: `aldex.plot(result, type="MW", test="welch")` - Shows dispersion vs. difference.
- **Volcano Plot**: `aldex.plot(result, type="volcano", test="welch")`
- **Feature Plot**: `aldex.plotFeature(x, "FeatureName")` - Visualizes the posterior distribution of a specific feature.

## Interpretation Tips
- **Effect Size**: Focus on the `effect` column. An absolute effect size > 1 is generally considered biologically relevant.
- **Overlap**: The `overlap` column indicates the proportion of the distribution overlapping 0. Low overlap suggests a robust difference.
- **P-values**: ALDEx2 returns *expected* p-values (`we.ep`, `wi.ep`) and BH-corrected values (`we.eBH`, `wi.eBH`).
- **Asymmetry**: If the data is asymmetric (one group has many more features than the other), use `denom="iqlr"` in `aldex.clr`.

## Reference documentation
- [ANOVA-Like Differential Expression tool for high throughput sequencing data](./references/ALDEx2_vignette.md)
- [ALDEx2 scaleSim Vignette](./references/scaleSim_vignette.md)