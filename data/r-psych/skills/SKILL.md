---
name: r-psych
description: The r-psych package provides a comprehensive set of tools for multivariate analysis, scale construction, and reliability testing in psychological research. Use when user asks to perform exploratory factor analysis, calculate scale reliability like Cronbach's alpha or omega, score questionnaires, or conduct mediation analysis.
homepage: https://cloud.r-project.org/web/packages/psych/index.html
---

# r-psych

## Overview
The `psych` package is a comprehensive toolbox for psychological research. It provides functions for multivariate analysis, scale construction, reliability analysis, and Item Response Theory (IRT). It is particularly strong in Factor Analysis, Cluster Analysis, and Structural Equation Modeling (SEM) front-end support.

## Installation
```R
install.packages("psych")
# It is also recommended to install psychTools for additional data sets and utilities
install.packages("psychTools")
```

## Core Workflows

### 1. Data Exploration and Descriptives
Before analysis, use `describe` for comprehensive univariate statistics and `pairs.panels` for multivariate visualization.
```R
library(psych)
describe(my.data) # Mean, sd, skew, kurtosis, etc.
pairs.panels(my.data) # Correlation matrix with histograms and loess fits
```

### 2. Scale Construction and Scoring
The primary workflow for scoring questionnaires involves creating keys and calculating scale statistics.
```R
# 1. Define keys: item names/indices. Negative sign indicates reverse scoring.
my.keys <- list(
  Extraversion = c("E1", "E2", "-E3"), 
  Neuroticism = c("N1", "N2", "N3")
)

# 2. Score items and get reliability (Alpha)
my.scales <- scoreItems(my.keys, my.data)

# 3. Access results
my.scales$alpha      # Cronbach's Alpha
my.scales$scores     # Individual scale scores
my.scales$cor        # Inter-scale correlations
```

### 3. Reliability Analysis
Beyond Alpha, `psych` provides advanced reliability metrics like Coefficient Omega.
```R
# Hierarchical and total Omega
omega(my.data, nfactors = 3)

# Guttman's Lambda 6 and other estimates
splitHalf(my.data)
```

### 4. Factor Analysis and PCA
`fa` is the preferred function for Exploratory Factor Analysis (EFA), offering multiple rotation and extraction methods.
```R
# Exploratory Factor Analysis
# fm="minres" (default), "ml" (maximum likelihood), "pa" (principal axis)
fa_result <- fa(my.data, nfactors = 3, rotate = "oblimin", fm = "minres")
print(fa_result, cut = 0.3) # Hide loadings < .3
fa.diagram(fa_result)       # Visualize structure

# Principal Components Analysis
pca_result <- principal(my.data, nfactors = 2, rotate = "varimax")
```

### 5. Mediation and Regression
Perform mediation analysis and moderated regression with graphical output.
```R
# Mediation: y ~ x + (m)
med_model <- mediate(y ~ x + (m), data = my.data)
print(med_model)
```

## Tips and Best Practices
- **Missing Data**: Most functions handle missing data via `use="pairwise"` or `na.rm=TRUE`.
- **Overlap Correction**: If items appear in multiple scales, use `scoreOverlap` instead of `scoreItems` to get correlations corrected for item overlap.
- **Data Input**: Use `read.file()` from `psychTools` to import SPSS (.sav), CSV, or TXT files directly into a format optimized for `psych`.
- **Visualizing Correlations**: Use `corPlot(my.data)` for a heatmap of the correlation matrix.

## Reference documentation
- [Using R to score personality scales](./references/scoring.md)