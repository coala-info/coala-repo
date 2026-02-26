---
name: bioconductor-gnosis
description: GNOSIS provides a workflow for the statistical and survival analysis of cancer genomics data. Use when user asks to launch the interactive Shiny interface, perform survival analysis using Kaplan-Meier curves or Cox models, integrate clinical data with CNA and MAF files, or conduct statistical association testing.
homepage: https://bioconductor.org/packages/release/bioc/html/GNOSIS.html
---


# bioconductor-gnosis

## Overview
GNOSIS (GeNomics explOrer using StatistIcal and Survival analysis in R) is a tool designed for the interrogation of cancer genomics data. While it is primarily known for its Shiny-based Graphical User Interface (GUI), it provides a structured workflow for integrating clinical data with Copy Number Alteration (CNA) and Mutation Annotation Format (MAF) data. It is particularly optimized for data sourced from cBioPortal.

## Installation and Loading
To use GNOSIS, ensure the package and its dependencies are installed via Bioconductor.

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("GNOSIS")
library(GNOSIS)
```

## Core Workflow

### 1. Launching the Interface
The primary way to interact with GNOSIS is through its interactive Shiny application.
```r
GNOSIS()
```

### 2. Data Integration and Preparation
GNOSIS handles three main types of data:
*   **Clinical Data:** Patient demographics and survival outcomes.
*   **CNA Data:** Copy number alteration metrics.
*   **MAF Data:** Mutation data for genomic landscape analysis.

**Key Pre-processing Steps:**
*   **Variable Reformatting:** Convert columns to factors or numeric types to ensure statistical functions (like ANOVA or Cox models) execute correctly.
*   **Survival Recoding:** Survival status must often be recoded to a binary format (0/1) for compatibility with survival analysis functions.
*   **Filtering:** Subset data based on categorical variables (e.g., treatment groups or stages) before running comparative tests.

### 3. Survival Analysis
The package provides a robust framework for identifying prognostic markers:
*   **Kaplan-Meier (KM) Curves:** Used to visualize survival probability over time across different cohorts.
*   **Log-rank Tests:** Statistical comparison of survival curves.
*   **Cox Proportional Hazards Models:**
    *   *Univariate:* Testing the effect of a single variable on survival.
    *   *Multivariable:* Adjusting for multiple covariates.
*   **Assumption Testing:** Use scaled Schoenfeld residuals to check the Proportional Hazards (PH) assumption.
*   **Recursive Partitioning:** If PH assumptions are violated, use survival trees (`rpart`) to identify non-linear interactions.

### 4. Statistical Association Testing
To identify confounding variables or associations between clinical features, GNOSIS supports:
*   **Categorical vs. Categorical:** Chi-squared or Fisher’s Exact tests.
*   **Categorical vs. Continuous:** ANOVA, Kruskal-Wallis, or t-tests.

### 5. Mutation Analysis
GNOSIS integrates with `maftools` to process MAF files:
*   **Summary Plots:** Visualize the most frequently mutated genes.
*   **Lollipop Plots:** Map mutations to specific protein domains.

## Tips for Success
*   **Reproducibility:** Always download the `Shiny_Log.txt` from the GUI session to track the exact inputs and filters applied to the data.
*   **CNA Metrics:** When uploading raw CNA data, use the internal calculation tools to segment metrics per patient before attempting survival correlation.
*   **Missing Data:** Check for warnings regarding missing MAF or CNA data when loading cBioPortal studies, as some studies only provide clinical subsets.

## Reference documentation
- [GNOSIS Overview](./references/GNOSIS.md)
- [GNOSIS R Markdown Source](./references/GNOSIS.Rmd)