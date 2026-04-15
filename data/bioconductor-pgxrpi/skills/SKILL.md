---
name: bioconductor-pgxrpi
description: This package retrieves, processes, and visualizes oncogenomic data and clinical metadata from the Progenetix database via the Beacon v2 API. Use when user asks to query cancer genomic profiles, analyze copy number variations, or generate survival and CNV frequency plots in R.
homepage: https://bioconductor.org/packages/release/bioc/html/pgxRpi.html
---

# bioconductor-pgxrpi

name: bioconductor-pgxrpi
description: Expert guidance for the pgxRpi Bioconductor package to retrieve, process, and visualize genomic data (CNVs, variants, metadata) from the Progenetix database via the Beacon v2 API. Use this skill when a user needs to query cancer oncogenomic profiles, analyze copy number variations (CNV), or generate survival plots and CNV frequency visualizations in R.

# bioconductor-pgxrpi

## Overview
The `pgxRpi` package serves as an R client for the Progenetix REST API. It allows users to access curated oncogenomic data, specifically Copy Number Variations (CNV) and associated clinical metadata. The package facilitates the retrieval of biosamples, individuals, and variant data, and provides specialized functions for visualizing survival data (Kaplan-Meier plots) and CNV frequencies (genome-wide, per-chromosome, or circos plots).

## Core Workflows

### 1. Data Retrieval with `pgxLoader`
The `pgxLoader` function is the primary entry point for fetching data.

*   **Metadata (Individuals/Biosamples):**
    ```r
    library(pgxRpi)
    # Search for biosamples by NCIt filter
    biosamples <- pgxLoader(type="biosamples", filters = "NCIT:C7541")
    # Search for individuals
    individuals <- pgxLoader(type="individuals", filters = "NCIT:C3512")
    ```
*   **Genomic Variants:**
    Note: Variant queries usually require `biosample_id`.
    ```r
    # Get variants in default format
    variants <- pgxLoader(type="g_variants", biosample_id = "pgxbs-kftvki7h")
    # Get variants in .pgxseg format (includes log2 values)
    variants_seg <- pgxLoader(type="g_variants", biosample_id = "pgxbs-kftvki7h", output = "pgxseg")
    ```
*   **CNV Frequencies and Fractions:**
    ```r
    # Retrieve pre-calculated frequencies for a cohort
    freq <- pgxLoader(type="cnv_frequency", filters = "NCIT:C3058")
    # Retrieve CNV fractions (sample-wise proportions)
    fractions <- pgxLoader(type="cnv_fraction", filters = "NCIT:C2948")
    ```

### 2. Visualization
*   **Survival Plots:** Use `pgxMetaplot` with data from `pgxLoader(type="individuals", ...)`.
    ```r
    pgxMetaplot(data = luad_inds, group_id = "age_iso", condition = "P70Y", pval = TRUE)
    ```
*   **CNV Frequency Plots:** Use `pgxFreqplot`.
    ```r
    # Genome-wide plot
    pgxFreqplot(freq_data, filters = "NCIT:C3058")
    # Circos plot for multiple filters
    pgxFreqplot(freq_matrix, filters = c("NCIT:C3493", "NCIT:C3512"), circos = TRUE)
    ```

### 3. Processing Local Files
The `pgxSegprocess` function handles local `.pgxseg` files, which are common in the Progenetix ecosystem.
```r
# Extract metadata and segments from a local file
data <- pgxSegprocess(file = "path/to/file.pgxseg", return_metadata = TRUE, return_seg = TRUE)
```

## Key Parameters & Tips
*   **Filters:** Use `pgxLoader(type="filtering_terms")` to find valid ontology terms (NCIT, ICD-O).
*   **Codematches:** Set `codematches = TRUE` to restrict results to an exact term, excluding child terms in the ontology hierarchy.
*   **Parallel Processing:** Use `num_cores` to speed up multi-sample variant queries.
*   **Domains:** Switch between `"progenetix.org"` (default) and `"cancercelllines.org"` using the `domain` parameter.
*   **Output Formats:** For CNV data, `output = "pgxmatrix"` returns a `SummarizedExperiment` object, which is standard for Bioconductor workflows.

## Reference documentation
- [Load Metadata and Biosamples](./references/Introduction_1_load_metadata.md)
- [Query Genomic Variants](./references/Introduction_2_query_variants.md)
- [Access CNV Frequency](./references/Introduction_3_access_cnv_frequency.md)
- [Process pgxseg Files](./references/Introduction_4_process_pgxseg.md)