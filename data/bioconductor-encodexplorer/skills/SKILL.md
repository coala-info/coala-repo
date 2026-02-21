---
name: bioconductor-encodexplorer
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/ENCODExplorer.html
---

# bioconductor-encodexplorer

name: bioconductor-encodexplorer
description: Access and query ENCODE project metadata, download files, and generate consensus peaks or expression summaries. Use this skill when you need to search for genomic data (ChIP-seq, RNA-seq, etc.) from the ENCODE Consortium, organize experimental designs, or download specific datasets for analysis in R.

# bioconductor-encodexplorer

## Overview

The `ENCODExplorer` package facilitates access to the Encyclopedia of DNA Elements (ENCODE) database. It provides a local, searchable metadata database that allows users to query experiments, biosamples, and files without navigating the web portal. It includes tools for downloading files with MD5 verification and helper functions to aggregate data into consensus peaks (ChIP-seq) or expression summaries (RNA-seq).

## Core Workflow

### 1. Initialize Metadata
To perform queries, you must first load the metadata `data.table`. By default, this is retrieved via `AnnotationHub`.

```r
library(ENCODExplorer)
encode_df <- get_encode_df()
```

### 2. Querying the Database
There are three primary ways to find data:

*   **Specific Queries (`queryEncode`):** Use for structured searches on specific columns (e.g., assay, biosample, organism).
    *   `fixed = TRUE`: Exact string matching (default).
    *   `fixed = FALSE`: Allows regular expressions.
    *   `fuzzy = TRUE`: Allows partial matches.
*   **Generic Queries (`queryEncodeGeneric`):** Search columns not included in the standard `queryEncode` interface.
*   **Keyword Search (`searchEncode`):** Simulates the ENCODE portal's keyword search. Use `searchToquery()` to convert these results into the standard metadata format.
*   **Global Search (`fuzzySearch`):** Searches for a term across all columns in the database.

```r
# Example: Find human MCF-7 fastq files
results <- queryEncode(organism = "Homo sapiens", 
                       biosample_name = "MCF-7", 
                       file_format = "fastq")

# Example: Regex search for RNA-seq in HeLa cells
results_regex <- queryEncode(assay = ".*RNA-seq",
                             biosample_name = "HeLa-S3", 
                             fixed = FALSE)
```

### 3. Organizing and Downloading
Once you have a result set, you can organize it into an experimental design or download the files.

*   **`createDesign`:** Organizes results into a table of replicates and controls.
*   **`downloadEncode`:** Downloads files. It accepts a vector of accessions or the data table returned by query functions. It automatically verifies file integrity using MD5 sums.

```r
# Download all files from a query result
downloadEncode(results, destdir = "data/encode")
```

## Specialized Summaries

### ChIP-Seq Consensus Peaks
`queryConsensusPeaks` identifies peaks present across all replicates for a specific target and biosample.

```r
# Get consensus peaks for CTCF in 22Rv1 cells
ctcf_peaks <- queryConsensusPeaks(biosample = "22Rv1", 
                                  assembly = "GRCh38", 
                                  target = "CTCF")

# Access results
consensus_gr <- consensus(ctcf_peaks)
```

### RNA-Seq Expression Summaries
`queryGeneExpression` and `queryTranscriptExpression` aggregate expression metrics (e.g., FPKM, TPM) and calculate mean values per condition.

```r
# Get gene expression for bone marrow samples
exp_res <- queryGeneExpression("bone marrow")
metrics <- metric_data(exp_res)
```

## Tips and Best Practices
*   **Interactive Mode:** Set `use_interactive = TRUE` in summary functions to manually select assemblies or assays if the heuristics choose the wrong files.
*   **Metadata Updates:** The metadata is updated with Bioconductor releases. For the absolute latest data, use `AnnotationHub` to search for "ENCODExplorerData".
*   **Shiny Interface:** Use `shinyEncode()` to launch a local web application for GUI-based searching and design creation.

## Reference documentation
- [ENCODExplorer: A compilation of metadata from ENCODE](./references/ENCODExplorer.Rmd)