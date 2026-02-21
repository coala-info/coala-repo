---
name: bioconductor-htqpcr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/HTqPCR.html
---

# bioconductor-htqpcr

name: bioconductor-htqpcr
description: Analysis of high-throughput quantitative real-time PCR (qPCR) data. Use when Claude needs to process cycle threshold (Ct) values, including data import from various platforms (SDS, BioMark, OpenArray, LightCycler), quality control, normalization, and differential expression testing using t-tests, Mann-Whitney, or limma.

# bioconductor-htqpcr

## Overview
The `HTqPCR` package is designed for the analysis of high-throughput qPCR data. It handles cycle threshold (Ct) values, providing a specialized `qPCRset` object (inheriting from `eSet`) to manage expression data, feature metadata, and sample information. The workflow typically involves data import, quality assessment, normalization, and statistical testing for differential expression.

## Core Workflow

### 1. Data Import
Use `readCtData` to import text files. The package supports multiple formats via the `format` argument.

```r
library(HTqPCR)
# Import plain tab-delimited files
raw <- readCtData(files = c("sample1.txt", "sample2.txt"), path = ".")

# Import specific platform formats
raw_sds <- readCtData(files = "SDS_export.txt", format = "SDS")
raw_biomark <- readCtData(files = "BioMark.csv", format = "BioMark", n.features = 48, n.data = 48)
```

### 2. The qPCRset Object
Data is stored in a `qPCRset`. Access and modify components using standard Bioconductor methods:
- `exprs(obj)` or `getCt(obj)`: Extract Ct values.
- `pData(obj)`: Access sample metadata.
- `fData(obj)`: Access feature metadata (gene names, types, positions).
- `featureCategory(obj)`: View reliability status ("OK", "Undetermined", "Unreliable").

### 3. Quality Control and Visualization
Assess data quality before and after normalization:
- `plotCtOverview(obj)`: General overview of Ct values across samples.
- `plotCtCard(obj)`: Spatial visualization of Ct values (for 96/384 well plates).
- `plotCtDensity(obj)` / `plotCtHistogram(obj)`: Distribution of Ct values.
- `plotCtVariation(obj)`: Assess variation between replicates.
- `plotCtPairs(obj)`: Pairwise scatter plots between samples.
- `plotCtPCA(obj)`: Principal Component Analysis.

### 4. Data Filtering and Categories
Assign categories based on Ct thresholds or replicate consistency:
- `setCategory(obj, Ct.max = 35)`: Mark high Ct values as "Undetermined".
- `filterCategory(obj)`: Remove or mask "Unreliable" data.

### 5. Normalization
Use `normalizeCtData` with various methods:
- `norm = "quantile"`: Force identical distributions.
- `norm = "deltaCt"`: Subtract mean of endogenous controls (specify via `deltaCt.genes`).
- `norm = "scale.rank"` or `"norm.rank"`: Rank-invariant normalization.
- `norm = "geometric.mean"`: Scale by the geometric mean of the sample.

```r
# Example: DeltaCt normalization
norm_data <- normalizeCtData(raw, norm = "deltaCt", deltaCt.genes = c("GAPDH", "18S"))
```

### 6. Differential Expression
Test for significant differences between groups:
- `ttestCtData(obj, groups = ...)`: Standard t-test for two groups.
- `mannwhitneyCtData(obj, groups = ...)`: Non-parametric test for two groups.
- `limmaCtData(obj, design = ...)`: Linear modeling for complex experimental designs (recommended for multiple groups).

```r
# Example: limma analysis
design <- model.matrix(~0 + condition, data = pData(norm_data))
results <- limmaCtData(norm_data, design = design, contrasts = "conditionA-conditionB")
```

### 7. Manipulating Layouts
If a single file contains multiple samples (e.g., Fluidigm or OpenArray), use `changeCtLayout` to reformat the `qPCRset`.
- `changeCtLayout(obj, sample.order = ...)`: Reorganize rows and columns based on sample loading.

## Reference documentation
- [HTqPCR](./references/HTqPCR.md)