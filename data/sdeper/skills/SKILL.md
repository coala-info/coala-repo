---
name: sdeper
description: SDePER (Spatial Deconvolution method with Platform Effect Removal) is a specialized tool for mapping cell types onto spatial transcriptomics maps.
homepage: https://az7jh2.github.io/SDePER/
---

# sdeper

## Overview
SDePER (Spatial Deconvolution method with Platform Effect Removal) is a specialized tool for mapping cell types onto spatial transcriptomics maps. It bridges the gap between high-resolution single-cell RNA-seq (scRNA-seq) data and spatial data by removing platform-specific biases. Use this skill to guide the preparation of required count matrices and to execute the deconvolution pipeline for accurate tissue architecture analysis.

## Core Workflow
SDePER operates as an "out-of-the-box" CLI tool. The primary command is `runDeconvolution`.

### Required Input Files
Ensure the following four files are prepared in CSV format:
1.  **Spatial Data** (`-q`): Raw nUMI counts (spots × genes).
2.  **scRNA-seq Reference** (`-r`): Raw nUMI counts (cells × genes).
3.  **Cell Annotations** (`-c`): Cell type labels for the scRNA-seq reference (cells × 1).
4.  **Adjacency Matrix** (`-a`): Optional. Defines spot connectivity (spots × spots) to account for spatial correlation.

### Execution Pattern
Run the standard deconvolution with default settings:
```bash
runDeconvolution -q spatial.csv -r scrna_ref.csv -c scrna_anno.csv -a adjacency.csv
```

## Best Practices
- **Environment**: SDePER requires Linux (e.g., Ubuntu) and Python 3.9 or 3.10. It is not compatible with Python 3.11+.
- **Data Preprocessing**: While SDePER handles marker gene identification internally, ensure input CSVs use raw nUMI counts rather than normalized values to allow the internal statistical model to function correctly.
- **Spatial Correlation**: Always provide the adjacency matrix (`-a`) when working with tissue sections where cell-type distribution is expected to be non-random or clustered, as this improves deconvolution accuracy.
- **Resolution Enhancement**: SDePER can impute expression at unmeasured locations; check the output directory for imputed cell-type composition maps.

## Reference documentation
- [SDePER Overview and Quick Start](./references/az7jh2_github_io_SDePER.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_sdeper_overview.md)