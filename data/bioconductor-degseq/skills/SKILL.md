---
name: bioconductor-degseq
description: This tool identifies differentially expressed genes from RNA-seq data using MA-plot-based methods or likelihood ratio tests. Use when user asks to perform differential expression analysis, identify DEGs from gene expression count matrices, or count mapped reads using a refFlat annotation.
homepage: https://bioconductor.org/packages/release/bioc/html/DEGseq.html
---


# bioconductor-degseq

name: bioconductor-degseq
description: Identifying differentially expressed genes (DEGs) from RNA-seq data using the DEGseq Bioconductor package. Use this skill when you need to perform differential expression analysis on uniquely mapped reads or gene expression count matrices, specifically using MA-plot-based methods (MARS, MATR) or Likelihood Ratio Tests (LRT).

## Overview
DEGseq is an R package designed to identify differentially expressed genes from RNA-seq data. It supports input in the form of mapped read files (BED, ELAND, etc.) or pre-calculated gene expression count matrices. The package is particularly known for its MA-plot-based methods that account for random sampling models or technical replicates to estimate noise levels and identify significant expression changes.

## Core Workflows

### 1. Analysis from Expression Matrices (DEGexp)
Use `DEGexp` when you already have gene expression values or read counts.

```r
library(DEGseq)

# Load data into a matrix
geneExpFile <- system.file("extdata", "GeneExpExample5000.txt", package="DEGseq")
geneExpMatrix1 <- readGeneExp(file=geneExpFile, geneCol=1, valCol=c(7,9,12,15,18))
geneExpMatrix2 <- readGeneExp(file=geneExpFile, geneCol=1, valCol=c(8,10,11,13,16))

# Identify DEGs using the Random Sampling model (MARS)
DEGexp(geneExpMatrix1=geneExpMatrix1, geneCol1=1, expCol1=c(2:6), groupLabel1="kidney",
       geneExpMatrix2=geneExpMatrix2, geneCol2=1, expCol2=c(2:6), groupLabel2="liver",
       method="MARS", pValue=0.001, outputDir="results")
```

### 2. Analysis from Mapped Reads (DEGseq)
Use `DEGseq` to automate the process of counting reads mapped to genes (using a refFlat annotation) and then performing differential expression analysis.

```r
# Define paths to alignment files (e.g., BED format)
kidney_reads <- system.file("extdata", "kidneyChr21.bed.txt", package="DEGseq")
liver_reads <- system.file("extdata", "liverChr21.bed.txt", package="DEGseq")
refFlat <- system.file("extdata", "refFlatChr21.txt", package="DEGseq")

# Run the full pipeline using Likelihood Ratio Test (LRT)
DEGseq(mapResultBatch1=kidney_reads, mapResultBatch2=liver_reads, 
       fileFormat="bed", refFlat=refFlat, 
       method="LRT", outputDir="DEG_output")
```

### 3. Handling Technical Replicates (MATR)
If technical replicates are available, use the `MATR` method to estimate intensity-dependent noise levels.

```r
DEGexp(geneExpMatrix1=geneExpMatrix1, expCol1=2, groupLabel1="Sample1",
       geneExpMatrix2=geneExpMatrix2, expCol2=2, groupLabel2="Sample2",
       replicateExpMatrix1=geneExpMatrix1, expColR1=3, replicateLabel1="Rep1",
       replicateExpMatrix2=geneExpMatrix1, expColR2=4, replicateLabel2="Rep2",
       method="MATR")
```

## Key Functions
- `readGeneExp`: Reads gene expression values from a text file into an R matrix.
- `getGeneExp`: Counts reads mapped to each gene for a single sample using a refFlat annotation file.
- `DEGexp`: The primary engine for DEG identification from matrices. Methods include "MARS" (Random Sampling), "MATR" (Technical Replicates), "LRT" (Likelihood Ratio Test), and "FoldChange".
- `DEGseq`: A wrapper that combines read counting and `DEGexp` analysis.

## Tips and Constraints
- **Annotation Format**: The `refFlat` file must follow the UCSC refFlat format.
- **Output**: If `outputDir` is specified, the package generates a text file with results and an XHTML summary page for visualization.
- **Dependencies**: Ensure `qvalue` and `samr` are installed, as DEGseq relies on them for FDR calculations and certain wrappers.
- **Visualization**: Use `layout()` and `par()` before calling `DEGexp` to view the diagnostic plots (Distribution of reads, MA-plots, etc.) generated during the analysis.

## Reference documentation
- [How to use the DEGseq Package](./references/DEGseq.md)