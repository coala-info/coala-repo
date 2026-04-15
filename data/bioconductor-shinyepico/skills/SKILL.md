---
name: bioconductor-shinyepico
description: shinyÉPICo provides an interactive graphical pipeline for the analysis of Illumina DNA methylation arrays using gold-standard Bioconductor packages. Use when user asks to analyze iDAT files, perform DNA methylation normalization, calculate differentially methylated positions, or detect differentially methylated regions.
homepage: https://bioconductor.org/packages/release/bioc/html/shinyepico.html
---

# bioconductor-shinyepico

## Overview

shinyÉPICo is a Bioconductor package designed to streamline the analysis of Illumina DNA methylation arrays (450k and EPIC). It acts as a "graphical pipeline" that integrates several gold-standard Bioconductor packages: `minfi` for normalization, `limma` for DMP calculation, and `mCSEA` for DMR detection. While primarily a Shiny web application, it provides a structured workflow for processing raw iDAT files into biological insights, including PCA, heatmaps, and genomic plots.

## Core Workflow

### 1. Launching the Application
The primary way to use the package is by launching the interactive web interface.

```r
library(shinyepico)
# Set a seed for reproducible DMR permutations
set.seed(123)
# Launch with default settings
run_shinyepico(n_cores = 2, max_upload_size = 2000)
```

### 2. Data Preparation
To use the package effectively, data must be organized as follows:
*   **iDAT Files**: Compressed into a single `.zip` file. Filenames must follow the `SentrixID_SentrixPosition_Channel.idat` convention.
*   **Sample Sheet**: A CSV file containing `Sentrix_ID` and `Sentrix_Position` columns, plus metadata (e.g., Sample_Name, Group, Donor).

### 3. Normalization Methods
The package supports multiple `minfi`-based normalization strategies:
*   **Raw**: No normalization.
*   **Illumina**: Genome Studio-like normalization.
*   **Funnorm**: Between-array normalization using control probes (recommended for datasets with global changes).
*   **Noob**: Within-array dye-bias correction.
*   **Quantile**: Between-array normalization (assumes no global differences).
*   **SWAN**: Normalizes Infinium I and II probes together.

### 4. Statistical Analysis (DMP and DMR)
*   **DMPs**: Calculated using `limma` on **M-values** (logit-transformed Beta values) to ensure homoscedasticity. Beta values are used for visualization.
*   **DMRs**: Calculated using `mCSEA` based on Gene Set Enrichment Analysis (GSEA) principles applied to promoters, gene bodies, or CpG islands.
*   **Paired Analysis**: If a "Donor" variable is selected during import, the package automatically includes it as a covariate in the linear model.

### 5. Exporting Results
The package allows exporting the internal R objects for further command-line analysis:
*   `RGSet`: Raw `RGChannelSet`.
*   `GenomicRatioSet`: Normalized data.
*   `Fit`: The `limma` linear model object.
*   `Ebayestables`: Statistics for each contrast.
*   `DMR_results`: `mCSEA` results list.

## Key Functions and Parameters

*   `run_shinyepico(n_cores, max_upload_size, host, port)`: Main entry point.
    *   `n_cores`: Set to 1 if RAM is limited (<8GB) to avoid overhead.
    *   `max_upload_size`: Increase this if working with very large ZIP files of iDATs.
*   `minfi::detectionP`: Used internally to filter probes with average p-value > 0.01.
*   `limma::removeBatchEffect`: Used for visualization in heatmaps (does not affect statistical testing).

## Tips for Success
*   **Memory Management**: Analyzing EPIC arrays is RAM-intensive. 12GB+ is recommended for smooth operation.
*   **Categorical Variables**: Do not use pure numbers for categorical groups in the sample sheet; ensure they are strings to avoid incorrect coercion to numeric types.
*   **Seed Setting**: Always run `set.seed()` before `run_shinyepico()` to ensure that DMR p-values (which rely on permutations) are reproducible.
*   **Sex Chromosomes**: Use the "Drop X/Y Chr" option if the donor sex is a confounding factor not relevant to the primary research question.

## Reference documentation
- [shinyÉPICo: the user's guide](./references/shiny_epico.md)
- [shinyÉPICo: the user's guide (RMarkdown)](./references/shiny_epico.Rmd)