---
name: bioconductor-h5vc
description: The h5vc package provides a scalable framework for managing and analyzing large-scale nucleotide tallies from NGS experiments using the HDF5 file format. Use when user asks to create tally files from BAMs, perform variant calling on cohorts, generate mismatch plots, or analyze mutation spectra.
homepage: https://bioconductor.org/packages/release/bioc/html/h5vc.html
---

# bioconductor-h5vc

name: bioconductor-h5vc
description: Expert assistance for the h5vc Bioconductor package. Use this skill for managing large-scale nucleotide tallies in HDF5 format, performing variant calling on cohorts, generating mismatch plots, and analyzing mutation spectra.

# bioconductor-h5vc

## Overview
The `h5vc` package provides a scalable framework for managing and analyzing nucleotide tallies from NGS experiments using the HDF5 file format. It is designed to handle large cohorts by storing essential information (counts, coverages, deletions, insertions, and reference bases) in a structured, random-access format, bypassing the need to repeatedly parse massive BAM files.

## Core Workflow

### 1. Creating Tally Files
Before analysis, you must preprocess BAM files into an HDF5 tally file.

```r
library(h5vc)
library(rhdf5)

# 1. Prepare the file structure
tallyFile <- "my_study.tally.hfs5"
prepareTallyFile(tallyFile, study = "/MyStudy", chrom = "1", chromlength = 248956422, nsamples = 10)

# 2. Define sample metadata
sampleData <- data.frame(
  Sample = c("S1", "S2"),
  Patient = c("P1", "P1"),
  Column = 1:2,
  Type = c("Case", "Control"),
  stringsAsFactors = FALSE
)
setSampleData(tallyFile, "/MyStudy/1", sampleData)

# 3. Extract tallies from BAMs and write to HDF5
# Requires a BSgenome object for the reference
library(BSgenome.Hsapiens.UCSC.hg38)
ranges <- GRanges("chr1", IRanges(start = 1000000, end = 1001000))
theData <- tallyRanges(bamFiles, ranges = ranges, reference = Hsapiens)
writeToTallyFile(theData, tallyFile, study = "/MyStudy", ranges = ranges)
```

### 2. Data Access and Manipulation
Use `h5readBlock` for specific regions or `h5dapply` for block-wise processing.

```r
# Read a specific block
data <- h5readBlock(tallyFile, "/MyStudy/1", names = c("Counts", "Coverages"), range = c(1000000, 1001000))

# Apply a function over ranges (e.g., binned coverage)
res <- h5dapply(
  filename = tallyFile,
  group = "/MyStudy/1",
  names = "Coverages",
  range = my_ranges,
  FUN = binnedCoverage,
  sampledata = sampleData
)
```

### 3. Variant Calling
`h5vc` provides functions for paired (case/control) or single-sample variant calling.

```r
# Call variants in a region
variants <- h5dapply(
  filename = tallyFile,
  group = "/MyStudy/1",
  FUN = callVariantsPaired,
  sampledata = sampleData,
  cl = vcConfParams(returnDataPoints = TRUE),
  range = my_region
)
variant_df <- do.call(rbind, variants)
```

### 4. Visualization
The `mismatchPlot` function creates a ggplot2-based visualization of coverage and mismatches across samples.

```r
p <- mismatchPlot(
  data = data,
  sampledata = sampleData,
  samples = c("S1", "S2"),
  windowsize = 35,
  position = 1000500
)
print(p)
```

### 5. Mutation Spectrum Analysis
Analyze the sequence context of mutations (e.g., trinucleotide context).

```r
ms <- mutationSpectrum(variant_df, tallyFile, "/MyStudy")
plotMutationSpectrum(ms)
```

## Performance Tips
- **Parallelization**: Register a parallel backend using `BiocParallel::register(MulticoreParam())` to speed up `tallyRanges` and `h5dapply`.
- **Chunking**: When preparing the tally file, the `chunksize` parameter in `prepareTallyFile` can significantly impact read/write performance depending on your I/O system.
- **Memory**: Use `h5dapply` with a reasonable `blocksize` to process large chromosomes without loading everything into RAM.

## Reference documentation
- [Building a minimal genome browser with h5vc and shiny](./references/h5vc.simple.genome.browser.md)
- [h5vc – Scalabale nucleotide tallies using HDF5](./references/h5vc.tour.md)