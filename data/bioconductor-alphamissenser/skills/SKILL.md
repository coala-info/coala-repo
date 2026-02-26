---
name: bioconductor-alphamissenser
description: This tool provides an R interface to access, query, and integrate AlphaMissense pathogenicity predictions for missense variants using DuckDB and Bioconductor objects. Use when user asks to retrieve AlphaMissense data for hg19 or hg38, map predictions to AlphaFold protein structures, perform genomic range-based joins, or benchmark variant scores against ClinVar and ProteinGym.
homepage: https://bioconductor.org/packages/release/bioc/html/AlphaMissenseR.html
---


# bioconductor-alphamissenser

name: bioconductor-alphamissenser
description: Access and integrate AlphaMissense pathogenicity predictions for missense variants. Use this skill when you need to retrieve AlphaMissense data (hg19/hg38), map predictions to protein structures (AlphaFold), benchmark against ClinVar or ProteinGym, or perform genomic range-based joins with variant pathogenicity scores in R.

## Overview
AlphaMissenseR provides an R interface to the AlphaMissense dataset, which contains pathogenicity predictions for over 70 million missense variants. The package utilizes DuckDB for efficient data storage and querying, allowing users to explore large-scale variant data without loading everything into memory. It integrates seamlessly with the Bioconductor ecosystem, including GenomicRanges and AnnotationHub.

## Core Workflow

### 1. Data Discovery and Retrieval
Use `am_available()` to see available datasets on Zenodo. Data is cached locally using `BiocFileCache`.

```r
library(AlphaMissenseR)

# List available datasets (hg38, hg19, aa_substitutions, etc.)
am_available()

# Download and connect to a specific dataset (e.g., hg38)
# This returns a DuckDB-backed tbl
hg38_tbl <- am_data("hg38")
```

### 2. Database Management
The package manages DuckDB connections automatically. Always disconnect at the end of a session.

```r
# Get the current connection
db <- db_connect()

# List tables in the database
db_tables(db)

# Disconnect all active connections
db_disconnect_all()
```

### 3. Genomic Integration
Convert AlphaMissense tables to Bioconductor objects for range-based analysis.

```r
# Filter and convert to GPos (memory efficient for SNPs)
gpos <- hg38_tbl |>
    filter(CHROM == "chr2", POS < 1000000) |>
    to_GPos()

# Perform a range join between a local GRanges object and the database
# This is highly efficient for large-scale overlaps
db_rw <- db_connect(read_only = FALSE)
db_temporary_table(db_rw, my_regions_df, "target_regions")
results <- db_range_join(db_rw, "hg38", "target_regions", "output_table")
```

### 4. Visualization and Benchmarking
AlphaMissenseR includes specialized functions for structural and clinical data integration.

*   **AlphaFold Integration**: Use `af_prediction_view(aa_data)` to visualize pathogenicity on 3D protein structures.
*   **ClinVar**: Use `clinvar_data()` to access clinical classifications and `clinvar_plot(uniprotId = "...")` to compare predictions with clinical labels.
*   **Genomic Tracks**: Use `gosling_plot(gpos, plot_type = "lollipop")` for interactive genome browser views.

## Tips and Best Practices
*   **Lazy Evaluation**: Most `am_data()` operations return `dbplyr` tables. Use `filter()`, `select()`, and `summarize()` before calling `collect()` to keep computation within DuckDB.
*   **UniProt IDs**: The package relies heavily on UniProt accessions for mapping between genomic coordinates and protein structures.
*   **DuckDB Versions**: If you encounter "IO Error: Trying to read a database file with version X", the most reliable fix is to clear the cache using `BiocFileCache::bfcremove()` and re-download the data.
*   **Write Access**: Use `db_connect(read_only = FALSE)` only when you need to create temporary tables for joins; otherwise, stick to the default read-only mode to prevent file locking issues.

## Reference documentation
- [AlphaFold Integration](./references/alphafold.md)
- [Benchmarking with ProteinGym](./references/benchmarking.md)
- [ClinVar Integration](./references/clinvar.md)
- [Introduction to AlphaMissenseR](./references/introduction.md)
- [Issues & Solutions](./references/issues.md)