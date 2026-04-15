---
name: bioconductor-vdjdive
description: This package integrates 10X Genomics AIRR-seq data into the Bioconductor single-cell ecosystem for clonotype assignment and diversity analysis. Use when user asks to read V(D)J contig annotations, merge immune repertoire data into a SingleCellExperiment object, assign clonotypes using EM algorithms, or calculate and visualize repertoire diversity metrics.
homepage: https://bioconductor.org/packages/release/bioc/html/VDJdive.html
---

# bioconductor-vdjdive

## Overview

The `VDJdive` package integrates adaptive immune receptor sequencing (AIRRseq) data into the Bioconductor single-cell ecosystem. It is specifically designed to handle 10X Genomics `filtered_contig_annotations.csv` files. The package provides a robust framework for clonotype assignment—including a probabilistic Expectation-Maximization (EM) approach for ambiguous cells—and calculates various diversity metrics to characterize immune repertoires across samples or clusters.

## Core Workflow

### 1. Data Loading
Read 10X Genomics V(D)J output files into a `SplitDataFrameList`.

```r
library(VDJdive)

# Read from a single directory
contigs <- readVDJcontigs("path/to/sample_folder")

# Read from multiple directories (barcodes are automatically prefixed with sample names)
contigs <- readVDJcontigs(c("sample1_dir", "sample2_dir"))
```

### 2. Integration with SingleCellExperiment
Merge V(D)J data into an existing `SingleCellExperiment` (SCE) object. Barcodes must match between the SCE and the contig data.

```r
library(SingleCellExperiment)
# Assuming 'sce' is your existing RNA-seq object
sce <- addVDJtoSCE(contigs, sce)

# Access the contig data within the SCE
sce$contigs
```

### 3. Clonotype Assignment
`VDJdive` offers two methods for defining clonotypes:
- **Unique**: Only considers cells with exactly one productive alpha and one productive beta chain.
- **EM (Default)**: Uses an Expectation-Maximization algorithm to handle ambiguous cells (e.g., multiple chains or missing chains) by assigning partial counts based on sample-wide prevalence.

```r
# Assign clonotypes to an SCE object
sce <- clonoStats(sce, method = "EM")

# Or directly to the contigs list
stats <- clonoStats(contigs, method = "unique")
```

### 4. Diversity Analysis
Calculate diversity metrics including Shannon entropy, Simpson index, and Chao richness.

```r
# Calculate all available metrics
div_metrics <- calculateDiversity(sce, methods = "all")

# Metrics include: nCells, nClonotypes, shannon, invsimpson, chao1, etc.
```

### 5. Visualization
The package provides several plotting functions to explore clonotype abundance and diversity.

```r
# Bar plot of clonotype expansion
barVDJ(sce, title = "Clonotype Abundance")

# Pie charts for individual samples
pieVDJ(sce)

# Dot plot of top clonotypes
abundanceVDJ(sce)

# Scatter plot comparing Richness vs. Evenness
# Requires a sample group dataframe for coloring
sampleGroups <- data.frame(Sample = c("s1", "s2"), Group = c("A", "B"))
scatterVDJ(div_metrics, sampleGroups = sampleGroups)
```

## Key Functions and Accessors

If you have run `clonoStats` on an SCE object, use these accessors:
- `clonoAbundance(sce)`: Get the abundance matrix (clonotypes x samples).
- `clonoFrequency(sce)`: Get the frequency of clonotype sizes (singletons, doubletons, etc.).
- `clonoGroup(sce)`: Get the group/sample assignments for cells.
- `clonoNames(sce)`: Get the CDR3 sequences defining each clonotype.

## Tips for Success
- **Group by Sample First**: Always run `clonoStats` with cells grouped by their sample of origin first to ensure accurate EM assignment. You can re-calculate statistics for clusters later using `clonoStats(EMstats, group = cluster_ids)`.
- **Ambiguous Cells**: If your data has many cells with multiple chains, the `EM` method is preferred over `unique` to avoid losing significant portions of your dataset.
- **External Dependencies**: For species richness estimation via `runBreakaway`, ensure the `breakaway` package is installed from CRAN.

## Reference documentation
- [VDJdive Workflow](./references/workflow.md)