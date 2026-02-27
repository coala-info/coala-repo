---
name: bioconductor-yarn
description: This tool provides a streamlined workflow for the preprocessing, quality control, and normalization of large-scale, multi-tissue RNA-seq datasets. Use when user asks to identify sample mis-annotations, merge similar tissue groups, filter lowly expressed genes, or perform tissue-aware normalization.
homepage: https://bioconductor.org/packages/release/bioc/html/yarn.html
---


# bioconductor-yarn

name: bioconductor-yarn
description: Robust multi-tissue RNA-seq preprocessing and normalization. Use when Claude needs to perform quality control, filtering, and normalization on large-scale RNA-seq datasets (like GTEx). This skill is ideal for: (1) Identifying sample mis-annotations using sex-specific genes, (2) Determining which tissue types or groups should be merged, (3) Filtering lowly expressed genes while preserving group specificity, and (4) Applying tissue-aware normalization to account for global expression differences across heterogeneous samples.

## Overview

The `yarn` package (Yet Another RNa-seq package) provides a streamlined workflow for processing large, heterogeneous RNA-seq experiments. It leverages existing Bioconductor tools to handle the sparsity and variability found in multi-tissue datasets. The core philosophy follows a four-step pipeline: sample filtering, condition merging, gene filtering, and group-aware normalization.

## Core Workflow

### 1. Data Loading and Initial Inspection

Load the library and your expression data (typically an `ExpressionSet`).

```r
library(yarn)
# Example using provided skin dataset
data(skin)
# View phenotype data
pData(skin)
```

### 2. Quality Control and Mis-annotation Check

Use known control genes (e.g., Y-chromosome genes for gender) to identify samples that may be incorrectly labeled.

```r
# Check gender mis-annotation
checkMisAnnotation(skin, "GENDER", controlGenes = "Y", legendPosition = "topleft")
```

### 3. Merging Sub-groups

Evaluate whether related tissue types or groups have similar enough expression profiles to be merged for increased statistical power.

```r
# Compare specific tissue (SMTS) vs sub-tissue (SMTSD)
checkTissuesToMerge(skin, "SMTS", "SMTSD")
```

### 4. Gene Filtering

Filter genes to remove noise while ensuring that genes specific to a particular tissue or group are not lost.

*   **Filter by expression:** Removes genes with low counts across groups.
*   **Filter by annotation:** Removes genes based on specific features (e.g., chromosome).

```r
# Filter lowly expressed genes based on group (SMTSD)
skin_filtered <- filterLowGenes(skin, "SMTSD")

# Filter specific chromosomes (e.g., keep only sex chromosomes and MT)
sex_mt_genes <- filterGenes(skin, labels = c("X", "Y", "MT"), 
                           featureName = "chromosome_name", keepOnly = TRUE)
```

### 5. Tissue-Aware Normalization

Standard normalization often fails when global expression distributions differ significantly between tissues. Use `normalizeTissueAware` to account for these differences.

```r
# Normalize based on tissue/group labels
skin_norm <- normalizeTissueAware(skin_filtered, "SMTSD")
```

## Visualization Tools

`yarn` provides several wrappers for common diagnostic plots:

*   **plotCMDS**: Performs Classical Multi-Dimensional Scaling (PCoA) to visualize sample relationships.
    ```r
    plotCMDS(skin, pch = 21, bg = factor(pData(skin)$SMTSD))
    ```
*   **plotDensity**: Inspects global expression trends and the effect of normalization.
    ```r
    # Compare raw vs normalized densities
    plotDensity(skin_filtered, "SMTSD", main = "Raw")
    plotDensity(skin_norm, "SMTSD", normalized = TRUE, main = "Normalized")
    ```
*   **plotHeatmap**: Generates a heatmap of the most variable genes.
    ```r
    plotHeatmap(skin, normalized = FALSE, log = TRUE, n = 10)
    ```

## Reference documentation

- [YARN: Robust Multi-Tissue RNA-Seq Preprocessing and Normalization](./references/yarn.md)