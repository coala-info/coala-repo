---
name: r-missforest
description: This tool performs non-parametric imputation of missing values in tabular data using Random Forest models. Use when user asks to impute missing data, handle missing values in mixed-type datasets, or estimate imputation error using out-of-bag observations.
homepage: https://cloud.r-project.org/web/packages/missForest/index.html
---

# r-missforest

## Overview

The `missForest` package implements a non-parametric imputation method for tabular data. It uses a Random Forest (via the `ranger` or `randomForest` backends) to predict missing values for each variable based on the observed values of other variables. It is particularly robust for mixed-type data and high-dimensional datasets where $p \gg n$.

## Installation

To install the package from CRAN:

```r
install.packages("missForest", dependencies = TRUE)
```

## Core Workflow

The primary function is `missForest()`. It returns a list containing the imputed data matrix and the estimated imputation error.

### Basic Imputation

```r
library(missForest)

# Generate a dataset with 10% missing values for demonstration
data(iris)
iris.mis <- prodNA(iris, noNA = 0.1)

# Perform imputation (default uses 'ranger' backend)
iris.imp <- missForest(iris.mis)

# Access the completed data
completed_data <- iris.imp$ximp

# Check the estimated OOB error (NRMSE for numeric, PFC for factors)
print(iris.imp$OOBerror)
```

### Monitoring and Diagnostics

- **Verbose Output**: Set `verbose = TRUE` to track the error and difference between iterations. The algorithm stops when the difference increases.
- **Variable-wise Error**: Set `variablewise = TRUE` to get OOB error estimates for every individual column rather than just by data type.
- **Ground Truth Comparison**: If the true values are known (e.g., in a simulation), provide them via `xtrue` to calculate the actual imputation error.

```r
# Impute with detailed diagnostics
imp_results <- missForest(iris.mis, verbose = TRUE, variablewise = TRUE, xtrue = iris)
# Access true error
imp_results$error
```

## Advanced Configuration

### Performance Tuning

- **ntree**: Number of trees grown in each forest. Default is 100. Reducing this (e.g., to 20) speeds up computation at a slight cost to accuracy.
- **mtry**: Number of variables randomly sampled at each split. Default is `floor(sqrt(p))`.
- **maxiter**: Maximum number of iterations. Default is 10.
- **nodesize**: A vector of length two. The first element is for numeric variables (default 5), the second for categorical (default 1).

### Parallelization

`missForest` supports two parallelization strategies to handle large datasets:

1.  **Variables**: Imputes different variables in parallel. Requires a registered `foreach` backend.
2.  **Forests**: Parallelizes the construction of the forest for a single variable.

```r
library(doParallel)
registerDoParallel(cores = 2)

# Parallelize by variables
imp_vars <- missForest(iris.mis, parallelize = "variables")

# Parallelize by forests (using ranger multithreading)
imp_fors <- missForest(iris.mis, parallelize = "forests", num.threads = 2)
```

### Handling Imbalanced Data

You can pass specific Random Forest arguments as lists, where each element corresponds to a variable in the dataframe.

- **sampsize**: Control sample size per variable.
- **classwt / cutoff**: Control classification behavior for factor variables (use `backend = "randomForest"` for native cutoff support).

```r
# Example: Custom sample sizes for variables
# Numeric variables get an integer; factors get a vector per class
my_sampsize <- list(12, 12, 12, 12, c(10, 15, 10))
imp_custom <- missForest(iris.mis, sampsize = my_sampsize)
```

## Reference documentation

- [Using the missForest Package](./references/missForest_1.6.Rmd)