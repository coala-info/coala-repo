---
name: bioconductor-flowclust
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/flowClust.html
---

# bioconductor-flowclust

## Overview
The `flowClust` package implements a robust clustering methodology for flow cytometry data. It utilizes multivariate $t$ mixture models combined with Box-Cox transformations to handle outliers and non-ellipsoidal cluster shapes. It is tightly integrated with the `flowCore` package, allowing for seamless filtering and gating workflows.

## Core Workflow

### 1. Data Preparation
`flowClust` can take a `flowFrame` (from `flowCore`) or a standard `matrix`/`data.frame`.

```r
library(flowClust)
library(flowCore)
data(rituximab)
```

### 2. Basic Clustering
Use the `flowClust` function to perform clustering. You can specify a single number of clusters ($K$) or a range to compare models.

```r
# Cluster on FSC.H and SSC.H
res <- flowClust(rituximab, varNames = c("FSC.H", "SSC.H"), K = 1:6, B = 100)

# Select best model via BIC
best_k <- which.max(criterion(res, "BIC"))
res_best <- res[[best_k]]
```

### 3. Outlier Identification
Outliers are identified based on quantiles or posterior probabilities. You can adjust these rules without re-fitting the model.

```r
# Set outlier rule to 95% quantile
ruleOutliers(res_best) <- list(level = 0.95)

# Add a posterior probability cutoff (z.cutoff)
ruleOutliers(res_best) <- list(level = 0.95, z.cutoff = 0.6)

# View outlier flags
outliers <- res_best@flagOutliers
```

### 4. Visualization
`flowClust` provides specialized plotting methods for cluster assignments, densities, and histograms.

```r
# Scatter plot with cluster ellipses
plot(res_best, data = rituximab, level = 0.9)

# Density contour plot
res_den <- density(res_best, data = rituximab)
plot(res_den)

# 1D Histogram of a specific channel
hist(res_best, data = rituximab, subset = "FL1.H")
```

## Integration with flowCore (Gating)
For standard Bioconductor workflows, use `tmixFilter` to create a filter object that can be applied via the `filter()` method.

```r
# Create the filter
s2filter <- tmixFilter("myFilter", c("FL1.H", "FL3.H"), K = 3)

# Apply the filter
res_filter <- filter(rituximab, s2filter)

# Subset the data (remove outliers)
clean_data <- Subset(rituximab, res_filter)

# Split into populations
pop_list <- split(rituximab, res_filter)
```

## Advanced Features

### Boundary Filtering
By default, `flowClust` filters points on the boundaries. Control this with `min`, `max`, `min.count`, and `max.count`.
```r
# Custom boundaries for specific channels
flowClust(rituximab, varNames = c("FL1.H", "FL3.H"), K = 2, 
          min = c(0, 0), max = c(400, 800))
```

### Using Priors
You can incorporate prior knowledge (e.g., from a previous experiment) using a Multivariate Normal-Inverse Wishart model.
```r
# Generate prior from an existing result
prior_obj <- flowClust2Prior(res_best, kappa = 1, Nt = 5000)

# Fit with prior
pfit <- flowClust(rituximab, varNames = c("FL1.H", "FL3.H"), 
                  K = 2, prior = prior_obj, usePrior = "yes")
```

## Tips
- **Performance**: The core algorithm is in C. For large datasets, keep the maximum iterations (`B`) reasonable during exploratory phases.
- **Model Selection**: Use `criterion(res, "BIC")` or `criterion(res, "ICL")` to determine the optimal number of clusters.
- **Transformation**: The Box-Cox transformation parameter ($\lambda$) is estimated automatically, allowing the model to adapt to the data's skewness.

## Reference documentation
- [Robust Model-based Clustering of Flow Cytometry Data](./references/flowClust.md)