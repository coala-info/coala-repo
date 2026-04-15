---
name: bioconductor-watermelon
description: The wateRmelon package provides tools for the quality control, normalization, and analysis of Illumina DNA methylation microarray data. Use when user asks to perform outlier detection, normalize methylation data using methods like dasen, or predict epigenetic age, biological sex, and cell-type proportions.
homepage: https://bioconductor.org/packages/release/bioc/html/wateRmelon.html
---

# bioconductor-watermelon

## Overview
The `wateRmelon` package provides a comprehensive suite of tools for the analysis of Illumina DNA methylation microarrays (450k and EPIC). It is designed to be highly compatible with `minfi` and `methylumi` objects. Its core strengths include robust outlier detection, a variety of normalization methods (notably `dasen`), and built-in predictors for epigenetic age, biological sex, and blood cell-type proportions.

## Core Workflow

### 1. Data Import
`wateRmelon` extends `methylumi` to handle EPIC arrays and works seamlessly with `minfi` objects.

```r
library(wateRmelon)

# Import EPIC data into a MethyLumiSet
mlumi <- readEPIC('path/to/idat_files')

# Or use the built-in example dataset
data(melon) # A MethyLumiSet with 12 samples
```

### 2. Quality Control (QC)
QC should be performed before normalization to identify poor-quality probes or outlier samples.

*   **Outlier Detection:** Use `outlyx` for multivariate outlier detection based on the Mahalanobis distance and interquartile range.
*   **Bisulfite Conversion:** Use `bscon` to check conversion efficiency (aim for >80-90%).
*   **Filtering:** Use `pfilter` to remove probes with high detection p-values or low bead counts.

```r
# Identify outliers
outliers <- outlyx(melon, plot=TRUE)
# Filter samples: melon[, !outliers$out]

# Check bisulfite conversion
bsc <- bscon(melon)

# Filter poor probes/samples (default thresholds: p < 0.05, beadcount < 3)
melon.pf <- pfilter(melon)
```

### 3. Phenotype Prediction
Generate biological covariates or verify sample metadata.

*   **Epigenetic Age:** `agep` supports multiple clocks: `horvath`, `hannum`, `phenoage`, `skinblood`, and `lin`.
*   **Sex Prediction:** `estimateSex` uses X and Y chromosome probe intensities.
*   **Cell Counts:** `estimateCellCounts.wateRmelon` estimates proportions for bulk blood.

```r
# Predict age using all available clocks
ages <- agep(melon, method='all')

# Predict sex
sex_preds <- estimateSex(betas(melon), do_plot=TRUE)

# Estimate blood cell types
cell_counts <- estimateCellCounts.wateRmelon(melon, referencePlatform = "IlluminaHumanMethylationEPIC")
```

### 4. Normalization
The package offers several methods, with `dasen` being the most widely recommended for general use.

| Function | Description |
| :--- | :--- |
| `dasen` | Background adjustment and between-array quantile normalization. |
| `nasen` | A simpler version of dasen (useful for EPIC data). |
| `swan` | Subset-quantile within-array normalization. |
| `adjusted_dasen` | Includes interpolated XY chromosome correction. |

```r
# Apply dasen normalization
melon.dasen <- dasen(melon.pf)

# Extract normalized Beta values for downstream stats
norm_betas <- betas(melon.dasen)
```

### 5. Performance Metrics and Post-Processing
*   **Normalization Violence:** Use `qual` to estimate how much the data was transformed during normalization; high values may indicate noisy samples.
*   **Final Sweep:** Use `pwod` (Probe-Wise Outlier Detection) to mask individual data points that remain outliers after normalization.

```r
# Check normalization violence
qu <- qual(betas(melon), betas(melon.dasen))

# Final outlier masking before statistical analysis
final_betas <- pwod(norm_betas)
```

## Reference documentation
- [wateRmelon User's Guide](./references/wateRmelon.md)