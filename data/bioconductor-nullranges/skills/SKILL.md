---
name: bioconductor-nullranges
description: This tool generates null hypothesis genomic ranges by matching covariates or performing block bootstrapping to preserve biological properties. Use when user asks to perform covariate-matched sampling with matchRanges, generate random null sets using bootRanges, or maintain genomic architecture during hypothesis testing.
homepage: https://bioconductor.org/packages/release/bioc/html/nullranges.html
---

# bioconductor-nullranges

name: bioconductor-nullranges
description: Expert guidance for the Bioconductor package 'nullranges' to generate null hypothesis genomic ranges. Use this skill when you need to perform covariate-matched sampling (matchRanges) or block bootstrapping (bootRanges) for genomic features like ChIP-seq peaks, ATAC-seq bins, or chromatin interactions (GInteractions).

# bioconductor-nullranges

## Overview
The `nullranges` package provides tools for generating null sets of genomic ranges that maintain specific biological or statistical properties of a focal set. It primarily addresses two workflows:
1.  **Covariate Matching (`matchRanges`)**: Selecting a subset from a background pool that matches the focal set's covariate distributions (e.g., matching loop anchors to non-anchors based on GC content or DNase signal).
2.  **Block Bootstrapping (`bootRanges`)**: Generating random genomic null sets by sampling blocks of ranges, preserving local genomic architecture and inter-range distances.

## Covariate Matching with matchRanges

Use `matchRanges()` when you have a "focal" set (e.g., hits) and a "pool" set (e.g., background) and want to select a control set with similar characteristics.

### Basic Workflow
```r
library(nullranges)

# focal: ranges of interest; pool: background ranges to sample from
mgr <- matchRanges(focal = focal_gr, 
                   pool = pool_gr, 
                   covar = ~feature1 + feature2,
                   method = "stratified", # or "nearest", "rejection"
                   replace = FALSE)

# Access the matched set
matched_gr <- matched(mgr)
```

### Matching Methods
-   **stratified**: (Default) Bins propensity scores and samples; robust for most cases.
-   **nearest**: Fast rolling-join matching; best for very large datasets (usually requires `replace = TRUE`).
-   **rejection**: Probability-based sampling; fast for sampling without replacement on large data.

### Quality Control
Always assess the balance of covariates after matching:
```r
# Text summary of means/SDs across sets
overview(mgr)

# Visual checks
plotPropensity(mgr, sets = c('f', 'm', 'p'))
plotCovariate(mgr, covar = "feature1", sets = c('f', 'm', 'p'))
```

## Block Bootstrapping with bootRanges

Use `bootRanges()` to generate null sets that preserve the clustering and spacing of your original ranges.

### Basic Workflow
```r
# blockLength: size of genomic chunks to shuffle
# R: number of bootstrap iterations
boots <- bootRanges(ranges, blockLength = 5e5, R = 100)

# Result is a BootRanges object (GRanges subclass) with an 'iter' column
```

### Segmented Bootstrapping
For whole-genome analysis, it is recommended to use a **segmentation** (e.g., based on gene density) to account for genomic heterogeneity.
```r
# Use pre-built hg38 segmentation from ExperimentHub
library(ExperimentHub)
eh <- ExperimentHub()
seg <- eh[["EH7307"]] 

# Bootstrap within segments
boots <- bootRanges(ranges, blockLength = 5e5, R = 50, seg = seg)
```

### Integration with plyranges
`nullranges` is designed to work with `plyranges` for tidy analysis.
```r
library(plyranges)

# Calculate overlaps for each bootstrap iteration
boot_stats <- x_ranges %>% 
  join_overlap_inner(boots) %>%
  group_by(iter) %>%
  summarize(n_overlaps = n())
```

## Working with Chromatin Interactions
`matchRanges` supports `GInteractions` objects (from the `InteractionSet` package), allowing you to match bin-pairs based on distance and anchor signal.
```r
mgi <- matchRanges(focal = focal_gi, 
                   pool = pool_gi, 
                   covar = ~distance + anchor_signal)
```

## Tips for Efficiency
-   **Filtering**: Filter the `pool` set to a reasonable size before matching to save memory.
-   **Metadata**: Only keep essential metadata columns in the input ranges; `bootRanges` replicates metadata `R` times, which can lead to high memory usage.
-   **Exclusion**: Use `exclude` regions (e.g., ENCODE blacklists) in `bootRanges` to avoid placing null ranges in unmappable areas.

## Reference documentation
- [Introduction to bootRanges](./references/bootRanges.md)
- [Introduction to matchRanges](./references/matchRanges.md)
- [Case study II: CTCF orientation (Rmd)](./references/matching_ginteractions.Rmd)
- [Case study II: CTCF orientation (md)](./references/matching_ginteractions.md)
- [Case study I: CTCF occupancy (Rmd)](./references/matching_granges.Rmd)
- [Case study I: CTCF occupancy (md)](./references/matching_granges.md)
- [Matching Pool Set](./references/matching_pool_set.md)
- [Matching Ranges Tutorial](./references/matching_ranges.Rmd)
- [Main nullranges Vignette (Rmd)](./references/nullranges.Rmd)
- [Main nullranges Vignette (md)](./references/nullranges.md)
- [Segmented Bootstrapping](./references/segmented_boot_ranges.Rmd)
- [Unsegmented Bootstrapping](./references/unseg_boot_ranges.Rmd)