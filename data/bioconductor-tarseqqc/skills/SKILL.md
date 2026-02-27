---
name: bioconductor-tarseqqc
description: TarSeqQC performs quality control and exploration of targeted sequencing experiments by analyzing coverage and read counts for genomic features. Use when user asks to evaluate targeted sequencing panel performance, calculate coverage for BED regions, identify low-coverage features, or visualize read profiles and nucleotide percentages for specific amplicons.
homepage: https://bioconductor.org/packages/3.5/bioc/html/TarSeqQC.html
---


# bioconductor-tarseqqc

name: bioconductor-tarseqqc
description: Quality control and exploration of Targeted Sequencing (TS) experiments. Use this skill to analyze BAM, BED, and FASTA files from targeted sequencing panels (e.g., amplicon sequencing, cancer panels) to evaluate coverage, read counts, and pool performance.

# bioconductor-tarseqqc

## Overview

TarSeqQC is an R/Bioconductor package designed for the quality control (QC) and fast exploration of Targeted Sequencing experiments. It models experiments using the `TargetExperiment` class (for single samples) and `TargetExperimentList` (for multiple samples). The package calculates coverage and read counts for targeted regions (features) and provides graphical tools to detect library preparation issues, sequencing errors, and pool-specific biases.

## Core Workflow: Single Sample

### 1. Initialization
To begin, you need a BED file (defining features), a BAM file (alignments), and a FASTA file (reference genome).

```r
library(TarSeqQC)
library(BiocParallel)

# Define file paths
bedFile <- "path/to/targets.bed"
bamFile <- "path/to/reads.bam"
fastaFile <- "path/to/genome.fa"

# Check file consistency before building object
checkBedFasta(bedFile, fastaFile)

# Create TargetExperiment object
# attribute can be "coverage" or "medianCounts"
myPanel <- TargetExperiment(bedFile, bamFile, fastaFile, 
                            feature="amplicon", 
                            attribute="coverage", 
                            BPPARAM=bpparam())
```

### 2. Early Exploration
Quickly summarize the sequencing performance at the feature or gene level.

```r
# Summary statistics
summary(myPanel)
summaryGeneLev(myPanel)

# Plot attribute distribution (density + boxplot)
plotAttrExpl(myPanel, level="feature", join=TRUE)

# Check "on-target" vs "off-target" read frequencies
freqs <- readFrequencies(myPanel)
plotInOutFeatures(freqs)
```

### 3. Quality Control Analysis
Define thresholds to categorize performance and visualize the entire panel.

```r
# Define coverage intervals for QC
thresholds <- c(0, 1, 50, 200, 500, Inf)

# Circular histogram of the whole panel
plot(myPanel, attributeThres=thresholds, chrLabels=TRUE)

# Bar plot of feature performance
plotFeatPerform(myPanel, thresholds, complete=TRUE)

# Identify low-coverage features
lowCts <- getLowCtsFeatures(myPanel, level="feature", threshold=50)
```

### 4. Nucleotide-Level Exploration
Examine specific regions or features to identify potential variants or sequencing artifacts.

```r
# Plot read profile for a specific feature
plotFeature(myPanel, featureID="AMPL20")

# Plot nucleotide percentages for a feature
plotNtdPercentage(myPanel, featureID="AMPL20")
```

## Multi-Sample Analysis

Use `TargetExperimentList` to compare multiple samples sequenced with the same BED file.

```r
# Combine TargetExperiment objects into a list
panelList <- list(sample1=te1, sample2=te2)

# Create the list object
TEList <- TargetExperimentList(TEList=panelList, 
                               feature="amplicon", 
                               attribute="coverage")

# Heatmap comparison of all samples
plot(TEList, attributeThres=thresholds, sampleLabs=TRUE)

# Compare pool performance across samples
plotPoolPerformance(TEList, dens=TRUE)
```

## Reporting

Generate a comprehensive Excel report containing summary statistics and a QC plot.

```r
buildReport(myPanel, thresholds, imageFile="qc_plot.pdf", file="QC_Results.xlsx")
```

## Tips and Troubleshooting
- **Unmapped Reads**: If the BAM file contains unmapped reads, use `scanBamFlag(isUnmappedQuery = FALSE)` within `ScanBamParam` to avoid errors during object construction.
- **Pool Information**: Ensure your BED file has a "pool" column if you want to analyze PCR pool-specific performance.
- **File Paths**: If loading a saved `TargetExperiment` object, you must re-define the BAM and FASTA paths using `setBamFile()` and `setFastaFile()` before running nucleotide-level plots.

## Reference documentation
- [TarSeqQC: Targeted Sequencing Experiment Quality Control](./references/TarSeqQC-vignette.md)