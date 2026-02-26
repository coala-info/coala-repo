---
name: r-sleuth
description: This tool performs statistical analysis of RNA-Seq data to identify differentially expressed transcripts using bootstrap estimates from quantification tools like kallisto. Use when user asks to perform differential expression analysis, fit linear models to transcript-level abundances, or conduct likelihood ratio and Wald tests on RNA-Seq experiments.
homepage: https://cran.r-project.org/web/packages/sleuth/index.html
---


# r-sleuth

name: r-sleuth
description: Statistical analysis of RNA-Seq experiments using the sleuth R package. Use this skill when performing differential expression analysis of transcript-level abundances, particularly those quantified using kallisto. It supports experimental designs with multiple conditions, covariates, and replicates, utilizing bootstrap samples to account for technical variation.

# r-sleuth

## Overview
The `sleuth` package is designed for the analysis of RNA-Seq data, specifically focusing on transcript-level differential expression. It leverages bootstrap estimates from quantification tools like `kallisto` to decouple technical noise from biological variance, providing more accurate effect size estimates and significance testing.

## Installation
To install the `sleuth` package from CRAN:
```R
install.packages("sleuth")
```

## Workflow

### 1. Data Preparation
Create a metadata data frame (often called `s2c`) containing a column `sample` (matching directory names) and columns for experimental conditions.
```R
sample_id <- dir(file.path("path", "to", "kallisto_results"))
kal_dirs <- sapply(sample_id, function(id) file.path("path", "to", "kallisto_results", id))
s2c <- data.frame(sample = sample_id, condition = c("A", "A", "B", "B"), path = kal_dirs, stringsAsFactors = FALSE)
```

### 2. The Sleuth Object
Initialize the sleuth object, which loads the data and bootstrap samples.
```R
library(sleuth)
so <- sleuth_prep(s2c, extra_bootstrap_summary = TRUE)
```

### 3. Model Fitting
Fit the full model and any reduced models for likelihood ratio tests (LRT).
```R
# Fit the full model
so <- sleuth_fit(so, ~condition, 'full')

# Fit a reduced model (e.g., intercept only) for LRT
so <- sleuth_fit(so, ~1, 'reduced')
```

### 4. Statistical Testing
Perform either a Likelihood Ratio Test (LRT) or a Wald Test.
```R
# Likelihood Ratio Test
so <- sleuth_lrt(so, 'reduced', 'full')

# Wald Test (requires specifying the coefficient)
so <- sleuth_wt(so, 'conditionB')
```

### 5. Results and Visualization
Extract results into a data frame and use built-in plotting functions.
```R
# Get results
results_table <- sleuth_results(so, 'reduced:full', 'lrt', show_all = FALSE)

# Visualization
plot_pca(so, color_by = 'condition')
plot_volcano(so, "conditionB")
plot_ma(so, "conditionB")
sleuth_live(so) # Launch shiny app for interactive exploration
```

## Key Functions
- `sleuth_prep()`: Reads kallisto outputs and prepares the sleuth object. Use `target_mapping` argument to map transcript IDs to gene names.
- `sleuth_fit()`: Fits a linear model to the data.
- `sleuth_lrt()`: Compares two models to find differentially expressed transcripts.
- `sleuth_wt()`: Tests if a specific coefficient is non-zero.
- `sleuth_results()`: Extracts the statistical results.
- `sleuth_live()`: Opens an interactive Shiny interface for data exploration.

## Tips
- **Bootstraps**: Ensure kallisto was run with `--bootstrap-samples` (typically 30-100) to take advantage of sleuth's error modeling.
- **Gene-level analysis**: Use the `aggregation_column` parameter in `sleuth_prep` to perform gene-level differential expression instead of transcript-level.
- **Filtering**: `sleuth_prep` performs basic filtering by default. You can customize this using the `filter_fun` argument.

## Reference documentation
- [sleuth Home Page](./references/home_page.md)