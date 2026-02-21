---
name: bioconductor-katdetectr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/katdetectr.html
---

# bioconductor-katdetectr

name: bioconductor-katdetectr
description: Detection, characterization, and visualization of localized hypermutated regions (kataegis) in genomic data. Use this skill when analyzing somatic mutations (VCF, MAF, or VRanges) to identify clusters of high mutation density using changepoint detection.

# bioconductor-katdetectr

## Overview

The `katdetectr` package provides a robust framework for identifying "kataegis"—localized areas of hypermutation—within genomic datasets. It utilizes changepoint detection on intermutation distances (IMD) to segment the genome and identify regions where the mutation rate significantly exceeds the background. The package is integrated into the Bioconductor ecosystem, working seamlessly with standard genomic objects like `VRanges` and `GRanges`.

## Core Workflow

### 1. Data Import
Load genomic variants from VCF or MAF files, or use existing `VRanges` objects.

```r
library(katdetectr)

# From VCF
vcf_path <- "path/to/variants.vcf"
# From MAF
maf_path <- "path/to/variants.maf"

# Synthetic data generation for testing
synthetic_data <- generateSyntheticData(nBackgroundVariants = 2500, nKataegisFoci = 2)
```

### 2. Detecting Kataegis
The `detectKataegis()` function is the primary tool for analysis. It calculates IMD, performs changepoint analysis (PELT method by default), and identifies foci based on size and distance thresholds.

```r
# Basic detection
# Use aggregateRecords = TRUE for MAF files with multiple samples
results <- detectKataegis(genomicVariants = vcf_path)

# Parameters:
# minSizeKataegis: Minimum number of variants in a cluster (default: 6)
# IMDcutoff: Maximum average intermutation distance (default: 1000 bp)
```

### 3. Accessing Results
Results are stored in a `KatDetect` S4 object. Use getter functions to extract specific data:

*   `getKataegisFoci(results)`: Returns a `GRanges` object of identified kataegis regions.
*   `getGenomicVariants(results)`: Returns a `VRanges` object with IMD and kataegis status for every variant.
*   `getSegments(results)`: Returns a `GRanges` object of all genomic segments identified by changepoint detection.
*   `summary(results)`: Provides a high-level count of variants and foci.

### 4. Visualization
Generate rainfall plots to visualize mutation density and identified segments.

```r
# Standard rainfall plot
rainfallPlot(results)

# Highlight segments and specific sequences
rainfallPlot(results, showSegmentation = TRUE, showSequence = "Kataegis")
```

## Advanced Usage

### Custom IMD Cutoffs
Instead of a fixed 1000bp threshold, you can provide a custom function to calculate dynamic cutoffs based on sample-specific mutation rates.

```r
custom_cutoff_fun <- function(genomicVariants, segments) {
    # Logic to return a numeric vector of cutoffs for each segment
    # Example: return(rep(500, nrow(segments)))
}

results_custom <- detectKataegis(synthetic_data, IMDcutoff = custom_cutoff_fun)
```

### Non-standard Genomes
For genomes other than hg19/hg38, provide a dataframe containing sequence lengths via the `refSeq` argument.

```r
seq_lengths <- data.frame(chr1 = 249250621, custom_contig = 100000)
results_nonstd <- detectKataegis(genomicVariants = my_variants, refSeq = seq_lengths)
```

## Reference documentation

- [Overview of katdetectr](./references/General_overview.md)
- [Vignette Source](./references/General_overview.Rmd)