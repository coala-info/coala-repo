---
name: bioconductor-bloodgen3module
description: This package performs modular repertoire analysis of blood transcription data to interpret immune response signatures at a module level. Use when user asks to perform group comparison analysis, conduct individual sample comparisons against a reference, or generate fingerprint grid and heatmap visualizations.
homepage: https://bioconductor.org/packages/release/bioc/html/BloodGen3Module.html
---


# bioconductor-bloodgen3module

## Overview

The `BloodGen3Module` package is designed for modular repertoire analysis of blood transcription data. It translates gene-level expression changes into module-level results, expressing findings as the percentage of genes within a predefined module that are significantly increased or decreased. This higher-level abstraction helps in interpreting complex immune response signatures.

## Core Workflow

### 1. Data Preparation
*   **Expression Matrix**: Must be **non-log2 transformed** (the package performs transformation internally).
*   **Sample Annotation**: A data frame where row names match the column names of the expression matrix.
*   **Input Formats**: Supports both standard matrices and `SummarizedExperiment` objects.

### 2. Group Comparison Analysis
Compare two groups (e.g., Sepsis vs. Control) to find module-level differences.

```R
library(BloodGen3Module)

# Using t-test
Group_df <- Groupcomparison(data_matrix,
                            sample_info = sample.info,
                            FC = 1.5,
                            pval = 0.1,
                            FDR = TRUE,
                            Group_column = "Condition",
                            Test_group = "Sepsis",
                            Ref_group = "Control",
                            SummarizedExperiment = FALSE)

# Using limma (preferred for complex designs or better FDR control)
Group_limma <- Groupcomparisonlimma(data_matrix,
                                    sample_info = sample.info,
                                    FC = 1.5,
                                    pval = 0.1,
                                    FDR = TRUE,
                                    Group_column = "Condition",
                                    Test_group = "Sepsis",
                                    Ref_group = "Control",
                                    SummarizedExperiment = FALSE)
```

### 3. Individual Sample Analysis
Compare each individual sample against a reference group to see personalized module activity.

```R
Individual_df <- Individualcomparison(data_matrix,
                                     sample_info = sample.info,
                                     FC = 1.5,
                                     DIFF = 10,
                                     Group_column = "Condition",
                                     Ref_group = "Control",
                                     SummarizedExperiment = FALSE)
```

### 4. Visualization
The package provides two primary visualization types, typically outputting to PDF.

*   **Fingerprint Grid**: Best for group-level summaries.
    ```R
    gridplot(Group_df,
             cutoff = 15, # % threshold for display
             Ref_group = "Control",
             filename = "Group_Grid.pdf")
    ```

*   **Fingerprint Heatmap**: Best for individual sample variation.
    ```R
    fingerprintplot(Individual_df,
                    sample_info = sample.info,
                    cutoff = 15,
                    rowSplit = TRUE,
                    Group_column = "Condition",
                    Ref_group = "Control",
                    filename = "Individual_Heatmap.pdf")
    ```

## Key Tips
*   **Column Names**: Ensure the `Group_column` argument exactly matches the column name in your `sample_info` data frame.
*   **Cutoff**: The `cutoff` parameter in plotting functions (default 15%) filters out modules where the percentage of differentially expressed genes is below that threshold.
*   **Data Scale**: If your data is already log-transformed, you must exponentiate it back to linear scale before using these functions to avoid incorrect fold-change calculations.

## Reference documentation
- [BloodGen3Module](./references/BloodGen3Module.md)