---
name: bioconductor-varianttoolsdata
description: This package provides example genomic datasets and raw files for the TP53 region to support VariantTools tutorials. Use when user asks to access sample BAM, FASTQ, or VCF files for variant calling demonstrations or load pre-computed tally objects for analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/VariantToolsData.html
---

# bioconductor-varianttoolsdata

## Overview

The `VariantToolsData` package is a data-only experiment package designed to support the tutorial for the `VariantTools` package. It contains a dataset derived from a 50/50 mixture of HapMap samples (NA12878 and NA19240) performed in triplicate. The data is subset to the TP53 genomic region. It provides both summarized R objects and raw external files (FASTQ, BAM, VCF) used for demonstrating variant calling, filtering, and annotation workflows.

## Loading the Data

To use the package, first load it into the R session:

```r
library(VariantToolsData)
```

### Accessing Summarized Objects
The package includes pre-computed objects accessible via the `data()` function. These are useful for jumping straight into analysis without re-processing raw files.

```r
# Load specific datasets
data(vignette) 
# This typically loads objects like 'tallies', 'variants', or 'filters' 
# used in the VariantTools vignette.
```

### Locating Raw Data Files
The core utility of this package is providing paths to raw genomic files stored in the `extdata` directory. Use `system.file` to retrieve these paths for use in alignment or variant calling functions.

```r
# List all available files
extdata_path <- system.file("extdata", package="VariantToolsData")
dir(extdata_path)

# Get path to a specific BAM file
bam_file <- system.file("extdata", "SAM7991860-p53-first.bam", package="VariantToolsData")

# Get path to the dbSNP VCF file
vcf_file <- system.file("extdata", "dbsnp-p53.vcf.gz", package="VariantToolsData")
```

## Typical Workflow Integration

This package is almost always used in conjunction with `VariantTools` and `GenomicRanges`.

1.  **Identify Files**: Use `system.file` to get paths to the FASTQ or BAM files.
2.  **Tally Variants**: Pass the BAM file paths to `VariantTools::tallyVariants()`.
3.  **Filter Variants**: Use the provided `dbsnp-p53.vcf.gz` to annotate or filter known vs. novel variants.
4.  **Validation**: Compare results against the pre-computed objects loaded via `data()`.

## Available File Types
- **FASTQ**: Raw reads (`.fastq.gz`) for testing alignment pipelines.
- **BAM**: Aligned reads (`.bam`) and indices (`.bai`) for variant calling.
- **VCF**: Known variants from dbSNP (`.vcf.gz`) for the TP53 region.

## Reference documentation

- [Data for the VariantTools Tutorial](./references/intro.md)