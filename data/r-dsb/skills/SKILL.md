---
name: r-dsb
description: This tool normalizes and denoises protein expression data from droplet-based single-cell experiments by removing ambient and technical noise. Use when user asks to normalize ADT counts, remove ambient protein noise using empty droplets, or denoise CITE-seq data using isotype controls.
homepage: https://cran.r-project.org/web/packages/dsb/index.html
---

# r-dsb

## Overview
The `dsb` (Denoised and Scaled by Background) package provides a method for normalizing and denoising protein expression data from droplet-based single-cell experiments. It addresses two major noise components:
1. **Ambient Noise**: Protein-specific noise from unbound antibodies in droplets, inferred from empty droplets.
2. **Technical Noise**: Cell-specific noise revealed by shared variance across isotype controls and background protein counts.

## Installation
```R
install.packages("dsb")
library(dsb)
```

## Core Workflow: DSBNormalizeProtein
The primary function is `DSBNormalizeProtein()`. It requires a raw ADT count matrix for cells and a raw ADT count matrix for empty droplets.

### Standard Usage
```R
# cell_protein_matrix: matrix of raw ADT counts (rows=proteins, cols=cells)
# empty_drop_matrix: matrix of raw ADT counts from empty droplets
# isotype.control.name.vec: vector of rownames corresponding to isotype controls

normalized_matrix <- DSBNormalizeProtein(
  cell_protein_matrix = cell_adt_raw,
  empty_drop_matrix = empty_drop_adt_raw,
  denoise.counts = TRUE,
  use.isotype.control = TRUE,
  isotype.control.name.vec = c("IgG1", "IgG2a", "IgG2b")
)
```

### Defining Empty Droplets
To use `dsb` effectively, you must load the **raw** (unfiltered) matrix from your aligner (e.g., Cell Ranger `raw_feature_bc_matrix`) to identify background droplets.
- **Cells**: Barcodes called as cells by the aligner.
- **Empty Droplets**: Barcodes with low RNA content but sufficient ADT counts (e.g., log10 ADT library size between 1.5 and 3).

## Advanced Workflows

### Data Lacking Isotype Controls
If isotype controls are unavailable, you can still remove ambient noise:
```R
normalized_matrix <- DSBNormalizeProtein(
  cell_protein_matrix = cell_adt_raw,
  empty_drop_matrix = empty_drop_adt_raw,
  denoise.counts = FALSE # Only step 1 (ambient removal)
)
```

### No Empty Droplets Available
If you only have the filtered cell matrix, use `ModelNegativeADTnorm()` to infer the background population via a Gaussian Mixture Model:
```R
normalized_matrix <- ModelNegativeADTnorm(
  cell_protein_matrix = cell_adt_raw,
  denoise.counts = TRUE,
  use.isotype.control = TRUE,
  isotype.control.name.vec = isotypes
)
```

### Large Datasets (Fast Mode)
For datasets with >100k cells, use `fast.km = TRUE` to speed up the denoising step by ~10-fold:
```R
normalized_matrix <- DSBNormalizeProtein(
  cell_protein_matrix = cell_adt_raw,
  empty_drop_matrix = empty_drop_adt_raw,
  fast.km = TRUE
)
```

## Integration with Seurat
Add `dsb` normalized values to the `data` slot of a Seurat Assay (do not put them in `counts` as they are already normalized and contain negative values).

```R
# Create Seurat object with RNA
pbmc <- CreateSeuratObject(counts = rna_counts)

# Add dsb normalized protein to a new assay
pbmc[["ADT"]] <- CreateAssayObject(data = normalized_matrix)

# Downstream: skip NormalizeData for ADT; go straight to ScaleData or PCA
DefaultAssay(pbmc) <- "ADT"
pbmc <- ScaleData(pbmc)
pbmc <- RunPCA(pbmc, reduction.name = "apca")
```

## Tips for Success
- **Outliers**: If normalized values have an extreme range (e.g., > 50), use `quantile.clipping = TRUE` in `DSBNormalizeProtein`.
- **Interpretation**: `dsb` values are interpretable as standard deviations above the expected noise. A value of 3-4 is often a good threshold for "positive" expression.
- **Sparse Matrices**: Convert large sparse matrices to dense matrices (`as.matrix()`) before passing to `dsb` if memory allows, as `dsb` performs dense matrix operations.

## Reference documentation
- [End-to-end CITE-seq analysis workflow](./references/end_to_end_workflow.Rmd)
- [Understanding how the dsb method works](./references/understanding_dsb.Rmd)
- [Normalizing without empty droplets](./references/no_empty_drops.Rmd)
- [Fast normalization for large datasets](./references/fastkm.Rmd)
- [Additional Topics: Python, Bioconductor, and FAQ](./references/additional_topics.Rmd)