---
name: bioconductor-regparallel
description: This tool performs high-throughput parallelized regression analyses on large dataframes using multi-core processing. Use when user asks to run thousands of linear, logistic, or Cox regression models, perform omics-wide association studies, or parallelize statistical testing across genomic variables.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RegParallel.html
---

# bioconductor-regparallel

name: bioconductor-regparallel
description: Perform high-throughput parallelized regression analyses (linear, logistic, Cox, conditional logistic) on large dataframes. Use this skill when you need to test thousands of variables (e.g., genomic probes, metabolites) against a trait while adjusting for covariates using multi-core processing.

# bioconductor-regparallel

## Overview

RegParallel is designed to overcome the computational bottleneck of running thousands of independent regression models in R. It wraps standard functions like `lm()`, `glm()`, `coxph()`, and `clogit()` into a parallelized framework. By using "nested" parallel processing, it can process thousands of variables in seconds, making it ideal for "omics" data where each feature must be tested individually against a clinical endpoint.

## Core Workflow

The primary function is `RegParallel()`. It divides the variables to be tested into blocks and distributes them across available CPU cores.

### 1. Data Preparation
Data should be in a standard R `data.frame`. Typically, metadata (traits, covariates) and feature data (gene expression, SNPs) are merged into one wide-format dataframe.

```r
# Example: Merging metadata and expression
# data should have samples as rows and variables as columns
my_data <- data.frame(trait = metadata$trait, 
                      age = metadata$age, 
                      t(expression_matrix))
```

### 2. Running RegParallel
You must specify the formula using a special `[*]` placeholder for the variable being iterated.

```r
library(RegParallel)

res <- RegParallel(
  data = my_data,
  formula = 'trait ~ [*] + age', # [*] is the placeholder for each variable
  FUN = function(formula, data)
    glm(formula = formula, data = data, family = binomial(link = 'logit')),
  FUNtype = 'glm',
  variables = colnames(my_data)[3:ncol(my_data)], # variables to iterate over
  blocksize = 500,
  cores = 2,
  nestedParallel = TRUE,
  p.adjust = "BH"
)
```

### 3. Supported Model Types
Set the `FUN` and `FUNtype` arguments based on the analysis:

*   **Linear Regression**: `FUNtype = 'lm'`, `FUN = function(f, d) lm(f, d)`
*   **Logistic Regression**: `FUNtype = 'glm'`, `FUN = function(f, d) glm(f, d, family = binomial)`
*   **Cox Proportional Hazards**: `FUNtype = 'coxph'`, `FUN = function(f, d) coxph(f, d)`
*   **Conditional Logistic**: `FUNtype = 'clogit'`, `FUN = function(f, d) clogit(f, d)`

## Optimization and Advanced Features

### Speeding up Processing
*   **blocksize**: Controls how many variables are processed per core per iteration. Larger blocks (e.g., 2000-5000) are generally faster for very large datasets but require more RAM.
*   **nestedParallel**: When `TRUE`, it uses `foreach` with a parallel backend to further parallelize the processing of blocks.
*   **cores**: Set this to the number of physical cores available.

### Filtering Output
Use `excludeTerms` to remove covariates from the final results table, keeping only the statistics for the `[*]` variable.

```r
res <- RegParallel(
  ...,
  excludeTerms = c('age', 'sex'),
  excludeIntercept = TRUE
)
```

### Confidence Intervals
Adjust the `conflevel` parameter (default is 95) to change the `ORlower` and `ORupper` (or `HRlower`/`HRupper`) calculations.

## Tips for Success
1.  **Variable Names**: Ensure variable names in the `variables` vector do not contain special characters that break R formulas (e.g., hyphens). RegParallel often prepends an 'X' to names starting with numbers.
2.  **Memory Management**: Parallel processing clones the data across threads. If you have a massive dataframe, monitor RAM usage.
3.  **Method 'glm.fit'**: For logistic regression, using `method = 'glm.fit'` inside the `glm` function can provide significant speedups.

## Reference documentation
- [Standard regression functions in R enabled for parallel processing over large data-frames](./references/RegParallel.Rmd)
- [Standard regression functions in R enabled for parallel processing over large data-frames](./references/RegParallel.md)