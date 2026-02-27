---
name: bioconductor-cosmic.67
description: This tool provides access to the COSMIC version 67 dataset for querying somatic mutations and the Cancer Gene Census. Use when user asks to retrieve somatic mutation data for specific genomic ranges, access genes causally linked to cancer, or query historical COSMIC v67 records using GRCh37 coordinates.
homepage: https://bioconductor.org/packages/release/data/experiment/html/COSMIC.67.html
---


# bioconductor-cosmic.67

name: bioconductor-cosmic.67
description: Access and query the COSMIC (Catalogue of Somatic Mutations in Cancer) version 67 dataset, including coding/non-coding mutations and the Cancer Gene Census. Use this skill when you need to retrieve somatic mutation data for specific genomic ranges (GRCh37/hg19) or access a list of genes causally linked to cancer as of the COSMIC v67 release.

## Overview
The `COSMIC.67` package is a Bioconductor data experiment package containing curated mutation data from COSMIC release v67 (October 2013). It provides genomic coordinates, gene names, strand information, CDS/AA changes, and mutation counts. Data is stored as a `CollapsedVCF` object and a bgzipped/tabix-indexed VCF file. It also includes the Cancer Gene Census (CGC) as a data frame.

## Loading the Data
The package provides two primary datasets: `cosmic_67` (mutations) and `cgc_67` (Cancer Gene Census).

```r
library(COSMIC.67)
library(VariantAnnotation)
library(GenomicRanges)

# Load the Cancer Gene Census
data(cgc_67, package = "COSMIC.67")

# Load the mutation data (Note: This loads a VRanges object)
data(cosmic_67, package = "COSMIC.67")
```

## Querying Mutations by Genomic Range
To efficiently query specific regions (e.g., a specific gene), use the indexed VCF file provided within the package.

```r
# 1. Define the target range (Coordinates must be GRCh37/hg19)
# Example: TP53 region on chromosome 17
tp53_range <- GRanges("17", IRanges(7565097, 7590856))

# 2. Locate the VCF file path
vcf_path <- system.file("vcf", "cosmic_67.vcf.gz", package = "COSMIC.67")

# 3. Read specific ranges using ScanVcfParam
cosmic_tp53 <- readVcf(vcf_path, genome = "GRCh37", ScanVcfParam(which = tp53_range))

# 4. Inspect results
cosmic_tp53
```

## Working with the Cancer Gene Census
The `cgc_67` object is a data frame containing genes linked to cancer.

```r
data(cgc_67, package = "COSMIC.67")
head(cgc_67)
# Columns include: SYMBOL, ENTREZID, ENSEMBL
```

## Data Structure and Metadata
When mutations are loaded into a VCF object, the `info` fields provide critical COSMIC metadata:
- `GENE`: The gene name.
- `STRAND`: Genomic strand.
- `CDS`: Coding sequence annotation.
- `AA`: Peptide (Amino Acid) change annotation.
- `CNT`: Number of samples in COSMIC found to have this specific mutation.

Access these using:
```r
info(cosmic_tp53)
```

## Tips and Constraints
- **Genome Build**: All coordinates in this package are based on **GRCh37 (hg19)**. If working with GRCh38 data, you must lift over coordinates before querying.
- **VCF vs VRanges**: The `data(cosmic_67)` command loads a `VRanges` object. For standard VCF operations or range-based filtering of the whole dataset, using `readVcf` on the `system.file` path is often more memory-efficient.
- **Version**: This is version 67. For more recent mutations, users should refer to the latest COSMIC database online, as this package is a static historical snapshot.

## Reference documentation
- [COSMIC 67](./references/COSMIC.67.md)