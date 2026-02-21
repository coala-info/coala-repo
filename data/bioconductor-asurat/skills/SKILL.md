---
name: bioconductor-asurat
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ASURAT.html
---

# bioconductor-asurat

## Overview

ASURAT is a Bioconductor package for the multifaceted analysis of single-cell transcriptomes. Unlike standard workflows that cluster cells based on gene expression alone, ASURAT transforms gene expression data into functional feature matrices called **Sign-by-Sample Matrices (SSMs)**. These "signs" represent biological entities such as cell types, metabolic pathways, or biological processes. This approach allows for simultaneous characterization of cells from multiple biological perspectives (e.g., identifying a cell by its type, its signaling activity, and its metabolic state).

## Workflow and Core Functions

### 1. Data Preparation and Preprocessing
ASURAT works with `SingleCellExperiment` (SCE) objects. It requires a "centered" assay where gene expression is mean-centered across samples.

```r
library(ASURAT)
library(SingleCellExperiment)

# Add quality control metadata (nReads, nGenes, percMT)
sce <- add_metadata(sce = sce, mitochondria_symbol = "^MT-")

# Filter variables and samples
sce <- remove_variables(sce, min_nsamples = 10)
sce <- remove_samples(sce, min_nReads = 5000, max_percMT = 10)
sce <- remove_variables_second(sce, min_meannReads = 0.05)

# Normalization and Centering
assay(sce, "logcounts") <- log(assay(sce, "counts") + 1)
mat <- assay(sce, "logcounts")
assay(sce, "centered") <- sweep(mat, 1, apply(mat, 1, mean), FUN = "-")
```

### 2. Sign Analysis Setup
You must load external databases (Cell Ontology, MSigDB, GO, KEGG) to define the biological signs.

```r
# Compute gene-gene correlation matrix (Spearman)
mat_c <- t(as.matrix(assay(sce, "centered")))
cormat <- cor(mat_c[sample(rownames(mat_c), 1000), ], method = "spearman")

# Load and format database (example: GO)
metadata(sce)$sign <- human_GO[["BP"]] 
```

### 3. Creating Signs
Signs are created by clustering genes within functional sets based on their correlation profiles.

*   **`remove_signs()`**: Filters biological terms by gene set size.
*   **`cluster_genesets()`**: Decomposes gene sets into Strongly Correlated (SCG), Variably Correlated (VCG), and Weakly Correlated (WCG) groups.
*   **`create_signs()`**: Finalizes sign definitions based on correlation strength.

```r
sce <- remove_signs(sce, min_ngenes = 2, max_ngenes = 1000)
sce <- cluster_genesets(sce, cormat = cormat, th_posi = 0.30, th_nega = -0.30)
sce <- create_signs(sce, min_cnt_strg = 2, min_cnt_vari = 2)
```

### 4. Sign-by-Sample Matrix (SSM) Generation
The SSM contains "sign scores" which represent the activity of a biological term in a specific cell.

```r
# Create the SSM
sce_ssm <- makeSignMatrix(sce, weight_strg = 0.5, weight_vari = 0.5)
```

### 5. Clustering and Downstream Analysis
Once the SSM is created, you can use standard tools like `Seurat` or `Rtsne` for clustering and visualization, treating sign scores like expression values.

*   **`compute_sepI_all()`**: Identifies "significant signs" (markers) for clusters using the Separation Index (sepI), ranging from -1 to 1.
*   **`plot_multiheatmaps()`**: Visualizes multiple SSMs (e.g., Cell Type, GO, KEGG) and gene expression simultaneously.

```r
# Identify marker signs
sce_ssm <- compute_sepI_all(sce = sce_ssm, labels = colData(sce_ssm)$seurat_clusters)

# Multi-layered heatmap
plot_multiheatmaps(ssm_list = list(CellType = assay(sce_ssm, "counts")), 
                   gem_list = list(GeneExpr = assay(altExp(sce), "counts")),
                   nrand_samples = 100)
```

## Tips for Success
*   **Parameter Tuning**: The thresholds `th_posi` and `th_nega` in `cluster_genesets()` are critical. Typical values range between 0.15 and 0.4.
*   **Redundancy**: Use `remove_signs_redundant()` for GO terms to collapse semantically similar biological processes using a similarity matrix.
*   **Seurat Integration**: Use `Seurat::as.Seurat(sce, counts = "counts", data = "counts")` to leverage Seurat's community detection clustering on the SSM.
*   **Memory**: For large datasets, compute the correlation matrix (`cormat`) on a random subset of cells (e.g., 1000-2000) to save time and memory.

## Reference documentation
- [ASURAT](./references/ASURAT.md)