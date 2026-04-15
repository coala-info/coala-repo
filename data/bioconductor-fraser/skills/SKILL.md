---
name: bioconductor-fraser
description: FRASER detects rare aberrant splicing events in RNA-seq data by modeling read count ratios and correcting for latent confounders using a denoising autoencoder. Use when user asks to identify splice site defects, quantify alternative splicing or intron retention, and call splicing outliers in rare disease diagnostics.
homepage: https://bioconductor.org/packages/release/bioc/html/FRASER.html
---

# bioconductor-fraser

name: bioconductor-fraser
description: Statistical method for detecting rare aberrant splicing events in RNA-seq data. Use this skill when analyzing RNA-seq data for rare diseases to identify splice site defects, alternative splicing, or intron retention. It covers the full workflow from read counting and metric calculation (Intron Jaccard Index, psi, theta) to denoising with autoencoders and calling outliers.

## Overview

FRASER (Find RAre Splicing Events in RNA-seq) is a Bioconductor package designed for diagnostics in rare diseases. It detects aberrant splicing by modeling read count ratios using a beta-binomial distribution and automatically controlling for latent confounders with a denoising autoencoder. It supports de novo splice site detection and quantifies alternative donor/acceptor usage and intron retention.

## Core Workflow

### 1. Data Preparation
Create a `FraserDataSet` (fds) using a sample annotation table and BAM files.

```r
library(FRASER)

# Define sample metadata
sampleTable <- data.table(
  sampleID = c("S1", "S2"),
  bamFile = c("path/to/s1.bam", "path/to/s2.bam"),
  pairedEnd = TRUE
)

# Initialize object
fds <- FraserDataSet(colData=sampleTable, workingDir="FRASER_output")

# Count reads (extracts split and non-split reads)
fds <- countRNAData(fds)
```

### 2. Metric Calculation and Filtering
FRASER 2.0+ defaults to the **Intron Jaccard Index**, which combines alternative splicing and intron retention into a single robust metric.

```r
# Calculate splicing metrics (psi5, psi3, theta, and jaccard)
fds <- calculatePSIValues(fds)

# Filter lowly expressed junctions (recommended: at least 20 reads in one sample)
fds <- filterExpressionAndVariability(fds, 
                                      minExpressionInOneSample=20, 
                                      filter=TRUE)
```

### 3. Fitting the Model
The `FRASER()` function is a wrapper that performs:
1. Latent space dimension (q) estimation.
2. Autoencoder fitting to correct for confounders.
3. P-value calculation.

```r
# Run the full pipeline
# q is the number of latent components; can be estimated via estimateBestQ()
fds <- FRASER(fds, q=c(jaccard=2))
```

### 4. Annotation and Results
Annotate genomic ranges with gene symbols before extracting results.

```r
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)

# Annotate
fds <- annotateRangesWithTxDb(fds, 
                              txdb=TxDb.Hsapiens.UCSC.hg19.knownGene, 
                              orgDb=org.Hs.eg.db)

# Extract significant outliers (default: padj <= 0.05, |deltaPsi| >= 0.3)
res <- results(fds, padjCutoff=0.05, deltaPsiCutoff=0.3)

# For gene-level results
res_gene <- results(fds, aggregate=TRUE)
```

## Visualization

FRASER provides several plotting functions to evaluate results and QC:

*   **Volcano Plot**: `plotVolcano(fds, sampleID="S1", type="jaccard")`
*   **Expression Plot**: `plotExpression(fds, type="jaccard", result=res[1])`
*   **Sample Correlation**: `plotCountCorHeatmap(fds, type="jaccard", normalized=TRUE)`
*   **Sashimi Plot**: `plotBamCoverageFromResultTable(fds, result=res[1])` (requires BAM access)

## Key Tips
*   **Sample Size**: For best performance in correcting confounders, at least 50 samples are recommended.
*   **FRASER 2.0**: Always prefer the `jaccard` metric over the older `psi5`, `psi3`, and `theta` metrics for improved sensitivity and specificity.
*   **Latent Space**: If the autoencoder doesn't seem to remove correlations, use `estimateBestQ(fds)` to find the optimal `q`.
*   **Strand Specificity**: Ensure the `strandMode` is correctly set in the `FraserDataSet` if your library prep was stranded.

## Reference documentation
- [FRASER: Find RAre Splicing Events in RNA-seq Data](./references/FRASER.md)