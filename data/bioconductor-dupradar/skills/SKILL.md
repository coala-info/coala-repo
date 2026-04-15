---
name: bioconductor-dupradar
description: bioconductor-dupradar provides quality control for RNA-Seq data by analyzing the relationship between gene expression levels and duplication rates. Use when user asks to mark duplicates, calculate duplication matrices, generate diagnostic plots, or assess PCR artifacts in sequencing experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/dupRadar.html
---

# bioconductor-dupradar

## Overview

The `dupRadar` package provides quality control for RNA-Seq experiments by analyzing the relationship between gene expression levels (RPK) and duplication rates. In RNA-Seq, high duplication is expected for highly expressed genes, while high duplication in lowly expressed genes typically indicates technical PCR artifacts. This skill guides you through marking duplicates, calculating duplication matrices, and interpreting diagnostic plots.

## Core Workflow

### 1. Data Preparation
`dupRadar` requires BAM files where duplicates have been marked (e.g., via Picard or BamUtil). You can use the internal wrapper if the tools are installed on your system.

```r
library(dupRadar)

# Optional: Mark duplicates using a system tool wrapper
bamDuprm <- markDuplicates(dupremover="bamutil",
                           bam="input.bam",
                           path="/path/to/bin",
                           rminput=FALSE)
```

### 2. Duplication Rate Analysis
The core function `analyzeDuprates` calculates a duplication matrix. You must specify the strandedness and library type.

```r
# Parameters:
# stranded: 0 (unstranded), 1 (stranded), 2 (reversely stranded)
# paired: TRUE/FALSE
dm <- analyzeDuprates(bam="marked_duplicates.bam", 
                      gtf="annotation.gtf", 
                      stranded=2, 
                      paired=FALSE, 
                      threads=4)
```

### 3. Visualization and Interpretation
The primary diagnostic tool is the 2D density scatter plot.

```r
# 2D Density scatter plot (The "Blue Cloud")
duprateExpDensPlot(DupMat=dm)
```

**Interpretation:**
*   **Good Experiment:** A "cloud" that starts low at low RPK values and rises only as expression increases.
*   **Failed Experiment:** High duplication rates even at low RPK values (high intercept), indicating PCR over-amplification.

### 4. Modeling and Metrics
To automate QC, fit a logistic regression model to the duplication data.

```r
fit <- duprateExpFit(DupMat=dm)
cat("Intercept (duplication at low counts):", fit$intercept, "\n")
cat("Slope (progression of duplication):", fit$slope, "\n")
```

### 5. Additional Diagnostics
*   **Boxplots:** View duplication distribution across expression bins.
    ```r
    duprateExpBoxplot(DupMat=dm)
    ```
*   **Expression Histogram:** Check for skewed RPK distributions.
    ```r
    expressionHist(DupMat=dm)
    ```
*   **Distribution of Reads:** See how much of the library is consumed by the top 5% of expressed genes.
    ```r
    readcountExpBoxplot(DupMat=dm)
    ```

## Advanced Analysis

### Multimapping Analysis
You can derive multimapping rates from the duplication matrix by comparing `allCountsMulti` and `allCounts`.

```r
# Calculate fraction of multimappers per gene
dm$mhRate <- (dm$allCountsMulti - dm$allCounts) / dm$allCountsMulti

# Identify genes covered exclusively by multimappers
exclusive_multi <- dm[dm$mhRate == 1, "ID"]
```

### GC Content Bias
Combine `dupRadar` with `biomaRt` to check if PCR artifacts are linked to GC content.

```r
# After obtaining GC content (e.g., from biomaRt) and merging with dm:
par(mfrow=c(1,2))
duprateExpDensPlot(dm.gc[dm.gc$gc <= 45,], main="Low GC")
duprateExpDensPlot(dm.gc[dm.gc$gc > 45,], main="High GC")
```

## Reference documentation
- [Using the dupRadar package](./references/dupRadar.md)