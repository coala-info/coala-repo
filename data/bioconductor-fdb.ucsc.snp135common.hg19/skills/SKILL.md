---
name: bioconductor-fdb.ucsc.snp135common.hg19
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/FDb.UCSC.snp135common.hg19.html
---

# bioconductor-fdb.ucsc.snp135common.hg19

name: bioconductor-fdb.ucsc.snp135common.hg19
description: Access and use the UCSC common SNPs track (dbSNP build 135) for the hg19 genome assembly. Use this skill when needing to annotate genomic data with common variants, extract SNP coordinates, or work with the FDb.UCSC.snp135common.hg19 FeatureDb object in R.

# bioconductor-fdb.ucsc.snp135common.hg19

## Overview
This package provides a pre-constructed `FeatureDb` object containing "common" SNPs (those with at least 1% heterozygosity) from dbSNP build 135, mapped to the hg19 (GRCh37) human genome assembly. Because this track is too large for standard automated construction, it is provided as a specialized annotation package for efficient querying and integration with other Bioconductor workflows.

## Loading and Inspection
To use the package, load the library and inspect the primary database object:

```r
library(FDb.UCSC.snp135common.hg19)

# View the database object details
FDb.UCSC.snp135common.hg19

# List package contents
ls('package:FDb.UCSC.snp135common.hg19')
```

## Common Workflows

### Extracting SNP Features
The primary use case is extracting the SNPs as a `GRanges` object for downstream analysis or overlapping with experimental data.

```r
# Extract all common SNPs as a GRanges object
snp135common <- features(FDb.UCSC.snp135common.hg19)

# Assign the correct genome assembly information
met <- metadata(FDb.UCSC.snp135common.hg19)
genome(snp135common) <- met[which(met[,'name']=='Genome'),'value']

# Inspect the resulting GRanges
head(snp135common)
```

### Filtering and Annotation
Once extracted as a `GRanges` object, you can use standard `GenomicRanges` functions to interact with the data:

- **Overlaps**: Use `findOverlaps(query_gr, snp135common)` to identify which of your regions of interest contain common SNPs.
- **Subsetting**: Filter by chromosome or position using standard R indexing on the `snp135common` object.

## Usage Tips
- **Memory Management**: The `features()` call returns a large object. If you only need specific regions, consider subsetting the resulting `GRanges` immediately.
- **Genome Version**: Ensure your experimental data is also on `hg19`. If using `hg38`, you must use a different annotation package or lift over the coordinates.
- **Metadata**: Always check the `metadata(FDb.UCSC.snp135common.hg19)` to confirm the source, creation date, and specific UCSC track versions used.

## Reference documentation
- [FDb.UCSC.snp135common.hg19 Reference Manual](./references/reference_manual.md)