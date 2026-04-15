---
name: bioconductor-highlyreplicatedrnaseq
description: This package provides access to a highly replicated bulk RNA-seq dataset from Saccharomyces cerevisiae for benchmarking differential expression analysis. Use when user asks to load the Schurch 2016 dataset, access high-replicate yeast RNA-seq counts, or benchmark the effect of biological replicates on statistical power.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HighlyReplicatedRNASeq.html
---

# bioconductor-highlyreplicatedrnaseq

## Overview

The `HighlyReplicatedRNASeq` package provides access to a unique bulk RNA-seq dataset from Schurch et al. (2016) featuring 86 samples of *Saccharomyces cerevisiae* (48 wild-type and 38 SNF2 knockout replicates). This dataset is a benchmark for determining how many biological replicates are needed for reliable differential expression analysis.

## Loading Data

The primary way to access the data is via the `Schurch16()` function, which returns a `SummarizedExperiment` object.

```r
library(HighlyReplicatedRNASeq)

# Load the Schurch 2016 dataset
schurch_se <- Schurch16()

# Inspect the object
schurch_se
# dim: 7126 genes, 86 samples
# colData contains: condition (wildtype/knockout), replicate, name
```

Alternatively, you can load the raw count matrix directly from `ExperimentHub`:

```r
library(ExperimentHub)
eh <- ExperimentHub()
count_matrix <- eh[["EH3315"]]
```

## Typical Workflow

### 1. Data Normalization
Because the dataset contains raw counts, you must account for sequencing depth. A common quick normalization involves dividing by column means and log-transforming.

```r
# Extract counts
counts <- assay(schurch_se, "counts")

# Normalize by library size and log transform (with pseudocount)
norm_counts <- log(counts / colMeans(counts) + 0.001)
```

### 2. Exploratory Analysis
With 86 samples, you can visualize the distribution of counts or check for batch effects.

```r
# Check distribution
hist(norm_counts, breaks = 100, main = "Log-normalized Counts")

# Compare conditions
wt_idx <- schurch_se$condition == "wildtype"
ko_idx <- schurch_se$condition == "knockout"

wt_mean <- rowMeans(norm_counts[, wt_idx])
ko_mean <- rowMeans(norm_counts[, ko_idx])
```

### 3. Differential Expression
The high number of replicates allows for standard statistical tests (like t-tests) that are usually underpowered in low-replicate RNA-seq experiments.

```r
# Simple t-test for each gene
pvalues <- sapply(seq_len(nrow(norm_counts)), function(i) {
  t.test(norm_counts[i, wt_idx], norm_counts[i, ko_idx])$p.value
})

# Volcano Plot
plot(wt_mean - ko_mean, -log10(pvalues), 
     pch = 16, cex = 0.5, col = "#00000050",
     xlab = "Log Fold Change", ylab = "-log10(p-value)")
```

## Tips
- **SummarizedExperiment**: Use `assay(schurch_se)` to get counts and `colData(schurch_se)` to access sample metadata.
- **Replicate Subsampling**: This dataset is ideal for benchmarking. You can randomly sample 3, 6, or 12 replicates from the 48 available to see how DE results change with sample size.
- **Filtering**: Many genes have low counts; consider filtering genes where `rowSums(counts) > 10` before analysis.

## Reference documentation
- [Exploring the 86 bulk RNA-seq samples from the Schurch et al. (2016) study](./references/HighlyReplicatedRNASeq.Rmd)
- [HighlyReplicatedRNASeq Package Guide](./references/HighlyReplicatedRNASeq.md)