---
name: bioconductor-edaseq
description: The EDASeq package provides a framework for exploratory data analysis and normalization of RNA-Seq data to account for GC-content and gene length biases. Use when user asks to perform quality control on sequencing reads, visualize systematic biases in gene expression, or apply within-lane and between-lane normalization.
homepage: https://bioconductor.org/packages/release/bioc/html/EDASeq.html
---

# bioconductor-edaseq

## Overview
The `EDASeq` package provides a comprehensive framework for the exploratory data analysis and normalization of RNA-Seq data. It operates at two levels:
1.  **Read-level EDA**: Quality control of FASTQ or BAM files (mapping percentages, quality scores, nucleotide frequencies).
2.  **Gene-level EDA**: Detection of systematic biases (GC-content, gene length) and normalization to account for these effects.

The package introduces the `SeqExpressionSet` class, which extends `eSet` to store raw counts, normalized counts, and normalization offsets.

## Core Workflows

### 1. Data Import and Object Creation
`EDASeq` uses `ShortRead` and `Rsamtools` objects for read-level data, and a custom container for gene-level counts.

```R
library(EDASeq)

# Create a SeqExpressionSet
# counts: matrix of gene counts
# featureData: data.frame with 'gc' and 'length' columns
# phenoData: data.frame with sample conditions
data <- newSeqExpressionSet(counts = as.matrix(gene_counts),
                            featureData = feature_info,
                            phenoData = sample_info)
```

### 2. Exploratory Data Analysis
Use these functions to visualize biases before and after normalization.

*   **Read-level**:
    *   `barplot(bamFileList)`: Plot number of mapped reads.
    *   `plotQuality(bamFileList)`: Plot mean per-base quality scores.
    *   `plotNtFrequency(bamFile)`: Plot nucleotide distribution.
*   **Gene-level**:
    *   `biasPlot(data, "gc", log=TRUE)`: Visualize count dependence on a feature (e.g., "gc" or "length").
    *   `biasBoxplot(log_fold_change, feature_vector)`: Check if differential expression is biased by gene features.
    *   `meanVarPlot(data)`: Check for over-dispersion (Poisson vs. Negative Binomial).
    *   `MDPlot(data, c(1,2))`: Mean-Difference plot between two lanes.

### 3. Normalization
Normalization is typically a two-step process. Within-lane normalization should be performed first.

*   **Within-lane**: Corrects for gene-specific features (GC-content, length).
    *   Methods: `loess`, `median`, `upper`, `full`.
    *   `dataWithin <- withinLaneNormalization(data, "gc", which="full")`
*   **Between-lane**: Corrects for sequencing depth and distributional differences.
    *   Methods: `median`, `upper`, `full`.
    *   `dataNorm <- betweenLaneNormalization(dataWithin, which="full")`

### 4. Using Offsets for Differential Expression
Instead of using normalized counts directly, it is often preferred to use the original counts and provide an "offset" to statistical models (like `edgeR` or `DESeq2`).

```R
# Generate offsets
dataOffset <- withinLaneNormalization(data, "gc", which="full", offset=TRUE)
dataOffset <- betweenLaneNormalization(dataOffset, which="full", offset=TRUE)

# For edgeR: Note that edgeR expects the negative of the EDASeq offset
library(edgeR)
y <- DGEList(counts = counts(dataOffset))
y$offset <- -offst(dataOffset) 

# For DESeq2:
library(DESeq2)
dds <- DESeqDataSetFromMatrix(countData = counts(dataOffset), 
                              colData = pData(dataOffset), 
                              design = ~ conditions)
normalizationFactors(dds) <- exp(-1 * offst(dataOffset))
```

## Tips and Conventions
*   **Feature Retrieval**: Use `getGeneLengthAndGCContent(ids, org="hsa")` to automatically fetch GC and length data for human (hsa), mouse (mmu), or yeast (sacCer3).
*   **Rounding**: By default, normalization functions round results to the nearest integer ("pseudo-counts"). Use `round=FALSE` if you need high-precision offsets.
*   **Zero Counts**: `EDASeq` adds a small constant (0.1) to counts when calculating logs or offsets to avoid mathematical errors with zeros.
*   **Filtering**: Always filter out non-expressed or very lowly expressed genes (e.g., mean count < 10) before running `biasPlot` or normalization to reduce noise.

## Reference documentation
- [EDASeq Vignette](./references/EDASeq.md)
- [EDASeq R Markdown Source](./references/EDASeq.Rmd)