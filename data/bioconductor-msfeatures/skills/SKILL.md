---
name: bioconductor-msfeatures
description: This tool groups mass spectrometry features into feature groups based on similarities in retention time and abundance patterns. Use when user asks to group MS features, identify adducts or isotopes from the same compound, or refine feature groups using abundance correlation.
homepage: https://bioconductor.org/packages/release/bioc/html/MsFeatures.html
---


# bioconductor-msfeatures

name: bioconductor-msfeatures
description: Grouping mass spectrometry (MS) features into feature groups based on similarity of characteristics like retention time and abundance patterns. Use this skill when processing metabolomics or proteomics data to reduce complexity by identifying ions (adducts, isotopes) originating from the same compound. It supports base R objects and SummarizedExperiment containers.

# bioconductor-msfeatures

## Overview

The `MsFeatures` package provides a framework for grouping MS features that likely represent signal from the same original compound. This is critical in ESI-MS workflows where a single metabolite can produce multiple adducts or isotopes. The package implements a stepwise approach where initial groups (e.g., based on retention time) can be refined using additional criteria (e.g., abundance correlation).

## Core Workflow

The primary function is `groupFeatures()`, which assigns features to a single group. It typically follows a pipeline:
1.  **Initial Grouping**: Group features by similar retention time.
2.  **Refinement**: Sub-group existing groups based on abundance similarity across samples.

### 1. Grouping by Retention Time
Use `SimilarRtimeParam` to group features with a maximum difference in retention time.

```r
library(MsFeatures)
# Assuming 'se' is a SummarizedExperiment with a 'rtmed' column in rowData
se <- groupFeatures(se, 
                    param = SimilarRtimeParam(diff = 10), 
                    rtime = "rtmed")

# Access group assignments
featureGroups(se)
```

### 2. Grouping by Abundance Similarity
Use `AbundanceSimilarityParam` to refine groups by calculating pairwise similarities (e.g., Pearson correlation) of feature intensities across samples.

```r
# Refine existing groups in 'se'
se <- groupFeatures(se, 
                    param = AbundanceSimilarityParam(threshold = 0.7, 
                                                     transform = log2), 
                    i = 1) # 'i' specifies the assay index
```

### 3. Working with Results
*   **Accessing Groups**: Use `featureGroups(object)` to get a character vector of group IDs.
*   **Resetting Groups**: To overwrite or restart grouping, set the column to NULL: `rowData(se)$feature_group <- NULL`.
*   **Subset Grouping**: To group only specific features, set `featureGroups(se)` to `NA` for unwanted features and a placeholder (e.g., "FG") for features of interest before calling `groupFeatures`.

## Key Parameters and Functions

| Function / Object | Description |
| --- | --- |
| `groupFeatures()` | Main interface for feature grouping. |
| `featureGroups()` | Getter/setter for the `feature_group` column in `rowData` or metadata. |
| `SimilarRtimeParam(diff)` | Parameter object for RT-based grouping within a `diff` threshold. |
| `AbundanceSimilarityParam()` | Parameter object for correlation-based grouping. Supports `threshold`, `simFun` (default `cor`), and `transform`. |

## Tips for Effective Grouping
*   **Stepwise Refinement**: `groupFeatures` does not overwrite existing groups by default; it creates sub-groups (e.g., `FG.001.001`).
*   **Data Scale**: Use `transform = log2` in `AbundanceSimilarityParam` for MS intensity data to stabilize variance.
*   **Sample Size**: Abundance correlation is more reliable with larger sample sizes (n > 8) and features with high variance across samples.
*   **Integration**: After grouping, use the `QFeatures` package to aggregate feature abundances into a single compound-level signal.

## Reference documentation
- [Grouping Mass Spectrometry Features](./references/MsFeatures.md)
- [Grouping Mass Spectrometry Features (Rmd Source)](./references/MsFeatures.Rmd)