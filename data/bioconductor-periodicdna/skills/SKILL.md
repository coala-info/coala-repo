---
name: bioconductor-periodicdna
description: This package analyzes the periodicity of k-mers in genomic sequences using Fast Fourier Transform to identify structural patterns like nucleosome positioning. Use when user asks to quantify motif periodicity, calculate statistical significance via shuffling, visualize power spectral density, or generate genomic tracks of periodicity strength.
homepage: https://bioconductor.org/packages/release/bioc/html/periodicDNA.html
---

# bioconductor-periodicdna

## Overview

The `periodicDNA` package provides tools to analyze the periodicity of k-mers (short DNA motifs) within genomic sequences. It uses Fast Fourier Transform (FFT) to estimate Power Spectral Density (PSD), allowing researchers to identify structural periodicities like the 10-bp cycle often associated with nucleosome positioning.

## Core Workflow

### 1. Quantifying Periodicity

The primary function `getPeriodicity()` calculates the periodicity of a specific motif within a set of sequences or genomic ranges.

```r
library(periodicDNA)
library(BSgenome.Celegans.UCSC.ce11)

# Using GRanges (requires a BSgenome object)
data(ce11_TSSs)
res <- getPeriodicity(
    ce11_TSSs[['Ubiq.']],
    genome = 'BSgenome.Celegans.UCSC.ce11',
    motif = 'TT',
    BPPARAM = setUpBPPARAM(1)
)

# Using DNAStringSet directly
# res <- getPeriodicity(my_sequences, motif = 'CC')
```

### 2. Statistical Significance via Shuffling

To determine if an observed periodicity is stronger than expected by chance, use the `n_shuffling` argument.

*   **Fold-Change:** Set `n_shuffling` to a small number (e.g., 5-10) to get log2 fold-change (l2FC) over median shuffled background.
*   **P-values:** Set `n_shuffling >= 100` to compute empirical p-values and FDR.

```r
res_sig <- getPeriodicity(
    ce11_TSSs[['Ubiq.']],
    genome = 'BSgenome.Celegans.UCSC.ce11',
    motif = 'TT',
    n_shuffling = 100
)
```

### 3. Visualizing Results

Use `plotPeriodicityResults()` to generate a three-panel diagnostic plot:
1.  **Raw Distogram:** Distribution of pairwise distances between k-mers.
2.  **Normalized Distogram:** Distances corrected for decay and smoothed.
3.  **PSD Plot:** Power spectral density across different periods (look for peaks at specific bp values).

```r
plotPeriodicityResults(res)
```

### 4. Generating Genomic Tracks

To visualize periodicity strength across a genome (e.g., in a genome browser), use `getPeriodicityTrack()`. This calculates the strength for a specific period (e.g., 10 bp) across the provided ranges.

```r
track <- getPeriodicityTrack(
    genome = 'BSgenome.Celegans.UCSC.ce11',
    granges = my_regions,
    motif = 'WW',
    period = 10,
    bw_file = 'periodicity_10bp.bw'
)

# Plot aggregate coverage over multiple sets of regions
plotAggregateCoverage(track, list_of_granges)
```

## Key Functions Reference

*   `getPeriodicity()`: Main analysis function. Returns a list containing `PSD` (raw values) and `periodicityMetrics` (summary table).
*   `getPeriodicityTrack()`: Generates a linear track (RleList or BigWig) of periodicity strength.
*   `plotPeriodicityResults()`: Standard visualization for `getPeriodicity` output.
*   `plotAggregateCoverage()`: Visualizes average periodicity signal across genomic features.
*   `setUpBPPARAM()`: Helper to configure parallel processing for faster computation.

## Tips for Analysis

*   **Motif Selection:** Common motifs for structural analysis include 'TT', 'AA', or 'WW' (A or T).
*   **Period of Interest:** While 10-bp is the biological standard for nucleosomes, the FFT approach will identify any dominant period between 2 and the maximum sequence length.
*   **Normalization:** The package automatically masks the universal 3-bp genomic periodicity and subtracts local averages to normalize for distance decay.

## Reference documentation

- [Introduction to periodicDNA](./references/periodicDNA.Rmd)
- [periodicDNA Vignette](./references/periodicDNA.md)