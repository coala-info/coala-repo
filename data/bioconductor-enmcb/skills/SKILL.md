---
name: bioconductor-enmcb
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/EnMCB.html
---

# bioconductor-enmcb

name: bioconductor-enmcb
description: Expert assistance for the EnMCB R package to identify Methylation Correlated Blocks (MCB) and build ensemble survival models. Use this skill when analyzing Illumina 450K methylation data to: (1) Identify genomic regions with highly correlated methylation patterns (MCBs), (2) Perform differential methylation analysis on blocks, (3) Build and validate survival models (Cox, SVR, Elastic-Net), or (4) Create stacked ensemble machine learning models for disease progression prediction.

# bioconductor-enmcb

## Overview

The `EnMCB` package provides tools for discovering Methylation Correlated Blocks (MCBs) from DNA methylation profiles (specifically Illumina Human Methylation 450K). It allows users to move beyond single-CpG analysis by grouping adjacent, highly correlated markers into functional blocks. These blocks can then be used as features for survival analysis using individual regression methods or a specialized stacked ensemble model that combines Cox regression, Support Vector Regression (SVR), and Elastic-Net.

## Core Workflow

### 1. Data Preparation and MCB Identification
The package requires a methylation matrix (CpGs as rows, samples as columns).

```r
library(EnMCB)

# Load demo data or your own 450K matrix
methylation_dataset <- create_demo()

# Identify MCBs based on Pearson correlation thresholds
res <- IdentifyMCB(methylation_dataset)

# Extract the MCB information table
MCB_info <- res$MCBinformation

# Filter for blocks with a minimum number of CpGs (e.g., >= 5)
MCB_filtered <- MCB_info[MCB_info[,"CpGs_num"] >= 5, ]
```

### 2. Differential Methylation Block Analysis
To find blocks that differ significantly between two groups (e.g., control vs. disease):

```r
# Define groups (vector matching columns of methylation_dataset)
groups <- c(rep("control", 200), rep("dis", 255))

# Calculate differential methylation for the identified blocks
diff_results <- DiffMCB(methylation_dataset, groups, MCB_filtered)$tab
```

### 3. Building Survival Models
You can build standard survival models using the identified blocks.

```r
library(survival)
data(demo_survival_data)

# Split data into training and testing
train_idx <- sample(1:ncol(methylation_dataset), 0.6 * ncol(methylation_dataset))
train_data <- methylation_dataset[, train_idx]
test_data <- methylation_dataset[, -train_idx]
surv_train <- demo_survival_data[train_idx]

# Build models (Method can be "cox", "svm", or "enet")
models <- metricMCB(MCB_filtered, 
                    training_set = train_data, 
                    Surv = surv_train, 
                    Method = "cox", 
                    ci = TRUE)

# Extract the best performing model
best_model <- models$best_cox_model$cox_model

# Predict risk scores for new data
# Note: predict() expects a data frame with CpGs as columns
new_data <- data.frame(t(test_data))
predictions <- predict(best_model, new_data)
```

### 4. Stacked Ensemble Modeling
For high-performance prediction on a specific MCB, use the ensemble approach.

```r
# Select a specific MCB (e.g., the first one)
# Note: ensemble_model is computationally intensive; usually run on single blocks
select_idx <- 1
em <- ensemble_model(t(MCB_filtered[select_idx, ]), 
                     training_set = train_data, 
                     Surv_training = surv_train)

# Predict using the ensemble model
em_predictions <- ensemble_prediction(ensemble_model = em, 
                                      prediction_data = test_data)
```

## Tips and Best Practices
- **Platform Support**: While designed for 450K data, any methylation matrix with genomic-order rows can technically be processed, though the default correlation thresholds are optimized for 450K.
- **Computational Load**: The `ensemble_model` function is resource-intensive. It is recommended to pre-filter MCBs (e.g., by differential methylation or univariate survival significance) before building ensemble models.
- **Data Orientation**: Pay close attention to matrix orientation. `IdentifyMCB` and `metricMCB` typically take CpGs as rows, but standard R `predict` methods often require samples as rows (use `t()`).

## Reference documentation
- [EnMCB Vignette](./references/vignette.md)