---
name: bioconductor-geofastq
description: GEOfastq retrieves high-throughput sequencing data from GEO by identifying ENA accessions and downloading pre-converted FASTQ files directly. Use when user asks to retrieve metadata for a GEO series, extract GSM sample IDs, or download FASTQ files from GEO via ENA.
homepage: https://bioconductor.org/packages/release/bioc/html/GEOfastq.html
---


# bioconductor-geofastq

## Overview

The `GEOfastq` package provides a streamlined workflow for retrieving high-throughput sequencing data from GEO. Instead of downloading bulky `.sra` files and using `fastq-dump`, this package crawls GEO to identify corresponding ENA accessions and downloads the pre-converted `.fastq.gz` files directly. This is significantly faster and more efficient for large-scale RNA-seq or DNA-seq data retrieval.

## Installation

To use this package, ensure `BiocManager` is installed:

```r
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("GEOfastq")
library(GEOfastq)
```

## Core Workflow

### 1. Retrieve Metadata for a GEO Series (GSE)
Start by crawling the GEO series page to get the raw text metadata.

```r
gse_id <- 'GSE133758'
gse_metadata <- crawl_gse(gse_id)
```

### 2. Extract Sample IDs (GSM)
Extract the individual GSM accessions contained within the series.

```r
gsm_ids <- extract_gsms(gse_metadata)
# View the first few IDs
head(gsm_ids)
```

### 3. Map GSM to ENA/SRA Metadata
Retrieve the specific run information (SRR IDs) and ENA download URLs for a specific sample.

```r
# Process a single GSM
gsm_id <- gsm_ids[1]
srp_meta <- crawl_gsms(gsm_id)
```

### 4. Download FASTQ Files
Download the files to a specified directory. The `get_fastqs` function handles the file transfer.

```r
dest_dir <- "./data/fastq"
dir.create(dest_dir, recursive = TRUE)

# Download based on the metadata retrieved
res <- get_fastqs(srp_meta, dest_dir)
```

## Utility Functions

- `get_dldir(run_id)`: A helper function to construct the EBI directory path for a specific SRR run ID.
- `crawl_gsms()`: Can handle multiple GSM IDs to batch process metadata retrieval.

## Tips for Success

- **Directory Setup**: Always use `tempdir()` for testing or ensure your destination directory has write permissions.
- **Data Frames**: The `get_fastqs` function expects a data frame with specific columns (`run`, `gsm_name`, `ebi_dir`). If you are manually constructing this, ensure `stringsAsFactors = FALSE`.
- **Network Stability**: Since this package relies on crawling web pages and FTP/HTTP downloads, ensure a stable internet connection. Large studies may require significant disk space.

## Reference documentation

- [Using the GEOfastq Package](./references/GEOfastq.Rmd)
- [GEOfastq Manual](./references/GEOfastq.md)