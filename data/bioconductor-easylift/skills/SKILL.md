---
name: bioconductor-easylift
description: The easylift package provides a streamlined interface for migrating genomic coordinates between different assembly versions using GRanges objects in R. Use when user asks to perform genomic liftover, convert coordinates between genome assemblies, or manage liftover chain files using BiocFileCache.
homepage: https://bioconductor.org/packages/release/bioc/html/easylift.html
---


# bioconductor-easylift

## Overview

The `easylift` package provides a streamlined interface for genomic liftover in R. It acts as a wrapper around Bioconductor's core infrastructure (like `GenomicRanges` and `rtracklayer`) to simplify the process of migrating genomic coordinates between different assembly versions. Its primary advantage is the ability to handle `GRanges` objects directly and integrate with `BiocFileCache` for efficient chain file management.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("easylift")
library(easylift)
```

## Core Workflow

### 1. Prepare the Input GRanges
The input `GRanges` object must have the source genome version assigned to its metadata.

```r
library(GenomicRanges)
gr <- GRanges(seqnames = "chr1", ranges = IRanges(start = 1, end = 200000))
genome(gr) <- "hg19"
```

### 2. Perform Liftover
The `easylift()` function requires the input object, the target genome string, and the path to a `.chain` or `.chain.gz` file.

```r
# Path to your local chain file
chain_path <- "path/to/hg19ToHg38.over.chain.gz"

# Execute liftover
gr_hg38 <- easylift(gr, "hg38", chain_path)
```

### 3. Using BiocFileCache
`easylift` can automatically retrieve chain files if they are registered in the `BiocFileCache`. This removes the need to pass the `chain` argument explicitly every time.

```r
library(BiocFileCache)
bfc <- BiocFileCache()

# Add a chain file to the cache if not already present
chain_file <- "hg19ToHg38.over.chain.gz"
if (nrow(bfcquery(bfc, basename(chain_file))) == 0) {
    bfcadd(bfc, chain_file)
}

# Now easylift can find the chain automatically
gr_hg38 <- easylift(gr, "hg38")

# Supports pipe operator
gr_hg38 <- gr |> easylift("hg38")
```

## Key Functions

- `easylift(obj, target_genome, chain)`: The main function. 
    - `obj`: A `GRanges` object with a defined `genome(obj)`.
    - `target_genome`: A string representing the destination assembly (e.g., "hg38").
    - `chain`: (Optional if using BiocFileCache) Path to the liftover chain file.

## Tips for Success

- **Genome Metadata**: Always ensure `genome(gr)` is set on your input object. `easylift` uses this to identify the source assembly.
- **Chain Files**: You can obtain chain files from the UCSC Genome Browser download portal.
- **Result Structure**: Unlike the base `rtracklayer::liftOver` which returns a `GRangesList`, `easylift` returns a flattened `GRanges` object, making it more convenient for immediate downstream analysis.

## Reference documentation

- [easylift](./references/easylift.md)