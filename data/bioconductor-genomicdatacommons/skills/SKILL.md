---
name: bioconductor-genomicdatacommons
description: The GenomicDataCommons package provides an R interface for searching, retrieving metadata, and downloading data from the NCI Genomic Data Commons API. Use when user asks to query cancer genomics metadata, download TCGA or TARGET datasets, retrieve clinical information, or perform genomic BAM slicing.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicDataCommons.html
---

# bioconductor-genomicdatacommons

## Overview

The `GenomicDataCommons` package provides an R interface to the National Cancer Institute's (NCI) Genomic Data Commons (GDC) API. It allows for programmatic searching, metadata retrieval, and data downloading for major cancer research projects like The Cancer Genome Atlas (TCGA) and TARGET. The package follows a `dplyr`-like syntax for filtering and selecting data across four main endpoints: `projects()`, `cases()`, `files()`, and `annotations()`.

## Core Workflow

### 1. Connectivity and Status
Always verify the API status before starting a session.
```r
library(GenomicDataCommons)
status() # Should return $status "OK"
```

### 2. Querying Metadata
Queries are built using endpoint functions and modified with verbs.
*   **Endpoints**: `projects()`, `cases()`, `files()`, `annotations()`.
*   **Verbs**: `filter()`, `select()`, `facet()`, `expand()`.
*   **Execution**: `results()`, `count()`, `ids()`, `manifest()`.

**Example: Finding Gene Expression Files**
```r
q_files <- files() |>
    filter(cases.project.project_id == 'TCGA-OV' &
           type == 'gene_expression' &
           analysis.workflow_type == 'STAR - Counts')

# Get total count
count(q_files)

# Get manifest for download
ge_manifest <- manifest(q_files)
```

### 3. Field Discovery
Since the GDC data model is complex, use these helpers to find valid field names and values:
*   `available_fields('files')`: List all possible fields for an endpoint.
*   `grep_fields('files', 'workflow')`: Search for specific field names.
*   `available_values('files', 'data_type')`: See valid categorical values for a field.
*   `default_fields('cases')`: See fields returned by default.

### 4. Retrieving Clinical Data
Use `gdc_clinical()` for a simplified interface to demographic, diagnosis, and exposure data.
```r
case_ids <- cases() |> results(size=10) |> ids()
clindat <- gdc_clinical(case_ids)
# Returns a list of tibbles: main, demographic, diagnoses, exposures
```

### 5. Downloading Data
*   **Small/Medium Files**: Use `gdcdata()` to download files directly into a local cache.
*   **Controlled Access**: Requires a GDC authentication token.
```r
# Set token (from environment variable GDC_TOKEN or ~/.gdc_token)
token <- gdc_token()
fnames <- gdcdata(ge_manifest$id[1:5], token = token)
```

### 6. Somatic Mutations (SSMs)
The package provides specific endpoints for mutation data: `ssms()` and `ssm_occurrences()`.
```r
# Find mutations for a specific gene
tp53_muts <- ssms() |>
    filter(consequence.transcript.gene.symbol == 'TP53') |>
    results_all()
```

## Advanced Features

### BAM Slicing
Retrieve specific genomic regions from BAM files without downloading the entire file.
```r
# Requires a token and a file_id for a BAM file
bamfile <- slicing(file_id, regions="chr12:6534405-6538375", token=gdc_token())
```

### Faceting and Aggregation
Generate summary tables (similar to R's `table()`) directly from the API.
```r
res <- cases() |> 
    facet("project.project_id") |> 
    aggregations()
# Access results via res$project.project_id
```

## Tips and Best Practices
*   **Filter Syntax**: Use standard R logical operators (`==`, `&`, `%in%`). While older versions used formulas (`~`), modern versions support direct expressions.
*   **Pagination**: `results()` defaults to 10 records. Use `size` and `from` arguments to page, or `results_all()` for complete sets (use with caution on large queries).
*   **Caching**: The package manages a local cache. Use `gdc_cache()` to inspect or change the cache location.
*   **Select**: `select()` replaces the default fields. To add fields to the defaults, you must explicitly include `default_fields(endpoint)` in your selection.

## Reference documentation
- [The GenomicDataCommons Package](./references/overview.md)
- [Questions and answers from over the years](./references/questions-and-answers.md)
- [Working with simple somatic mutations](./references/somatic_mutations.md)