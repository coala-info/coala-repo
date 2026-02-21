---
name: w4mclassfilter
description: The `w4mclassfilter` tool is designed to maintain the integrity of metabolomics datasets when subsetting by sample groups.
homepage: https://github.com/HegemanLab/w4mclassfilter
---

# w4mclassfilter

## Overview

The `w4mclassfilter` tool is designed to maintain the integrity of metabolomics datasets when subsetting by sample groups. In the W4M framework, data is stored in three related files; this tool ensures that when samples are filtered out based on metadata classes, the corresponding entries in the data matrix and variable metadata are updated or removed accordingly. It also provides essential preprocessing steps like removing features with no variance and imputing missing values to prepare the dataset for downstream statistical modeling.

## Core Functionality

The primary entry point for this tool is the R function `w4m_filter_by_sample_class`. It operates on the "triplet" of W4M files:
1.  **dataMatrix**: A tab-separated file of intensities (variables in rows, samples in columns).
2.  **sampleMetadata**: Metadata for each sample (samples in rows).
3.  **variableMetadata**: Metadata for each variable/feature (variables in rows).

### Common Parameters and Arguments

- **classes**: A character vector or a comma-separated string specifying which sample classes to retain.
- **variable_range_filter**: Allows filtering variables based on specific ranges (can accept CSV inputs).
- **impute**: Boolean flag to enable/disable NA imputation for missing values.
- **include_medoids**: When enabled, the tool calculates the "most representative sample" (medoid) for each class using PCA scores as coordinates.

## Best Practices and Workflow Patterns

### 1. Data Cleaning and Variance Reduction
Always use the tool to eliminate zero-variance rows and columns. This is critical before performing multivariate analyses like PCA or PLS-DA, as zero-variance features can cause mathematical errors in scaling and rotation.

### 2. Handling Missing Values
If your downstream tools do not support `NA` values, use the optional imputation feature. Note that `w4mclassfilter` treats negative values as missing values in certain versions (refer to Issue #10 if encountering unexpected filtering of negative intensities).

### 3. Metadata Sorting
The tool supports ordering the output by multiple metadata columns. When providing sort columns, you can use a vector of names or a comma-separated list.

### 4. Medoid Calculation
For large cohorts, use the medoid calculation to identify the centroid sample of a class. The tool uses `prcomp` to scale features before running PCA to determine the coordinates for distance calculations, ensuring that high-intensity features do not disproportionately bias the selection of the representative sample.

## Troubleshooting

- **Numeric Class Names**: If your sample classes are purely numeric, ensure they are handled correctly as factors to avoid matrix-sorting issues.
- **Row/Column Mismatches**: If the tool fails, verify that the sample IDs in the `dataMatrix` header exactly match the row names in `sampleMetadata`.

## Reference documentation
- [w4mclassfilter GitHub README](./references/github_com_HegemanLab_w4mclassfilter.md)
- [w4mclassfilter Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_w4mclassfilter_overview.md)
- [w4mclassfilter Commit History (Functional Details)](./references/github_com_HegemanLab_w4mclassfilter_commits_master.md)