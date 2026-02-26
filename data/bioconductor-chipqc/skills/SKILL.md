---
name: bioconductor-chipqc
description: Bioconductor-chipqc performs quality control analysis and generates metrics for ChIP-seq datasets. Use when user asks to evaluate ChIP-seq experiment quality, calculate metrics like FRiP and SSD, or generate comprehensive quality control reports and visualizations from BAM and peak files.
homepage: https://bioconductor.org/packages/release/bioc/html/ChIPQC.html
---


# bioconductor-chipqc

name: bioconductor-chipqc
description: Quality control analysis for ChIP-seq data. Use this skill when you need to evaluate the quality of ChIP-seq experiments, including calculating metrics like FRiP, SSD, and cross-coverage, or generating summary reports and heatmaps from BAM and peak files.

# bioconductor-chipqc

## Overview
The `ChIPQC` package automates the generation of quality control metrics for ChIP-seq datasets. It evaluates sample quality by analyzing read distribution, enrichment, and duplication levels. It is designed to work with aligned reads (BAM files) and identified peaks (BED files), providing both per-sample metrics and experiment-wide comparisons to identify outliers or failed experiments.

## Core Workflow

### 1. Data Preparation
`ChIPQC` requires a sample sheet (CSV format) to organize metadata.
- **Required Columns**: `SampleID`, `Tissue`, `Factor`, `Condition`, `Replicate`, `bamReads`, `Peaks`.
- **Optional Columns**: `ControlID`, `bamControl`.

```r
library(ChIPQC)
# Load the experiment based on the sample sheet
experiment = ChIPQC(samples = "samplesheet.csv", annotation = "hg19")
```

### 2. Quality Metrics Analysis
Once the `ChIPQCexperiment` object is created, you can extract specific metrics:
- **QCsummary(experiment)**: Returns a table with primary metrics (Reads, Map%, Filter%, Dup%, FragLen, SSD, FragLenCrossCorr, RelativeCrossCorr, FRiP).
- **regi(experiment)**: Shows read distribution across genomic features (promoters, exons, etc.).

### 3. Visualizing Results
`ChIPQC` provides several plotting functions to assess data quality:
- **plotCC(experiment)**: Cross-coverage DNA profiles (checks for fragment length peaks).
- **plotCoverageHist(experiment)**: Histogram of coverage (checks for enrichment).
- **plotPrincomp(experiment)**: PCA plot based on correlation of peak profiles.
- **plotFrip(experiment)**: Barplot of Fraction of Reads in Peaks.
- **plotSSD(experiment)**: Barplot of SSD scores (measures "pile-up" or signal strength).

### 4. Generating Reports
To create a comprehensive HTML report containing all metrics and plots:
```r
ChIPQCreport(experiment, reportName="ChIP_QC_Report", reportFolder="ChIPQCreport")
```

## Key Metrics Interpretation
- **SSD**: High SSD indicates high enrichment (good for transcription factors), but very high SSD in inputs may indicate artifacts.
- **FRiP**: Fraction of Reads in Peaks. Higher values (e.g., >5%) generally indicate better enrichment.
- **Relative Cross-Coverage (RCC)**: Should be >1; values significantly higher than 1 indicate good signal-to-noise ratio.
- **PCA**: Replicates should cluster together; samples should ideally cluster by Factor or Tissue.

## Tips
- **Annotation**: Ensure the `annotation` parameter in `ChIPQC()` matches your genome (e.g., "hg38", "mm10"). If using a custom genome, provide a `GRanges` object.
- **Parallel Processing**: `ChIPQC` can be computationally intensive. It uses `BiocParallel` if configured.
- **Blacklists**: Use the `blacklist` parameter in `ChIPQC()` to exclude known problematic regions (e.g., ENCODE blacklisted regions) to improve metric accuracy.

## Reference documentation
- [ChIPQC Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/ChIPQC.html)