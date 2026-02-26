---
name: r-kaos
description: This tool encodes biological or symbolic sequences into Chaos Game Representation (CGR) and Frequency Matrix Chaos Game Representation (FMCGR) for visualization and numerical analysis. Use when user asks to transform sequences into 2D spatial distributions, generate k-mer frequency matrices, or visualize sequence patterns using CGR plots and heatmaps.
homepage: https://cran.r-project.org/web/packages/kaos/index.html
---


# r-kaos

name: r-kaos
description: Use for encoding biological or symbolic sequences using Chaos Game Representation (CGR) and Frequency Matrix Chaos Game Representation (FMCGR) in R. This skill is ideal for visualizing sequence patterns, generating numerical descriptors for sequences, and preparing sequence data for machine learning or comparative genomics.

## Overview
The `kaos` package implements Chaos Game Representation (CGR) and Frequency Matrix Chaos Game Representation (FMCGR). These techniques transform sequences (like DNA, RNA, or proteins) into a 2D spatial distribution or a frequency matrix, capturing the local and global patterns of the sequence in a compact numerical or visual format.

## Installation
```R
install.packages("kaos")
library(kaos)
```

## Core Functions

### Chaos Game Representation (CGR)
The `cgr` function calculates the coordinates for each element in the sequence within a unit square.
- `cgr(data, seq.base = NULL, res = 100)`
- **data**: A character vector or string representing the sequence.
- **seq.base**: The alphabet of the sequence (e.g., `c("A", "C", "G", "T")`). If NULL, it is inferred from the data.
- **res**: Resolution of the representation.

### Frequency Matrix CGR (FMCGR)
The `fmcgr` function generates a k-mer frequency matrix mapped onto the CGR space.
- `fmcgr(data, k = 1, seq.base = NULL)`
- **k**: The length of the k-mer to consider for frequency counting.

### Visualization
The package provides dedicated plotting functions that utilize `ggplot2`.
- `cgr_plot(cgr_obj)`: Visualizes the point distribution of a CGR object.
- `fmcgr_plot(fmcgr_obj)`: Visualizes the density/frequency matrix as a heatmap.

## Workflows

### Basic Sequence Encoding and Plotting
```R
library(kaos)

# Define a sequence
sequence <- "ATGCATGCATGCATGC"

# Generate CGR
my_cgr <- cgr(sequence)

# Plot CGR
cgr_plot(my_cgr)

# Generate Frequency Matrix CGR (k-mer = 2)
my_fmcgr <- fmcgr(sequence, k = 2)

# Plot FMCGR
fmcgr_plot(my_fmcgr)
```

### Working with Custom Alphabets
For non-DNA sequences (e.g., proteins or text), explicitly define the `seq.base`.
```R
prot_seq <- "MKWVTFISLLFLFSSAYS"
prot_base <- c("A", "R", "N", "D", "C", "Q", "E", "G", "H", "I", 
               "L", "K", "M", "F", "P", "S", "T", "W", "Y", "V")

prot_cgr <- cgr(prot_seq, seq.base = prot_base)
cgr_plot(prot_cgr)
```

## Tips
- **Memory Efficiency**: For very long sequences, `fmcgr` is often more useful for downstream statistical analysis than the raw point coordinates from `cgr`.
- **K-mer Selection**: Increasing `k` in `fmcgr` provides higher resolution but increases the matrix size exponentially ($alphabet\_size^k$).
- **Data Extraction**: The objects returned by `cgr` and `fmcgr` contain data frames (e.g., `my_cgr$matrix`) that can be used directly in other R functions or machine learning pipelines.

## Reference documentation
- [kaos: Encoding of Sequences Based on Frequency Matrix Chaos Game Representation](./references/home_page.md)