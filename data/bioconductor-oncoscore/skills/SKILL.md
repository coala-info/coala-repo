---
name: bioconductor-oncoscore
description: OncoScore measures the oncogenic potential of genes by analyzing their citation frequencies in cancer-related literature via PubMed queries. Use when user asks to calculate oncogenic scores for genes, retrieve citation data from PubMed, analyze research trends over time, or identify cancer-associated genes within specific genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/OncoScore.html
---


# bioconductor-oncoscore

## Overview

OncoScore is an R package that measures the association of genes to cancer by analyzing citation frequencies in biomedical literature. It performs dynamic web queries to PubMed to compare the number of citations for a gene in cancer-related research versus its total citations. This provides a numerical score representing the gene's oncogenic potential, which can be calculated for a single point in time or as a time-series to observe research trends.

## Installation

To install the package from GitHub:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("biomaRt")

if (!require("devtools")) install.packages("devtools")
devtools::install_github("danro9685/OncoScore", ref = "master")
library(OncoScore)
```

## Core Workflow

### 1. Querying PubMed Data
Retrieve citation counts for a list of gene symbols.

```r
# Standard query for current data
genes <- c("ASXL1", "IDH1", "IDH2", "SETBP1", "TET2")
query <- perform.query(genes)

# Time-series query for historical trends
timepoints <- c("2012/03/01", "2014/03/01", "2016/03/01")
query_ts <- perform.query.timeseries(genes, timepoints)
```

### 2. Data Manipulation
Merge results for gene aliases or retrieve genes from specific genomic coordinates.

```r
# Merge aliases (e.g., merging IDH1 and IDH2 into a single entry)
combined_query <- combine.query.results(query, c('IDH1', 'IDH2'), 'IDH_group')

# Get genes from a chromosomal region via biomaRt
genes_region <- get.genes.from.biomart(chromosome=13, start=54700000, end=72800000)
```

### 3. Computing OncoScore
Calculate the oncogenic potential score based on the retrieved query data.

```r
# Compute score for a standard query
result <- compute.oncoscore(query)

# Compute score for a time-series
result_ts <- compute.oncoscore.timeseries(query_ts)

# Direct computation from a genomic region
result_region <- compute.oncoscore.from.region(10, 100000, 500000)
```

### 4. Visualization
Visualize the scores as barplots or time-series trends.

```r
# Barplot of current scores
plot.oncoscore(result, col = 'darkblue')

# Plot time-series (absolute values)
plot.oncoscore.timeseries(result_ts)

# Plot variations (incremental/relative)
plot.oncoscore.timeseries(result_ts, incremental = TRUE, relative = TRUE)
```

## Tips and Troubleshooting
- **HTTP 429 Errors**: The package queries PubMed APIs. If you encounter "429 Unknown Error", it indicates rate limiting. Reduce the number of genes or timepoints, or wait before retrying.
- **Gene Aliases**: Use `combine.query.results` to ensure that citations for different names of the same gene are aggregated correctly to avoid underestimating the score.
- **Biomart**: Functions involving chromosomal regions require an active internet connection to reach Ensembl/biomaRt servers.

## Reference documentation
- [Introduction](./references/v1_introduction.md)
- [Running OncoScore](./references/v2_running_OncoScore.md)