---
name: bioconductor-micrornaome
description: This package provides access to the microRNAome dataset containing small RNA-seq read counts for human microRNAs across various tissues and cell types. Use when user asks to access human miRNA expression data, load the microRNAome SummarizedExperiment object, or analyze processed SRA small RNA-seq counts.
homepage: https://bioconductor.org/packages/release/data/experiment/html/microRNAome.html
---


# bioconductor-micrornaome

name: bioconductor-micrornaome
description: Access and utilize the microRNAome dataset, a SummarizedExperiment object containing read counts for microRNAs across various human tissues, cell-types, and cancer cell-lines. Use this skill when a user needs to analyze human miRNA expression data from the microRNAome project (SRA data processed via miRge3).

# bioconductor-micrornaome

## Overview
The `microRNAome` package provides a comprehensive collection of small RNA-seq read counts for human microRNAs. The data encompasses 2,406 samples from the Sequence Read Archive (SRA), covering 196 primary cell types. The data is encapsulated in a `SummarizedExperiment` object, making it compatible with standard Bioconductor workflows for differential expression and multivariate analysis.

## Installation and Loading
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("microRNAome")
library(microRNAome)
```

## Accessing the Data
The primary dataset is loaded using the `data()` function.

```r
# Load the SummarizedExperiment object
data("microRNAome")

# View the object structure
microRNAome
```

## Typical Workflow

### 1. Exploring Metadata
The `colData` contains information about the samples, including tissue types and cell lines.

```r
# View sample metadata
metadata <- colData(microRNAome)
head(metadata)

# Check available sample variables
colnames(metadata)
```

### 2. Extracting Count Data
The read counts are stored in the `assays` slot.

```r
# List available assays (usually just "counts")
names(assays(microRNAome))

# Access the count matrix
counts_matrix <- assays(microRNAome)$counts

# View a subset of the data (first 5 miRNAs, first 5 samples)
counts_matrix[1:5, 1:5]
```

### 3. Accessing Feature Information
The `rowData` or `rowRanges` contains information about the microRNAs.

```r
# View miRNA information
rowData(microRNAome)
```

## Integration with Downstream Analysis
Since the data is a `SummarizedExperiment`, it can be easily passed to other Bioconductor tools:

*   **DESeq2**: For differential expression analysis.
*   **edgeR**: For digital gene expression analysis.
*   **limma**: Using the `voom` transformation for linear modeling.

Example of converting to a DESeq2 object:
```r
library(DESeq2)
# Assuming 'group' is a column in colData(microRNAome)
dds <- DESeqDataSet(microRNAome, design = ~ group)
```

## Tips
*   The dataset is large (2406 samples). When performing exploratory analysis or plotting (like PCA), consider filtering out low-count miRNAs to improve performance and reduce noise.
*   The counts provided are raw read counts. Ensure proper normalization (e.g., CPM, TMM, or median-of-ratios) before comparing across samples.

## Reference documentation
- [microRNAome Reference Manual](./references/reference_manual.md)