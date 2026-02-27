---
name: bioconductor-marr
description: The marr package implements a nonparametric method to identify and filter reproducible features in high-throughput biological data by calculating maximal rank statistics across replicate sample pairs. Use when user asks to quantify feature reproducibility, identify consistent measurements across replicates, or filter high-dimensional datasets like metabolomics for reproducible components.
homepage: https://bioconductor.org/packages/release/bioc/html/marr.html
---


# bioconductor-marr

## Overview
The `marr` package implements a nonparametric method to identify reproducible features in high-throughput biological experiments. It calculates a maximal rank statistic to determine if measurements are consistent across replicate sample pairs. It is particularly useful for MS-Metabolomics but applicable to any high-dimensional data where reproducibility between replicates needs to be quantified without parametric assumptions.

## Core Workflow

### 1. Data Preparation
The input should be a `matrix`, `data.frame`, or `SummarizedExperiment` object. Rows represent features (e.g., metabolites, genes) and columns represent replicate samples.

```r
library(marr)
# Example using built-in COPD metabolomics data
data("msprepCOPD")
# msprepCOPD is a SummarizedExperiment (645 features x 20 replicates)
```

### 2. Running the marr Procedure
Use the `Marr()` function to calculate reproducibility.

```r
# Basic execution with default thresholds
# pSamplepairs: threshold for feature reproducibility (default 0.75)
# pFeatures: threshold for sample pair reproducibility (default 0.75)
# alpha: FDR significance level (default 0.05)
Marr_output <- Marr(msprepCOPD, 
                    pSamplepairs = 0.75, 
                    pFeatures = 0.75, 
                    alpha = 0.05)
```

### 3. Extracting and Interpreting Results
The output object contains reproducibility percentages for both features and sample pairs.

```r
# Get reproducibility % for each feature across all sample pairs
feat_repro <- MarrFeatures(Marr_output)
head(feat_repro)

# Get reproducibility % for each sample pair across all features
pair_repro <- MarrSamplepairs(Marr_output)
head(pair_repro)

# Get the overall percentage of features/pairs passing the 75% threshold
MarrFeaturesfiltered(Marr_output)
MarrSamplepairsfiltered(Marr_output)
```

### 4. Visualization
Visualize the distribution of reproducibility to determine if thresholds are appropriate.

```r
# Plot % of reproducible features per sample pair
MarrPlotSamplepairs(Marr_output)

# Plot % of reproducible sample pairs per feature
MarrPlotFeatures(Marr_output)
```

### 5. Filtering Data
Filter the original dataset to keep only reproducible components.

```r
# Filter by features only
clean_features <- MarrFilterData(Marr_output, by = "features")

# Filter by sample pairs only
clean_samples <- MarrFilterData(Marr_output, by = "samplePairs")

# Filter by both
clean_all <- MarrFilterData(Marr_output, by = "both")
```

## Tips for Success
- **Input Scaling**: `marr` is rank-based and nonparametric, so it is robust to different normalization methods, but data should be pre-processed (imputed and normalized) before analysis.
- **Threshold Selection**: If `MarrFeaturesfiltered` returns a very low percentage, consider lowering `pSamplepairs` or inspecting the `MarrPlotFeatures` output to find a more natural elbow in the distribution.
- **Sample Pairs**: For $I$ replicates, the algorithm evaluates $J = \binom{I}{2}$ pairs. Large numbers of replicates will increase computation time accordingly.

## Reference documentation
- [The marr user's guide](./references/MarrVignette.md)
- [The marr user's guide (RMarkdown)](./references/MarrVignette.Rmd)