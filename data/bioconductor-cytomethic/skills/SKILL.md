---
name: bioconductor-cytomethic
description: The package links to our models on ExperimentHub. The package currently supports HM450, EPIC, EPICv2, MSA, and MM285.
homepage: https://bioconductor.org/packages/release/data/experiment/html/CytoMethIC.html
---

# bioconductor-cytomethic

name: bioconductor-cytomethic
description: DNA methylome-based classification and phenotyping using machine learning models. Use this skill to predict cancer types, subtypes, cell of origin, age, sex, race, and tissue composition from DNA methylation beta values across platforms including HM450, EPIC, EPICv2, MSA, and MM285.

# bioconductor-cytomethic

## Overview
`CytoMethIC` provides a high-level abstraction for using machine learning models (RandomForest, SVM, XGBoost, and TensorFlow) to classify cancer types and phenotypes from DNA methylation data. It integrates with `ExperimentHub` to provide pre-trained models for CNS tumors, pan-cancer classification, race prediction, cell of origin, and more.

## Installation
```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("CytoMethIC")
```

## Core Workflow

1. **Prepare Data**: Load methylation beta values (typically using the `sesame` package).
2. **Preprocess**: Handle missing values or platform differences.
3. **Load Model**: Retrieve a model from `ExperimentHub` or a remote RDS file.
4. **Predict**: Use `cmi_predict` to generate results.

### 1. Data Preparation and Preprocessing
Models require a beta value matrix. If data contains missing values or comes from a different platform than the model, use these helpers:

```r
library(CytoMethIC)
library(sesame)

# Impute missing values (required for most ML models)
betas <- imputeBetas(sesameDataGet("HM450.1.TCGA.PAAD")$betas)

# Convert between platforms (e.g., EPIC to HM450) if necessary
# betas_lifted <- imputeBetas(mLiftOver(betas_epic, "HM450"))
```

### 2. Loading Models
Models are identified by `ExperimentHub` IDs (EHID) or hosted on GitHub.

*   **ExperimentHub**:
    ```r
    library(ExperimentHub)
    eh <- ExperimentHub()
    model <- eh[["EH8395"]] # Example: Pan-cancer Random Forest
    ```
*   **GitHub**:
    ```r
    model_url <- "https://github.com/zhou-lab/CytoMethIC_models/raw/main/models/Race3_rfcTCGA_InfHum3.rds"
    model <- readRDS(url(model_url))
    ```

### 3. Running Predictions
The primary function is `cmi_predict` (or `cmi_classify` in some versions).

```r
# General prediction (Cancer type, Race, Sex, etc.)
results <- cmi_predict(betas, model)

# Interpreting results
# For classification: results$response (label) and results$prob (probability)
# For regression (Age): results$age
# For composition: results$frac
```

## Common Model Categories

| Task | Example EHID | Description |
| :--- | :--- | :--- |
| **Cancer Type** | `EH8395` (RFC), `EH8396` (SVM) | 33 TCGA cancer types |
| **CNS Tumors** | `EH8399` | 66 CNS tumor classes |
| **Subtypes** | `EH8422` | 91 TCGA cancer subtypes |
| **Cell of Origin**| `EH8423` | 21 Cell of origin classes |
| **Race/Ethnicity**| `EH8421` | 5-race classification |
| **Tissue Comp** | (GitHub) | Deconvolution/Cell fractions |

## Tips for Success
*   **Imputation**: Always run `imputeBetas()` on your input matrix before prediction, as most underlying models (like Random Forest or SVM) cannot handle `NA` values.
*   **Platform Matching**: Ensure your beta values match the platform the model was trained on (e.g., HM450 vs EPIC). Use `mLiftOver` from the `sesame` ecosystem if a mismatch exists.
*   **Model Metadata**: Check `cmi_models` (a built-in data frame) to see a list of supported models and their descriptions.

## Reference documentation
- [CytoMethIC User Guide](./references/CytoMethIC.Rmd)
- [Basic Information](./references/CytoMethIC.md)
- [Oncology Models](./references/Oncology.md)