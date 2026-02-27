---
name: bioconductor-outsplice
description: OutSplice identifies aberrant splicing events in tumor samples by comparing them to a normal distribution using outlier statistics. Use when user asks to identify sporadic splicing events in cancer samples, calculate splicing burden per sample, or visualize junction expression via waterfall plots.
homepage: https://bioconductor.org/packages/release/bioc/html/OutSplice.html
---


# bioconductor-outsplice

name: bioconductor-outsplice
description: Identify aberrant splicing events in tumor samples using outlier statistics. Use this skill to characterize sporadic splicing events (skipping, insertion, deletion) in heterogeneous cancer samples, calculate splicing burden per sample, and visualize junction expression via waterfall plots.

# bioconductor-outsplice

## Overview
OutSplice identifies aberrant splicing events in tumor samples by comparing them to a distribution of normal samples using outlier statistics rather than mean comparisons. This approach is specifically designed to capture the heterogeneity of cancer, where specific splicing events may only occur in a subset of samples. The package classifies events as skipping, insertion, or deletion and calculates a "splicing burden" for each sample.

## Installation and Setup
Load the package and required genomic annotation libraries:

```r
library(OutSplice)
# Ensure relevant TxDb and org.db packages are loaded for your organism
library(org.Hs.eg.db)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
```

## Core Workflow: Splicing Outlier Analysis

### 1. Standard Analysis
Use `outspliceAnalysis()` for user-provided RNA-seq data. You must provide four primary inputs:

*   **junction**: Filepath to raw junction read counts.
*   **gene_expr**: Filepath to normalized gene expression (RSEM quartile normalized recommended).
*   **rawcounts**: Filepath to raw read counts (per gene or summed total).
*   **sample_labels**: Filepath to a phenotype matrix (Sample Name vs. Phenotype "T" for tumor, "F" for normal).

```r
results <- outspliceAnalysis(
  junction = "path/to/junctions.txt",
  gene_expr = "path/to/gene_expr.txt",
  rawcounts = "path/to/rawcounts.txt",
  sample_labels = "path/to/pheno.txt",
  TxDb = "TxDb.Hsapiens.UCSC.hg19.knownGene",
  annotation = "org.Hs.eg.db",
  p_value = 0.05,
  saveOutput = TRUE
)
```

### 2. TCGA Analysis
Use `outspliceTCGA()` for data in TCGA format. This function automatically infers phenotypes from TCGA sample barcodes.

```r
results_TCGA <- outspliceTCGA(
  junction = "TCGA_junctions.txt",
  gene_expr = "TCGA_genes_normalized.txt",
  rawcounts = "Total_Rawcounts.txt",
  TxDb = "TxDb.Hsapiens.UCSC.hg19.knownGene"
)
```

## Interpreting Results
The analysis functions return a list containing:
*   **ASE.type**: Classification of significant events (skipping, insertion, deletion).
*   **FisherAnalyses**: P-values and rankings for over/under-expressed events.
*   **junc.Outliers**: Logical matrices indicating which samples are outliers for which junctions.
*   **splice_burden**: A matrix containing the count of over-expressed, under-expressed, and total outliers per sample.
*   **junc.RPM.norm**: Junction counts normalized by gene expression.

## Visualization
Use `plotJunctionData()` to generate bar and waterfall plots for specific junctions or top-ranked events.

```r
# Plot a specific junction by coordinates
plotJunctionData(
  data_file = "OutSplice_Results.RDa", 
  junctions = "chr1:150483674-150483933",
  makepdf = TRUE,
  pdffile = "junction_plot.pdf"
)

# Plot top 5 over-expressed junctions for a specific gene symbol
plotJunctionData(
  data_file = "OutSplice_Results.RDa",
  NUMBER = 5,
  tail = "RIGHT",
  GENE = TRUE,
  SYMBOL = "AKT3"
)
```

## Key Parameters and Constraints
*   **Phenotype Requirements**: The analysis requires at least 10 control (normal) samples and at least 1 tumor sample to proceed.
*   **Offsets**: The `offsets_value` (default 0.00001) filters out low-expression events that may not be biologically relevant.
*   **Event Classification**:
    *   **Insertion**: Junction starts outside a known exon.
    *   **Skipping**: Junction skips over a known exon.
    *   **Deletion**: Junction is inside a known exon but not at its boundaries.
*   **Organism Support**: Compatible with any organism if the corresponding `TxDb` and `org.db` packages are provided.

## Reference documentation
- [Find Splicing Outliers in Tumor Samples with OutSplice](./references/OutSplice.Rmd)
- [OutSplice Vignette](./references/OutSplice.md)