---
name: fraposa-pgsc
description: The `fraposa-pgsc` tool is a specialized version of FRAPOSA (Fast and Robust Ancestry Prediction) integrated into the PGS Catalog pipeline.
homepage: https://github.com/PGScatalog/fraposa_pgsc
---

# fraposa-pgsc

## Overview

The `fraposa-pgsc` tool is a specialized version of FRAPOSA (Fast and Robust Ancestry Prediction) integrated into the PGS Catalog pipeline. It enables the projection of study samples into a reference PCA space (like 1000 Genomes) to determine genetic ancestry. It is designed to be computationally efficient, handling large-scale genomic data by utilizing Online Singular Value Decomposition (SVD) and Procrustes transformation.

## Core Workflow

### 1. Data Preparation
Before running the tool, ensure your reference and study datasets are in binary PLINK format (`.bed`, `.bim`, `.fam`). 

**Critical Requirement**: The reference and study sets must contain the exact same variants in the same order. Use tools like `plink` or `pgscatalog-intersect` to extract common variants before starting.

### 2. Generating PC Scores
The primary command projects study samples onto the reference loadings.

```bash
# Basic usage with default OADP method
fraposa --stu_filepref <study_prefix> <ref_prefix>
```

**Key Options:**
- `--method`: Choose between `oadp` (default, most accurate), `adp` (accurate but slow), or `sp` (fast but ignores shrinkage bias).
- `--dim_ref`: Number of PCs to calculate (default is often sufficient, but can be adjusted for specific resolution).
- `--out`: Specify a custom output prefix.

### 3. Ancestry Prediction
To predict population labels, you must provide a reference population file (`.popu`) containing Family ID, Individual ID, and the population label.

```bash
# Predict study ancestry memberships
fraposa_pred <stu_prefix>
```

### 4. Visualization
Generate a PC plot to inspect the projection and clustering.

```bash
# Create a PNG plot of the PC scores
fraposa_plot <stu_prefix>
```

## Expert Tips and Best Practices

### Handling Large Study Sets
If the study dataset is too large for memory, use the `--stu_filt_iid` flag to process samples in batches. You can split your `.fam` file into smaller lists of IDs and run `fraposa` in parallel across these batches.

```bash
# Example: Processing a specific batch of IDs
fraposa <ref_prefix> --stu_filepref <study_prefix> --stu_filt_iid <batch_ids.txt> --out <batch_output>
```

### Method Selection
- **OADP (Default)**: Always prefer OADP for study samples. It corrects for the "shrinkage" effect where study samples appear closer to the PCA origin than they should, which is a common artifact in high-dimensional genetic data.
- **SP (Standard Projection)**: Only use for very quick looks or when the number of samples is significantly larger than the number of variants.

### Intermediate Files
The tool produces `.dat` files during execution. These are cached versions of the reference data. If you are running multiple study batches against the same reference, keep these files to significantly reduce computation time for subsequent runs.

## Reference documentation
- [github_com_PGScatalog_fraposa_pgsc.md](./references/github_com_PGScatalog_fraposa_pgsc.md)
- [anaconda_org_channels_bioconda_packages_fraposa-pgsc_overview.md](./references/anaconda_org_channels_bioconda_packages_fraposa-pgsc_overview.md)