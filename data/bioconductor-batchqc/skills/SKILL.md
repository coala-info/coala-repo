---
name: bioconductor-batchqc
description: BatchQC identifies, evaluates, and corrects batch effects in high-throughput genomic data using diagnostic tests and established correction methods. Use when user asks to identify batch effects, evaluate data confounding, perform kBET analysis, or correct batch effects using ComBat or ComBat-Seq.
homepage: https://bioconductor.org/packages/release/bioc/html/BatchQC.html
---

# bioconductor-batchqc

## Overview
BatchQC is a Bioconductor package designed to identify, evaluate, and correct batch effects in high-throughput genomic data. It provides both an interactive Shiny application and a suite of R functions for programmatic analysis. The package streamlines the workflow of data normalization, batch diagnostic testing (kBET, AIC, Pearson correlation), and correction using established methods like ComBat and ComBat-Seq.

## Core Workflow

### 1. Data Preparation
BatchQC primarily operates on `SummarizedExperiment` (SE) objects. You can create one from a feature matrix and metadata.

```R
library(BatchQC)
# Example using provided protein data
data(protein_data)
data(protein_sample_info)
se_object <- BatchQC::summarized_experiment(protein_data, protein_sample_info)

# Ensure batch and condition variables are factors
se_object$batch <- as.factor(se_object$batch)
se_object$condition <- as.factor(se_object$condition)
```

### 2. Diagnostic Analysis
Before correction, evaluate the extent of batch effects.

*   **Confounding Metrics:** Check correlation between batch and condition.
    ```R
    confound_table <- BatchQC::confound_metrics(se = se_object, batch = "batch")
    ```
*   **kBET:** Quantify batch effects using a chi-square test on local neighborhoods.
    ```R
    kbet_results <- BatchQC::run_kBET(se = se_object, assay_to_normalize = "counts", batch = "batch")
    BatchQC::plot_kBET(kbet_results)
    ```
*   **Distribution Check:** Use AIC to determine if data fits Negative Binomial, Lognormal, or Voom distributions.
    ```R
    aic_results <- compute_aic(se = se_object, assay_of_interest = "counts", batchind = "batch", groupind = "condition")
    ```

### 3. Normalization and Batch Correction
Apply normalization followed by the appropriate correction method based on your data distribution.

*   **Normalization:**
    ```R
    se_object <- BatchQC::normalize_SE(se = se_object, method = "CPM", assay_to_normalize = "counts", output_assay_name = "CPM_norm")
    ```
*   **Correction:**
    *   **ComBat-Seq:** Use for raw, untransformed count data (Negative Binomial).
    *   **ComBat:** Use for normalized, log-transformed data (Lognormal).
    *   **limma:** Use for log-transformed data.

    ```R
    # Example: ComBat correction
    se_object <- BatchQC::batch_correct(se = se_object, method = "ComBat", 
                                        assay_to_normalize = "CPM_norm", 
                                        batch = "batch", covar = "condition", 
                                        output_assay_name = "ComBat_corrected")
    ```

### 4. Visualization
Compare raw and corrected data to verify batch removal.

*   **PCA Plot:**
    ```R
    pca_plot <- BatchQC::PCA_plotter(se = se_object, assays = c("counts", "ComBat_corrected"), 
                                     color = "batch", shape = "condition")
    pca_plot$plot
    ```
*   **Explained Variation:**
    ```R
    ex_var <- batchqc_explained_variation(se = se_object, batch = "batch", 
                                          condition = "condition", assay_name = "ComBat_corrected")
    BatchQC::EV_plotter(batchqc_ev = ex_var[[1]])
    ```
*   **Heatmaps:**
    ```R
    heatmaps <- BatchQC::heatmap_plotter(se = se_object, assay = "ComBat_corrected", 
                                         annotation_column = c("batch", "condition"))
    heatmaps$correlation_heatmap
    ```

### 5. Differential Expression
Perform DE analysis while accounting for batch.
```R
de_results <- BatchQC::DE_analyze(se = se_object, method = "limma", 
                                  batch = "batch", conditions = c("condition"), 
                                  assay_to_analyze = "ComBat_corrected")
```

## Tips for Success
*   **Interactive Mode:** Use `BatchQC()` to launch the Shiny app for exploratory analysis, then use the R functions for reproducible scripts.
*   **Assay Management:** BatchQC functions often return the SE object with a new assay added. Always keep track of the `output_assay_name`.
*   **Factor Check:** Ensure your batch and covariate columns in the SE metadata are explicitly set as `factors` to avoid errors in modeling.

## Reference documentation
- [Introduction to BatchQC](./references/BatchQC_Intro.md)
- [BatchQC Examples](./references/BatchQC_examples.md)