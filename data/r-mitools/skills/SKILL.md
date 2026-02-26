---
name: r-mitools
description: The r-mitools package provides a framework for managing, analyzing, and pooling results from multiply imputed datasets in R. Use when user asks to create imputation lists, perform analyses across multiple datasets, or combine results using Rubin's Rules.
homepage: https://cloud.r-project.org/web/packages/mitools/index.html
---


# r-mitools

name: r-mitools
description: Tools for analyzing and combining results from multiple-imputation datasets in R. Use this skill when you need to manage lists of imputed data, perform analyses across multiple datasets, and pool results using Rubin's Rules. It is particularly useful for handling data from external imputation software or when using the 'survey' package with multiply imputed data.

# r-mitools

## Overview
The `mitools` package provides a framework for managing and analyzing multiply imputed datasets. It allows users to treat a collection of imputed data frames as a single object, apply standard R modeling functions to each, and automatically combine the results into a single inference.

## Installation
To install the package from CRAN:
```r
install.packages("mitools")
```

## Core Workflow

### 1. Creating an Imputation List
The primary object in `mitools` is an `imputationList`. You can create one from a list of data frames or from files.

```r
library(mitools)
# From a list of data frames
my_list <- imputationList(list(df1, df2, df3, df4, df5))

# From files (e.g., CSVs)
files <- list.files(pattern = "imp[1-5].csv")
my_list <- imputationList(lapply(files, read.csv))
```

### 2. Data Manipulation
Use `update()` to add or transform variables across all imputed datasets simultaneously.

```r
# Create a new variable in all datasets
my_list <- update(my_list, log_income = log(income), 
                  is_adult = age >= 18)
```

### 3. Running Analyses
Use `with()` to run a function or model on every dataset in the list. This returns a list of results.

```r
# Fit a GLM to each dataset
models <- with(my_list, glm(outcome ~ x1 + x2, family = binomial()))

# Simple tables
tables <- with(my_list, table(sex, smoking_status))
```

### 4. Combining Results
Use `MIcombine()` to pool the results from your analyses using Rubin's Rules. This works automatically for objects with `coef` and `vcov` methods.

```r
# Pool the GLM results
pooled_result <- MIcombine(models)

# View summary with confidence intervals and fraction of missing information
summary(pooled_result)
```

## Advanced Usage

### Manual Extraction
If a model object does not have standard methods, use `MIextract` to pull coefficients and variances manually before combining.

```r
betas <- MIextract(models, fun = coef)
vars <- MIextract(models, fun = vcov)
pooled <- MIcombine(betas, vars)
```

### Combining Imputation Lists
You can combine sets of imputations (e.g., if imputations were done separately by strata) using `rbind()`.

```r
all_data <- rbind(imputed_men, imputed_women)
```

## Tips
- **Memory Efficiency**: For very large datasets, `imputationList` can take a list of filenames and a function to read them, rather than loading all data into memory at once.
- **Subsetting**: You can subset an `imputationList` using standard `[` indexing: `my_list[1:3]`.
- **Compatibility**: `mitools` is designed to work seamlessly with the `survey` package for complex sample designs.

## Reference documentation
- [Combining multiple imputations](./references/smi.md)