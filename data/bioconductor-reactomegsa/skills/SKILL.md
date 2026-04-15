---
name: bioconductor-reactomegsa
description: The ReactomeGSA package provides a client interface to perform multi-omics gene set enrichment analysis using the Reactome Analysis System. Use when user asks to perform pathway analysis on transcriptomics or proteomics data, conduct cross-species comparisons, analyze single-cell RNA-sequencing data via pseudo-bulk or ssGSEA, or retrieve public datasets from Reactome.
homepage: https://bioconductor.org/packages/release/bioc/html/ReactomeGSA.html
---

# bioconductor-reactomegsa

## Overview
The `ReactomeGSA` package acts as a client for the web-based Reactome Analysis System. It allows researchers to perform gene set enrichment analysis using the most current Reactome pathway database. Key features include the ability to analyze multiple 'omics types (Proteomics and Transcriptomics) side-by-side, support for cross-species comparisons, and specialized workflows for single-cell RNA-sequencing data (pseudo-bulk or ssGSEA).

## Core Workflow

### 1. Setup and Method Selection
Check available analysis methods (e.g., "Camera", "PADOG", "ssGSEA") before starting.

```r
library(ReactomeGSA)
methods <- get_reactome_methods(print_methods = FALSE, return_result = TRUE)
methods$name
```

### 2. Creating a Request
Initialize an analysis request by specifying a method and setting global parameters.

```r
my_request <- ReactomeAnalysisRequest(method = "Camera")
my_request <- set_parameters(request = my_request, max_missing_values = 0.5)
```

### 3. Adding Datasets
You can add multiple datasets to a single request. Supported objects include `EList`, `DGEList`, `ExpressionSet`, or `data.frame`.

```r
# Example adding an RNA-seq dataset
my_request <- add_dataset(request = my_request, 
                          expression_values = rnaseq_data, 
                          name = "RNA-seq", 
                          type = "rnaseq_counts",
                          comparison_factor = "condition", 
                          comparison_group_1 = "Control", 
                          comparison_group_2 = "Treatment")
```

### 4. Performing Analysis
Submit the request to the Reactome API.

```r
result <- perform_reactome_analysis(request = my_request, compress = FALSE)
```

## Single-Cell RNA-seq Analysis
There are two primary ways to handle scRNA-seq data (e.g., Seurat objects):

1.  **Pseudo-bulk Approach**: Aggregates cells into "bulks" for classical differential pathway analysis.
    ```r
    pb_data <- generate_pseudo_bulk_data(seurat_obj, group_by = "clusters")
    pb_metadata <- generate_metadata(pb_data)
    # Add pb_data to a standard ReactomeAnalysisRequest
    ```
2.  **Cluster-level ssGSEA**: Calculates pathway expression per cluster.
    ```r
    gsva_result <- analyse_sc_clusters(seurat_obj)
    pathway_expr <- pathways(gsva_result)
    ```

## Working with Public Data
Search and load reprocessed public datasets directly into R.

```r
# Search for human melanoma datasets
datasets <- find_public_datasets("melanoma", species = "Homo sapiens")

# Load a specific dataset by its row in the search results
study_data <- load_public_dataset(datasets[1, ])
```

## Visualizing Results
`ReactomeGSA` provides several functions to interpret the `ReactomeAnalysisResult` object.

*   **Pathway Results**: `pathways(result)` returns a merged data frame of all results.
*   **Volcano Plot**: `plot_volcano(result, dataset_index = 1)`
*   **Correlations**: `plot_correlations(result)` (compares two datasets in the same request).
*   **Heatmaps**: `plot_heatmap(result)` or `plot_gsva_heatmap(gsva_result)` for scRNA-seq.
*   **Web Browser**: `open_reactome(result)` opens the interactive Reactome Pathway Browser.

## Reference documentation
- [Analysing single-cell RNA-sequencing Data](./references/analysing-scRNAseq.md)
- [Loading and re-analysing public data through ReactomeGSA](./references/reanalysing-public-data.md)
- [Using the ReactomeGSA package](./references/using-reactomegsa.md)