---
name: bioconductor-tbx20bamsubset
description: This tool provides access to a subset of RNA-Seq BAM files and phenotypic data from a TBX20 knock-out experiment in mouse heart tissue. Use when user asks to load sample datasets for testing splice graph analysis, retrieve BAM file paths for chromosome 19, or demonstrate read alignment workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TBX20BamSubset.html
---


# bioconductor-tbx20bamsubset

name: bioconductor-tbx20bamsubset
description: Access and utilize the TBX20 RNA-Seq subset data from Bioconductor. Use this skill to load BAM files and phenotypic data from the TBX20 knock-out experiment (Mus musculus, mm9, chromosome 19) for testing splice graph analysis, read alignment workflows, or genomic interval operations.

## Overview

The `TBX20BamSubset` package is an experiment data package providing a subset of RNA-Seq data from a study on the transcriptional regulator TBX20 in mouse heart tissue. The data includes six BAM files (3 wild-type/normal and 3 TBX20 knock-out) containing reads aligned to chromosome 19 of the mm9 assembly. It is primarily used as a lightweight dataset for demonstrating Bioconductor packages like `SpliceGraph` or `Rsamtools`.

## Loading Data and Metadata

### Accessing Phenotypic Data
The experimental design (sample IDs, conditions, and replicates) is stored in a text file within the package.

```r
library(TBX20BamSubset)

# Locate and read the phenotypic data
fn <- system.file("extdata", "phenoData.txt", package="TBX20BamSubset")
pd <- read.table(fn, header=TRUE, stringsAsFactors=FALSE)

# View the design (Normal vs Tbx20 knockout)
print(pd)
```

### Accessing BAM Files
The package provides a helper function to retrieve the paths to the subsetted BAM files.

```r
library(Rsamtools)

# Get character vector of file paths
fls <- getBamFileList()

# Wrap in a BamFileList for use with Rsamtools/GenomicAlignments
bfs <- BamFileList(fls)

# Check file existence and headers
path(bfs)
```

## Typical Workflows

### Counting Reads in Genomic Intervals
Since the data is aligned to mm9, you can use it to test counting functions.

```r
library(GenomicAlignments)

# Example: Count reads in a specific region on Chr19
roi <- GRanges("chr19", IRanges(start=1000000, end=2000000))
se <- summarizeOverlaps(features=roi, reads=bfs)
```

### Data Characteristics
- **Organism**: *Mus musculus*
- **Assembly**: mm9 (UCSC)
- **Region**: Subset of Chromosome 19
- **Conditions**: 
    - `normal`: Wild-type adult heart tissue.
    - `Tbx20 knockout`: Tamoxifen-mediated conditional knock-out of TBX20 exon 2.

## Tips
- Use `getBamFileList()` to quickly initialize `Rsamtools` objects without manually searching the `extdata` directory.
- The BAM files are indexed; the `.bai` files are located in the same directory as the `.bam` files.
- This package is intended for demonstration and testing; for full biological analysis, the complete dataset should be retrieved from GEO (accession GSM767225-GSM767230).

## Reference documentation

- [TBX20 RNA-Seq data subset](./references/TBX20BamSubset.md)