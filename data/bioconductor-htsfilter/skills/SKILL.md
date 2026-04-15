---
name: bioconductor-htsfilter
description: This tool performs data-driven filtering of replicated high-throughput sequencing data to remove uninformative genes with low or constant expression. Use when user asks to filter RNA-seq data, identify optimal expression thresholds using the Jaccard index, or increase statistical power for differential expression analysis with edgeR or DESeq2.
homepage: https://bioconductor.org/packages/release/bioc/html/HTSFilter.html
---

# bioconductor-htsfilter

name: bioconductor-htsfilter
description: Data-based filtering for replicated high-throughput sequencing (RNA-seq) data. Use this skill to identify and remove uninformative genes (low, constant expression) using a similarity index (Jaccard index) to increase power for differential expression analysis. Supports matrix, data.frame, edgeR (DGEExact, DGELRT), and DESeq2 (DESeqDataSet) objects.

## Overview

The `HTSFilter` package implements a data-driven filtering procedure for replicated RNA-seq data. It calculates a global Jaccard index across a range of potential thresholds to find an optimal cutoff that maximizes the similarity between biological replicates. This ensures that filtered genes are consistently low-expressed across samples, while potentially differentially expressed (DE) genes are retained.

Key assumptions:
1. Biological replicates are available for each condition.
2. Data can be normalized to correct for inter-sample biases.

## Core Workflow

### 1. Basic Filtering (Matrix or Data.frame)
For raw count matrices, provide the matrix and a character vector of condition labels.

```r
library(HTSFilter)

# mat: matrix of counts
# conds: vector of condition labels (e.g., c("A", "A", "B", "B"))
filter_result <- HTSFilter(mat, conds, s.len=100, plot=TRUE)

# Access filtered data
filtered_counts <- filter_result$filteredData
removed_counts <- filter_result$removedData
threshold <- filter_result$threshold
```

### 2. Integration with edgeR
Apply the filter to `DGEExact` or `DGELRT` objects after running differential expression tests.

```r
library(edgeR)
# ... standard edgeR workflow (calcNormFactors, estimateDisp, exactTest) ...

# Filter DGEExact object
et_filtered <- HTSFilter(et, DGEList=dge)$filteredData

# Filter DGELRT object
lrt_filtered <- HTSFilter(lrt, DGEGLM=fit)$filteredData

# Results can be passed directly to topTags
topTags(et_filtered)
```

### 3. Integration with DESeq2
Apply the filter to a `DESeqDataSet` after the `DESeq()` call. Disable DESeq2's internal independent filtering when extracting results.

```r
library(DESeq2)
# ... standard DESeq2 workflow (dds <- DESeq(dds)) ...

# Filter the DESeqDataSet
dds_filtered <- HTSFilter(dds)$filteredData

# Get results without DESeq2's default independent filtering
res <- results(dds_filtered, independentFiltering=FALSE)
```

### 4. Custom Normalization
If using external normalization (e.g., EDASeq), set `normalization="none"`.

```r
# counts_norm: pre-normalized count matrix
filter <- HTSFilter(counts_norm, conds, normalization="none")

# Use the 'on' vector (1 = keep, 0 = filter) to subset original data
keep_indices <- filter$on
final_data <- counts_norm[keep_indices == 1, ]
```

## Key Parameters

- `s.len`: Number of thresholds to test (default 100). Decrease for faster computation during exploration.
- `normalization`: Method to use ("TMM", "DESeq", "pseudo.counts", or "none").
- `plot`: If `TRUE`, generates a plot of the global Jaccard index vs. thresholds. A "good" filter shows a clear maximum.
- `s.min`, `s.max`: The range of thresholds to test.

## Tips for Success

- **Check the Plot**: Always inspect the Jaccard index plot. If the curve does not show a clear peak or plateau followed by a decrease, the filtering may not be appropriate for the dataset.
- **Timing**: For `edgeR`, apply the filter *after* `exactTest` or `glmLRT`. For `DESeq2`, apply it *after* `DESeq()`.
- **Re-filtering**: Do not apply `HTSFilter` to data that has already been filtered; the Jaccard index will typically show a plateau at low thresholds, indicating no further genes should be removed.

## Reference documentation

- [HTSFilter Quick-start guide](./references/HTSFilter.md)