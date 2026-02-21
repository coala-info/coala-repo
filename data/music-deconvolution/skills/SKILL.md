---
name: music-deconvolution
description: MuSiC (Multi-subject Single Cell Deconvolution) is an R-based analysis toolkit that utilizes cross-subject scRNA-seq data as a reference to estimate cell type proportions in bulk RNA-seq samples.
homepage: https://github.com/xuranw/MuSiC
---

# music-deconvolution

## Overview

MuSiC (Multi-subject Single Cell Deconvolution) is an R-based analysis toolkit that utilizes cross-subject scRNA-seq data as a reference to estimate cell type proportions in bulk RNA-seq samples. By leveraging information from multiple individuals, MuSiC identifies genes with consistent expression patterns across subjects, providing more weighted and accurate deconvolution than methods relying on single-subject references. This skill covers the implementation of both the original MuSiC algorithm and the MuSiC2 iterative algorithm for multi-condition datasets.

## Installation and Setup

The tool is primarily distributed as an R package. You can install it via Bioconda or directly from GitHub.

**Conda Installation:**
```bash
conda install bioconda::music-deconvolution
```

**R Installation (via devtools):**
```R
install.packages('devtools')
devtools::install_github('xuranw/MuSiC')
library(MuSiC)
```

## Core Workflow and Usage

### Data Preparation
MuSiC requires two primary inputs:
1.  **Reference Data**: A `SingleCellExperiment` or `ExpressionSet` object containing scRNA-seq data with subject and cell type annotations.
2.  **Bulk Data**: An `ExpressionSet` object containing the bulk RNA-seq expression matrix.

### Standard Deconvolution (MuSiC)
Use the `music_prop` function for standard estimation when the bulk data and scRNA-seq reference share similar conditions.

```R
# Basic deconvolution pattern
est_prop <- music_prop(
  bulk.eset = bulk_data, 
  sc.eset = reference_data, 
  clusters = 'cellTypeColumn', 
  samples = 'subjectIDColumn', 
  select.ct = c('Neuron', 'Astrocyte', 'Microglia'), # Optional: specific cell types
  verbose = TRUE
)
```

### Multi-Condition Deconvolution (MuSiC2)
Use MuSiC2 when bulk samples are generated from clinical conditions (e.g., disease vs. control) that differ from the scRNA-seq reference. MuSiC2 employs an iterative algorithm to account for condition-specific gene expression changes.

```R
# MuSiC2 pattern for multi-condition data
est_prop_v2 <- music2_prop(
  bulk.eset = bulk_data, 
  sc.eset = reference_data, 
  condition = 'clinical_condition',
  control = 'control_label',
  case = 'disease_label',
  clusters = 'cellTypeColumn', 
  samples = 'subjectIDColumn'
)
```

## Best Practices and Expert Tips

*   **Object Compatibility**: While MuSiC originally used `ExpressionSet` objects, version 1.0.0+ supports the `SingleCellExperiment` class. It is recommended to use `SingleCellExperiment` for modern pipelines to ensure better integration with other Bioconductor tools.
*   **Gene Matching**: Ensure that the gene identifiers (e.g., Gene Symbols or Ensembl IDs) are consistent between your bulk and single-cell datasets before running the deconvolution.
*   **Subject Weighting**: MuSiC's primary advantage is its weighting scheme. It prioritizes genes that show low intra-subject and inter-subject variance. If your reference has very few subjects (e.g., < 3), the statistical power of this weighting is reduced.
*   **Handling Errors**: 
    *   If you encounter "non-conformable arrays," verify that the bulk matrix and reference matrix have overlapping gene sets.
    *   If `music_prop` fails to find the `counts` function, ensure you have the `Biobase` or `SingleCellExperiment` libraries loaded.

## Reference documentation

- [MuSiC GitHub Repository](./references/github_com_xuranw_MuSiC.md)
- [Bioconda MuSiC Package Overview](./references/anaconda_org_channels_bioconda_packages_music-deconvolution_overview.md)