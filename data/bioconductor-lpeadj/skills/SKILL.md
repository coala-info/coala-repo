---
name: bioconductor-lpeadj
description: This tool performs differential expression analysis on microarray data using an adjusted Local Pooled Error method for small sample sizes. Use when user asks to perform differential expression analysis, apply empirical variance adjustments to microarray data, or improve p-value distributions for experiments with limited replicates.
homepage: https://bioconductor.org/packages/3.6/bioc/html/LPEadj.html
---


# bioconductor-lpeadj

name: bioconductor-lpeadj
description: Statistical analysis of microarray data using the LPEadj package, an adjustment to the Local Pooled Error (LPE) method. Use this skill to perform differential expression analysis when sample sizes are small (typically 3-10 replicates), requiring empirical variance adjustments and improved p-value distributions compared to the standard LPE test.

## Overview

LPEadj improves the standard Local Pooled Error (LPE) method by addressing two specific limitations:
1. It replaces the asymptotic $\pi/2$ variance adjustment with empirical values ($c_i$) based on specific sample sizes (up to 10 replicates), which corrects for the difference in variability between medians and means in small samples.
2. It provides an option to disable the practice of setting all low variances to the maximum observed variance (`doMax=FALSE`), which prevents over-estimation of error in certain distributions.

The result is a more uniform p-value distribution and a more accurate False Positive Rate (FPR) compared to the original LPE method.

## Core Workflow

The most efficient way to use the package is through the high-level `lpeAdj` wrapper function.

### 1. Basic Differential Expression
To run the adjusted LPE test on a normalized intensity matrix:

```R
library(LPEadj)

# dat: matrix of normalized intensities (rows=genes, cols=replicates)
# labels: vector indicating groups (e.g., 0 for control, 1 for treatment)
results <- lpeAdj(dat, 
                  labels = c(0,0,0,1,1,1), 
                  doMax = FALSE, 
                  doAdj = TRUE)
```

### 2. Parameter Guidance
- `doMax`: Default is `FALSE`. Set to `TRUE` only if you specifically want to follow the original LPE behavior of capping low variances at the maximum observed variance.
- `doAdj`: Default is `TRUE`. This applies the empirical sample-size adjustment. If `FALSE`, it reverts to the $\pi/2$ adjustment.
- `labels`: A vector of group identifiers. The function automatically calculates the number of replicates per group to select the correct adjustment factor.

### 3. Low-level Control
If you need to calculate baseline error distributions separately or use custom adjustment values, use the component functions:

```R
# 1. Calculate baseline error for each group
# setMax1=FALSE corresponds to doMax=FALSE in the wrapper
var1 <- adjBaseOlig.error(dat[,1:3], setMax1=FALSE, q=0.05)
var2 <- adjBaseOlig.error(dat[,4:6], setMax1=FALSE, q=0.05)

# 2. Define or use empirical adjustment values (indices 1-10 correspond to n replicates)
ADJ.VALUES <- c(1, 1, 1.345859, 1.193632, 1.436849, 1.289652, 1.476581, 1.343830, 1.499721, 1.383541)

# 3. Calculate the adjusted LPE z-statistics
final_results <- calculateLpeAdj(dat[,1:3], 
                                 dat[,4:6], 
                                 var1, 
                                 var2, 
                                 probe.set.name = rownames(dat), 
                                 adjust1 = ADJ.VALUES[3], 
                                 adjust2 = ADJ.VALUES[3])
```

## Interpreting Results

The output is typically a data frame containing:
- Median intensities for each group.
- The pooled variance.
- The z-statistic.
- The p-value (derived from the standard normal distribution).

Because LPEadj corrects the p-value skew seen in standard LPE, you should expect a more uniform distribution of p-values under the null hypothesis, making FDR corrections (like Benjamini-Hochberg) more reliable.

## Reference documentation
- [LPEadj](./references/LPEadj.md)