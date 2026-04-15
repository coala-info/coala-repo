---
name: bioconductor-recount3
description: This tool accesses and downloads uniformly processed RNA-seq data from the recount3 project as RangedSummarizedExperiment objects. Use when user asks to retrieve gene, exon, or junction-level counts, find study IDs from SRA, GTEx, or TCGA, and transform raw coverage counts for differential expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/recount3.html
---

# bioconductor-recount3

name: bioconductor-recount3
description: Access and download uniformly processed RNA-seq data from the recount3 project. Use this skill when you need to retrieve RangedSummarizedExperiment (RSE) objects for human or mouse studies, including gene, exon, or junction-level counts, and associated metadata from SRA, GTEx, or TCGA.

## Overview

The `recount3` package provides an interface to the recount3 project, which contains hundreds of thousands of uniformly processed RNA-seq samples. It allows users to download data directly into R as `RangedSummarizedExperiment` objects, facilitating immediate downstream analysis with Bioconductor tools like `DESeq2`, `limma`, and `edgeR`.

## Core Workflow

### 1. Identify Projects
Use `available_projects()` to find study IDs. You can filter by organism ("human" or "mouse") and data source (e.g., "sra", "gtex", "tcga").

```r
library(recount3)

# List all human projects
human_projects <- available_projects()

# Find a specific SRA project (e.g., SRP009615)
proj_info <- subset(
    human_projects,
    project == "SRP009615" & project_type == "data_sources"
)
```

### 2. Select Annotation
Check available annotations for the organism.

```r
# For human: gencode_v26 (default), gencode_v29, refseq, etc.
annotation_options("human")
```

### 3. Create RangedSummarizedExperiment (RSE)
Use `create_rse()` to download and build the object. You can specify the feature type: "gene" (default), "exon", or "jxn" (junctions).

```r
# Create gene-level RSE
rse_gene <- create_rse(proj_info)

# Create exon-level RSE
rse_exon <- create_rse(proj_info, type = "exon")
```

### 4. Transform Counts
Recount3 provides raw base-pair coverage counts in the `raw_counts` assay. These must be transformed for differential expression analysis.

```r
# Transform to scaled counts (RPKM/TPM style)
assay(rse_gene, "counts") <- transform_counts(rse_gene)
```

## Metadata and Exploration

### Sample Metadata
Access extensive quality control metrics and sample attributes via `colData()`. For SRA studies, use `expand_sra_attributes()` to parse the XML-style attribute strings into separate columns.

```r
# Expand SRA attributes for easier filtering
rse_expanded <- expand_sra_attributes(rse_gene)
colData(rse_expanded)
```

### Feature Information
Access genomic coordinates and gene/exon IDs via `rowRanges()`.

```r
rowRanges(rse_gene)
```

### BigWig Access
The URLs for raw BigWig coverage files are stored in the `BigWigURL` column of the `colData`. These can be used with the `megadepth` package for custom quantification.

## Cache Management
The package uses `BiocFileCache` to avoid redundant downloads.

```r
# List cached files
recount3_cache_files()

# Clear cache
recount3_cache_rm()
```

## Tips for Large Projects
- **Memory**: Exon-level RSE objects are significantly larger than gene-level objects. Monitor memory usage when working with large cohorts (e.g., GTEx tissues).
- **Junctions**: Junction-level RSEs use sparse matrices (`Matrix` package) to save memory.
- **GTEx/TCGA**: These projects are organized by tissue type (e.g., "ADIPOSE_TISSUE", "BRCA").

## Reference documentation
- [recount3 quick start guide](./references/recount3-quickstart.md)