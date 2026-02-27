---
name: bioconductor-massarray
description: This tool analyzes MassArray data for DNA methylation and SNP detection. Use when user asks to design amplicons, evaluate bisulphite conversion efficiency, import Sequenom EpiTyper data, visualize methylation patterns, or identify SNPs.
homepage: https://bioconductor.org/packages/release/bioc/html/MassArray.html
---


# bioconductor-massarray

name: bioconductor-massarray
description: Analysis of MassArray data for DNA methylation and SNP detection. Use this skill to design amplicons, evaluate bisulphite conversion efficiency, import Sequenom EpiTyper data, visualize methylation patterns, and identify potential SNPs in mass spectrometry data.

# bioconductor-massarray

## Overview

The `MassArray` package provides tools for the quantitative analysis of DNA methylation and Single Nucleotide Polymorphisms (SNPs) using mass spectrometry of base-specific cleavage reactions (Sequenom workflow). It allows for in silico prediction of fragmentation patterns, quality control of bisulphite conversion, and visualization of methylation levels across amplicons.

## Core Workflows

### 1. In Silico Amplicon Prediction
Before performing experiments, use `ampliconPrediction()` to evaluate how a sequence will fragment and which CG sites are measurable.

```r
library(MassArray)
# Predict fragmentation for a sequence
# Use '>' and '<' to denote primers, and '(CG)' to highlight specific sites
sequence <- "AAAA>TTTTCCCCTCTGCGTGAGAGAGTTGTC(CG)AC<AAAA"
results <- ampliconPrediction(sequence)

# results$summary shows measurability across T/C reactions on +/- strands
```

### 2. Data Import
Data must be exported from Sequenom’s EpiTyper as a tab-delimited text file. Ensure "Matched Peaks", "Show All Matched Peaks", and "Show All Missing Peaks" are enabled during export.

```r
# Define the amplicon sequence (including primers and tags)
sequence <- "CCAGGTCCAA..." 
# Create MassArrayData object
data <- new("MassArrayData", sequence, file="Example.txt")
```

### 3. Conversion Control Evaluation
To ensure bisulphite conversion is complete, the package searches for non-CG cytosines in fragments that do not contain CGs.

```r
# Automatically handled during data import, but can be inspected
# Fragments meeting criteria (no CG, contains TG, in mass window) are flagged green
# Use evaluateConversion() to check levels
```

### 4. Data Visualization
The package provides bar-plot visualizations (epigrams) for methylation levels.

```r
# Plot individual samples
plot(data, collapse=FALSE, bars=FALSE, scale=FALSE)

# Plot averaged data with error bars (Median Absolute Deviation)
plot(data, collapse=TRUE, bars=TRUE, scale=FALSE)

# Plot scaled to relative nucleotide position
plot(data, collapse=TRUE, bars=FALSE, scale=TRUE)
```
*   **Yellow background**: CGs located on the same fragment (cannot be resolved independently).
*   **Red stars**: User-defined "required" sites.
*   **Gray outline**: CG sites outside the usable mass window.

### 5. SNP Detection
Identify potential SNPs that interfere with methylation readings by comparing expected vs. observed fragmentation patterns.

```r
# Identify putative SNPs
SNP.results <- evaluateSNPs(data)

# SNP.results contains:
# - SNP: position and base change (e.g., "312:G")
# - SNP.quality: Likelihood score (0 to 2)
# - samples: which samples contain the novel peak
```

## Key Classes
*   `MassArrayData`: The primary container for an experiment (sequence + peak data).
*   `MassArrayFragment`: Describes individual fragments and their CG content.
*   `MassArrayPeak`: Contains specific mass spectrometry peak information.

## Reference documentation

- [MassArray Analytical Tools](./references/MassArray.md)