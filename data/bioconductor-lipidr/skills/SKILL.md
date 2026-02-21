---
name: bioconductor-lipidr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/lipidr.html
---

# bioconductor-lipidr

name: bioconductor-lipidr
description: Comprehensive analysis of targeted lipidomics data. Use when Claude needs to process Skyline exported CSV files, perform quality control, normalize lipidomics data, conduct differential analysis, or perform lipid set enrichment analysis (LSEA) in R.

# bioconductor-lipidr

## Overview
`lipidr` is a Bioconductor package designed for the inspection, analysis, and visualization of targeted lipidomics datasets. It primarily handles data exported from Skyline as CSV files. The package represents data as `SummarizedExperiment` objects, allowing for seamless integration with the broader Bioconductor ecosystem. Key capabilities include data normalization (PQN and internal standards), multivariate analysis (PCA, OPLS-DA), differential expression using `limma`, and a specialized Lipid Set Enrichment Analysis (LSEA).

## Core Workflow

### 1. Data Import and Annotation
Load Skyline CSV files and attach sample metadata.

```r
library(lipidr)

# Import Skyline files
files <- list.files(path = "data/", pattern = "*.csv", full.names = TRUE)
d <- read_skyline(files)

# Add sample annotations (CSV with sample names and clinical variables)
d <- add_sample_annotation(d, "clinical_data.csv")
```

### 2. Quality Control
Visualize data distributions and check for batch effects or outliers.

```r
# Plot Total Ion Current (TIC)
plot_samples(d, type = "tic", log = TRUE)

# Check molecule-wise variation (SD or CV)
plot_molecules(d, "cv", measure = "Area")

# Boxplots by lipid class
plot_lipidclass(d, "boxplot")
```

### 3. Data Processing
Summarize multiple transitions per lipid and normalize the data.

```r
# Aggregate transitions to lipid level
d_summarized <- summarize_transitions(d, method = "average")

# Normalization: Probabilistic Quotient Normalization (PQN)
d_norm <- normalize_pqn(d_summarized, measure = "Area", exclude = "blank", log = TRUE)

# Alternative: Internal Standard (ISTD) normalization
# d_norm <- normalize_istd(d_summarized, measure = "Area")
```

### 4. Multivariate Analysis (MVA)
Perform unsupervised (PCA) or supervised (OPLS-DA) analysis.

```r
# PCA
mva_pca <- mva(d_norm, method = "PCA")
plot_mva(mva_pca, color_by = "group")

# OPLS-DA (requires group comparison)
mva_opls <- mva(d_norm, method = "OPLS-DA", group_col = "Diet", groups = c("HighFat", "Normal"))
top_lipids(mva_opls, top.n = 10)
```

### 5. Differential Analysis
Identify significantly altered lipids between conditions using `limma` logic.

```r
# Simple comparison
de_results <- de_analysis(
  data = d_norm, 
  HighFat - Normal,
  measure = "Area"
)

# View significant molecules
significant_molecules(de_results)

# Volcano plot
plot_results_volcano(de_results, show.labels = FALSE)
```

### 6. Lipid Set Enrichment Analysis (LSEA)
Detect enrichment in lipid classes, chain lengths, or unsaturation patterns.

```r
# Perform LSEA based on log fold change
enrich_results <- lsea(de_results, rank.by = "logFC")

# View significant sets
significant_lipidsets(enrich_results)

# Visualize enrichment
plot_enrichment(de_results, significant_lipidsets(enrich_results), annotation = "class")
plot_chain_distribution(de_results)
```

## Tips and Best Practices
- **Skyline Export**: Ensure "Transition Results" are exported from Skyline to include peak Area or Height.
- **Subsetting**: Use standard R indexing `d[rows, cols]` to filter lipids or samples. `rowData(d)` contains lipid metadata (Class, total_cl, total_cs), while `colData(d)` contains sample metadata.
- **Interactive Plots**: Call `use_interactive_graphics()` to enable `plotly`-based interactive visualizations.
- **Complex Designs**: For multi-factor experiments, use `de_design()` and provide a design matrix or formula.

## Reference documentation
- [Workflow](./references/workflow.Rmd)
- [Workflow](./references/workflow.md)