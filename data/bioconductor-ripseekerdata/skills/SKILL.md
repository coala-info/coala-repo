---
name: bioconductor-ripseekerdata
description: This package provides example RIP-seq datasets for testing and demonstrating the RIPSeeker analysis pipeline. Use when user asks to access example BAM files for RIP-seq peak calling, test RIPSeeker workflows with PRC2 or CCNT1 data, or demonstrate strand-specific alignment processing.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/RIPSeekerData.html
---


# bioconductor-ripseekerdata

name: bioconductor-ripseekerdata
description: Access and use the RIP-seq datasets (PRC2 and CCNT1) provided by the RIPSeekerData package for testing and demonstrating the RIPSeeker analysis pipeline. Use when the user needs example BAM files for RIP-seq peak calling, strand-specific alignment processing, or mouse (mm9) and human (hg19) genomic data analysis.

# bioconductor-ripseekerdata

## Overview

The `RIPSeekerData` package provides two primary RIP-seq datasets used for testing the `RIPSeeker` package. These datasets include BAM files for:
1. **PRC2 (Mouse):** Ezh2 subunit in mouse embryonic stem cells (mESC), aligned to the mm9 genome.
2. **CCNT1 (Human):** CCNT1 and GFP control experiments, aligned to the hg19 genome.

The data is stored in the package's `extdata` directory and is intended to be processed using the `RIPSeeker` package functions.

## Data Access and Loading

To use these datasets, you must locate the BAM files within the package installation directory.

```R
library(RIPSeekerData)
library(RIPSeeker)

# Locate the external data directory
extdata.dir <- system.file("extdata", package="RIPSeekerData")

# List all BAM files recursively
bamFiles <- list.files(extdata.dir, "\\.bam$", recursive=TRUE, full.names=TRUE)
```

## Typical Workflows

### Processing PRC2 Data (Mouse mm9)

The PRC2 data requires reverse complementation because the library construction generated sequences from the opposite strand of the bound RNA.

```R
# Filter for PRC2 files
bamFiles.PRC2 <- grep("PRC2/", bamFiles, value=TRUE)

# Identify specific files (e.g., Replicate 1)
# SRR039213 is a specific run ID in this dataset
PRC2.rip.biorep1 <- bamFiles.PRC2[grep("SRR039213", bamFiles.PRC2, invert=TRUE)]

# Import and convert to GAlignments using RIPSeeker's combineAlignGals
ripGal.PRC2 <- combineAlignGals(PRC2.rip.biorep1, 
                                reverseComplement=TRUE, 
                                genomeBuild="mm9")
```

### Processing CCNT1 Data (Human hg19)

The CCNT1 data also uses the reverse complement setting for the strand-specific libraries.

```R
# Filter for CCNT1 files
bamFiles.CCNT1 <- grep("CCNT1/", bamFiles, value=TRUE)

# Identify RIP and Control files
CCNT1.rip <- grep(pattern="humanCCNT1", bamFiles.CCNT1, value=TRUE, invert=FALSE)
CCNT1.ctl <- grep(pattern="humanGFP", bamFiles.CCNT1, value=TRUE, invert=FALSE)

# Import data
ripGal.CCNT1 <- combineAlignGals(CCNT1.rip, 
                                 reverseComplement=TRUE, 
                                 genomeBuild="hg19")
```

## Usage Tips

- **Genome Builds:** Ensure you specify the correct `genomeBuild` (`mm9` for PRC2, `hg19` for CCNT1) when importing data to ensure proper chromosome naming and length validation.
- **Strand Specificity:** Both datasets provided in this package typically require `reverseComplement=TRUE` when using `combineAlignGals` due to the cDNA synthesis protocol used in the original experiments.
- **Memory Management:** These are subsetted/test datasets, but when working with full RIP-seq data, ensure your R session has sufficient memory for `GAlignments` objects.

## Reference documentation

- [RIPSeekerData](./references/RIPSeekerData.md)