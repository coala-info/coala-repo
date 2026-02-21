---
name: bioconductor-fdb.ucsc.snp137common.hg19
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/FDb.UCSC.snp137common.hg19.html
---

# bioconductor-fdb.ucsc.snp137common.hg19

name: bioconductor-fdb.ucsc.snp137common.hg19
description: Access and use the UCSC common SNPs track (dbSNP build 137) for the hg19 genome assembly. Use this skill when you need to retrieve SNP locations, annotate genomic data with common variants, or work with FeatureDb objects containing human SNP data for the hg19 build.

# bioconductor-fdb.ucsc.snp137common.hg19

## Overview
The `FDb.UCSC.snp137common.hg19` package is a Bioconductor annotation package providing a `FeatureDb` object. It contains data from the UCSC "Common SNPs" track, which includes variants found in at least 1% of the population from dbSNP build 137, mapped to the hg19 (GRCh37) human genome assembly.

## Basic Usage

### Loading the Package
To use the database, load the library. This automatically loads the `FDb.UCSC.snp137common.hg19` object into the global environment.

```r
library(FDb.UCSC.snp137common.hg19)

# Inspect the database object
FDb.UCSC.snp137common.hg19
```

### Extracting SNP Features
The primary way to interact with this package is to extract the SNPs as a `GRanges` object using the `features()` function from the `GenomicFeatures` framework.

```r
# Extract all common SNPs as a GRanges object
snp137common <- features(FDb.UCSC.snp137common.hg19)

# View the first few SNPs
head(snp137common)
```

### Setting Genome Information
The `FeatureDb` object contains metadata that should be used to properly label the genome assembly of the resulting `GRanges` object.

```r
# Retrieve metadata
met <- metadata(FDb.UCSC.snp137common.hg19)

# Assign the correct genome build (hg19) to the GRanges object
genome(snp137common) <- met[which(met[,'name']=='Genome'), 'value']
```

## Common Workflows

### Filtering SNPs by Region
Once extracted as a `GRanges` object, you can use standard `GenomicRanges` functions to subset SNPs.

```r
library(GenomicRanges)

# Define a region of interest
roi <- GRanges(seqnames = "chr1", ranges = IRanges(start = 1000000, end = 2000000))

# Find SNPs within this region
subset_snps <- subsetByOverlaps(snp137common, roi)
```

### Annotating Experimental Data
Use this package to identify which of your experimental variants or regions overlap with known common SNPs.

```r
# Assuming 'my_variants' is a GRanges object of your data
overlaps <- findOverlaps(my_variants, snp137common)

# Identify which of your variants are "common"
my_variants$is_common <- countOverlaps(my_variants, snp137common) > 0
```

## Tips
- **Memory Management**: This dataset is large. If you only need specific chromosomes, consider subsetting the `GRanges` object immediately after extraction.
- **Object Type**: The main object is a `FeatureDb`. While it behaves similarly to `TxDb` objects, it is specifically structured for genomic features like SNPs.
- **Coordinate System**: Ensure your input data is also in `hg19` coordinates. If your data is in `hg38`, you must use a liftover tool or the corresponding `hg38` SNP package.

## Reference documentation
- [FDb.UCSC.snp137common.hg19 Reference Manual](./references/reference_manual.md)