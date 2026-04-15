---
name: bioconductor-animalcules
description: This tool provides an interactive framework for microbiome data analysis, visualization, and biomarker discovery using MultiAssayExperiment objects. Use when user asks to perform alpha or beta diversity analysis, visualize taxonomic abundance, conduct differential abundance testing, or apply dimensionality reduction techniques like PCA and UMAP to microbiome datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/animalcules.html
---

# bioconductor-animalcules

name: bioconductor-animalcules
description: Interactive microbiome analytics and visualization using the animalcules R package. Use this skill to perform alpha/beta diversity analysis, differential abundance testing with DESeq2, dimensionality reduction (PCA, PCoA, UMAP, t-SNE), and biomarker identification for microbiome datasets stored in MultiAssayExperiment (MAE) format.

# bioconductor-animalcules

## Overview
The `animalcules` package provides a comprehensive framework for microbiome data analysis. It utilizes the `MultiAssayExperiment` (MAE) data structure to integrate microbiome counts with sample metadata. The package is designed for both interactive use via a Shiny interface and programmatic use via R functions for visualization, diversity metrics, and machine learning-based biomarker discovery.

## Core Workflow

### 1. Data Loading and Preparation
The package primarily works with `MultiAssayExperiment` objects.

```r
library(animalcules)
library(SummarizedExperiment)

# Load example data
data_dir <- system.file("extdata/TB_example_dataset.rds", package = "animalcules")
MAE <- readRDS(data_dir)

# For custom data, ensure it is formatted as an MAE object
# or use the Shiny app to generate a compatible .rds file
```

### 2. Data Summary and Filtering
Before analysis, summarize metadata to identify outliers or distribution patterns.

*   **Pie/Box Plots:** `filter_summary_pie_box(MAE, samples_discard, filter_type, sample_condition)`
*   **Bar/Density Plots:** `filter_summary_bar_density(MAE, samples_discard, filter_type, sample_condition)`
*   **Binning Continuous Data:** Use `filter_categorize()` to convert continuous metadata (like age) into categorical groups for downstream comparison.

### 3. Visualization
Visualize relative abundance across taxonomic levels.

*   **Stacked Bar Plot:** `relabu_barplot(MAE, tax_level="genus", sort_by="conditions", sample_conditions=c("Group"))`
*   **Heatmap:** `relabu_heatmap(MAE, tax_level="family", sort_by="conditions")`
*   **Boxplot:** `relabu_boxplot(MAE, tax_level="genus", organisms=c("Genus1"), condition="Status")`

### 4. Diversity Analysis
*   **Alpha Diversity:** 
    *   Plot: `alpha_div_boxplot(MAE, tax_level="genus", condition="Disease", alpha_metric="shannon")`
    *   Test: `do_alpha_div_test(MAE, tax_level="genus", condition="Disease", alpha_metric="shannon", alpha_stat="T-test")`
*   **Beta Diversity:**
    *   Heatmap: `diversity_beta_heatmap(MAE, tax_level="genus", input_beta_method="bray")`
    *   NMDS: `diversity_beta_NMDS(MAE, tax_level="genus", input_beta_method="bray", input_select_beta_condition="Disease")`
    *   Statistical Test (PERMANOVA): `diversity_beta_test(MAE, tax_level="genus", input_beta_method="bray", input_select_beta_condition="Disease", input_select_beta_stat_method="PERMANOVA")`

### 5. Dimensionality Reduction
Wrappers for common reduction techniques (supports 2D and 3D):
*   **PCA:** `dimred_pca(MAE, tax_level="genus", color="age", shape="Disease")`
*   **PCoA:** `dimred_pcoa(MAE, tax_level="genus", method="bray")`
*   **UMAP:** `dimred_umap(MAE, tax_level="genus", n_neighbors=15)`
*   **t-SNE:** `dimred_tsne(MAE, tax_level="genus", perplexity=10)`

### 6. Differential Abundance and Biomarkers
*   **DESeq2 Analysis:** `differential_abundance(MAE, tax_level="phylum", input_da_condition=c("Disease"))`
*   **Biomarker Discovery:** Identify key microbes using machine learning (logistic regression, random forest, or GBM).
    ```r
    p <- find_biomarker(MAE, 
                        tax_level="genus", 
                        input_select_target_biomarker=c("Disease"),
                        model_name="logistic regression")
    # Access results
    p$biomarker      # List of microbes
    p$importance_plot # Feature importance
    p$roc_plot        # Model performance
    ```

## Tips for Success
*   **Taxonomic Levels:** Ensure `tax_level` matches the rowData in your MAE (e.g., "kingdom", "phylum", "class", "order", "family", "genus", "species").
*   **Data Types:** Functions like `relabu_boxplot` or `dimred_pca` often allow a `datatype` argument (e.g., "logcpm", "counts", "relabu").
*   **Interactive Mode:** If a GUI is preferred for exploration, run `run_animalcules()`.

## Reference documentation
- [animalcules](./references/animalcules.md)