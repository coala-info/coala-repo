---
name: bioconductor-copynumber
description: This tool performs segmentation and visualization of copy number data to detect genomic gains and losses. Use when user asks to perform single-sample, multi-sample, or allele-specific segmentation, handle outliers via Winsorization, or visualize genomic aberrations through genome plots, heatmaps, and frequency plots.
homepage: https://bioconductor.org/packages/3.5/bioc/html/copynumber.html
---


# bioconductor-copynumber

name: bioconductor-copynumber
description: Analysis of copy number data using the Bioconductor package 'copynumber'. Use this skill to perform single-sample, multi-sample, or allele-specific segmentation (PCF, multiPCF, asPCF), handle outliers via Winsorization, and visualize genomic aberrations through genome plots, heatmaps, circle plots, and frequency plots.

## Overview

The `copynumber` package provides tools for segmenting and visualizing copy number data. It uses penalized least squares minimization to fit piecewise constant curves to log-transformed copy number measurements. This allows for the detection of genomic aberrations (gains and losses) in single samples or across multiple samples simultaneously.

## Data Preparation

Data should be a data frame where:
- Column 1: Chromosome
- Column 2: Genomic position (bp)
- Subsequent columns: Sample copy number measurements (LogR)
- For SNP data: A second data frame for B-allele frequencies (BAF) is required.

```r
library(copynumber)
# Load example data
data(lymphoma)
# Subset data for specific samples
sub_data <- subsetData(data = lymphoma, sample = 1:3)
```

## Workflow

### 1. Preprocessing
Outliers can significantly bias segmentation. Use Winsorization to mitigate extreme values.

```r
# Detect and modify outliers
wins_data <- winsorize(data = sub_data, verbose = FALSE)

# Impute missing values if necessary
imputed_data <- imputeMissing(data = wins_data, method = "pcf")
```

### 2. Segmentation
Choose the segmentation method based on the experimental design:

- **Single-sample (`pcf`)**: Independent segmentation for each sample.
- **Multi-sample (`multipcf`)**: Joint segmentation across samples to find common breakpoints.
- **Allele-specific (`aspcf`)**: Joint segmentation of LogR and BAF data for SNP arrays.

```r
# Single-sample segmentation (gamma controls smoothness)
single_seg <- pcf(data = wins_data, gamma = 12)

# Multi-sample segmentation
multi_seg <- multipcf(data = wins_data, gamma = 12)

# Allele-specific segmentation
# logR and BAF must be provided
allele_seg <- aspcf(logR_data, BAF_data)
```

### 3. Parameter Selection
The `gamma` parameter is critical. Higher values result in fewer segments. Use `plotGamma` to find an optimal value.

```r
# Diagnostic plot for penalty selection
plotGamma(micma, chrom = 17)
```

## Visualization

The package offers several ways to view results:

- **Genome/Sample Plots**: `plotGenome(data, segments, sample = 1)` or `plotSample(data, segments)`.
- **Chromosome Comparison**: `plotChrom(data, segments, chrom = 1)` to compare samples on one chromosome.
- **Frequency Plots**: `plotFreq(segments, thres.gain = 0.2, thres.loss = -0.1)` to see recurrent aberrations.
- **Heatmaps**: `plotHeatmap(segments, upper.lim = 0.3)` for a global view of all samples.
- **Circle Plots**: `plotCircle(segments)` to visualize aberrations and interchromosomal connections.

## Advanced Operations

- **Call Aberrations**: Use `callAberrations(segments, thres.gain = 0.2)` to classify segments as gain, loss, or normal.
- **Select Segments**: Use `selectSegments()` to filter for segments with high variance or specific lengths.
- **Large Data**: For very large datasets, pass the path to a `.txt` file instead of a data frame to the functions; the package will process data chromosome by chromosome to save memory.
- **GRanges**: Convert results using `getGRangesFormat(segments)`.

## Reference documentation

- [An overview of the copynumber package](./references/copynumber.md)