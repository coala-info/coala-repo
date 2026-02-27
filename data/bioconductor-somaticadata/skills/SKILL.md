---
name: bioconductor-somaticadata
description: This package provides a high-density paired tumor-normal glioblastoma sequencing dataset for benchmarking and example usage. Use when user asks to load example cancer whole-genome sequencing data, access the glio dataset, or provide sample data for somatic copy number variation analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SomatiCAData.html
---


# bioconductor-somaticadata

name: bioconductor-somaticadata
description: Access and use the SomatiCAData experiment data package. Use this skill when a user needs example cancer whole-genome sequencing (WGS) data for testing copy number variation (CNV) or somatic mutation analysis, specifically for the SomatiCA pipeline.

# bioconductor-somaticadata

## Overview

SomatiCAData is a Bioconductor experiment data package providing a high-density paired tumor-normal sequencing dataset. The data originates from a Complete Genomics sequencing of a glioblastoma sample. It is primarily intended as a benchmark or example dataset for the `SomatiCA` package, which identifies genomic structural variations and estimates tumor purity and clonality.

## Data Access and Usage

The package contains a single primary dataset named `glio`.

### Loading the Data

To use the dataset in an R session, load the library and use the `data()` function:

```R
# Install the package if necessary
# if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# BiocManager::install("SomatiCAData")

library(SomatiCAData)

# Load the glioblastoma dataset
data(glio)
```

### Data Structure

The `glio` object is a data frame containing 3,458,745 rows. It represents processed sequencing information across the genome.

Key columns include:
- `seqnames`: Chromosome identifier.
- `start`: Genomic position.
- `zygosity`: Zygosity state (e.g., "homozygous", "heterozygous").
- `tCount`: Total read count in the tumor sample.
- `LAF`: Less Allele Fraction in the tumor sample.
- `tCountN`: Total read count in the normal (control) sample.
- `germLAF`: Less Allele Fraction in the germline (normal) sample.

### Typical Workflow

This data is typically passed into the `SomatiCA` segmentation and characterization functions.

```R
# Example: Inspecting the first few rows
head(glio)

# Example: Basic filtering for a specific chromosome
glio_chr1 <- glio[glio$seqnames == "chr1", ]

# Example: Visualizing the Less Allele Fraction (LAF)
plot(glio_chr1$start, glio_chr1$LAF, pch=".", main="LAF for Chromosome 1")
```

## Tips

- **Memory Management**: The `glio` dataset is large (over 3.4 million rows). Ensure your R environment has sufficient memory when performing complex operations or plotting the entire dataset.
- **Integration**: This package does not contain analysis functions; it is a data container. Use it in conjunction with the `SomatiCA` package for actual somatic copy number analysis.
- **Data Source**: The data is derived from Complete Genomics platforms, which may have specific bias profiles compared to Illumina-based sequencing.

## Reference documentation

- [SomatiCAData Reference Manual](./references/reference_manual.md)