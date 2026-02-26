---
name: bioconductor-humantranscriptomecompendium
description: This package provides programmatic access to a large-scale collection of uniformly processed human RNA-seq data stored in the cloud as SummarizedExperiment objects. Use when user asks to load gene-level quantifications, query RNA-seq data by study accession, filter datasets by metadata, or materialize remote transcriptomic data for analysis.
homepage: https://bioconductor.org/packages/3.9/bioc/html/HumanTranscriptomeCompendium.html
---


# bioconductor-humantranscriptomecompendium

## Overview

The `HumanTranscriptomeCompendium` package provides programmatic access to a massive, uniformly processed collection of human RNA-seq data stored in the cloud. It utilizes the HDF Scalable Data Service (HSDS) to allow users to interact with data as `SummarizedExperiment` objects without downloading the entire dataset. This is ideal for cross-study comparisons, meta-analyses, and large-scale expression queries.

## Core Workflows

### Loading the Compendium

The primary entry point is `htx_load()`, which establishes a connection to the remote HDF5 data.

```r
library(HumanTranscriptomeCompendium)

# Load gene-level quantifications (default)
htx_gene = htx_load(genesOnly = TRUE)

# Access the underlying DelayedArray assay
# Note: Data is fetched from the cloud only when materialized (e.g., as.matrix)
assay(htx_gene)
```

### Querying by Study Accession

If you know specific SRA study accessions (e.g., SRP numbers), use the dedicated query function to retrieve a subsetted `SummarizedExperiment`.

```r
studies <- c("SRP073777", "SRP073813")
htx_subset <- htx_query_by_study_accession(studies)
```

### Filtering and Identifying Studies

You can use standard `SummarizedExperiment` subsetting and metadata filtering on the object returned by `htx_load`.

*   **Identify Single-Cell Studies:** Search the `study_title` in the `colData`.
    ```r
    is_sc <- grep("single.cell", htx_gene$study_title, ignore.case = TRUE)
    htx_sc <- htx_gene[, is_sc]
    ```
*   **Filter by Disease:**
    ```r
    is_glio <- grep("glioblastoma", htx_gene$study_title, ignore.case = TRUE)
    glio_data <- htx_gene[, is_glio]
    ```

### Materializing Data

Because the data is stored remotely as a `DelayedMatrix`, you should only materialize the specific rows (genes) or columns (samples) you need for analysis to avoid network timeouts or memory issues.

```r
# Materialize a specific gene across 100 samples
gene_id <- "ENSG00000138413.13"
vals <- as.matrix(assay(htx_gene[gene_id, 1:100]))
```

## Metadata and Utilities

*   **`addRD()`**: Enhances the `rowData` of the compendium object with gene types, symbols, and IDs.
    ```r
    htx_gene <- addRD(htx_gene)
    ```
*   **`sampleAtts(accession)`**: Fetches detailed SRA sample attributes for a specific study accession in real-time.
*   **`htx_app()`**: Launches a Shiny gadget for interactive searching and retrieval of studies based on titles and sizes.
*   **`tx2gene_gencode27()`**: Provides a mapping between transcripts and genes based on Gencode v27.

## Usage Tips

1.  **Bioconductor Version:** This package relies on `restfulSE` and `rhdf5client`. Ensure your Bioconductor version is 3.10 or higher for full compatibility with the HSDS backend.
2.  **Chunking:** When requesting data for thousands of genes or samples, the HSDS may error. It is best to process large requests in smaller chunks.
3.  **Transcript Level:** While `htx_load(genesOnly = FALSE)` exists, gene-level data is generally more stable for retrieval.

## Reference documentation

- [HumanTranscriptomeCompendium – a cloud-resident collection of sequenced human transcriptomes](./references/htxcomp.md)