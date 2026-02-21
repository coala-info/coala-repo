---
name: bioconductor-chromhmmdata
description: The package includes data for two versions of the genome of humans and mice.
homepage: https://bioconductor.org/packages/release/data/annotation/html/chromhmmData.html
---

# bioconductor-chromhmmdata

## Overview

The `chromhmmData` package is a data-only Bioconductor annotation package. It provides the essential auxiliary files required to run the ChromHMM (Chromatin Hidden Markov Model) software. These files include chromosome lengths, genomic coordinates for specific features, and transcription start/end site anchors for human and mouse assemblies.

## Installation

To install the package from Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("chromhmmData")
```

## Data Access Workflow

Since this package stores data in `extdata`, you must use `system.file()` to retrieve the absolute paths to the directories or specific files.

### 1. Available Data Types
The package organizes data into three main subdirectories within `extdata`:
- `CHROMSIZES`: Text files containing chromosome names and their respective lengths.
- `COORDS`: BED files containing coordinates of genomic features.
- `ANCHORFILES`: Text files containing transcription start sites (TSS) and transcription end sites (TES).

### 2. Supported Genomes
The package contains data for:
- Human: `hg18`, `hg19`
- Mouse: `mm9`, `mm10`

### 3. Locating Files
To use these files in R or pass their paths to external tools:

```r
library(chromhmmData)

# List all available chromosome size files
chrom_dir <- system.file("extdata/CHROMSIZES", package = "chromhmmData")
list.files(chrom_dir)

# Get the path to a specific annotation file (e.g., hg19 sizes)
hg19_path <- system.file("extdata/CHROMSIZES", "hg19.txt", package = "chromhmmData")

# Get the path to anchor files for mm10
mm10_anchors <- system.file("extdata/ANCHORFILES/mm10", package = "chromhmmData")
list.files(mm10_anchors)
```

### 4. Loading Data into R
While the package is designed to provide paths for ChromHMM, you can load the data into R data frames for custom analysis:

```r
# Load chromosome sizes
hg19_sizes <- read.table(system.file("extdata/CHROMSIZES", "hg19.txt", package = "chromhmmData"))
colnames(hg19_sizes) <- c("chr", "size")
```

## Reference documentation

- [Description of chromhmmData (Rmd)](./references/chromhmmData.Rmd)
- [Description of chromhmmData (md)](./references/chromhmmData.md)