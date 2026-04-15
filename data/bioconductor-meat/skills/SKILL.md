---
name: bioconductor-meat
description: This tool estimates epigenetic age and age acceleration specifically for human skeletal muscle samples using DNA methylation data. Use when user asks to calculate DNAmage, perform muscle-specific data calibration, or estimate age acceleration metrics like AAdiff and AAresid.
homepage: https://bioconductor.org/packages/release/bioc/html/MEAT.html
---

# bioconductor-meat

name: bioconductor-meat
description: Specialized tool for estimating epigenetic age and age acceleration specifically in human skeletal muscle samples using DNA methylation data (HM27, HM450, and EPIC arrays). Use when analyzing muscle-specific epigenetic clocks, calculating DNAmage, AAdiff, or AAresid, and performing data calibration against muscle-specific gold standards.

# bioconductor-meat

## Overview

MEAT (Muscle Epigenetic Age Test) is a Bioconductor package designed to estimate the epigenetic age of human skeletal muscle samples. While pan-tissue clocks exist, MEAT provides higher accuracy for muscle tissue by using a penalized regression model (elastic net) trained specifically on skeletal muscle datasets. It supports two versions: the original MEAT (200 CpGs) and MEAT 2.0 (156 CpGs).

The workflow follows a strict three-step sequence:
1. **Data Cleaning**: Subsetting to relevant CpGs and imputing missing values.
2. **Data Calibration**: Rescaling methylation profiles to a muscle-specific gold standard.
3. **Age Estimation**: Calculating the epigenetic age (DNAmage) and age acceleration metrics.

## Workflow

### 1. Data Preparation
MEAT requires data to be formatted as a `SummarizedExperiment` object. The methylation matrix must be named "beta" within the assays list.

```r
library(MEAT)
library(SummarizedExperiment)

# beta_matrix: CpGs in rows, samples in columns
# pheno_data: samples in rows, phenotypes (including Age) in columns
GSE_SE <- SummarizedExperiment(assays = list(beta = beta_matrix),
                               colData = pheno_data)
```

### 2. Data Cleaning
The `clean_beta` function reduces the matrix to the CpGs used in the clock and handles imputation.

```r
# version can be "MEAT" or "MEAT2.0"
GSE_SE_clean <- clean_beta(SE = GSE_SE, version = "MEAT2.0")
```

### 3. Data Calibration
Calibration harmonizes your data with the gold standard (GSE50498) to account for lab-to-lab variability and different processing methods. This is a critical step for accurate age estimation.

```r
GSE_SE_calibrated <- BMIQcalibration(SE = GSE_SE_clean, version = "MEAT2.0")
```

### 4. Epigenetic Age Estimation
The final step calculates the epigenetic age. If chronological age is provided in the `colData`, it also calculates age acceleration.

```r
GSE_SE_epiage <- epiage_estimation(SE = GSE_SE_calibrated,
                                   age_col_name = "Age", # Name of the age column in colData
                                   version = "MEAT2.0")

# Results are stored in colData
results <- colData(GSE_SE_epiage)
```

## Key Metrics and Interpretation

*   **DNAmage**: The estimated epigenetic age of the muscle sample.
*   **AAdiff**: Age Acceleration Difference (DNAmage - Chronological Age). Positive values suggest "older" muscle; negative values suggest "younger" muscle. Note: sensitive to dataset mean age and preprocessing.
*   **AAresid**: Age Acceleration Residuals. Calculated as the residuals from a linear regression of DNAmage on chronological age. This metric is more robust against different preprocessing methods and insensitive to the mean age of the dataset. (Requires n > 2 samples).

## Tips for Success

*   **Preprocessing**: For best results, input beta values that have already been normalized (e.g., using ChAMP or minfi) and corrected for batch effects.
*   **Assay Naming**: Ensure the assay in your `SummarizedExperiment` is explicitly named `"beta"`.
*   **Version Consistency**: Use the same `version` argument ("MEAT" or "MEAT2.0") across all three functions in the workflow.
*   **CpG Information**: To inspect the CpGs and coefficients used in the models, you can load the internal data:
    *   `data("CpGs_in_MEAT")`
    *   `data("CpGs_in_MEAT2.0")`

## Reference documentation

- [MEAT (Muscle Epigenetic Age Test)](./references/MEAT.md)
- [MEAT (Muscle Epigenetic Age Test) Rmd](./references/MEAT.Rmd)