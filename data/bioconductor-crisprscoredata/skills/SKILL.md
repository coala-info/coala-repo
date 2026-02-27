---
name: bioconductor-crisprscoredata
description: This package provides access to pre-trained model weights and file paths for various CRISPR on-target activity prediction algorithms. Use when user asks to retrieve model files for DeepHF, Lindel, CRISPRa, or CRISPRi to be used with the crisprScore package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/crisprScoreData.html
---


# bioconductor-crisprscoredata

name: bioconductor-crisprscoredata
description: Access and manage pre-trained models for CRISPR on-target activity prediction. Use this skill when you need to retrieve model weights or file paths for algorithms like DeepHF, Lindel, CRISPRa, or CRISPRi to be used with the crisprScore package.

# bioconductor-crisprscoredata

## Overview

The `crisprScoreData` package serves as a data companion to the `crisprScore` package. It provides a centralized interface to retrieve pre-trained machine learning models and weights required for various CRISPR scoring algorithms. These models are hosted on Bioconductor's `ExperimentHub`, ensuring versioned and cached access to large model files (HDF5, PKL, and RDS formats).

## Installation

To install the package from Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("crisprScoreData")
```

## Accessing Model Files

The package provides two primary ways to access model data: direct accessor functions and the `ExperimentHub` interface.

### Direct Accessor Functions

The most straightforward way to get the local file path of a specific model is to call its named function. These functions automatically download the data from ExperimentHub (if not already cached) and return the local path.

**DeepHF Models (HDF5):**
```r
library(crisprScoreData)

# Wild-type SpCas9 models
path_wt <- DeepWt.hdf5()
path_t7 <- DeepWt_T7.hdf5()
path_u6 <- DeepWt_U6.hdf5()

# High-fidelity and enhanced specificity models
path_esp <- esp_rnn_model.hdf5()
path_hf  <- hf_rnn_model.hdf5()
```

**Lindel and CRISPRa/i Models:**
```r
# Lindel model weights (Pickle file)
path_lindel <- Model_weights.pkl()

# CRISPRa and CRISPRi models
path_crispra <- CRISPRa_model.pkl()
path_crispri <- CRISPRi_model.pkl()

# Combined Random Forest model
path_rf <- RFcombined.rds()
```

### ExperimentHub Interface

For programmatic discovery or to see all available records, use the `ExperimentHub` query system.

```r
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "crisprScoreData")

# Retrieve by ExperimentHub ID
model_path <- eh[["EH6127"]]
```

## Typical Workflow

1. **Identify the Algorithm**: Determine which scoring algorithm you intend to use in `crisprScore` (e.g., DeepHF).
2. **Retrieve Path**: Use the corresponding `crisprScoreData` function to get the path to the model file.
3. **Pass to Scorer**: Provide this path to the scoring function in the `crisprScore` package.

Example:
```r
library(crisprScoreData)
# Get the path for the DeepHF WT model
model_path <- DeepWt.hdf5()

# This path is then typically used by crisprScore functions:
# results <- crisprScore::getDeepHFScores(guides, modelFile = model_path)
```

## Tips

- **Caching**: The first time you call a model function, it will download the file. Subsequent calls will load the file from your local BiocFileCache, making it much faster.
- **Metadata**: To see details about the source, species, or training data for a specific model, use `?crisprScoreData` or inspect the `mcols()` of the ExperimentHub object.
- **Dependencies**: Ensure you have `ExperimentHub` installed, as `crisprScoreData` relies on it for data delivery.

## Reference documentation

- [crisprScoreData Vignette (Rmd)](./references/crisprScoreData.Rmd)
- [crisprScoreData Documentation (md)](./references/crisprScoreData.md)