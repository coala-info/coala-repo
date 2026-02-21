---
name: bioconductor-hicdatalymphoblast
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HiCDataLymphoblast.html
---

# bioconductor-hicdatalymphoblast

name: bioconductor-hicdatalymphoblast
description: Access and use the HiCDataLymphoblast experimental data package. This skill should be used when a user needs to load or analyze the Lieberman-Aiden et al. (2009) Hi-C dataset for human lymphoblastoid cells (specifically chromosome 20, HindIII replicate SRR027956) for use in genomic interaction studies or with the GOTHiC package.

# bioconductor-hicdatalymphoblast

## Overview
HiCDataLymphoblast is a Bioconductor data package providing processed Hi-C sequencing data. It contains paired-end reads from human lymphoblastoid cells (replicate SRR027956) mapped to the hg18 reference genome using Bowtie. The data is specifically focused on chromosome 20 and is intended for demonstrating Hi-C analysis workflows, particularly for identifying significant chromatin interactions using packages like GOTHiC.

## Loading the Data
The package stores data as aligned read files within its `extdata` directory. You can locate and load these files using the `ShortRead` package.

```r
# Load the library
library(HiCDataLymphoblast)
library(ShortRead)

# Locate the external data directory
dirPath <- system.file("extdata", package="HiCDataLymphoblast")

# List the available files (typically two files for paired-end reads)
fileNames <- list.files(dirPath, full.names=TRUE)

# Load the aligned reads (Bowtie format)
# Usually, you load both ends of the paired reads
alignedReads1 <- readAligned(fileNames[1], type="Bowtie")
alignedReads2 <- readAligned(fileNames[2], type="Bowtie")
```

## Typical Workflow
1. **Data Retrieval**: Use `system.file` to find the path to the raw mapped files.
2. **Data Import**: Use `ShortRead::readAligned` to bring the Bowtie-mapped reads into the R environment.
3. **Downstream Analysis**: Pass the resulting `AlignedRead` objects to interaction-calling packages such as `GOTHiC` to find statistically significant genomic interactions.

## Tips
- **Reference Genome**: Note that this specific dataset is mapped to **hg18**. Ensure your genomic coordinates and annotation objects match this version.
- **Scope**: This package is an "Experiment Data" package. It does not contain analysis functions itself but provides the necessary data objects for testing Hi-C analysis algorithms.
- **Paired-Ends**: Hi-C data relies on paired-end sequencing; always ensure you are processing both files (representing the two ends of the DNA fragments) to reconstruct interactions.

## Reference documentation
- [HiCDataLymphoblast User Manual](./references/package_vignettes.md)