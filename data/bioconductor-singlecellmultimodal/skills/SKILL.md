---
name: bioconductor-singlecellmultimodal
description: This package provides access to curated landmark single-cell multimodal datasets through a unified Bioconductor interface. Use when user asks to download multi-omics datasets, load CITE-seq or scMultiome data, or explore integrated single-cell experiments as MultiAssayExperiment objects.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SingleCellMultiModal.html
---


# bioconductor-singlecellmultimodal

name: bioconductor-singlecellmultimodal
description: Access and manage curated single-cell multimodal landmark datasets from Bioconductor. Use this skill to download, load, and explore datasets like CITE-seq, scNMT-seq, G&T-seq, SCoPE2, and seqFISH, typically represented as MultiAssayExperiment or SingleCellExperiment objects.

## Overview

The `SingleCellMultiModal` package provides a unified interface to landmark multi-omics single-cell datasets. It leverages the `MultiAssayExperiment` (MAE) framework to harmonize different modalities (e.g., RNA, ADT, ATAC, Methylation) measured in the same cells or similar experimental designs.

## Installation and Loading

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SingleCellMultiModal")

library(SingleCellMultiModal)
library(MultiAssayExperiment)
```

## Core Dataset Functions

The package provides specific functions for different technologies. Use `dry.run = TRUE` to see available metadata before downloading.

### CITE-seq & ECCITE-seq
Combines scRNA-seq with Antibody-Derived Tags (ADT) and Hashtagged Oligos (HTO).
```R
# Cord Blood (CITE-seq)
mae <- CITEseq(DataType="cord_blood", modes="*", dry.run=FALSE)

# Peripheral Blood (ECCITE-seq)
mae_pb <- CITEseq(DataType="peripheral_blood", modes="*", dry.run=FALSE)

# Convert directly to SingleCellExperiment (RNA as main, ADT as altExp)
sce <- CITEseq(DataType="cord_blood", DataClass="SingleCellExperiment")
```

### scNMT-seq
Nucleosome, Methylation, and Transcription sequencing.
```R
# Mouse Gastrulation
nmt <- scNMT("mouse_gastrulation", mode = c("*_cgi", "rna"), version = "2.0.0")
```

### scMultiome (10x Genomics)
Chromatin accessibility (ATAC) and Gene Expression (RNA).
```R
multiome <- scMultiome("pbmc_10x", modes = "*", format = "MTX")
```

### SCoPE2
Mass spectrometry-based single-cell proteomics.
```R
scope2 <- SCoPE2("macrophage_differentiation", modes = "rna|protein")
```

### G&T-seq
Parallel sequencing of single-cell genomes and transcriptomes.
```R
gts <- GTseq("mouse_embryo_8_cell")
```

### seqFISH
Spatial transcriptomics combined with scRNA-seq.
```R
sf <- seqFISH(DataType="mouse_visual_cortex")
```

## Working with MultiAssayExperiment (MAE)

Most functions return a `MultiAssayExperiment`. Key operations include:

*   **List Experiments**: `experiments(mae)`
*   **Access Assay Data**: `assay(mae, "assay_name")` or `mae[["assay_name"]]`
*   **Cell Metadata**: `colData(mae)`
*   **Subset by Condition**: `mae[, mae$condition == "CTCL", ]`
*   **Find Overlapping Samples**: `mae[, complete.cases(mae), ]`
*   **Check Row/Col Names**: `rownames(mae)` and `colnames(mae)`

## Workflow Tips

1.  **Dry Runs**: Always use `dry.run = TRUE` first to check the `ah_id` (ExperimentHub ID) and file sizes.
2.  **Versions**: Many datasets have multiple versions (e.g., `1.0.0`, `2.0.0`). Version `2.0.0` often contains more cells or processed subsets.
3.  **Sparse Matrices**: Large datasets (like scMultiome or SCoPE2 RNA) are often returned as `dgCMatrix` or HDF5-backed `DelayedMatrix` to save memory.
4.  **Spatial Data**: For `seqFISH`, the `seqFISH` experiment is a `SpatialExperiment` object. Access coordinates using `spatialCoords(mae[["seqFISH"]])`.

## Reference documentation

- [CITEseq Cord Blood](./references/CITEseq.md)
- [ECCITEseq Peripheral Blood](./references/ECCITEseq.md)
- [G&T-seq Mouse Embryo](./references/GTseq.md)
- [SCoPE2: Macrophage vs Monocytes](./references/SCoPE2.md)
- [SingleCellMultiModal Introduction](./references/SingleCellMultiModal.md)
- [PBMCs 10x Multiome](./references/scMultiome.md)
- [scNMT Mouse Gastrulation](./references/scNMT.md)
- [seqFISH Mouse Visual Cortex](./references/seqFISH.md)