---
name: bioconductor-metavolcanor
description: MetaVolcanoR performs meta-analysis of differential gene expression results from multiple independent transcriptomic studies using random effects models, vote-counting, or p-value combining methods. Use when user asks to synthesize results from multiple RNA-seq or microarray datasets, identify consistently perturbed genes across studies, or generate MetaVolcano and forest plots.
homepage: https://bioconductor.org/packages/3.10/bioc/html/MetaVolcanoR.html
---


# bioconductor-metavolcanor

name: bioconductor-metavolcanor
description: Meta-analysis of differential gene expression results using Random Effects Models (REM), vote-counting, and p-value combining approaches. Use this skill when you need to synthesize results from multiple independent transcriptomic studies (RNA-seq or Microarray) to identify consistently perturbed genes and visualize them using MetaVolcano plots or forest plots.

# bioconductor-metavolcanor

## Overview

MetaVolcanoR is an R package designed to combine differential gene expression (DGE) results from independent studies. It addresses the low signal-to-noise ratio often found in individual studies by identifying genes that show consistent expression changes across multiple datasets. It provides three distinct meta-analysis strategies and specialized "MetaVolcano" visualizations to highlight robust biological signals.

## Input Data Requirements

The package requires a **named list** of data frames. Each data frame represents one study and must contain:
- **Gene Names**: A column with gene symbols or IDs.
- **Fold Change**: Log2 fold change values.
- **P-values**: Significance values for the differential expression.
- **Variance/CI (Recommended)**: Confidence intervals (lower and upper limits) or variance are required for the Random Effects Model (REM) approach.

```r
# Example structure
data(diffexplist)
# diffexplist is a list of 5 data frames
# Each has: Symbol, Log2FC, pvalue, CI.L, CI.R
```

## Meta-Analysis Workflows

### 1. Random Effects Model (REM)
The most robust approach, summarizing fold changes while accounting for within-study and between-study variance.

```r
meta_degs_rem <- rem_mv(diffexp = diffexplist,
                        pcriteria = "pvalue",
                        foldchangecol = 'Log2FC',
                        genenamecol = 'Symbol',
                        llcol = 'CI.L', # Lower bound CI
                        rlcol = 'CI.R', # Upper bound CI
                        metathr = 0.01, # Top 1% most perturbed
                        draw = 'HTML')

# Access results
head(meta_degs_rem@metaresult)
# View plot
meta_degs_rem@MetaVolcano
```

### 2. Vote-Counting Approach
Identifies genes based on the number of studies where they pass specific p-value and fold-change thresholds. Useful when variance information is unavailable.

```r
meta_degs_vote <- votecount_mv(diffexp = diffexplist,
                               pcriteria = 'pvalue',
                               foldchangecol = 'Log2FC',
                               genenamecol = 'Symbol',
                               pvalue = 0.05,
                               foldchange = 0,
                               metathr = 0.01)

# View frequency of DEGs across studies
meta_degs_vote@degfreq
```

### 3. Combining P-values (Fisher's Method)
Summarizes fold changes using mean or median and combines p-values using Fisher's method.

```r
meta_degs_comb <- combining_mv(diffexp = diffexplist,
                               pcriteria = 'pvalue',
                               foldchangecol = 'Log2FC',
                               genenamecol = 'Symbol',
                               metafc = 'Mean', # or 'Median'
                               metathr = 0.01)
```

## Visualizing Specific Genes

To inspect the contribution of each study to a specific gene's meta-analysis result, use the forest plot function (specifically for REM results).

```r
draw_forest(remres = meta_degs_rem,
            gene = "MMP9",
            genecol = "Symbol",
            foldchangecol = "Log2FC",
            llcol = "CI.L",
            rlcol = "CI.R")
```

## Key Parameters
- `metathr`: Sets the quantile threshold to highlight the most consistently perturbed genes (e.g., 0.01 for top 1%).
- `collaps`: Set to `TRUE` if there are duplicate gene names within a study that need to be merged.
- `jobname`: Prefix for output files if saving results to disk.

## Reference documentation
- [MetaVolcano](./references/MetaVolcano.md)
- [PrepareDatasets](./references/PrepareDatasets.md)