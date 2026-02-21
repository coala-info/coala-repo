---
name: bioconductor-geuvstore2
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/geuvStore2.html
---

# bioconductor-geuvstore2

name: bioconductor-geuvstore2
description: Management and retrieval of sharded cis-association statistics (cis-eQTL) from the GEUVADIS project. Use this skill to access large-scale genomic association data, query results by gene identifier (probe ID) or genomic coordinates (GRanges), and perform parallelized operations on sharded result stores.

## Overview

The `geuvStore2` package provides a scalable infrastructure for managing millions of cis-eQTL association statistics. It uses a "sharded" storage approach where results are distributed across multiple serialized R objects, mediated by a `ciseStore` object. This allows for efficient, parallelizable retrieval of statistics without loading the entire dataset into memory. The package specifically contains a selection of 160 jobs from a GEUVADIS FPKM analysis, mapping SNPs (MAF > 10^-6) within a 1MB radius of gene regions.

## Core Workflows

### Initializing the Store

To access the data, you must first create the mediator object.

```R
library(geuvStore2)
library(gQTLBase)

# Create the ciseStore instance
prstore <- makeGeuvStore2()
print(prstore)
```

### Querying by Gene Identifier

Use `extractByProbes` to retrieve all association statistics for specific Ensembl gene IDs.

```R
# Extract results for specific genes
probes <- c("ENSG00000183814.10", "ENSG00000174827.9")
res_probes <- extractByProbes(prstore, probeids = probes)

# Results are returned as a GRanges object with metadata columns:
# chisq, permScore_1..6, snp, MAF, probeid, mindist
head(res_probes)
```

### Querying by Genomic Range

Use `extractByRanges` to find associations within specific chromosomal coordinates. This returns results for all genes whose regions overlap the query range.

```R
# Define a genomic region
query_range <- GRanges("1", IRanges(146000000, width = 1e6))

# Extract results
res_range <- extractByRanges(prstore, query_range)
head(res_range)
```

### Applicative Programming

The package supports applying functions across the entire sharded store using `storeApply`, which utilizes the `foreach` backend for parallel processing.

```R
# Example: Get the number of associations in each shard
shard_lengths <- storeApply(prstore, length)
summary(unlist(shard_lengths))
```

## Data Structure and Metadata

The extracted `GRanges` objects contain several critical metadata columns:
- `chisq`: The association chi-squared statistic.
- `permScore_n`: Permutation scores for significance testing.
- `snp`: The RS identifier for the variant.
- `MAF`: Minor Allele Frequency.
- `probeid`: The gene/expression feature identifier.
- `mindist`: Distance from the SNP to the gene boundary.

## Tips for Efficient Usage

1. **Parallel Backends**: `extractByProbes` and `storeApply` use `foreach`. Register a parallel backend (like `doParallel`) before running large queries to improve performance.
2. **Memory Management**: Because the store is sharded, you can process data in chunks rather than extracting everything at once.
3. **Genome Versions**: The data in this package is mapped to the **hg19** genome build. Ensure your query `GRanges` use the same coordinate system.

## Reference documentation

- [geuvStore2: sharded storage for cis-association statistics](./references/geuvStore2.md)