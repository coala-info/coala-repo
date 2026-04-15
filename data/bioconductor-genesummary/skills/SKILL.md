---
name: bioconductor-genesummary
description: This tool retrieves functional gene summaries and biological descriptions from the NCBI RefSeq database for over 120 organisms. Use when user asks to get gene function descriptions, retrieve RefSeq summary comments, or annotate gene lists with human-readable functional information.
homepage: https://bioconductor.org/packages/release/data/annotation/html/GeneSummary.html
---

# bioconductor-genesummary

name: bioconductor-genesummary
description: Access and retrieve functional gene summaries from the NCBI RefSeq database for various organisms. Use this skill when you need to provide descriptive text about gene functions, biological roles, or protein characteristics based on curated RefSeq "Summary" comments.

# bioconductor-genesummary

## Overview

The `GeneSummary` package provides access to a curated collection of gene descriptions extracted from the RefSeq database. It specifically targets the "Summary" section within the "COMMENT" field of RefSeq records. This is highly useful for bioinformatics workflows that require functional annotation or human-readable descriptions of gene lists across a wide range of organisms (over 120 species).

## Core Workflow

### Loading the Package
```r
library(GeneSummary)
```

### Retrieving Gene Summaries
The primary function is `loadGeneSummary()`. It returns a data frame containing RefSeq accessions, Organism names, Taxon IDs, Gene IDs, Review Status, and the actual Gene Summary text.

**1. Get summaries for a specific organism**
You can use either the NCBI Taxonomy ID (integer) or the full scientific name (string).
```r
# Using Taxon ID (e.g., 9606 for Homo sapiens)
human_summaries <- loadGeneSummary(organism = 9606)

# Using scientific name
mouse_summaries <- loadGeneSummary(organism = "Mus musculus")
```

**2. Filter by Review Status**
RefSeq records have different curation levels. You can filter the results using the `status` argument (e.g., "reviewed", "provisional", "predicted", "inferred", "validated").
```r
# Get only high-quality, manually curated summaries
reviewed_summaries <- loadGeneSummary(organism = 9606, status = "reviewed")
```

**3. List all available organisms**
Setting `organism = NULL` returns the entire database, which can then be used to see which species are supported.
```r
all_data <- loadGeneSummary(organism = NULL)
unique_species <- unique(all_data$Organism)
```

### Checking Data Version
To check the RefSeq release version and the number of organisms included in the current package build:
```r
GeneSummary
```

## Tips and Best Practices

- **Gene ID Mapping**: The `Gene_ID` column corresponds to Entrez Gene IDs. Use these to merge summaries with other Bioconductor objects (like `SummarizedExperiment` or results from `DESeq2`).
- **Memory Management**: Loading the full database (`organism = NULL`) can be memory-intensive. It is generally better to load specific organisms as needed.
- **Text Mining**: The `Gene_summary` column contains long-form text. You can use standard R string functions (`grep`, `stringr`) to search for specific keywords (e.g., "kinase", "transcription factor") within the summaries.

## Reference documentation

- [Gene Summaries from RefSeq Database](./references/GeneSummary.Rmd)
- [Gene Summaries from RefSeq Database (Markdown)](./references/GeneSummary.md)