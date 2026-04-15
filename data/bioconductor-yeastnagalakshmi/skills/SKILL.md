---
name: bioconductor-yeastnagalakshmi
description: This package provides yeast RNA-seq data and transcript annotations from the Nagalakshmi et al. (2008) study. Use when user asks to access yeast BAM files, load transcript databases, or perform feature counting on RNA-seq data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/yeastNagalakshmi.html
---

# bioconductor-yeastnagalakshmi

name: bioconductor-yeastnagalakshmi
description: Access and use the yeastNagalakshmi Bioconductor experiment data package. Use this skill when you need to work with yeast (Saccharomyces cerevisiae) RNA-seq data from the Nagalakshmi et al. (2008) study, specifically for retrieving BAM files and transcript annotations for genomic analysis workflows.

# bioconductor-yeastnagalakshmi

## Overview
The `yeastNagalakshmi` package provides a subset of RNA sequencing data from the landmark study by Nagalakshmi et al. (Science, 2008). It contains yeast genome data retrieved from the Sequence Read Archive (SRA), aligned using `bwa`, and stored in BAM format. It also includes a `TranscriptDb` object for yeast based on UCSC Genome Browser annotations. This package is primarily used as a source of sample data for demonstrating sequencing analysis workflows in R/Bioconductor.

## Loading the Package and Locating Data
The package does not contain high-level R functions; instead, it serves as a container for external data files located in the `extdata` directory.

```r
# Load the package
library(yeastNagalakshmi)

# Locate the external data directory
data_dir <- system.file("extdata", package="yeastNagalakshmi")

# List the available files
list.files(data_dir)
```

## Working with the Data Files
The package typically includes three key files:
1.  **BAM Files**: Two RNA-seq alignment files (e.g., `SRR002051.bam` and `SRR002052.bam`).
2.  **TranscriptDb**: A SQLite database containing transcript annotations.

### Accessing BAM Files
You can use these files with packages like `Rsamtools` or `GenomicAlignments`.

```r
library(Rsamtools)
bam_files <- list.files(data_dir, pattern = "\\.bam$", full.names = TRUE)

# Example: Quick summary of a BAM file
quick_check <- countBam(bam_files[1])
print(quick_check)
```

### Loading the Transcript Database
The package includes a pre-built annotation object that can be loaded using `AnnotationDbi`.

```r
library(AnnotationDbi)
# Locate the sqlite file
db_file <- list.files(data_dir, pattern = "\\.sqlite$", full.names = TRUE)

# Load the TxDb object
# Note: In some versions, you may need to use loadDb
txdb <- loadDb(db_file)
columns(txdb)
```

## Typical Workflow: Feature Counting
A common use case for this package is demonstrating how to count reads overlapping genomic features.

```r
library(GenomicAlignments)
library(GenomicFeatures)

# 1. Get exons by gene from the included TxDb
exons_by_gene <- exonsBy(txdb, by = "gene")

# 2. Point to the BAM files
bam_files <- list.files(data_dir, pattern = "\\.bam$", full.names = TRUE)
bam_list <- BamFileList(bam_files, yieldSize = 100000)

# 3. Count reads (summarizeOverlaps)
se <- summarizeOverlaps(features = exons_by_gene, 
                        reads = bam_list, 
                        mode = "Union", 
                        singleEnd = TRUE, 
                        ignore.strand = FALSE)

# View results
head(assay(se))
```

## Reference documentation
- [yeastNagalakshmi Reference Manual](./references/reference_manual.md)