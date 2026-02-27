---
name: bioconductor-mofa
description: MOFA is a statistical framework that integrates multiple data modalities to infer latent factors representing the main sources of variation across samples. Use when user asks to integrate multi-omics data, perform multi-view factor analysis, or identify latent drivers of biological variation.
homepage: https://bioconductor.org/packages/3.9/bioc/html/MOFA.html
---


# bioconductor-mofa

## Overview

MOFA is a statistical framework for integrating multiple "views" (data modalities) measured on the same set of samples. It generalizes Principal Component Analysis (PCA) to multi-omics data, inferring latent factors that capture the driving sources of variation across different data types. This skill guides the workflow from data preparation and model training to downstream characterization of biological or technical factors.

## Core Workflow

### 1. Data Preparation
MOFA accepts data as a list of matrices (features as rows, samples as columns) or a `MultiAssayExperiment` object.

```r
library(MOFA)
library(MOFAdata)

# Option 1: List of matrices
data("CLL_data")
MOFAobject <- createMOFAobject(CLL_data)

# Option 2: MultiAssayExperiment
# mae_obj <- MultiAssayExperiment(experiments = CLL_data, colData = metadata)
# MOFAobject <- createMOFAobject(mae_obj)
```

### 2. Model Configuration
Define data, model, and training options before running the model.

```r
# Get default options
DataOptions <- getDefaultDataOptions()
ModelOptions <- getDefaultModelOptions(MOFAobject)
TrainOptions <- getDefaultTrainOptions()

# Customize options
ModelOptions$numFactors <- 25
TrainOptions$DropFactorThreshold <- 0.02 # Remove factors explaining < 2% variance
TrainOptions$tolerance <- 0.01           # Convergence threshold

# Prepare the object
MOFAobject <- prepareMOFA(
  MOFAobject,
  DataOptions = DataOptions,
  ModelOptions = ModelOptions,
  TrainOptions = TrainOptions
)
```

### 3. Training the Model
MOFA requires the `mofapy` Python package via `reticulate`.

```r
# Ensure reticulate is pointed to the correct python/conda env
# library(reticulate); use_python("/path/to/python")

MOFAobject <- runMOFA(MOFAobject)
```

### 4. Downstream Analysis

#### Variance Decomposition
Identify which factors are active in which omic views.
```r
plotVarianceExplained(MOFAobject)
```

#### Inspecting Loadings (Weights)
Identify the features (genes, CpGs, etc.) driving each factor.
```r
# Plot top features for a factor
plotTopWeights(MOFAobject, view = "mRNA", factor = 1)

# Heatmap of original data for top features
plotDataHeatmap(MOFAobject, view = "mRNA", factor = 1, features = 20)
```

#### Sample Ordination
Visualize samples in the latent factor space.
```r
plotFactorScatter(MOFAobject, factors = 1:2, color_by = "Condition")
plotFactorBeeswarm(MOFAobject, factors = 1, color_by = "Condition")
```

#### Enrichment Analysis
Perform Gene Set Enrichment Analysis (GSEA) on the factor loadings.
```r
# feature.sets should be a binary matrix (sets x features)
gsea <- runEnrichmentAnalysis(MOFAobject, view = "mRNA", feature.sets = reactomeGS)
plotEnrichment(MOFAobject, gsea, factor = 1)
```

#### Imputation and Prediction
```r
# Impute missing values in the original matrices
MOFAobject <- impute(MOFAobject)
imputed_data <- getImputedData(MOFAobject)
```

## Best Practices

- **Normalization**: Always normalize and variance-stabilize data (e.g., log-transform RNA-seq counts) before running MOFA.
- **Feature Selection**: Use the top N most variable features per assay (e.g., 2000-5000) to prevent the model from being overwhelmed by noise.
- **Technical Effects**: If strong batch effects are known, use `regressCovariates` before training to ensure MOFA focuses on biological signal.
- **Model Selection**: Since the optimization is non-convex, run the model multiple times with different seeds and use `compareModels` and `selectModel` to find the most robust solution with the highest ELBO.
- **Likelihoods**: Use "gaussian" for continuous data, "bernoulli" for binary (e.g., mutations), and "poisson" for counts.

## Reference documentation

- [MOFA vignette](./references/MOFA.md)
- [MOFA CLL Example](./references/MOFA_example_CLL.md)
- [MOFA scMT Example](./references/MOFA_example_scMT.md)
- [MOFA Simulated Data Example](./references/MOFA_example_simulated.md)