---
name: bioconductor-tcseq
description: This tool analyzes time course sequencing data such as RNA-seq, ATAC-seq, and ChIP-seq to identify temporal patterns and differential expression. Use when user asks to perform differential analysis between time points, generate reference genomic regions from peak files, or identify temporal patterns using unsupervised clustering.
homepage: https://bioconductor.org/packages/release/bioc/html/TCseq.html
---

# bioconductor-tcseq

name: bioconductor-tcseq
description: Analysis of time course sequencing data (RNA-seq, ATAC-seq, ChIP-seq). Use this skill to perform differential analysis between time points, generate reference genomic regions from peak files, and identify temporal patterns using unsupervised clustering (hard and soft clustering).

# bioconductor-tcseq

## Overview
The `TCseq` package is designed for the analysis of time course sequencing data. It provides a unified framework for both transcriptomic (RNA-seq) and epigenomic (ATAC-seq, ChIP-seq) data. Key capabilities include merging condition-specific genomic regions (peaks) into a reference set, performing differential binding/expression analysis using edgeR-based GLMs, and clustering genomic features into temporal patterns for visualization.

## Core Workflow

### 1. Data Preparation and Object Creation
The central data structure is the `TCA` object.

```R
library(TCseq)

# Option A: From genomic intervals and BAM files
# experiment_design should contain 'bamfile', 'sampleid', 'timepoint', 'group'
tca <- TCA(design = experiment_design, genomicFeature = genomicIntervals)
tca <- countReads(tca, dir = "path/to/bams")

# Option B: From an existing counts table
tca <- TCA(design = experiment_design, genomicFeature = genomicIntervals, counts = countsTable)

# Option C: For epigenomic data, generate reference regions from BED files
gf <- peakreference(dir = "path/to/peaks", pattern = "narrowpeaks")
```

### 2. Differential Analysis
`TCseq` uses `edgeR` internally to detect differential events across the time course.

```R
# Perform differential analysis
# filter.type "raw" keeps regions with counts > filter.value in at least samplePassfilter samples
tca <- DBanalysis(tca, filter.type = "raw", filter.value = 10, samplePassfilter = 2)

# Extract results for specific time point comparisons
DBres <- DBresult(tca, group1 = "0h", group2 = c("24h", "40h", "72h"))

# Extract only significant results (log2FC > 2 and adj.P < 0.05)
DBres.sig <- DBresult(tca, group1 = "0h", group2 = c("24h", "40h", "72h"), top.sig = TRUE)
```

### 3. Temporal Pattern Analysis (Clustering)
Identify groups of genomic regions that share similar behavior over time.

```R
# 1. Construct time course table
# value can be "FC" (fold change vs control) or "expression" (normalized counts)
tca <- timecourseTable(tca, value = "FC", control.group = "0h", norm.method = "rpkm", filter = TRUE)

# 2. Perform clustering
# algo: "cm" (c-means/soft), "km" (k-means), "pam", or "hc" (hierarchical)
# k: number of clusters
tca <- timeclust(tca, algo = "cm", k = 6, standardize = TRUE)

# 3. Visualization
# Returns a list of ggplot objects
p <- timeclustplot(tca, value = "z-score(RPKM)", cols = 3)
print(p[[1]]) # Plot first cluster
```

## Key Functions
- `peakreference`: Merges overlapping peak regions from multiple BED files.
- `TCA`: Constructor for the Time Course Analysis object.
- `countReads`: Quantifies reads in genomic features from BAM files.
- `DBanalysis`: Runs the differential binding/expression pipeline.
- `DBresult`: Extracts fold changes and p-values for specific comparisons.
- `timecourseTable`: Prepares data for clustering (normalization and filtering).
- `timeclust`: Executes unsupervised clustering algorithms.
- `timeclustplot`: Generates temporal profile plots for clusters.

## Tips
- **Standardization**: When clustering, setting `standardize = TRUE` in `timeclust` performs z-score transformation. This is recommended if you want to group features by the *shape* of their temporal pattern rather than their absolute magnitude.
- **Filtering**: Setting `filter = TRUE` in `timecourseTable` restricts clustering to only those features that showed significant changes in the `DBanalysis` step.
- **Epigenomic Data**: Unlike RNA-seq where genes are fixed, use `peakreference` to create a consensus set of regions across all your time-course samples before quantification.

## Reference documentation
- [TCseq](./references/TCseq.md)