---
name: bioconductor-snapcount
description: The snapcount package provides an R interface to Snaptron web services for querying and downloading targeted RNA-seq coverage data across large sample compilations. Use when user asks to query gene or exon expression, retrieve splice junction counts, calculate percent spliced in, or compare RNA-seq data across different genomic compilations.
homepage: https://bioconductor.org/packages/release/bioc/html/snapcount.html
---


# bioconductor-snapcount

## Overview

The `snapcount` package provides an R interface to the Snaptron web services, allowing users to query and download RNA-seq coverage data for specific genes, exons, or splice junctions. Unlike the `recount` package, which is optimized for study-wide downloads, `snapcount` is designed for targeted queries across tens of thousands of samples. Results are returned as `RangedSummarizedExperiment` (RSE) objects, facilitating immediate integration with Bioconductor workflows.

## Core Workflow

### 1. Initialize a Query
All queries start with a `QueryBuilder` object which defines the data source (compilation) and the genomic regions of interest.

```r
library(snapcount)

# Create a builder for a specific compilation (e.g., "gtex", "tcga", "srav2")
sb <- QueryBuilder(compilation = "gtex", regions = "CD99")

# Regions can also be genomic coordinates
sb_coords <- QueryBuilder(compilation = "tcga", regions = "chr19:45297955-45298142")
```

### 2. Apply Filters
You can filter results by row (genomic features) or by column (sample metadata).

```r
# Filter samples by metadata (e.g., only Brain tissue)
sb <- set_column_filters(sb, SMTS == "Brain")

# Filter features (e.g., only annotated junctions)
sb <- set_row_filters(sb, annotated == 1)

# Set coordinate matching behavior (Exact, Within, etc.)
sb <- set_coordinate_modifier(sb, Coordinates$Exact)
```

### 3. Execute Query
Retrieve data as a `RangedSummarizedExperiment`.

```r
# Query genes
genes_rse <- query_gene(sb)

# Query exons
exons_rse <- query_exon(sb)

# Query splice junctions
jx_rse <- query_jx(sb)
```

## High-Level Analysis Functions

`snapcount` includes specialized functions for splicing analysis that return data frames:

*   **Percent Spliced In (PSI):** Calculates exon inclusion levels based on inclusion and exclusion junction queries.
    ```r
    psi_df <- percent_spliced_in(inclusion_l_list, inclusion_r_list, exclusion_list)
    ```
*   **Junction Inclusion Ratio (JIR):** Compares the relative prevalence of two sets of junctions.
    ```r
    jir_df <- junction_inclusion_ratio(list(query_A), list(query_B))
    ```
*   **Tissue Specificity (TS):** Identifies if junctions are associated with specific tissue types.
    ```r
    ts_df <- tissue_specificity(list(query_A))
    ```
*   **Shared Sample Count (SSC):** Reports how many samples contain co-occurring junctions.
    ```r
    ssc_df <- shared_sample_counts(list(query_A), list(query_B))
    ```

## Combining Compilations

You can merge results from different compilations (e.g., comparing GTEx "normal" to TCGA "tumor") using union or intersection functions:

```r
# Get junctions found in either compilation
union_rse <- junction_union(gtex_builder, tcga_builder)

# Get junctions found in both compilations
intersect_rse <- junction_intersection(gtex_builder, tcga_builder)
```

## Tips for Success
*   **Metadata:** Sample metadata is stored in `colData(rse)`. Note that metadata fields vary significantly between compilations (e.g., `srav2` vs `gtex`).
*   **Raw Counts:** All counts returned are raw, un-normalized counts.
*   **Performance:** The more specific the `regions` and `filters`, the faster the query will return.

## Reference documentation
- [snapcount quick start guide](./references/snapcount_vignette.md)
- [snapcount Rmd source](./references/snapcount_vignette.Rmd)