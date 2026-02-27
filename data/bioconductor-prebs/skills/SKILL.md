---
name: bioconductor-prebs
description: This tool processes RNA-sequencing data to make it comparable to microarray data by summarizing sequencing-based expressions of probe regions. Use when user asks to estimate probe region expression from BAM files, compare RNA-seq data with microarray results, or apply microarray summarization algorithms like RPA or RMA to sequencing data.
homepage: https://bioconductor.org/packages/release/bioc/html/prebs.html
---


# bioconductor-prebs

name: bioconductor-prebs
description: Use this skill to process RNA-sequencing (RNA-seq) data to make it comparable to microarray data using the prebs package. This skill is applicable when you need to summarize sequencing-based expressions of probe regions using microarray summarization algorithms like RPA or RMA. It supports both Custom CDF (gene-level) and manufacturer's CDF (probe set-level) modes.

## Overview

The `prebs` package (Probe Region Expression Estimation for RNA-seq) facilitates the comparison of RNA-seq data with microarray data. It achieves this by mapping sequencing reads to microarray probe regions and then applying standard microarray summarization algorithms (RPA or RMA). The primary input consists of BAM files (mapped reads) and probe sequence mapping files.

## Core Workflow

### 1. Installation and Loading
```R
if (!requireNamespace("BiocManager", quietly=TRUE)) install.packages("BiocManager")
BiocManager::install("prebs")
library(prebs)
```

### 2. Basic Expression Estimation
The main function is `calc_prebs`. It requires a vector of BAM file paths and a probe mapping file.

```R
# Basic usage with RPA (default) and Custom CDF
bam_files <- c("sample1.bam", "sample2.bam")
mapping_file <- "HGU133Plus2_Hs_ENSG_mapping.txt"
prebs_values <- calc_prebs(bam_files, mapping_file)

# Access results (ExpressionSet)
library(Biobase)
expr_data <- exprs(prebs_values)
```

### 3. Configuration Options
- **Summarization Method**: Use `sum.method="rma"` or `sum.method="rpa"` (default). RPA is generally recommended for better comparability.
- **Output Format**: Set `output_eset=FALSE` to receive a standard R data frame instead of an `ExpressionSet`.
- **Parallelization**: Use the `cluster` argument with a cluster object from the `parallel` package to speed up processing of multiple BAM files.
- **Read Counting**: 
    - `paired_ended_reads=TRUE`: Use for paired-end data.
    - `ignore_strand=FALSE`: Use for strand-specific RNA-seq protocols.

### 4. CDF Modes
- **Custom CDF**: Produces gene-level expressions (e.g., Ensembl IDs). Requires mapping files and CDF packages from sources like Brainarray.
- **Manufacturer's CDF**: Produces probe set-level expressions. Requires the corresponding Bioconductor CDF package (e.g., `hgu133plus2cdf`).

## Parallel Processing Example
```R
library(parallel)
cl <- makeCluster(4)
prebs_values <- calc_prebs(bam_files, mapping_file, cluster=cl)
stopCluster(cl)
```

## Input Requirements
- **BAM Files**: Reads should ideally be mapped to the transcriptome (e.g., using TopHat with `--transcriptome-only`) and limited to unique mappings (`--max-multihits 1`).
- **Mapping Files**: These are tab-delimited files linking probes to genomic coordinates. If using manufacturer's CDFs without provided mapping files, you must generate them by mapping probe sequences to the genome (e.g., via Bowtie) and formatting the output to match the `prebs` requirement.

## Reference documentation
- [prebs User Guide](./references/prebs.md)