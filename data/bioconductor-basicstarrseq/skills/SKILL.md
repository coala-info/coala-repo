---
name: bioconductor-basicstarrseq
description: This package identifies enhancers from STARR-seq data by comparing a STARR-seq library against an input control library using a binomial model. Use when user asks to call peaks from STARR-seq data, identify genomic enhancers, or calculate enrichment scores between STARR-seq and control libraries.
homepage: https://bioconductor.org/packages/release/bioc/html/BasicSTARRseq.html
---

# bioconductor-basicstarrseq

## Overview

The `BasicSTARRseq` package implements a standardized workflow for identifying enhancers from STARR-seq (Self-Transcribing Active Regulatory Region sequencing) data. It operates by comparing a STARR-seq library (representing enhancer activity) against an input library (representing the tested genomic regions). Peaks are called based on a binomial model to determine significant enrichment of the STARR-seq signal over the control.

## Core Workflow

### 1. Data Loading and Object Initialization

The package uses the `STARRseqData` container. You can initialize it from BAM files or existing `GRanges` objects.

```R
library(BasicSTARRseq)

# From BAM files (supports single-end or paired-end)
starr_bam <- "path/to/starrseq.bam"
input_bam <- "path/to/input.bam"

# For paired-end data
data_obj <- STARRseqData(sample = starr_bam, 
                         control = input_bam, 
                         pairedEnd = TRUE)

# From GRanges (if data is already in memory)
# data_obj <- STARRseqData(sample = starr_gr, control = input_gr)
```

### 2. Peak Calling

The `getPeaks` function is the primary tool for identifying enhancers. It identifies genomic positions where coverage exceeds a specific quantile and applies a binomial test.

```R
# Basic peak calling with default parameters
peaks <- getPeaks(data_obj)

# Customized peak calling
peaks <- getPeaks(data_obj, 
                  minQuantile = 0.9,    # Coverage threshold for peak centers
                  peakWidth = 500,      # Width of the resulting peaks
                  maxPval = 0.001,      # Significance threshold
                  deduplicate = TRUE,   # Remove duplicate reads
                  model = 1)            # Binomial model selection (1 or 2)
```

### 3. Interpreting Results

The output is a `GRanges` object containing the following metadata columns:
- `sampleCov`: Coverage in the STARR-seq sample.
- `controlCov`: Coverage in the input control sample.
- `pVal`: The p-value calculated via the chosen binomial model.
- `enrichment`: The calculated enrichment score (STARR-seq/Input), corrected using binomial confidence intervals.

## Binomial Models

- **Model 1 (Default):** Uses the total number of STARR-seq sequences as trials and the input coverage ratio as the success probability.
- **Model 2:** Used in the original Arnold et al. (2013) study. It treats the sum of STARR-seq and input coverage as trials, with the success probability derived from the ratio of total library sizes.

## Tips for Success

- **Deduplication:** By default, `getPeaks` performs deduplication. If your library has very high complexity or you have already pre-processed the BAM files, ensure this matches your experimental design.
- **Memory Management:** For very large genomes, ensure you have sufficient RAM, as the package loads fragments into memory via `GenomicAlignments`.
- **Filtering:** It is recommended to filter BAM files for mapping quality and secondary alignments using tools like `Rsamtools` before initializing the `STARRseqData` object.

## Reference documentation

- [BasicSTARRseq](./references/BasicSTARRseq.md)