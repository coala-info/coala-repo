---
name: bioconductor-msqc1
description: The bioconductor-msqc1 package provides datasets and tools for benchmarking the performance and retention time stability of targeted proteomics workflows across multiple mass spectrometry platforms. Use when user asks to evaluate quantitative accuracy, normalize retention times across instruments, or visualize peptide elution stability using MSQC1 standard data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/msqc1.html
---


# bioconductor-msqc1

## Overview
The `msqc1` package provides a standardized dataset and tools for evaluating the performance of targeted proteomics workflows across multiple mass spectrometry platforms (e.g., QExactive, QTRAP, TripleTOF, TSQVantage). It is primarily used to benchmark quantitative accuracy, precision, and retention time stability using a commercial standard (MSQC1 Sigma mix) in a complex yeast matrix.

## Core Datasets
The package contains three primary data objects:
- `msqc1_8rep`: Data from eight technical replicates across five platforms.
- `msqc1_dil`: A dilution series covering three orders of magnitude.
- `peptides`: A reference table of the 14 MSQC1 peptides and their properties.

```r
library(msqc1)
data(msqc1_8rep)
data(msqc1_dil)
data(peptides)
```

## Retention Time Normalization
Retention times (RT) vary significantly between LC-MS platforms. The package uses a linear model to map RTs from various instruments to a reference platform (typically QTRAP).

### 1. Reshape Data
Prepare the training data by reshaping from long to wide format.
```r
# Training data for 8 replicates
S.training.8rep <- msqc1:::.reshape_rt(msqc1_8rep, peptides = peptides)
```

### 2. Normalize RT
Apply the normalization function which builds a linear model (`lm`) and scales values to [0, 1].
```r
# Normalize 8-replicate data using QTRAP as reference
msqc1_8rep.norm <- msqc1:::.normalize_rt(msqc1_8rep, 
                                         S.training.8rep, 
                                         reference_instrument = 'Retention.Time.QTRAP')
```

## Visualization Workflows

### Retention Time Stability
Visualize how peptides elute across different replicates or dilution points.
```r
# Plot raw or normalized RT for 8 replicates
msqc1:::.plot_rt_8rep(msqc1_8rep.norm, peptides = peptides, xlab = 'Replicate Id')

# Plot RT for dilution series
msqc1:::.plot_rt_dil(msqc1_dil, peptides = peptides, ylab = 'Raw Retention Time')
```

### Quantitative Performance
Evaluate the stability of Light:Heavy (L:H) ratios.
```r
# Generate data for a Volcano Plot to see fold-change vs p-value
S.volcano <- msqc1:::.shape_for_volcano(S = msqc1_8rep, peptides = peptides)

# Setup figure and plot
msqc1:::.figure_setup()
lattice::xyplot(-log(p.value, 10) ~ log2FC | instrument, data = S.volcano, 
                group = Peptide.Sequence)
```

## Usage Tips
- **Internal Functions**: Many core processing and plotting functions are internal (prefixed with `:::`). Use them to replicate the standardized analysis pipeline described in the package vignettes.
- **Platform Comparison**: Use the `instrument` column in the data frames to subset or facet analyses when comparing SRM, PRM, and DIA performance.
- **Peptide Filtering**: When working with raw data, it is often necessary to filter for specific fragment ions (e.g., `grep("[by]", Fragment.Ion)`) before aggregation.

## Reference documentation
- [LC Observations - Retention Time Stability](./references/chromatography.md)
- [A Mass Spec Data set for Targeted Proteomics Performance Evaluation](./references/msqc1.md)
- [Targeted Proteomics Performance Poster](./references/poster.md)