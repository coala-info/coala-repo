---
name: bioconductor-motif2site
description: This tool detects transcription factor binding sites by integrating DNA sequence motifs with ChIP-seq data. Use when user asks to identify binding sites from motifs or BED files, recenter sites across experiments, or perform differential binding analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/Motif2Site.html
---

# bioconductor-motif2site

name: bioconductor-motif2site
description: Detect transcription factor binding sites by integrating DNA sequence motifs with ChIP-seq data. Use this skill when you need to identify, recenter, and compare binding sites across different experiments or conditions using the Motif2Site R package.

# bioconductor-motif2site

## Overview

Motif2Site is a Bioconductor package designed to detect transcription factor binding sites (TFBS) by combining DNA sequence motif information with ChIP-seq alignment data. Unlike standard peak callers that identify broad regions of enrichment, Motif2Site uses motifs as anchors and ChIP-seq signal to statistically validate and precisely locate binding events. It employs negative binomial distributions (via edgeR) for modeling counts and mixture models (via mixtools) to deconvolve closely spaced binding sites.

## Core Workflows

### 1. Motif Selection and Validation
Before detecting sites, evaluate the quality of your motif or bed files against known high-confidence regions.

```r
library(Motif2Site)

# Compare DNA strings with different mismatch tolerances
comp <- compareMotifs2UserProvidedRegions(
    givenRegion = high_confidence_granges,
    motifs = c("TGATTSCAGGANT", "TGATTCCAGGANT"),
    mismatchNumbers = c(1, 0),
    genome = "Scerevisiae",
    genomeBuild = "sacCer3"
)

# Compare existing BED files
comp_bed <- compareBedFiless2UserProvidedRegions(
    givenRegion = high_confidence_granges,
    bedfiles = c("path/to/file1.bed", "path/to/file2.bed"),
    motifnames = c("Motif1", "Motif2")
)
```

### 2. Detecting Binding Sites
You can detect sites using either a BED file of candidate regions or a DNA sequence motif.

**Using a BED file:**
```r
stats <- DetectBindingSitesBed(
    BedFile = "candidate_motifs.bed",
    IPfiles = c("IP_rep1.bam", "IP_rep2.bam"),
    BackgroundFiles = c("Input_rep1.bam", "Input_rep2.bam"),
    genome = "Ecoli",
    genomeBuild = "20080805",
    DB = "NCBI",
    expName = "MyExperiment",
    format = "BAM" # Supports BAM, BEDSE (Single End), BEDPE (Paired End)
)
```

**Using a DNA String:**
```r
stats <- DetectBindingSitesMotif(
    motif = "GWWTGAGAA",
    mismatchNumber = 1,
    IPfiles = ip_files,
    BackgroundFiles = input_files,
    genome = "Ecoli",
    genomeBuild = "20080805",
    DB = "NCBI",
    expName = "MyExperiment_String",
    GivenRegion = optional_granges_to_limit_search
)
```

### 3. Combining and Comparing Experiments
Combine results from multiple conditions into a unified matrix and perform differential binding analysis.

**Recenter and Combine:**
```r
# Combines results from previous DetectBindingSites runs
corMAT <- recenterBindingSitesAcrossExperiments(
    expLocations = c("Exp_Condition1", "Exp_Condition2"),
    experimentNames = c("Cond1", "Cond2"),
    expName = "Combined_Analysis"
)
```

**Differential Binding:**
```r
# Uses edgeR TMM normalization and GLM test
diff_results <- pairwisDifferential(
    tableOfCountsDir = "Combined_Analysis",
    exp1 = "Cond1",
    exp2 = "Cond2",
    FDRcutoff = 0.05,
    logFCcuttoff = 1
)
# Returns a list: [[1]] Up in exp1, [[2]] Up in exp2, [[3]] Full table
```

## Key Parameters and Tips

- **Input Formats**: `format` argument accepts "BAM", "BEDSE" (Single End), and "BEDPE" (Paired End).
- **Genome Builds**: Ensure the `genomeBuild` and `DB` (e.g., "UCSC", "NCBI") match the BSgenome package installed.
- **Output Structure**: Functions like `DetectBindingSitesMotif` create a directory named after `expName` containing the results.
- **Filtering**: The `recenterBindingSitesAcrossExperiments` function uses a default stringent FDR of 0.001 to ensure high-quality combined sites.
- **Efficiency**: Use the `GivenRegion` parameter in `DetectBindingSitesMotif` to restrict the search to specific chromosomes or regions, significantly speeding up processing.

## Reference documentation

- [Motif2Site](./references/Motif2Site.md)
- [Motif2Site.Rmd](./references/Motif2Site.Rmd)