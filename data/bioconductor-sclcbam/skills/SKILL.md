---
name: bioconductor-sclcbam
description: This package provides a BAM file containing off-target sequencing reads from chromosome 4 of a small-cell lung tumor for genomic analysis. Use when user asks to access sample data for copy number detection with CopywriteR, test BAM file processing tools, or retrieve genomic data for chromosome 4.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SCLCBam.html
---


# bioconductor-sclcbam

name: bioconductor-sclcbam
description: Access and use the SCLCBam experiment data package, which provides a BAM file containing off-target reads from chromosome 4 of a small-cell lung tumor. Use this skill when needing sample genomic data for copy number detection workflows (specifically CopywriteR) or for testing BAM file processing and sequence alignment tools in R.

# bioconductor-sclcbam

## Overview
SCLCBam is a Bioconductor experiment data package. It contains a subset of sequencing data (specifically chromosome 4) from a small-cell lung tumor. This data is primarily intended for use with the `CopywriteR` package, which utilizes off-target reads from targeted sequencing to detect copy number variations.

## Usage

### Loading the Package
To use the data, first load the library:

```r
library(SCLCBam)
```

### Locating the BAM Data
The package provides a helper function to retrieve the file system path where the BAM file is stored.

```r
# Get the directory path containing the .bam file
bam_folder <- getPathBamFolder()
print(bam_folder)

# List the files in the directory to identify the specific BAM file
list.files(bam_folder)
```

### Typical Workflow
The BAM file is typically used as an input for copy number analysis or as a small test dataset for genomic range operations.

```r
library(SCLCBam)
library(Rsamtools)

# Get path
bam_dir <- getPathBamFolder()
bam_file <- list.files(bam_dir, pattern = "\\.bam$", full.names = TRUE)

# Example: Inspecting the BAM header
header <- scanBamHeader(bam_file)
print(header)

# Example: Counting reads in a specific region of Chromosome 4
which <- GRanges("4", IRanges(1, 1000000))
param <- ScanBamParam(which = which)
count <- countBam(bam_file, param = param)
print(count)
```

## Tips
- **Data Scope**: Remember that this package only contains data for chromosome 4. Queries against other chromosomes will return no results.
- **CopywriteR Integration**: This package is specifically designed to serve as the example dataset for the `CopywriteR` vignette and functional testing.
- **Full Dataset**: If the full genome BAM is required, it must be downloaded from the European Nucleotide Archive (ENA) using accession SAMEA2697779.

## Reference documentation
- [SCLCBam](./references/SCLCBam.md)