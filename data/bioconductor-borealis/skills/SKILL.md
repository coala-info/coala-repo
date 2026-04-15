---
name: bioconductor-borealis
description: bioconductor-borealis detects outlier DNA methylation sites in bisulfite sequencing data by comparing individual samples against a cohort using a beta-binomial model. Use when user asks to identify differentially methylated loci, run the Borealis pipeline on Bismark outputs, or visualize site-specific methylation deviations.
homepage: https://bioconductor.org/packages/release/bioc/html/borealis.html
---

# bioconductor-borealis

## Overview

Borealis is designed for outlier methylation detection using bisulfite sequencing data (specifically Bismark outputs). Unlike traditional case-control studies, Borealis compares each individual sample against the rest of the cohort to identify significant deviations at single CpG-site resolution. It uses a beta-binomial model to account for both mean methylation levels and dispersion across the cohort.

## Core Workflow

### 1. Running the Pipeline
The primary entry point is `runBorealis()`. This function processes Bismark coverage files and generates statistical outputs for each sample.

```r
library(borealis)

# extdata should point to a directory containing .bismark.cov.gz or similar files
extdata <- system.file("extdata", "bismark", package="borealis")
outdir <- tempdir()

results <- runBorealis(
  location = extdata,
  nThreads = 2,
  chrs = "chr14",
  suffix = ".gz",
  outprefix = file.path(outdir, "borealis_"),
  modelOutPrefix = file.path(outdir, "CpG_model")
)
```

### 2. Loading and Formatting Results
Borealis outputs `.tsv` files (ending in `_DMLs.tsv`). It is standard practice to convert these into `GRanges` objects for downstream analysis.

```r
# Identify output files
borealis_files <- dir(outdir, pattern = "*DMLs.tsv")

# Load a specific sample into GRanges
sample_data <- read.table(file.path(outdir, borealis_files[1]), header=TRUE)
sample_gr <- GenomicRanges::makeGRangesFromDataFrame(
  sample_data, 
  start.field="pos", 
  end.field="pos.1", 
  seqnames.field="chr", 
  keep.extra.columns=TRUE
)
```

### 3. Statistical Post-Processing
Borealis provides raw p-values. You must manually perform multiple testing correction (e.g., Benjamini-Hochberg).

```r
# Add adjusted p-values to the GRanges object
sample_gr$pAdj <- p.adjust(sample_gr$pVal, method="BH")

# Filter for significant outliers
significant_sites <- sample_gr[sample_gr$pAdj <= 0.05]
```

### 4. Interpreting Output Columns
*   **x**: Number of methylated reads at the position.
*   **n**: Total read depth at the position.
*   **mu**: Modeled mean methylation fraction for the cohort.
*   **theta**: Modeled dispersion (variability) at this site.
*   **pVal**: Probability of the observed methylation given the cohort model.
*   **effSize**: Magnitude of deviation from the cohort mean.
*   **isHypo**: Logical; `TRUE` if the site is hypomethylated, `FALSE` if hypermethylated.

### 5. Visualization
Use `plotCpGsite` to visualize a specific genomic coordinate's methylation relative to the cohort model.

```r
plotCpGsite(
  "chr14:24780288", 
  sampleOfInterest = "patient_72",
  modelFile = "path/to/CpG_model_chr14.csv",
  methCountFile = "path/to/rawMethCount_chr14.tsv",
  totalCountFile = "path/to/rawTotalCount_chr14.tsv"
)
```

## Integration with annotatr
To add biological context (e.g., promoters, CpG islands), use the `annotatr` package:

```r
library(annotatr)
annots <- build_annotations(genome = 'hg19', annotations = 'hg19_genes_promoters')
annotated_regions <- annotate_regions(
  regions = sample_gr,
  annotations = annots,
  ignore.strand = TRUE
)
```

## Tips for Success
*   **Cohort Size**: While Borealis works with as few as 3 samples, larger cohorts (20+) provide more robust estimates of `mu` and `theta`.
*   **Input Format**: Ensure input files are Bismark-style coverage files.
*   **Memory Management**: For whole-genome analysis, use the `chrs` argument in `runBorealis` to process chromosomes individually if memory is limited.

## Reference documentation
- [Borealis outlier methylation detection](./references/borealis.md)