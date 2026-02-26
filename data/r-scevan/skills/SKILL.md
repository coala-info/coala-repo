---
name: r-scevan
description: SCEVAN performs unsupervised analysis of single-cell RNA-seq data to classify malignant cells and infer copy number profiles. Use when user asks to classify cells as malignant or non-malignant, infer copy number alterations, identify subclonal structures, or analyze clonal evolution in tumor samples.
homepage: https://cran.r-project.org/web/packages/scevan/index.html
---


# r-scevan

name: r-scevan
description: Single-cell Variational Aneuploidy Analysis (SCEVAN) for scRNA-seq data. Use this skill to automatically classify cells as malignant or non-malignant, infer copy number profiles, identify subclonal structures, and analyze clonal evolution in tumor samples.

# r-scevan

## Overview
SCEVAN is an R package designed for the unsupervised analysis of single-cell RNA-seq (scRNA-seq) data from tumor biopsies. It performs two primary tasks:
1. **Cell Classification**: Segregates malignant cells from non-malignant cells (tumor microenvironment) based on aneuploidy.
2. **Clonal Characterization**: Identifies subclonal structures within malignant populations, inferring copy number (CN) profiles and specific alterations for each subpopulation.

The package uses a variational algorithm and a greedy multichannel segmentation approach, making it efficient for large datasets.

## Installation
To install SCEVAN and its required dependencies from GitHub:

```R
if (!require("devtools", quietly = TRUE)) install.packages("devtools")
devtools::install_github("miccec/yaGST")
devtools::install_github("AntonioDeFalco/SCEVAN")
library(SCEVAN)
```

## Core Workflows

### Single-Sample Analysis
The `pipelineCNA` function is the primary entry point for analyzing a single sample. It handles the entire pipeline from raw counts to subclone identification.

```R
# count_mtx: raw count matrix (genes as rows, cells as columns)
# Gene symbols or Ensembl IDs are supported
results <- pipelineCNA(count_mtx, 
                       sample = "SampleName", 
                       par_cores = 20, 
                       organism = "human")
```

**Key Parameters:**
- `norm_cells`: Optional vector of known normal cell names to use as a reference.
- `SUBCLONES`: Set to `TRUE` (default) to analyze clonal structure; `FALSE` for classification only.
- `beta_vega`: Segmentation parameter (default 0.5). Higher values result in coarser segmentation.
- `organism`: "human" (default) or "mouse".

### Multi-Sample Comparison
Compare clonal profiles across multiple samples (e.g., primary vs. metastasis) using `multiSampleComparisonClonalCN`.

```R
# listCountMtx: A named list of raw count matrices
results_multi <- multiSampleComparisonClonalCN(listCountMtx, 
                                               organism = "human", 
                                               par_cores = 20)
```

### Integration with Seurat
SCEVAN results can be easily integrated into Seurat objects for downstream visualization and analysis.

```R
library(Seurat)

# Option 1: Create new Seurat object with SCEVAN metadata
seurObj <- CreateSeuratObject(count_mtx, meta.data = results)

# Option 2: Add to existing Seurat object
seurObj <- AddMetaData(seurObj, metadata = results)
```

### Visualization
Generate copy number heatmaps with cell annotations:

```R
# metadata: data.frame with cell names as rownames
plotCNA_withAnnotCells(SampleName = "MySample", 
                       metadata = pData, 
                       COLUMNS_TO_PLOT = c("cell.assignment", "subclone"))
```

## Tips for Success
- **Input Data**: Use raw count matrices. SCEVAN performs its own internal normalization and filtering.
- **Parallelization**: Use the `par_cores` argument to speed up analysis, especially for datasets with >10,000 cells.
- **Reference Cells**: If you have high-confidence normal cells (e.g., from a non-tumor sample), providing them via `norm_cells` improves the baseline for CN inference.
- **Feature Plotting**: To visualize specific CN alterations on a UMAP, extract the mean value for a genomic region from the `CNA_mtx_relat` object and add it as metadata to your Seurat object.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)