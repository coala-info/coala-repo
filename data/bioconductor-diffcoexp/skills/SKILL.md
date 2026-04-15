---
name: bioconductor-diffcoexp
description: This tool identifies differentially coexpressed links and genes from gene expression data under two conditions. Use when user asks to identify gene pairs with significantly different correlation coefficients or find genes with more differential coexpression than expected by chance.
homepage: https://bioconductor.org/packages/release/bioc/html/diffcoexp.html
---

# bioconductor-diffcoexp

name: bioconductor-diffcoexp
description: Identify differentially coexpressed links (DCLs) and genes (DCGs) from gene expression data under two conditions. Use this skill when analyzing transcriptomic data to find gene pairs with significantly different correlation coefficients (Fisher’s Z-transformation) or genes with more differential coexpression than expected by chance.

# bioconductor-diffcoexp

## Overview

The `diffcoexp` package is designed to move beyond simple differential expression analysis by identifying changes in gene-gene coexpression patterns between two experimental conditions. It identifies:
1.  **Differentially Coexpressed Links (DCLs)**: Gene pairs whose correlation coefficients change significantly between conditions.
2.  **Differentially Coexpressed Genes (DCGs)**: Genes that possess a significantly higher number of DCLs than would be expected by chance, identified using a binomial probability model.

## Typical Workflow

### 1. Data Preparation
Input data should be two normalized expression matrices or data frames (`exprs.1` and `exprs.2`).
- Rows must represent genes; columns must represent samples.
- Both objects must have the same genes in the same order.
- Supports `SummarizedExperiment`, `matrix`, or `data.frame` objects.

### 2. Running the Analysis
The primary function is `diffcoexp`. It is recommended to enable multi-threading via `WGCNA` if working with large datasets.

```r
library(diffcoexp)
library(WGCNA)

# Enable multi-threading
allowWGCNAThreads()

# Run differential coexpression analysis
# r.method: "pearson" (default) or "spearman"
# q.method: "BH" (default) or other p.adjust methods
res <- diffcoexp(exprs.1 = data_cond1, 
                 exprs.2 = data_cond2, 
                 r.method = "spearman", 
                 q.method = "BH")
```

### 3. Interpreting Results
The output is a list containing two data frames: `DCLs` and `DCGs`.

#### Differentially Coexpressed Genes (DCGs)
Access via `res$DCGs`. Key columns:
- `Gene`: Gene identifier.
- `CLs`: Number of coexpressed links in at least one condition.
- `DCLs`: Number of differentially coexpressed links.
- `p` and `q`: Significance values for the gene being a DCG.

#### Differentially Coexpressed Links (DCLs)
Access via `res$DCLs`. Key columns:
- `cor.1` / `cor.2`: Correlation coefficients in each condition.
- `cor.diff`: Difference between correlations.
- `p.diffcor` / `q.diffcor`: Significance of the change in correlation.
- `type`: Classification of the change:
    - `same signed`: Same correlation sign in both, but magnitude changed.
    - `diff signed`: Opposite signs, but only one meets significance thresholds.
    - `switched opposites`: Opposite signs, and both are significant in their respective conditions.

## Filtering Thresholds
You can adjust the stringency of the analysis using these parameters in `diffcoexp()`:
- `rth`: Threshold for absolute correlation coefficient (default 0.5).
- `qth`: Threshold for adjusted p-value of correlation (default 0.1).
- `r.diffth`: Threshold for absolute difference in correlation (default 0.5).
- `q.diffth`: Threshold for adjusted p-value of the difference (default 0.1).
- `q.dcgth`: Threshold for adjusted p-value of DCGs (default 0.1).

## Downstream Analysis
- **DCGs**: Can be used for Gene Ontology (GO) or pathway enrichment analysis using `clusterProfiler` or `enrichr`.
- **DCLs**: Can be converted into a network object for visualization using `igraph`.

## Reference documentation
- [diffcoexp](./references/diffcoexp.md)