---
name: bioconductor-dstruct
description: This tool identifies differentially reactive regions in RNA molecules by comparing structurome profiling data across two conditions. Use when user asks to identify structural changes between RNA samples, perform de novo discovery of differentially reactive regions, or test pre-defined regions for structural differences.
homepage: https://bioconductor.org/packages/release/bioc/html/dStruct.html
---


# bioconductor-dstruct

name: bioconductor-dstruct
description: Differential analysis of RNA structurome profiling data (SHAPE-Seq, Structure-Seq, PARS, SHAPE-MaP, DMS-MaPseq). Use this skill to identify differentially reactive regions (DRRs) between two conditions using nucleotide-level normalized reactivities.

# bioconductor-dstruct

## Overview

The `dStruct` package identifies differentially reactive regions in RNA molecules by comparing structurome profiling data across two conditions. It accounts for biological variation between replicates and can identify structural changes *de novo* or test pre-defined regions (guided discovery). It is compatible with any technology that produces nucleotide-resolution reactivity scores.

## Data Preparation

Input data must be a `list` where each element is a `data.frame` representing one RNA transcript.

- **Rows**: Consecutive nucleotides.
- **Columns**: Samples labeled with prefixes `A` and `B` (representing the two conditions) and numeric suffixes starting at `1` (e.g., `A1`, `A2`, `B1`).
- **Values**: Normalized reactivities. Use `NA` for unprobed bases or missing data.
- **Normalization**: If data is not yet normalized, use `twoEightNormalize(reactivities)` for the standard 2-8% method.

## De Novo Discovery

Use `dStructome` to search for differential regions across multiple transcripts simultaneously.

```r
library(dStruct)

# res is an IRanges object
res <- dStructome(
  rl = my_reactivity_list, 
  reps_A = 3,               # Number of replicates in group A
  reps_B = 2,               # Number of replicates in group B
  min_length = 21,          # Minimum length of a differential region
  batches = TRUE,           # Set TRUE if samples are paired by batch
  ind_regions = TRUE,       # Test individual regions for significance
  processes = 1             # Number of cores for parallel processing
)
```

To analyze a single transcript `data.frame` directly, use the `dStruct()` function with the same parameters (passing the dataframe to `rdf`).

## Guided Discovery

Use this mode to test specific pre-defined regions (e.g., known protein binding sites or SNP locations).

```r
# For a single region
result <- dStructGuided(
  rdf = region_dataframe, 
  reps_A = 2, 
  reps_B = 1
)

# For a list of pre-defined regions
res_guided <- dStructome(
  rl = regions_list, 
  reps_A = 2, 
  reps_B = 1, 
  method = "guided"
)
```

## Visualizing Results

The `plotDStructurome` function generates PDF plots of reactivities for identified differential regions.

```r
plotDStructurome(
  rl = my_reactivity_list["Transcript_ID"], 
  diff_regions = subset(res, t == "Transcript_ID"),
  outfile = "DRR_plot", 
  fdr = 0.05, 
  ylim = c(-0.05, 3)
)
```

## Key Parameters and Output

- **del_d**: The median of nucleotide-wise differences between between-group and within-group dissimilarity scores. Higher values indicate stronger structural differences.
- **FDR**: Adjusted p-values. Typically, regions with FDR < 0.05 are considered significant.
- **between_combs / within_combs**: Optional data frames to manually specify sample groupings for dissimilarity calculations if the default automatic regrouping is not desired.

## Reference documentation

- [Differential RNA structurome analysis using dStruct](./references/dStruct.md)
- [dStruct R Markdown Source](./references/dStruct.Rmd)