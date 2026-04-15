---
name: r-factominer
description: FactoMineR is an R package for multivariate exploratory data analysis that provides advanced geometrical methods for analyzing structured datasets. Use when user asks to perform principal component analysis, correspondence analysis, multiple factor analysis, or hierarchical clustering on principal components.
homepage: https://cran.r-project.org/web/packages/factominer/index.html
---

# r-factominer

## Overview
FactoMineR is an R package dedicated to multivariate Exploratory Data Analysis (EDA). It provides a geometrical point of view for data analysis, offering advanced methods to handle structured data (groups of variables/individuals) and providing extensive graphical outputs and automatic interpretation tools.

## Installation
To install the package from CRAN, use:
```R
install.packages("FactoMineR")
```

## Main Functions and Workflows

### 1. Principal Component Analysis (PCA)
Used for continuous variables.
```R
library(FactoMineR)
# res.pca <- PCA(X, scale.unit = TRUE, ncp = 5, graph = TRUE)
# X: data frame with continuous variables
# scale.unit: if TRUE, data is standardized
```

### 2. Correspondence Analysis (CA)
Used for contingency tables (two categorical variables).
```R
# res.ca <- CA(X, ncp = 5, graph = TRUE)
```

### 3. Multiple Correspondence Analysis (MCA)
Used for datasets with multiple categorical variables.
```R
# res.mca <- MCA(X, ncp = 5, graph = TRUE)
```

### 4. Multiple Factor Analysis (MFA)
Used when variables are structured in groups (mix of continuous and categorical).
```R
# res.mfa <- MFA(X, group = c(3, 2, 5), type = c("s", "n", "s"), name.group = c("G1", "G2", "G3"))
# type: "s" for scaled continuous, "c" for centered continuous, "n" for categorical
```

### 5. Hierarchical Clustering on Principal Components (HCPC)
Combines principal component methods with clustering to define stable clusters.
```R
# res.hcpc <- HCPC(res.pca, nb.clust = -1, graph = TRUE)
# nb.clust: -1 automatically chooses the number of clusters
```

## Tips for Interpretation
- **Supplementary Variables:** Use `quanti.sup` or `quali.sup` arguments in PCA/MCA to project variables that do not participate in the calculation of dimensions but help interpret them.
- **dimdesc():** Use `dimdesc(res.pca)` to get an automatic description of the dimensions by the variables (correlation for continuous, V-test for categorical).
- **Graphical Customization:** Most functions generate plots by default. Use `plot.PCA()`, `plot.MCA()`, etc., to refine labels, colors, and visible elements (e.g., `invisible = "quali"`).

## Reference documentation
- [FactoMineR Home Page](./references/home_page.md)