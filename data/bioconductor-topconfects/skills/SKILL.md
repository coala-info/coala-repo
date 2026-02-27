---
name: bioconductor-topconfects
description: This tool performs differential expression analysis to rank genes by their confident effect sizes rather than p-values. Use when user asks to rank genes by fold change at a specific False Discovery Rate, find genes with the largest confident effect sizes, or integrate confident effect size calculations with limma, edgeR, and DESeq2.
homepage: https://bioconductor.org/packages/release/bioc/html/topconfects.html
---


# bioconductor-topconfects

name: bioconductor-topconfects
description: Perform differential expression analysis using the topconfects R package to find genes with the largest confident effect sizes (confect values). Use this skill when you need to rank genes by fold change while maintaining a specific False Discovery Rate (FDR), providing a more stable alternative to ranking by p-values. It supports integration with limma, edgeR, and DESeq2.

# bioconductor-topconfects

## Overview
The `topconfects` package provides a method for ranking genes in differential expression studies based on **confident effect sizes** (confect values) rather than p-values. While p-values indicate evidence against a null hypothesis, they are often poor proxies for the magnitude of change. `topconfects` calculates the largest fold change that can be confidently asserted for each gene at a given FDR, effectively providing a lower bound on the absolute effect size.

## Core Workflow

### 1. Integration with limma
This is the fastest method and is recommended for most users. It builds upon `limma::voom` or `limma::lmFit` objects.

```r
library(topconfects)
library(limma)

# Standard limma workflow
design <- model.matrix(~Condition, data=metadata)
fit <- voom(counts, design) %>% lmFit(design)

# Apply topconfects
# coef: the column name or index to test
confects <- limma_confects(fit, coef="ConditionTreatment", fdr=0.05)

# View top results
confects
```
*Note: If not using precision weights (voom), use `limma_confects(..., trend=TRUE)` if a mean-variance trend is present.*

### 2. Integration with edgeR
Supports quasi-likelihood (QL) objects.

```r
library(edgeR)
y <- DGEList(counts)
y <- estimateDisp(y, design)
efit <- glmQLFit(y, design)

# step: resolution of the search (default 0.01 is usually best)
econfects <- edger_confects(efit, coef=2, fdr=0.05)
```

### 3. Integration with DESeq2
Uses the `DESeqDataSet` after running `DESeq()`.

```r
library(DESeq2)
dds <- DESeq(dds)

# name: the name of the coefficient to test
dconfects <- deseq2_confects(dds, name="Condition_Treatment_vs_Control")
```

### 4. Generic Effect Sizes
If you have effect sizes and standard errors from another source, use `normal_confects`.

```r
# df: degrees of freedom
n_confects <- normal_confects(estimates, se, df=df, fdr=0.05)
```

## Visualization
`topconfects` provides specialized plotting functions to interpret the "confect" values.

- **`confects_plot(confects)`**: Shows the estimated effect size (dot) and the confident lower bound (line) for the top genes.
- **`confects_plot_me2(confects)`**: A Mean-Difference (MA) plot where points are colored by their confident effect size thresholds. This is the recommended global overview plot.
- **`rank_rank_plot(list1, list2)`**: Compares the ranking of genes between two different methods (e.g., topconfects vs. standard p-value ranking).

## Key Tips
- **The "confect" value**: This is the inner bound of a one-sided confidence interval. If a gene has a confect of 2.0, you can be confident (at the specified FDR) that its absolute log2 fold change is at least 2.0.
- **Ranking**: Genes are ranked by the `confect` column in descending order. Genes that do not meet the significance threshold at the given FDR will have `NA` as their confect value.
- **Step Parameter**: In `edger_confects` and `deseq2_confects`, the `step` argument determines the granularity of the fold-change thresholds tested. A smaller step (e.g., 0.01) is more precise but slower.

## Reference documentation
- [An overview of topconfects](./references/an_overview.md)
- [Confident fold change](./references/fold_change.md)