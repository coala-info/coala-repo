---
name: bioconductor-mgnifyr
description: This R package provides an interface to search and retrieve microbiome data and metadata from the EBI MGnify database. Use when user asks to search for metagenomic studies or samples, fetch analysis metadata, and import microbial abundance data into TreeSummarizedExperiment or MultiAssayExperiment formats.
homepage: https://bioconductor.org/packages/release/bioc/html/MGnifyR.html
---


# bioconductor-mgnifyr

name: bioconductor-mgnifyr
description: Access and retrieve microbiome data from the EBI MGnify database using the MGnifyR R package. Use this skill when you need to search for metagenomic studies, samples, or analyses, fetch metadata, and import microbial abundance data directly into TreeSummarizedExperiment (TreeSE) or MultiAssayExperiment (MAE) formats for downstream analysis with the miaverse framework.

## Overview

MGnifyR provides an R interface to the EBI MGnify metagenomics resource. It allows users to programmatically search the MGnify database and retrieve processed results (taxonomic and functional) without manual downloads. The package is designed to integrate seamlessly with the `miaverse` ecosystem, converting MGnify API responses into standard Bioconductor objects like `TreeSummarizedExperiment`.

## Core Workflow

### 1. Initialize the Client
All operations require a `MgnifyClient` object. Enabling local caching is highly recommended to speed up repetitive queries.

```r
library(MGnifyR)
mg <- MgnifyClient(useCache = TRUE, cacheDir = "./mgnify_cache")
```

### 2. Search for Data
Use `doQuery()` to find accessions based on biomes, locations, or experiment types.

```r
# Search for drinking water samples
samples <- doQuery(
    mg,
    type = "samples",
    biome_name = "root:Environmental:Aquatic:Freshwater:Drinking water",
    max.hits = 20
)
```

### 3. Resolve Analysis Accessions
MGnify uses "Analysis" IDs as the canonical identifier for specific pipeline runs. Convert study or sample IDs to analysis IDs before fetching data.

```r
# Convert sample accessions to analysis accessions
analysis_ids <- searchAnalysis(mg, type = "samples", accession = samples$accession)
```

### 4. Fetch Metadata
Retrieve detailed metadata for the selected analyses. Note that all returned values are initially characters; numeric conversion may be required.

```r
meta_df <- getMetadata(mg, analysis_ids)
# Example: Filter for specific pipeline version
meta_v5 <- meta_v5[meta_v5$`analysis_pipeline-version` == "5.0", ]
```

### 5. Import Microbiome Data
Use `getResult()` to fetch abundance tables.
- **Amplicon data**: Usually returns a single `TreeSummarizedExperiment` (TreeSE).
- **Metagenomic data**: Usually returns a `MultiAssayExperiment` (MAE) containing multiple TreeSE objects (taxonomic, GO terms, InterPro, etc.).

```r
# Fetch taxonomic data
tse <- getResult(mg, accession = analysis_ids, get.func = FALSE)

# Fetch both taxonomic and functional data (Metagenomics)
mae <- getResult(mg, accession = analysis_ids, bulk.dl = TRUE)
```

### 6. Fetch Files and Raw Data
For files not included in the standard TreeSE output (e.g., contigs, hidden Markov models), use `searchFile()` and `getFile()`.

```r
# Find download URLs for predicted CDS
file_list <- searchFile(mg, analysis_ids, type = "analyses")
target_file <- file_list[file_list$attributes.description.label == "Predicted CDS", ]

# Download a specific file
local_path <- getFile(mg, target_file$download_url[1])
```

## Integration with miaverse
Once data is in `TreeSE` format, use the `mia` and `scater` packages for analysis:

```r
library(mia)
# Transform to relative abundance
tse <- transformAssay(tse, method = "relabundance")

# Calculate Alpha Diversity
tse <- addAlpha(tse, index = "shannon")

# Perform PCoA (Beta Diversity)
tse <- runMDS(tse, FUN = vegan::vegdist, method = "bray", assay.type = "relabundance")
```

## Tips and Best Practices
- **Caching**: Always use `useCache = TRUE` for `MgnifyClient` to avoid redundant API calls and slow network speeds.
- **Bulk Downloads**: When fetching large metagenomic datasets, set `bulk.dl = TRUE` in `getResult()` to download study-level TSV files, which is significantly faster than per-analysis API queries.
- **Pipeline Versions**: MGnify often has multiple pipeline runs for the same sample. Filter your metadata by `analysis_pipeline-version` to ensure consistency.
- **Data Types**: `doQuery()` supports `studies`, `samples`, `runs`, `analyses`, and `assemblies`.

## Reference documentation
- [MGnifyR](./references/MGnifyR.md)
- [MGnifyR, extended vignette](./references/MGnifyR_long.md)
- [Metagenomics bioinformatics at MGnify](./references/MGnify_course.md)