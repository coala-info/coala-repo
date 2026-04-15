---
name: bioconductor-gsalightning
description: GSALightning performs ultra-fast permutation-based gene set analysis using maxmean, mean, or absmean statistics. Use when user asks to conduct high-performance gene set enrichment analysis, perform permutation tests on large-scale expression datasets, or analyze gene sets using paired or unpaired experimental designs.
homepage: https://bioconductor.org/packages/release/bioc/html/GSALightning.html
---

# bioconductor-gsalightning

name: bioconductor-gsalightning
description: Perform ultra-fast permutation-based gene set analysis (GSA) using the GSALightning Bioconductor package. Use this skill to conduct high-performance gene set enrichment analysis with maxmean, mean, or absmean statistics, supporting both unpaired and paired experimental designs.

## Overview

GSALightning is a high-performance R package designed for permutation-based gene set analysis. It implements the GSA algorithm (Efron 2007) with significant speed optimizations, making it ideal for large-scale datasets with many gene sets and permutations. It supports standard statistics (mean, absolute mean, and maxmean) and provides a restandardization procedure to ensure p-values are uniformly distributed under the null hypothesis.

## Core Workflow

### 1. Data Preparation

The package requires three primary inputs:
- **Expression Matrix (`eset`)**: A matrix where rows are genes (with names) and columns are samples.
- **Sample Labels (`fac`)**: A factor vector defining the groups (unpaired) or an integer vector (paired).
- **Gene Sets (`gs`)**: A list where each element is a character vector of gene symbols, or a `data.table` with "geneSet" and "gene" columns.

```r
library(GSALightning)

# Clean data: Remove genes with zero variance
expression <- expression[apply(expression, 1, sd) != 0, ]
```

### 2. Running Gene Set Analysis

The primary function is `GSALight()`.

```r
# Basic usage
results <- GSALight(
  eset = expression, 
  fac = factor(sampleInfo$Group), 
  gs = geneSetList,
  nperm = 1000,           # Number of permutations (NULL for auto-calculation)
  method = "maxmean",     # "maxmean", "mean", or "absmean"
  restandardize = TRUE,   # Recommended for better p-value distribution
  rmGSGenes = "gene",     # Remove genes in sets not found in expression data
  minsize = 10,           # Minimum genes per set
  maxsize = 500           # Maximum genes per set
)
```

### 3. Interpreting Results

The output is a matrix. For `maxmean` or `mean` methods, it includes:
- `p-value:up-regulated in [Group]`: Directional p-values.
- `q-value:up-regulated in [Group]`: FDR-adjusted values.
- `statistics`: The calculated gene set statistic.
- `# genes`: Number of genes analyzed in that set.

For `absmean`, results are non-directional (two-sided).

## Advanced Features

### Automatic Permutation Calculation
If `nperm = NULL`, the package automatically calculates the required permutations to ensure accuracy at the 0.05 significance level:
`nperm = (number of gene sets / 0.05) * 2`

### Paired Design
For paired tests, set `tests = 'paired'` and provide `fac` as an integer vector (e.g., `c(1, -1, 2, -2)`) where the absolute value indicates the pair and the sign indicates the condition.

```r
results_paired <- GSALight(
  eset = expression, 
  fac = paired_vector, 
  gs = geneSetList, 
  tests = 'paired'
)
```

### Single Gene Testing
Use `permTestLight()` for fast single-gene permutation tests or `wilcoxTest()` for Mann-Whitney U tests.

```r
# Single gene permutation
gene_res <- permTestLight(eset = expression, fac = factor(groups), nperm = 1000)

# Wilcoxon rank-sum test
wilcox_res <- wilcoxTest(eset = expression, fac = factor(groups), tests = "unpaired")
```

## Tips for Success
- **Missing Data**: `GSALight()` will error if missing values are present. Impute or remove NAs before running.
- **Gene Naming**: Ensure the row names of your expression matrix match the identifiers used in your gene set list.
- **Restandardization**: Always consider setting `restandardize = TRUE` if your p-value histogram shows a heavy skew toward zero in the absence of expected biological signal.

## Reference documentation
- [GSALightning: Ultra-fast Permutation-based Gene Set Analysis](./references/vignette.md)
- [GSALightning: Ultra-fast Permutation-based Gene Set Analysis](./references/vignette.Rmd)