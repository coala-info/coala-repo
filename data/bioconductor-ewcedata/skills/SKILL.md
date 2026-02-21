---
name: bioconductor-ewcedata
description: The package provides tools for testing enrichments within simple gene lists (such as human disease associated genes) and those resulting from differential expression studies. The package does not depend upon any particular Single Cell Transcriptome dataset and user defined datasets can be loaded in and used in the analyses.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ewceData.html
---

# bioconductor-ewcedata

## Overview
The `ewceData` package is a dedicated data companion for the `EWCE` (Expression Weighted Celltype Enrichment) Bioconductor package. It provides essential reference resources, including single-cell RNA-seq datasets from the mouse brain, human-mouse ortholog tables, and example gene lists associated with neurological disorders (e.g., Alzheimer's, Schizophrenia). These datasets are primarily used to test for enrichment of specific gene sets within defined cell types.

## Data Access and Usage
Unlike standard R data packages where datasets are loaded via `data()`, `ewceData` uses accessor functions to retrieve data objects.

### Loading the Library
```r
library(ewceData)
```

### Accessing Key Datasets
Call the function corresponding to the dataset name to load it into your environment:

*   **Cell Type Data (CTD):** Pre-processed objects for enrichment analysis.
    ```r
    ctd_data <- ctd()
    ```
*   **Single-Cell Transcriptomes:** Raw expression and annotation data.
    ```r
    cortex_info <- cortex_mrna()
    # Access expression matrix: cortex_info$exp
    # Access annotations: cortex_info$annot
    ```
*   **Homology Mapping:** Human to Mouse orthologs.
    ```r
    orthologs <- mouse_to_human_homologs()
    ```
*   **Example Gene Lists:**
    ```r
    # Alzheimer's associated genes
    ad_genes <- example_genelist()
    # Differential expression tables
    alz_tt <- tt_alzh()
    ```

### Common Data Objects
| Function | Description |
| :--- | :--- |
| `ctd()` | Main CellTypeData object used by EWCE functions |
| `mouse_to_human_homologs()` | Mapping table for cross-species analysis |
| `cortex_mrna()` | Zeisel et al. cortex/hippocampus dataset |
| `hypothalamus_mrna()` | Hypothalamus single-cell dataset |
| `all_mgi()` / `all_hgnc()` | Comprehensive lists of gene symbols |
| `schiz_genes()` | Schizophrenia associated gene list |

## Typical Workflow Integration
The data provided by this package is typically passed directly into `EWCE` analysis functions:

1.  **Load Reference:** Load the `ctd` object.
2.  **Load Target:** Load a gene list (e.g., `example_genelist()`).
3.  **Run Enrichment:** Use `EWCE::bootstrap_enrichment_test()` with the loaded data.

### Example: Visualizing Expression Distribution
To verify the expression of a specific gene across cell types in the reference data:
```r
library(ggplot2)
cortex_data <- cortex_mrna()
gene_name <- "Necab1"

# Create data frame for plotting
df <- data.frame(
  expression = cortex_data$exp[gene_name, ],
  cell_type = cortex_data$annot[colnames(cortex_data$exp), ]$level1class
)

ggplot(df, aes(x = cell_type, y = expression)) + 
  geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

## Tips
*   **Annotation Requirements:** If creating your own datasets to match `ewceData` formats, ensure your annotation data frame contains the columns `cell_id`, `level1class`, and `level2class`.
*   **Memory Management:** Some datasets (like `cortex_mrna`) contain large expression matrices. Only load the specific objects required for your current analysis.

## Reference documentation
- [Data package for Expression Weighted Celltype Enrichment EWCE](./references/ewceData.Rmd)
- [Data package for Expression Weighted Celltype Enrichment EWCE](./references/ewceData.md)