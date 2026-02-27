---
name: bioconductor-ucscrepeatmasker
description: This tool retrieves UCSC RepeatMasker genomic annotations as GRanges objects through Bioconductor's AnnotationHub. Use when user asks to identify repetitive elements like SINE or LINE, query repeat metadata for specific genome builds, or filter genomic repeats by class and family in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/UCSCRepeatMasker.html
---


# bioconductor-ucscrepeatmasker

name: bioconductor-ucscrepeatmasker
description: Access and retrieve UCSC RepeatMasker genomic annotations via Bioconductor's AnnotationHub. Use this skill when you need to identify repetitive elements (SINE, LINE, LTR, etc.) for specific genome builds (e.g., hg19, hg38) in R.

# bioconductor-ucscrepeatmasker

## Overview

The `UCSCRepeatMasker` package provides metadata for RepeatMasker annotations stored in Bioconductor's `AnnotationHub`. Instead of manually downloading and parsing `rmsk.txt.gz` files from the UCSC Genome Browser, this package allows users to query and stream these annotations directly into R as `GRanges` objects. These objects include detailed metadata about repeat classes, families, and alignment scores.

## Workflow: Retrieving Repeat Annotations

To use this package, you must interact with `AnnotationHub`.

### 1. Initialize and Query
Load the necessary libraries and search for RepeatMasker records for your species of interest.

```r
library(AnnotationHub)
library(UCSCRepeatMasker)

# Initialize the Hub
ah <- AnnotationHub()

# Query for RepeatMasker data (e.g., Human)
# Common terms: "UCSC", "RepeatMasker", and the species name
qr <- query(ah, c("UCSC", "RepeatMasker", "Homo sapiens"))
qr
```

### 2. Select and Download
Identify the specific Hub ID (e.g., "AH99003") from the query results and retrieve the data.

```r
# Retrieve a specific version (e.g., hg38 Sep2021)
rmsk_hg38 <- ah[["AH99003"]]
```

### 3. Inspect the Data
The returned object is a `GRanges` object. The metadata columns (`mcols`) contain the standard UCSC RepeatMasker fields.

```r
# View the first few entries
head(rmsk_hg38)

# Access specific metadata columns
# repName: Name of the repeat (e.g., AluJb)
# repClass: Class of repeat (e.g., SINE, LINE, LTR)
# repFamily: Family of repeat (e.g., Alu, L1)
table(rmsk_hg38$repClass)
```

## Common Tasks

### Filtering for Specific Repeats
Since the output is a `GRanges` object, you can use standard `GenomicRanges` subsetting.

```r
# Filter for only Alu elements
alu_elements <- rmsk_hg38[rmsk_hg38$repFamily == "Alu"]

# Filter for repeats on a specific chromosome
chr1_repeats <- rmsk_hg38[seqnames(rmsk_hg38) == "chr1"]
```

### Accessing Source Metadata
To see the original UCSC download URL and versioning information:

```r
metadata(rmsk_hg38)
```

## Tips
- **Caching**: `AnnotationHub` caches files locally. The first download may take time, but subsequent calls are nearly instantaneous.
- **Genome Versions**: Always ensure the `genome` field in the `AnnotationHub` query matches your analysis (e.g., hg19 vs hg38).
- **Memory**: RepeatMasker files for large genomes (like human) can contain millions of ranges. Ensure your R session has sufficient memory to hold the `GRanges` object.

## Reference documentation
- [UCSCRepeatMasker](./references/UCSCRepeatMasker.md)