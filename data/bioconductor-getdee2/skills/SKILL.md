---
name: bioconductor-getdee2
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/getDEE2.html
---

# bioconductor-getdee2

## Overview
The `getDEE2` package provides an R interface to the Digital Expression Explorer 2 repository, which contains over 1 million processed SRA runs. It allows users to retrieve gene-level or transcript-level counts and associated metadata without processing raw FASTQ files. Data is typically returned as a `SummarizedExperiment` object, compatible with downstream Bioconductor tools like `DESeq2` or `edgeR`.

## Core Workflow

### 1. Identify Species and Metadata
First, determine the "DEE2 name" for your organism and download the metadata to find accessions of interest.

```r
library(getDEE2)

# Common species names: "hsapiens", "mmusculus", "drerio", "celegans", "athaliana"
mdat <- getDEE2Metadata("hsapiens")

# Search for specific projects (SRP) or GEO series (GSE)
my_study <- mdat[which(mdat$SRP_accession == "SRP009256"), ]
srr_ids <- as.vector(my_study$SRR_accession)
```

### 2. Fetch Expression Data
Use `getDEE2()` to download counts. By default, it returns a `SummarizedExperiment`.

```r
# Fetch gene counts
se <- getDEE2(species = "celegans", 
              SRRvec = srr_ids, 
              metadata = mdat, 
              counts = "GeneCounts")

# Access counts and metadata
counts_matrix <- assays(se)$counts
sample_info <- colData(se)
```

**Count Options:**
* `GeneCounts`: STAR gene-level counts (Default).
* `TxCounts`: Kallisto transcript-level counts.
* `Tx2Gene`: Transcript counts aggregated to gene level.

### 3. Working with Large Projects (Bundles)
For large studies (dozens to thousands of runs), use the bundle functions which are more efficient than requesting individual SRR IDs.

```r
# 1. List available bundles
bundles <- list_bundles("athaliana")

# 2. Query if a project is available as a bundle
query_bundles("athaliana", "SRP058781", col="SRP_accession", bundles=bundles)

# 3. Fetch the bundle
se_bundle <- getDEE2_bundle("athaliana", "SRP058781", 
                            col="SRP_accession", 
                            counts="GeneCounts")
```

## Tips and Best Practices
* **Species Names**: Ensure you use the DEE2-specific name (e.g., `hsapiens` not `Homo sapiens`).
* **Metadata Caching**: If performing multiple queries, download the metadata once and pass it to the `metadata` argument in `getDEE2()` to save time and bandwidth.
* **Quality Control**: The `colData` of the returned object contains a `QC_summary`. Check this for "FAIL" or "WARN" flags indicating potential issues with specific SRA runs.
* **Legacy Format**: If you require a list object instead of a `SummarizedExperiment`, set `legacy = TRUE` in the `getDEE2()` call.

## Reference documentation
- [getDEE2: Programmatic access to the DEE2 RNA expression dataset](./references/getDEE2.md)