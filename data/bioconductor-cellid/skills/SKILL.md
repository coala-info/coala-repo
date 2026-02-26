---
name: bioconductor-cellid
description: Bioconductor-cellid extracts per-cell gene signatures and performs cell identity recognition using Multiple Correspondence Analysis. Use when user asks to perform clustering-free cell type prediction, match cells across datasets, or conduct functional enrichment analysis on single-cell RNA-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/CelliD.html
---


# bioconductor-cellid

name: bioconductor-cellid
description: Extraction of per-cell gene signatures and cell identity recognition using Multiple Correspondence Analysis (MCA). Use this skill to perform clustering-free cell type prediction, cell-to-cell matching across datasets, and functional enrichment analysis on single-cell RNA-seq data (Seurat or SingleCellExperiment objects).

# bioconductor-cellid

## Overview
CelliD is a multivariate statistical method for extracting robust gene signatures from single-cell data at the individual cell level. Unlike traditional methods that rely on clustering, CelliD uses Multiple Correspondence Analysis (MCA) to project cells and genes into a shared low-dimensional space. This allows for unbiased cell type assignment, cross-dataset label transfer, and functional annotation by calculating the distance between cells and specific gene sets.

## Core Workflow

### 1. Data Preparation
CelliD works with `Seurat` (v3+) or `SingleCellExperiment` objects. It is highly recommended to restrict the analysis to protein-coding genes.

```r
library(CelliD)
library(Seurat)

# Load provided protein-coding gene lists
data("HgProteinCodingGenes") 

# Filter and create Seurat object
counts_filtered <- raw_counts[rownames(raw_counts) %in% HgProteinCodingGenes, ]
seurat_obj <- CreateSeuratObject(counts = counts_filtered)

# Standard normalization
seurat_obj <- NormalizeData(seurat_obj)
seurat_obj <- ScaleData(seurat_obj, features = rownames(seurat_obj))
```

### 2. Dimensionality Reduction (MCA)
The core of CelliD is the `RunMCA` function, which replaces or complements PCA.

```r
# Perform MCA
seurat_obj <- RunMCA(seurat_obj)

# Visualize cells and specific marker genes in MCA space
DimPlotMC(seurat_obj, reduction = "mca", features = c("INS", "GCG"), as.text = TRUE)
```

### 3. Cell Type Prediction (Hypergeometric Test)
Use `RunCellHGT` to calculate the enrichment of pre-defined marker lists (e.g., from PanglaoDB) for every single cell.

```r
# pathways must be a named list of gene vectors
# n.features = 200 is the default signature size per cell
hgt_matrix <- RunCellHGT(seurat_obj, pathways = marker_list, dims = 1:50)

# Assign the best-fitting cell type (p-value < 0.01 is -log10 > 2)
predictions <- rownames(hgt_matrix)[apply(hgt_matrix, 2, which.max)]
significant_preds <- ifelse(apply(hgt_matrix, 2, max) > 2, predictions, "unassigned")
seurat_obj$cellid_type <- significant_preds
```

### 4. Label Transfer and Cell Matching
CelliD can match cells across different datasets (e.g., Human to Mouse) by extracting signatures from a reference and testing them on a query.

*   **Cell-to-Cell (CelliD-c):** `GetCellGeneSet(reference_obj)`
*   **Group-to-Cell (CelliD-g):** `GetGroupGeneSet(reference_obj, group.by = "label")`

```r
# 1. Extract signatures from reference
ref_signatures <- GetGroupGeneSet(reference_obj, group.by = "celltype")

# 2. Project query data into MCA space
query_obj <- RunMCA(query_obj)

# 3. Test reference signatures on query cells
hgt_transfer <- RunCellHGT(query_obj, pathways = ref_signatures, dims = 1:50)
```

### 5. Functional Annotation
You can treat pathway databases (KEGG, Reactome, Hallmark) as marker lists to perform per-cell functional enrichment.

```r
# Hallmark is provided in the package
hgt_hallmark <- RunCellHGT(seurat_obj, pathways = Hallmark, dims = 1:50)

# Add as an assay for visualization
seurat_obj[["Hallmark"]] <- CreateAssayObject(hgt_hallmark)
FeaturePlot(seurat_obj, features = "GLYCOLYSIS", reduction = "umap")
```

## Tips for Success
*   **Gene Symbols:** Ensure your object uses official Gene Symbols, as most reference databases (Panglao, MSigDB) use them.
*   **Signature Size:** The `n.features` parameter (default 200) defines how many of the top-ranked genes for a cell are used for the enrichment test.
*   **Significance:** A `-log10(p-value)` threshold of 2 (representing p < 0.01 after BH correction) is the standard for "assigned" vs "unassigned" cells.

## Reference documentation
- [CelliD Vignette](./references/BioconductorVignette.md)