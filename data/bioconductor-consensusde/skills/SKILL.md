---
name: bioconductor-consensusde
description: This tool performs differential expression analysis by integrating results from the voom/limma, DESeq2, and edgeR algorithms. Use when user asks to perform consensus RNA-seq differential expression analysis, remove unwanted variation using RUV, or generate automated pairwise comparisons and diagnostic plots.
homepage: https://bioconductor.org/packages/release/bioc/html/consensusDE.html
---

# bioconductor-consensusde

name: bioconductor-consensusde
description: Differential expression (DE) analysis using a consensus approach with multiple algorithms (voom/limma, DESeq2, and edgeR). Use this skill when you need to perform RNA-seq DE analysis that integrates results from multiple methods, removes unwanted variation (RUV), or requires automated pairwise comparisons and diagnostic plotting.

## Overview

The `consensusDE` package streamlines the process of performing differential expression analysis by running three popular algorithms—**voom/limma**, **DESeq2**, and **edgeR**—simultaneously. It merges their results into a single table, ranking genes by the summed ranks of their p-values. This "consensus" approach helps identify robust DE genes that are consistently detected across different statistical frameworks.

## Core Workflow

### 1. Building a SummarizedExperiment
Use `buildSummarized()` to prepare your data. It can count reads from BAM files or import existing count data.

```r
library(consensusDE)
library(TxDb.Dmelanogaster.UCSC.dm3.ensGene)

# Sample table must have "file" and "group" columns
sample_table <- data.frame(
  file = c("sample1.bam", "sample2.bam", "sample3.bam", "sample4.bam"),
  group = c("treat", "treat", "untreat", "untreat")
)

# Build the object
se <- buildSummarized(
  sample_table = sample_table,
  bam_dir = "/path/to/bams",
  tx_db = TxDb.Dmelanogaster.UCSC.dm3.ensGene,
  read_format = "paired" # or "single"
)
```

### 2. Performing Differential Expression
The `multi_de_pairs()` function performs all possible pairwise comparisons between groups defined in your metadata.

```r
# Basic DE analysis
results <- multi_de_pairs(
  summarized = se,
  paired = "unpaired",
  ruv_correct = FALSE
)

# Access merged results for a specific comparison
head(results$merged[["treat-untreat"]])
```

### 3. Removing Unwanted Variation (RUV)
To account for batch effects or hidden factors, set `ruv_correct = TRUE`. This implements the RUVr method (residuals-based).

```r
results_ruv <- multi_de_pairs(
  summarized = se,
  ruv_correct = TRUE
)
```

### 4. Paired Analysis
For paired designs (e.g., before/after treatment in the same patient), ensure your `colData` has a `pairs` column.

```r
colData(se)$pairs <- as.factor(c("p1", "p1", "p2", "p2"))
results_paired <- multi_de_pairs(
  summarized = se,
  paired = "paired"
)
```

## Key Functions and Parameters

- **`buildSummarized()`**:
  - `filter = TRUE`: Removes low-count genes.
  - `strand_mode`: 0 (unstranded), 1 (stranded), 2 (reversely stranded).
  - `gtf`: Path to a GTF file if a TxDb object is not available.
- **`multi_de_pairs()`**:
  - `ensembl_annotate`: Pass an OrgDb (e.g., `org.Hs.eg.db`) to add gene symbols and KEGG IDs.
  - `norm_method`: "all_defaults" (uses method-specific defaults) or "EDASeq" (consistent normalization across all methods).
  - `plot_dir`: Path to save a comprehensive PDF report of diagnostic plots.

## Interpreting Results

The `merged` output table contains several unique columns:
- `rank_sum`: The sum of p-value ranks across the three methods (lower is better).
- `p_intersect`: The largest p-value among the methods (conservative intersection).
- `p_union`: The smallest p-value among the methods (liberal union).
- `LogFC`: The average log2 fold-change across all methods.

## Diagnostic Plotting

Use `diag_plots()` to visualize data quality and DE results:

```r
# PCA Plot
diag_plots(se_in = se, pca = TRUE)

# Volcano Plot (requires a list with specific column names)
# Note: diag_plots expects a list where the dataframe has an "Adj_PVal" column
comp_list <- results$merged
colnames(comp_list[[1]])[colnames(comp_list[[1]]) == "edger_adj_p"] <- "Adj_PVal"
diag_plots(merged_in = comp_list, volcano = TRUE)
```

## Reference documentation
- [consensusDE: DE analysis using multiple algorithms](./references/consensusDE.md)