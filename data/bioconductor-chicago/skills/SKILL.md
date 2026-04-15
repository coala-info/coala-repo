---
name: bioconductor-chicago
description: bioconductor-chicago performs statistical analysis of Capture Hi-C data to identify significant looping interactions between genomic regions. Use when user asks to detect significant interactions in CHi-C data, perform background modeling and normalization, or visualize promoter-other end interactions.
homepage: https://bioconductor.org/packages/release/bioc/html/Chicago.html
---

# bioconductor-chicago

name: bioconductor-chicago
description: Statistical analysis of Capture Hi-C (CHi-C) data to detect significant looping interactions. Use this skill when analyzing CHi-C data in R, specifically for data normalization, background modeling (Brownian and technical noise), interaction calling (scoring), and visualizing promoter-other end interactions.

# bioconductor-chicago

## Overview

CHiCAGO (Capture Hi-C Analysis of Genomic Organization) is a specialized pipeline for detecting statistically significant interaction events in Capture Hi-C data. It employs a convolution background model that accounts for distance-dependent Brownian collisions and technical noise. The package produces "scores" which are soft-thresholded -log weighted p-values; a score of $\ge 5$ is the standard threshold for significant interactions.

## Core Workflow

### 1. Experiment Initialization
Define the design directory containing the five required design files (`.rmap`, `.baitmap`, `.npb`, `.nbpb`, `.poe`).

```r
library(Chicago)

# Initialize the chicagoData object
# designDir must contain the 5 precomputed design files
cd <- setExperiment(designDir = "path/to/designFiles", 
                    settingsFile = NULL) # Optional custom settings
```

### 2. Data Loading and Merging
Read `.chinput` files (generated from BAMs via `bam2chicago.sh`). Multiple replicates should be merged at this stage.

```r
files <- c("rep1.chinput", "rep2.chinput")
cd <- readAndMerge(files = files, cd = cd)
```

### 3. Running the Pipeline
The `chicagoPipeline` function executes the full statistical model, including normalization and significance testing.

```r
cd <- chicagoPipeline(cd)
```

### 4. Exporting Results
Results can be exported in multiple formats for visualization or downstream analysis.

```r
# Exports .ibed, .seqmonk.txt, and .washU_text.txt by default
exportResults(cd, outfileprefix = "my_results")
```

## Key Functions and Data Handling

### The chicagoData Object
The object `cd` stores all information. Access components using:
- `intData(cd)`: A `data.table` containing fragment pairs and scores.
- `settings(cd)`: Current experiment settings.
- `params(cd)`: Estimated model parameters.

**Note:** Many functions update `intData(cd)` by reference. Use `newCd <- copyCD(cd)` if you need to preserve the original state.

### Visualization
- `plotBaits(cd, n=16)`: Plots read counts vs. distance for specific or random baits. Significant interactions are highlighted (Red: score > 5, Blue: score > 3).

### Peak Enrichment
Test if interaction "other ends" are enriched for specific genomic features (e.g., H3K4me1 peaks).

```r
# no_bins should be chosen so bin size is ~10kb
enrichmentResults <- peakEnrichment4Features(cd, 
                                             folder = "path/to/features",
                                             list_frag = list(CTCF = "ctcf.bed"),
                                             no_bins = 500)
```

### Downstream Integration
Convert results to `GenomicInteractions` objects for use with other Bioconductor packages.

```r
library(GenomicInteractions)
gi <- exportToGI(cd)
# anchorOne(gi) returns baits, anchorTwo(gi) returns other ends
```

## Analysis Tips
- **Score Threshold:** Use 5 as a stringent threshold for calling interactions.
- **Bait-to-Bait:** In WashU output, bait-to-bait interaction scores are consolidated by taking the maximum of the two possible orientations.
- **Custom Weights:** If working with non-human data or unusual cell types, consider recalibrating p-value weights using the `fitDistCurve.R` script from the `chicagoTools` suite.

## Reference documentation
- [CHiCAGO Vignette](./references/Chicago.md)