---
name: bioconductor-doubletrouble
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/doubletrouble.html
---

# bioconductor-doubletrouble

name: bioconductor-doubletrouble
description: Identification and classification of duplicated genes from whole-genome protein sequences. Use this skill to classify gene pairs into duplication modes (segmental, tandem, proximal, transposed, dispersed), calculate substitution rates (Ka, Ks), identify Ks peaks for WGD events, and visualize duplication frequencies and age distributions.

# bioconductor-doubletrouble

## Overview

The `doubletrouble` package provides a comprehensive pipeline for analyzing gene duplication events. It allows users to distinguish between whole-genome duplications (WGD) and various types of small-scale duplications (SSD). The package integrates with the `syntenet` package for synteny detection and `MSA2dist` for calculating substitution rates.

## Typical Workflow

### 1. Data Preparation
Input requires protein sequences (`AAStringSet`), gene annotations (`GRanges`), and optionally CDS sequences (`DNAStringSet`).

```r
library(doubletrouble)
library(syntenet)

# Process input into standardized format
pdata <- process_input(proteome_list, annotation_list)

# Perform intraspecies similarity search (requires DIAMOND)
diamond_intra <- run_diamond(
    seq = pdata$seq,
    compare = "intraspecies",
    outdir = tempdir()
)
```

### 2. Classifying Duplicated Gene Pairs
Use `classify_gene_pairs()` with one of four schemes:

*   **binary**: Segmental (SD) vs Small-scale (SSD).
*   **standard**: SD, Tandem (TD), Proximal (PD), and Dispersed (DD).
*   **extended**: Adds Transposon-derived (TRD). Requires an outgroup in `blast_inter`.
*   **full**: Adds Retrotransposon-derived (rTRD) and DNA-transposon-derived (dTRD). Requires `intron_counts`.

```r
# Standard classification
gene_pairs <- classify_gene_pairs(
    annotation = pdata$annotation,
    blast_list = diamond_intra,
    scheme = "standard"
)

# Assign each gene to a unique mode (hierarchical priority)
unique_genes <- classify_genes(gene_pairs)
```

### 3. Substitution Rates and Ks Peaks
Calculate $K_a$ and $K_s$ to estimate duplication timing and selection pressure.

```r
# Calculate Ka/Ks (requires CDS list)
kaks_rates <- pairs2kaks(gene_pairs, cds_list)

# Find peaks in Ks distribution (GMM fitting)
# npeaks can be a vector to test multiple models; BIC is used for selection
peaks <- find_ks_peaks(kaks_rates$Scerevisiae$Ks, npeaks = c(2, 3))

# Classify pairs by age group based on peaks
age_groups <- split_pairs_by_peak(kaks_rates$Scerevisiae, peaks)
```

### 4. Visualization
The package provides several `ggplot2`-based functions for data exploration.

```r
# Frequency of duplicates
counts <- duplicates2counts(unique_genes)
plot_duplicate_freqs(counts, plot_type = "stack_percent")

# Ks distributions
plot_ks_distro(kaks_rates$Scerevisiae, bytype = TRUE, plot_type = "violin")

# Ks peaks
plot_ks_peaks(peaks)
```

## Key Functions

*   `classify_gene_pairs()`: Core function for identifying duplication modes.
*   `classify_genes()`: Resolves genes appearing in multiple pairs into a single duplication category.
*   `get_intron_counts()`: Helper to count introns from a `TxDb` object (required for "full" scheme).
*   `pairs2kaks()`: Interface for $K_a/K_s$ calculation.
*   `find_ks_peaks()`: Fits Gaussian Mixture Models to $K_s$ data.
*   `duplicates2counts()`: Prepares classification data for plotting.

## Tips for Success

*   **Consistency**: Ensure species names are identical across the protein, annotation, and CDS lists.
*   **Outgroups**: For TRD identification (extended/full schemes), use `make_bidirectional()` and `collapse_bidirectional_hits()` from `syntenet` to prepare the interspecies BLAST/DIAMOND data.
*   **Ks Saturation**: $K_s$ values > 2.0 are often saturated and unreliable for peak calling. Use the `max_ks` parameter in `find_ks_peaks()` to filter them.
*   **Prior Knowledge**: If you know the number of WGD events, specify `npeaks` as a single integer to avoid overclustering.

## Reference documentation

- [Identification and classification of duplicated genes](./references/doubletrouble_vignette.md)