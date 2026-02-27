---
name: bioconductor-vega
description: Bioconductor-vega segments copy number profiles from array comparative genomic hybridization data using a variational approach. Use when user asks to partition genomic data into regions of constant copy number, identify genomic aberrations, or classify segments as loss, normal, or gain.
homepage: https://bioconductor.org/packages/3.5/bioc/html/Vega.html
---


# bioconductor-vega

## Overview

Vega (Variational Estimator of Genomic Aberrations) is an R package designed to segment copy number profiles from array comparative genomic hybridization (aCGH) data. It uses a variational approach to partition the genome into regions of constant copy number, providing both the mean Log R Ratio (LRR) for each segment and a discrete classification (loss, normal, or gain).

## Installation

Install the package using BiocManager:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Vega")
library(Vega)
```

## Data Preparation

Vega requires a matrix or data frame with four specific columns:
1. **Chromosome**: Chromosome identifier (e.g., "1", "X").
2. **Probe Start Position**: Genomic start coordinate.
3. **Probe End Position**: Genomic end coordinate.
4. **LRR**: The measured Log R Ratio for the probe.

Example using built-in data:
```R
data(G519)
# G519 is a matrix with columns: Chromosome, Start, End, LRR
```

## Running Segmentation

The primary function is `vega()`. It processes the data and returns a segmentation table.

```R
# Segment all chromosomes
seg <- vega(CNVdata = G519, chromosomes = c(1:22, "X", "Y"))

# Segment a specific subset
seg_subset <- vega(CNVdata = G519, chromosomes = c(1, "X"))
```

### Key Parameters
- `beta`: (Default: 0.5) Controls the stop condition of the algorithm.
- `min_region_size`: (Default: 2) Minimum number of probes required to define a segment.
- `out_file_name`: If provided (e.g., "results.txt"), saves the output as a tab-delimited file.

### Interpreting Results
The output object contains:
- **Chromosome**: The chromosome of the segment.
- **bp Start / bp End**: Genomic boundaries.
- **Num of Markers**: Probes within the segment.
- **Mean**: The average LRR value.
- **Label**: The call (-1 for loss, 0 for normal, 1 for gain).

## Visualization

Use `plotSegmentation` to visualize the LRR data alongside the computed segments.

```R
# Plot LRR mean values (opt = 0)
plotSegmentation(G519, seg, chromosomes = c(1), opt = 0)

# Plot discrete labels/calls (opt = 1)
plotSegmentation(G519, seg, chromosomes = c(1), opt = 1)
```

## Reference documentation

- [Vega: Variational Segmentation for Copy Number Detection](./references/Vega.md)