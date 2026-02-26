---
name: bioconductor-anaquin
description: Anaquin is a statistical framework for analyzing synthetic sequencing spike-ins to calibrate and validate NGS workflows. Use when user asks to analyze sequins, estimate limits of quantification or detection, validate differential expression, or evaluate transcriptome assembly performance.
homepage: https://bioconductor.org/packages/release/bioc/html/Anaquin.html
---


# bioconductor-anaquin

## Overview

Anaquin is a statistical framework designed to analyze synthetic nucleic-acid "sequins" (sequencing spike-ins) added to NGS samples. By comparing measured data against known spike-in concentrations, the package allows for the calibration of NGS workflows, providing empirical metrics for sensitivity, accuracy, and detection limits.

## Core Workflow

### 1. Loading Mixture Data
Mixture files (CSV) define the known concentrations of sequins. Anaquin provides built-in datasets for standard mixtures.

```r
library(Anaquin)
data("RnaQuinIsoformMixture")
# Contains: Name, Length, MixA (attoml/ul), MixB (attoml/ul)
```

### 2. Linearity and Quantification
Use `plotLinear` to model the relationship between input concentrations and measured values (e.g., FPKM). This identifies the Limit of Quantification (LOQ).

```r
# x: log2 input concentration
# y: log2 measured FPKM
plotLinear(names, x, y, title="Expression Analysis", showLOQ=TRUE)
```

### 3. Transcriptome Assembly Performance
To evaluate how well an assembler performs relative to transcript concentration, use `plotLogistic`. This identifies the Limit of Assembly (LOA), typically defined at a sensitivity threshold of 0.70.

```r
# x: log2 input concentration
# y: measured sensitivity (0 to 1)
plotLogistic(names, x, y, title="Assembly Plot", showLOA=TRUE)
```

### 4. Differential Expression Validation
Validate fold-change accuracy by comparing expected log-fold changes (LFC) from the spike-ins against observed LFC from tools like DESeq2.

```r
# x: Expected LFC
# y: Observed LFC
plotLinear(names, x, y, title="Fold Change Validation", showAxis=TRUE)
```

### 5. Diagnostic Plots
*   **ROC Curves**: Evaluate the classification power of the experiment (True Positives vs. False Positives).
    ```r
    plotROC(seqs, score, ratio, label, title="ROC Plot", refGroup=0)
    ```
*   **LOD Curves**: Estimate the Limit of Detection (LOD) by modeling p-values against average counts.
    ```r
    plotLOD(mean, pval, abs(ratio), qval=qval, FDR=0.05)
    ```

## Key Functions
*   `plotLinear`: Generates regression plots with $R^2$ and LOQ estimation.
*   `plotLogistic`: Fits a logistic curve to sensitivity data to find the LOA.
*   `plotROC`: Creates Receiver Operating Characteristic curves for spike-in ratios.
*   `plotLOD`: Visualizes detection limits based on statistical significance and abundance.

## Reference documentation
- [Anaquin Vignette](./references/Anaquin.md)