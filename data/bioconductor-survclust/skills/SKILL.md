---
name: bioconductor-survclust
description: bioconductor-survclust performs outcome-weighted integrative supervised clustering for multi-omic data. Use when user asks to identify clinically relevant subtypes, cluster molecular data supervised by survival outcomes, or integrate multiple data types like mutations and expression.
homepage: https://bioconductor.org/packages/release/bioc/html/survClust.html
---

# bioconductor-survclust

name: bioconductor-survclust
description: Outcome-weighted integrative supervised clustering for multi-omic data. Use when clustering molecular data (such as mutations, copy number, or expression) supervised by survival or time-to-event outcomes to identify clinically relevant subtypes.

# bioconductor-survclust

## Overview

`survClust` is an R package for supervised integrative clustering. Unlike unsupervised methods that cluster molecular data alone, `survClust` uses time-to-event data (e.g., Overall Survival) to weight molecular features, ensuring that the resulting clusters are clinically meaningful. It supports multiple data types including continuous (RNA-seq, methylation) and binary (mutation status) data.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("survClust")
```

## Data Preparation

The package requires two main inputs:
1. **Molecular Data**: A list of `m` data types. Each element in the list should be a matrix or data frame where rows are samples and columns are features.
2. **Survival Data**: A matrix or data frame with at least two columns: time-to-event and event status (0/1). Row names must match the sample names in the molecular data.

**Pre-processing Tips:**
- Remove features with >20% missing data.
- For mRNA, filter out low-expression genes (e.g., bottom 10% quantile).
- For mutations, filter out silent variants and singletons.
- For Copy Number, use segmented data (e.g., from CBS).

## Core Workflow

The recommended workflow uses cross-validation to prevent overfitting.

### 1. Compute Weighted Distance
Use `getDist` to calculate distance matrices weighted by the survival outcome.

```r
library(survClust)
# Example with a list of data matrices 'dat' and survival data 'surv'
dist_list <- getDist(dat, surv)
```

### 2. Cross-Validation
Use `cv_survclust` to evaluate different cluster numbers ($k$). It is recommended to run at least 50 rounds for stability.

```r
library(BiocParallel)

# Function to run multiple rounds for a specific k
run_cv <- function(k, data, survival, rounds = 10) {
    fit <- list()
    for (i in 1:rounds) {
        fit[[i]] <- cv_survclust(data, survival, k, fold = 3)
    }
    return(fit)
}

# Run for k = 2 to 7
cv_results <- bplapply(2:7, run_cv, data = dat, survival = surv)
```

### 3. Evaluate and Pick k
Analyze the logrank statistic and Standardized Pooled Within-cluster Sum of Squares (SPWSS).

```r
# Summarize stats
stats <- getStats(cv_results, kk = 7, cvr = 10)

# Plot metrics: Look for logrank peak and SPWSS "elbow"
plotStats(stats, 2:7)
```

### 4. Final Cluster Assignment
Once an optimal $k$ is chosen (e.g., $k=4$), use `cv_voting` to get the consensus labels.

```r
final_labels <- cv_voting(cv_results, dist_list, pick_k = 4)

# Visualize with Kaplan-Meier
library(survival)
plot(survfit(Surv(surv[,1], surv[,2]) ~ final_labels), col = 1:4, mark.time = TRUE)
```

## Key Functions

- `getDist(x, surv, type)`: Computes weighted distance. `type` can be "standard" (continuous) or "mut" (binary).
- `combineDist(list_of_distances)`: Integrates multiple distance matrices by averaging.
- `cv_survclust(x, surv, k, fold)`: Wrapper for cross-validated clustering.
- `cv_voting(cv_fit, dist, pick_k)`: Performs majority voting across CV rounds to assign final cluster labels.
- `getStats` / `plotStats`: Tools for model selection based on logrank, SPWSS, and cluster size constraints.

## Reference documentation

- [An introduction to survClust package](./references/survClust_vignette.md)
- [survClust Vignette Source](./references/survClust_vignette.Rmd)