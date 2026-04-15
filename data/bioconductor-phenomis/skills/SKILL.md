---
name: bioconductor-phenomis
description: This tool provides post-processing and univariate statistical analysis for single-omics and multi-omics datasets. Use when user asks to perform signal drift correction, batch effect adjustment, data transformation, quality control filtering, or univariate hypothesis testing on omics data.
homepage: https://bioconductor.org/packages/release/bioc/html/phenomis.html
---

# bioconductor-phenomis

name: bioconductor-phenomis
description: Postprocessing and univariate statistical analysis of omics data (metabolomics, proteomics, etc.). Use this skill to perform signal drift correction, batch effect adjustment, data transformation, quality control filtering, and univariate hypothesis testing on SummarizedExperiment or MultiAssayExperiment objects.

# bioconductor-phenomis

## Overview

The `phenomis` package provides a comprehensive suite of tools for the post-processing and univariate statistical analysis of omics datasets. It is designed to handle both single-omics (via `SummarizedExperiment`) and multi-omics (via `MultiAssayExperiment`) data. Key functionalities include signal drift correction using pool/QC samples, data normalization, log transformation, outlier detection, and various univariate tests (t-test, Wilcoxon, limma, ANOVA, correlation).

## Core Workflow

### 1. Data Import
The `reading()` function imports data from a directory containing tabular files (dataMatrix.tsv, sampleMetadata.tsv, variableMetadata.tsv).

```R
library(phenomis)
# Import single-omics
se <- reading(system.file("extdata/sacurine", package = "phenomis"))

# Import multi-omics
mae <- reading(system.file("extdata/prometis", package = "phenomis"))
```

### 2. Inspection and Quality Control
The `inspecting()` function computes quality metrics (Hotelling's T2 p-values, missing value z-scores, etc.) and adds them to `colData` and `rowData`.

```R
se <- inspecting(se, report.c = "none")
# Access metrics
head(colData(se)[, c("hotel_pval", "miss_pval", "deci_pval")])
```

### 3. Post-processing
*   **Signal Correction**: Use `correcting()` to fix drift and batch effects. Requires `sampleType` (sample, pool, blank), `injectionOrder`, and `batch` columns in `colData`.
*   **Transformation**: Use `transforming()` for log10 or other scaling.
*   **Normalization**: Use `normalizing()` for Probabilistic Quotient Normalization (PQN) or manual sweeping.

```R
# Correct signal drift using 'pool' samples
se <- correcting(se, reference.vc = "pool")

# Log transformation
se <- transforming(se, method.vc = "log10")
```

### 4. Filtering
Filter features based on the Coefficient of Variation (CV) in pool samples or proportion of missing values.

```R
# Filter features with pool CV > 30%
se <- se[rowData(se)[, "pool_CV"] <= 0.3, ]

# Filter samples based on inspection p-values
se <- se[, colData(se)[, "hotel_pval"] >= 0.001]
```

### 5. Statistical Analysis
*   **Univariate Testing**: `hypotesting()` supports "ttest", "wilcoxon", "limma", "anova", "kruskal", "pearson", and "spearman".
*   **Clustering**: `clustering()` performs hierarchical clustering on samples and variables.

```R
# T-test for gender differences with BH correction
se <- hypotesting(se, test.c = "ttest", factor_names.vc = "gender", adjust.c = "BH")

# Hierarchical clustering
se <- clustering(se, clusters.vi = c(5, 3))
```

### 6. Annotation
The `annotating()` function connects to ChEBI or local databases via the `biodb` framework.

```R
se <- annotating(se, database.c = "chebi", 
                 param.ls = list(query.type = "mz", query.col = "mass_to_charge", ms.mode = "neg"))
```

### 7. Export
Save results back to tabular files.

```R
writing(se, dir.c = getwd(), prefix.c = "my_results")
```

## Multi-omics Usage
When using `MultiAssayExperiment`, parameters can be passed as vectors to apply different settings to different assays.

```R
# Log transform the first assay but not the second
mae <- transforming(mae, method.vc = c("log10", "none"))
```

## Reference documentation

- [phenomis: Postprocessing and univariate statistical analysis of omics data](./references/phenomis-vignette.md)