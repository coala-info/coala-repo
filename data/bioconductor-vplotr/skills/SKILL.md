---
name: bioconductor-vplotr
description: This R package generates V-plots and footprint profiles to visualize paired-end fragment density and chromatin organization from DNA accessibility data. Use when user asks to generate V-plots, analyze nucleosome positioning, create transcription factor footprint profiles, or visualize fragment size distributions from ATAC-seq or MNase-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/VplotR.html
---


# bioconductor-vplotr

name: bioconductor-vplotr
description: Specialized R package for generating V-plots (two-dimensional paired-end fragment density plots) and footprint profiles from DNA accessibility sequencing data (ATAC-seq, MNase-seq, DNA-seq). Use this skill when analyzing chromatin organization, nucleosome positioning, or transcription factor footprints using paired-end sequencing data in Bioconductor.

# bioconductor-vplotr

## Overview

VplotR is a Bioconductor package designed to visualize and analyze the distribution of paired-end sequencing fragments. Its primary output is the **V-plot**, which maps fragment midpoints relative to a genomic feature (x-axis) against the fragment length (y-axis). This visualization is powerful for identifying nucleosome footprints, sub-nucleosomal fragments, and transcription factor binding patterns.

The package integrates seamlessly with `GenomicRanges` and `ggplot2`, providing a streamlined workflow from BAM files to publication-quality plots.

## Core Workflow

### 1. Data Import
Use `importPEBamFiles()` to load paired-end data. For ATAC-seq, it is standard practice to shift fragments to account for Tn5 transposase insertion geometry.

```r
library(VplotR)
# Import BAM and apply ATAC-seq shift (+4bp/-5bp)
fragments <- importPEBamFiles("path/to/file.bam", shift_ATAC_fragments = TRUE)
```

### 2. Fragment Size Distribution
Before plotting V-plots, check the global fragment size distribution to ensure library quality (e.g., observing the ~147bp nucleosomal peak in MNase-seq).

```r
dist_df <- getFragmentsDistribution(fragments, granges = target_loci)
ggplot(dist_df, aes(x = x, y = y)) + geom_line() + theme_bw()
```

### 3. Generating V-plots
The `plotVmat()` function is the workhorse for 2D density plots. It can handle single samples or lists of samples for comparison.

**Single V-plot:**
```r
p <- plotVmat(x = fragments, granges = target_loci)
print(p)
```

**Multiple V-plots (Parallelized):**
```r
list_params <- list(
    "Sample A" = list(fragments_A, loci_A),
    "Sample B" = list(fragments_B, loci_B)
)
p <- plotVmat(list_params, cores = 4, nrow = 1, ncol = 2)
```

### 4. Normalization Options
Control the `normFun` argument in `plotVmat()` to adjust how density is calculated:
- `'libdepth+nloci'`: (Default) Normalizes by sequencing depth and number of genomic ranges.
- `'zscore'`: Internally z-scores the heatmap.
- `'quantile'`: Scales to a specific quantile (use with `s = 0.99`).
- `'none'`: Raw fragment counts.

### 5. Footprinting and Profiles
- **`plotFootprint()`**: Generates 1D footprint profiles (cut-site density) over aggregated loci.
- **`plotProfile()`**: Visualizes fragment distribution over a specific, individual genomic window (e.g., a single gene or enhancer).

```r
# 1D Footprint
plotFootprint(fragments, target_loci)

# Local window profile with annotations
plotProfile(
    fragments = fragments,
    window = "chrI:1000-2000",
    loci = target_loci,
    annots = gene_models
)
```

## Tips for Success
- **Memory Management**: Importing large BAM files can be memory-intensive. Consider filtering the BAM file to relevant chromosomes or regions before import if working with very large datasets.
- **Loci Orientation**: Ensure your `GRanges` object has correct strand information; `VplotR` uses strand info to orient fragments relative to the feature (e.g., TSS).
- **Smoothing**: `plotVmat()` applies smoothing by default. You can adjust this behavior via internal parameters if the plot appears too blurry or too noisy.

## Reference documentation

- [VplotR Vignette (Rmd)](./references/VplotR.Rmd)
- [VplotR Vignette (Markdown)](./references/VplotR.md)