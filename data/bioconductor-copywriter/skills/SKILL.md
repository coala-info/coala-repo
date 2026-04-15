---
name: bioconductor-copywriter
description: This tool detects DNA copy number variations from off-target reads in targeted sequencing data. Use when user asks to extract copy number information from whole exome sequencing or gene panels, generate reference helper files, or perform circular binary segmentation and plotting.
homepage: https://bioconductor.org/packages/3.6/bioc/html/CopywriteR.html
---

# bioconductor-copywriter

name: bioconductor-copywriter
description: DNA copy number detection from off-target sequence data using the CopywriteR R package. Use this skill when you need to extract copy number information from targeted sequencing (e.g., Whole Exome Sequencing or gene panels) by utilizing off-target reads. It covers the full workflow from generating helper files and processing BAM files to segmentation and plotting.

## Overview

CopywriteR is a Bioconductor package designed to detect DNA copy number variations (CNV) from off-target reads in targeted sequencing data. By focusing on off-target reads, it avoids biases associated with capture enrichment and provides a profile similar to low-depth Whole Genome Sequencing (WGS). The workflow consists of three main stages: generating reference helper files, calculating binned read counts from BAM files, and performing segmentation/plotting.

## Analysis Workflow

### 1. Initialization and Helper Files
Before processing samples, you must create helper files for GC-content and mappability based on your reference genome and desired bin size.

```R
library(CopywriteR)
library(BiocParallel)

# Define output folder
data.folder <- getwd()

# Generate helper files
# bin.size: 20000 (20kb) recommended for WES; 50000 (50kb) for small panels
# ref.genome: "hg18", "hg19", "hg38", "mm9", or "mm10"
preCopywriteR(output.folder = data.folder,
              bin.size = 20000,
              ref.genome = "hg19")
```

### 2. Running CopywriteR
This step processes BAM files to calculate read counts. You must define a `sample.control` data frame where the first column is the sample path and the second is the control path (used for peak calling). If no germline control is available, use the sample itself as the control.

```R
# Prepare sample-control matrix
bam.files <- list.files(path = "path/to/bams", pattern = ".bam$", full.names = TRUE)
# Example: using the same file for peak calling (self-control)
sample.control <- data.frame(samples = bam.files, controls = bam.files)

# Set up parallel processing
bp.param <- SnowParam(workers = 4, type = "SOCK")

# Execute main function
CopywriteR(sample.control = sample.control,
           destination.folder = data.folder,
           reference.folder = file.path(data.folder, "hg19_20kb"),
           bp.param = bp.param)
```

### 3. Segmentation and Plotting
The final step performs Circular Binary Segmentation (CBS) and generates copy number profiles.

```R
# This creates a 'plots' folder and 'segment.Rdata' inside 'CNAprofiles'
plotCNA(destination.folder = data.folder)
```

## Key Functions and Outputs

- `preCopywriteR()`: Creates `GC_mappability.rda` and `blacklist.rda`.
- `CopywriteR()`: Creates a `CNAprofiles` directory containing:
    - `read_counts.txt`: Raw and compensated read counts.
    - `log2_read_counts.igv`: Log2-transformed ratios for visualization in IGV.
    - `qc/`: Quality control plots for GC-content correction.
- `plotCNA()`: Produces:
    - `segment.Rdata`: The DNAcopy object containing segmented values.
    - `plots/`: PDF/PNG profiles for each chromosome and genome-wide.

## Tips for Success

- **Bin Size Selection**: Use 20 kb for Whole Exome Sequencing (WES). For smaller gene panels with lower off-target coverage, increase the bin size to 50 kb or 100 kb to maintain signal-to-noise ratios.
- **Reference Genomes**: Ensure the `ref.genome` string matches the version used for alignment.
- **Parallelization**: `CopywriteR` processes one sample per core. Adjust `workers` in `SnowParam` based on available RAM, as BAM processing is memory-intensive.
- **Capture Regions**: While not required, providing a BED file to the `capture.regions.file` argument in `CopywriteR()` allows the tool to calculate the overlap between called peaks and targeted regions.

## Reference documentation

- [CopywriteR](./references/CopywriteR.md)