---
name: bioconductor-xbseq
description: XBSeq performs differential expression analysis of RNA-seq data by modeling background noise from non-exonic regions using a convolution of Poisson and Negative Binomial distributions. Use when user asks to perform noise-corrected differential expression testing, analyze differential alternative polyadenylation usage, or visualize signal-to-noise distributions in sequencing data.
homepage: https://bioconductor.org/packages/3.5/bioc/html/XBSeq.html
---

# bioconductor-xbseq

name: bioconductor-xbseq
description: Statistical modeling and differential expression analysis of RNA-seq data by incorporating background noise from non-exonic regions. Use this skill for: (1) Accurate DE testing using a convolution model of Poisson (noise) and Negative Binomial (signal) distributions, (2) Differential alternative polyadenylation (APA) usage analysis, (3) Visualizing signal-to-noise distributions in RNA-seq datasets.

# bioconductor-xbseq

## Overview

XBSeq is a Bioconductor package designed for differential expression (DE) analysis of RNA-seq data. Unlike standard methods that only consider exonic reads, XBSeq assumes that observed signals are a convolution of true expression signals (Negative Binomial) and sequencing noise (Poisson). Sequencing noise is estimated from mapped reads in non-exonic regions. This approach provides more accurate DE detection by explicitly modeling the background noise. Additionally, the package supports differential alternative polyadenylation (APA) usage analysis.

## Core Workflow: Differential Expression

To use XBSeq, you must provide two count matrices: one for exonic regions (Observed) and one for non-exonic regions (Background).

### 1. Data Preparation and Object Creation

Construct a `XBSeqDataSet` object using your count matrices and experimental conditions.

```r
library(XBSeq)

# Observed: matrix of exonic counts
# Background: matrix of non-exonic counts
# conditions: factor defining experimental groups
conditions <- factor(c(rep("Control", 3), rep("Treatment", 3)))
xb_data <- XBSeqDataSet(Observed, Background, conditions)
```

### 2. Signal and Dispersion Estimation

The workflow follows a sequence of estimation steps similar to DESeq but incorporates the background noise model.

```r
# Estimate underlying true signal
xb_data <- estimateRealCount(xb_data)

# Estimate normalization factors
xb_data <- estimateSizeFactors(xb_data)

# Estimate dispersion (SCV)
xb_data <- estimateSCV(xb_data, method='pooled', sharingMode='maximum', fitType='local')
```

### 3. Differential Expression Testing

Perform the statistical test using `XBSeqTest`. The `NP` method (non-parametric) is often used for the final test.

```r
# Perform the test
results <- XBSeqTest(xb_data, "Control", "Treatment", method = 'NP')

# One-step wrapper alternative
results <- XBSeq(Observed, Background, conditions, method='pooled', 
                 sharingMode='maximum', fitType='local', paraMethod = 'NP')
```

## Differential Alternative Polyadenylation (APA)

XBSeq incorporates functionality to test for differential APA usage using alignment files and APA annotations.

```r
# bamTreatment/bamControl: lists of paths to BAM files
# apaAnno: path to APA annotation file
apa_results <- apaUsage(bamTreatment, bamControl, apaAnno)
```

## Visualization and Quality Control

### Signal vs. Noise Distribution
Examine the distribution of observed signals and background noise, typically in LogTPM units.

```r
# Requires gene length information
XBplot(xb_data, Samplenum = 1, unit = "LogTPM", Genelength = gene_lengths)
```

### Dispersion and MA Plots
Visualize the dispersion fit and the results of the DE test.

```r
# Plot SCV estimates
plotSCVEsts(xb_data)

# MA plot of results
MAplot(results, padj = FALSE, pcuff = 0.01, lfccuff = 1)
```

## Implementation Tips

*   **Read Counting**: You must run read-counting twice (once for exons, once for background regions) using tools like `featureCounts`, `HTSeq`, or `summarizeOverlaps`.
*   **Background Annotations**: Background regions should ideally have the same structure or length as the exonic regions of the gene.
*   **Intron Retention**: XBSeq treats reads from retained introns as background noise, as these transcripts are often degraded via Nonsense-mediated mRNA decay (NMD).
*   **Library Size**: If `libsize` is not provided to `XBplot`, it defaults to the sum of exonic reads.

## Reference documentation

- [Differential expression and apa usage analysis of count data using XBSeq package](./references/XBSeq.Rmd)
- [Differential expression and apa usage analysis of count data using XBSeq package](./references/XBSeq.md)