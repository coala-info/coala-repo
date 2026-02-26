---
name: r-breakaway
description: The r-breakaway package provides statistical models to estimate species richness and account for unobserved taxa in microbial ecology data. Use when user asks to estimate species richness, build frequency count tables, or perform hypothesis testing on diversity estimates using the betta model.
homepage: https://cloud.r-project.org/web/packages/breakaway/index.html
---


# r-breakaway

## Overview
`breakaway` is the premier R package for species richness estimation and modeling. It is specifically designed to handle the challenges of microbial ecology data, such as high diversity, varying sequencing depths, and the presence of many rare taxa (singletons and doubletons). Unlike simple observed richness counts, `breakaway` uses statistical models to estimate the number of unobserved species and provides standard errors for these estimates, which are essential for rigorous downstream inference.

## Installation
To install the stable version from CRAN:
```R
install.packages("breakaway")
```
To install the development version (recommended by authors for latest features):
```R
# install.packages("remotes")
remotes::install_github("adw96/breakaway")
```

## Core Workflow

### 1. Data Preparation
`breakaway` works with frequency count tables. A frequency count table has two columns: the first column is the number of times a species was observed ($j$), and the second column is the number of species observed exactly $j$ times.

```R
library(breakaway)

# From an OTU/ASV table (samples as columns)
frequency_tables <- build_frequency_count_tables(my_otu_table)

# From a single vector of counts
my_ft <- make_frequency_count_table(my_counts)
```

### 2. Estimating Richness
The `breakaway()` function automatically selects the best model (typically from the Kemp family) for your data.

```R
# Estimate richness for a single sample
result <- breakaway(my_ft)
print(result)

# Access estimate and standard error
result$estimate
result$error

# Plot the model fit to check for misspecification
plot(result)
```

### 3. Handling Model Misspecification
If the plot shows the model (pink circles) does not follow the observed ratios (green triangles), adjust the `cutoff`. The `cutoff` is the maximum frequency count used to fit the model.

```R
# Use only the first 10 frequency counts
result_adj <- breakaway(my_ft, cutoff = 10)
```

### 4. Hypothesis Testing with `betta`
Standard linear regression fails for diversity because estimates have different levels of uncertainty. Use `betta` (fixed effects) or `betta_random` (mixed effects) to model richness against covariates while accounting for this uncertainty.

```R
# 1. Get estimates for all samples
richness_results <- my_phyloseq_object %>% breakaway

# 2. Extract summary table
summary_df <- summary(richness_results)

# 3. Fit model with fixed effects (e.g., Treatment)
bt_model <- betta(formula = estimate ~ Treatment, 
                  ses = error, 
                  data = summary_df)
bt_model$table

# 4. Fit model with random effects (e.g., Subject ID)
bt_mixed <- betta_random(formula = estimate ~ Treatment | SubjectID, 
                         ses = error, 
                         data = summary_df)
```

## Key Functions
- `breakaway()`: Main wrapper for richness estimation.
- `breakaway_nof1()`: Sensitivity analysis tool for cases with suspected spurious singletons.
- `betta()`: Linear regression for diversity estimates accounting for standard errors.
- `betta_random()`: Linear mixed-effects models for diversity estimates.
- `test_submodel()`: Performs hypothesis testing (e.g., via parametric bootstrap) to compare nested `betta` models.
- `betta_lincom()`: Estimates confidence intervals for linear combinations of fixed effects.

## Tips for Success
- **Don't ignore error bars**: Large standard errors in richness estimation are common and reflect the difficulty of predicting unobserved taxa. `betta` is designed to handle these.
- **Phyloseq Integration**: `breakaway` integrates directly with `phyloseq` objects. You can pipe a phyloseq object directly into `breakaway()`.
- **Rarefaction**: The authors generally recommend against rarefaction; `breakaway` provides a statistically principled alternative by modeling the full distribution.

## Reference documentation
- [Getting started with breakaway](./references/breakaway.Rmd)
- [Introduction to hypothesis testing for diversity](./references/diversity-hypothesis-testing.Rmd)
- [Introduction to diversity estimation](./references/intro-diversity-estimation.Rmd)