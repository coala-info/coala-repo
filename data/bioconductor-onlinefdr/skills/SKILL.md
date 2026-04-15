---
name: bioconductor-onlinefdr
description: This tool provides algorithms for controlling False Discovery Rate and Familywise Error Rate in sequential, batch, and asynchronous hypothesis testing. Use when user asks to control error rates for streaming p-values, implement online FDR algorithms like LORD or SAFFRON, or perform multiple testing with dependent data.
homepage: https://bioconductor.org/packages/release/bioc/html/onlineFDR.html
---

# bioconductor-onlinefdr

name: bioconductor-onlinefdr
description: Expert guidance for using the onlineFDR Bioconductor R package to control False Discovery Rate (FDR) and Familywise Error Rate (FWER) in online, batch, and asynchronous hypothesis testing. Use this skill when a user needs to perform multiple hypothesis testing where p-values arrive in a stream or batches, or when they need to implement algorithms like LOND, LORD, SAFFRON, or ADDIS in R.

## Overview

The `onlineFDR` package provides a suite of algorithms for controlling error rates (FDR or FWER) when hypotheses are tested sequentially. Unlike traditional "offline" methods (like Benjamini-Hochberg) that require all p-values upfront, online methods allow for decision-making as data arrives, using a "wealth" system where discoveries earn back error budget.

## Core Workflow

### 1. Data Preparation
Input data should be a dataframe containing at least a `pval` column. Optional columns include `id` and `date` (format: "YYYY-MM-DD").

```r
library(onlineFDR)

# Example dataset
sample.df <- data.frame(
  id = c('A1', 'B2', 'C3'),
  date = as.Date(c("2023-01-01", "2023-01-01", "2023-02-01")),
  pval = c(1e-5, 0.04, 0.001)
)
```

### 2. Algorithm Selection
Choose an algorithm based on your data structure and dependency assumptions:

*   **FDR Control (Independent p-values):**
    *   `LORD()`: Default (LORD++). Good general-purpose online FDR control.
    *   `SAFFRON()`: Adaptive; more powerful when many non-nulls are present.
    *   `ADDIS()`: Discards conservative nulls; highest power for very conservative p-values.
*   **FDR Control (Dependent p-values):**
    *   `LOND()`: Controls FDR for independent or positively dependent (PRDS) p-values.
    *   `LOND(..., dep = TRUE)`: Guarantees control for arbitrary dependence.
    *   `LORD(..., version = 'dep')`: LORD version for arbitrary dependence.
*   **FWER Control:**
    *   `Alpha_spending()`: Bonferroni-like; handles arbitrary dependence.
    *   `online_fallback()`: More powerful than Alpha-spending; handles arbitrary dependence.
    *   `ADDIS_spending()`: Adaptive FWER control for independent p-values.

### 3. Execution and Interpretation
Always set a seed if your data contains batches (same dates), as `onlineFDR` randomizes order within batches by default to prevent post-hoc ordering bias.

```r
set.seed(123)
results <- LORD(sample.df, alpha = 0.05)

# Interpretation
# results$alphai: The adjusted significance threshold for each test
# results$R: Binary indicator (1 = Rejected/Discovery, 0 = Accepted)
num_discoveries <- sum(results$R)
```

## Advanced Usage

### Batch and Asynchronous Testing
*   **Batch Testing:** Use `BatchPRDS()`, `BatchBH()`, or `BatchStBH()` if p-values arrive in groups. Requires a `batch` column.
*   **Asynchronous Testing:** Use `LONDstar()`, `LORDstar()`, or `SAFFRONstar()` for overlapping tests where start/finish times vary.

### Customizing Parameters
*   `alpha`: Overall significance level (default 0.05).
*   `random`: Set to `FALSE` only if you have a specific, independent reason to order p-values (e.g., date-time stamps).
*   `betai` / `gammai`: Sequences that determine how alpha wealth is spent. Most users should use the defaults.

## Tips for Success
1.  **Consistency:** When using the package over time as a dataset grows, use the **same seed** for every run to ensure previous decisions remain consistent.
2.  **Full Reporting:** Pass all p-values to the functions, not just those you think are significant.
3.  **Power vs. Conservativeness:** If you have arbitrary dependence, use `LOND(dep=TRUE)` or `online_fallback()`, but be aware these are significantly more conservative (lower power).

## Reference documentation
- [Advanced usage of onlineFDR](./references/advanced-usage.md)
- [Managing online multiple hypothesis testing using the onlineFDR package](./references/onlineFDR.md)
- [The theory behind onlineFDR](./references/theory.md)