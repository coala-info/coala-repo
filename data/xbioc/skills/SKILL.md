---
name: xbioc
description: xbioc simplifies repetitive tasks in Bioconductor workflows by providing extra base functions for data manipulation, annotation, and validation. Use when user asks to merge ExpressionSet objects, tidy ExpressionSet data, validate data scale, map gene identifiers, determine Bioconductor annotation package names, append data frames, or generate object hashes.
homepage: https://github.com/renozao/xbioc
---


# xbioc

## Overview
The `xbioc` package provides a collection of "extra base functions" designed to simplify repetitive tasks in Bioconductor-based workflows. It acts as a productivity layer for bioinformaticians, offering robust methods for merging datasets, handling gene annotations, and transforming complex S4 objects into tidy formats. Use this skill to ensure efficient and idiomatic handling of genomic data structures in R.

## Installation and Setup
The package can be installed via Bioconda or directly from GitHub:

```r
# Via Conda
# conda install bioconda::xbioc

# Via R (using BiocManager)
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("renozao/xbioc")
```

## Core Functional Patterns

### ExpressionSet Manipulation
`xbioc` extends standard base functions to work seamlessly with `ExpressionSet` objects:
- **Merging**: Use `rbind()` and `cbind()` directly on `ExpressionSet` objects. The package handles the underlying metadata alignment.
- **Tidying**: Use `assayDataMelt()` or the `melt()` method for `ExpressionSet` to convert matrix-style assay data into a long-format data frame, which is essential for `ggplot2` visualizations.

### Data Scale Validation
Before performing differential expression or normalization, verify the data distribution:
- **`is_logscale(object)`**: Returns a logical value indicating if the data appears to be log-transformed.
- **`has_logscale_outlier(object)`**: Detects values that deviate significantly from expected log-scale distributions, helping identify preprocessing errors.

### Annotation and ID Mapping
Streamline the resolution of gene identifiers and annotation packages:
- **`convertAlias()`**: Maps gene symbols or aliases to primary identifiers. It includes logic to skip mapping if the input is already valid, reducing computation time.
- **`biocann_pkgname()`**: Automatically determines the correct name for Bioconductor annotation packages (e.g., OrgDb or EnsDb) based on organism strings or object metadata.

### Utility Functions
- **`df_append()`**: A robust way to append data frames that may have mismatched columns.
- **`digestN()`**: Generates hashes for complex objects, useful for caching or verifying data integrity in long-running pipelines.

## Expert Tips
- **Visualizing Assays**: When preparing data for heatmaps or facet plots, `assayDataMelt` is more efficient than manual extraction via `exprs()` followed by `reshape2::melt`.
- **Robust Pipelines**: Use `is_logscale` at the beginning of your analysis scripts to automatically decide whether to apply `log2()` transformation, making your workflows more portable across different dataset types.
- **Annotation Handling**: When working with Ensembl data, `biocann_pkgname` specifically handles the naming conventions of `EnsDb` packages, which often differ from standard `OrgDb` patterns.

## Reference documentation
- [xbioc Overview](./references/anaconda_org_channels_bioconda_packages_xbioc_overview.md)
- [xbioc GitHub Repository](./references/github_com_renozao_xbioc.md)
- [xbioc Commit History](./references/github_com_renozao_xbioc_commits_master.md)