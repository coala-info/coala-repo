---
name: bioconductor-imetagene
description: Imetagene provides a graphical and programmatic interface for analyzing and plotting the enrichment of DNA-interacting proteins over specific genomic regions. Use when user asks to analyze protein enrichment from BAM files, generate metagene plots with confidence intervals, or use an interactive interface for the metagene package.
homepage: https://bioconductor.org/packages/3.8/bioc/html/Imetagene.html
---


# bioconductor-imetagene

## Overview

`Imetagene` provides a graphical and programmatic interface for the `metagene` package. It allows users to analyze the enrichment of DNA-interacting proteins (from BAM files) over specific genomic regions (from BED files). The package uses bootstrapping to estimate mean enrichment and confidence intervals, providing statistically robust metagene plots.

The workflow typically follows four stages:
1. **Input**: Loading BAM/BED files or existing metagene objects.
2. **Design**: Defining relationships between ChIP samples and controls.
3. **Matrix**: Calculating coverage matrices and binning data.
4. **Plot**: Generating enrichment profiles with `ggplot2`.

## Core Workflow

### 1. Initialization and Input
To start an analysis, you must provide indexed BAM files and genomic regions in BED, narrowPeak, or broadPeak format.

```r
library(Imetagene)

# Launch the interactive Shiny interface
# imetagene()

# Programmatic initialization (via underlying metagene logic)
# Note: Imetagene is primarily a wrapper for the metagene package functionality
# BAM files must have corresponding .bai indexes in the same directory.
```

### 2. Experimental Design
A design defines which BAM files are "ChIP" (1), "Control" (2), or "Ignore" (0). This allows for background subtraction and replicate merging.

*   **Format**: A tab-delimited file or data frame where the first column contains BAM filenames and subsequent columns represent experiments.
*   **Usage**: Loading a design allows `metagene` to combine replicates and normalize signal against controls.

### 3. Matrix Generation
Coverage must be converted into a matrix where rows are regions and columns are binned positions.

*   **Binning**: Use `bin_count` (default 100) to reduce computation time and smooth the profile.
*   **Normalization**: If a design is provided, the matrix step handles background signal removal.

### 4. Plotting
Plots are generated using `ggplot2` and show the mean enrichment with a ribbon representing the confidence interval (calculated via bootstrap).

*   **Parameters**:
    *   `Regions to display`: Filter by the names of the BED files/regions used.
    *   `Experiments to display`: Filter by the experiment names defined in your design.

## Tips for Success
*   **Indexing**: Ensure all BAM files have a `.bai` index. `file.bam` requires `file.bam.bai`.
*   **Memory**: While there is no hard limit on BAM files, large numbers of files or very large BED files can lead to memory exhaustion during matrix generation.
*   **Object Persistence**: You can save the `metagene` object as an `.RData` file at any stage (after input, design, or matrix generation) to resume work later.

## Reference documentation
- [Imetagene: the interactive interface for metagene](./references/imetagene.Rmd)
- [Imetagene Vignette](./references/imetagene.md)