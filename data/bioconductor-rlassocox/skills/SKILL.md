---
name: bioconductor-rlassocox
description: bioconductor-rlassocox performs survival prediction and biomarker discovery by integrating gene interaction network information into a Lasso-Cox regularization framework. Use when user asks to perform survival analysis on high-dimensional data, incorporate gene network topology into Cox models, or identify stable biomarkers using the RLasso-Cox model.
homepage: https://bioconductor.org/packages/release/bioc/html/RLassoCox.html
---


# bioconductor-rlassocox

name: bioconductor-rlassocox
description: Perform survival prediction and biomarker discovery using the RLasso-Cox model. Use this skill when you need to integrate gene interaction network information (topological weights) into a Lasso-Cox regularization framework for high-dimensional survival data analysis.

# bioconductor-rlassocox

## Overview

RLassoCox implements the RLasso-Cox model, which improves upon the standard Lasso-Cox model by incorporating gene interaction information. It uses a random walk algorithm on a gene interaction network to calculate topological weights for genes. These weights are then used as penalty factors in the L1-norm constraint of the Cox proportional hazards model. This approach prioritizes topologically important genes, leading to more stable biomarker discovery and better generalization in survival prediction.

## Installation

Install the package from Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RLassoCox")
```

## Core Workflow

### 1. Data Preparation
The model requires three primary inputs:
- **Gene Expression Matrix**: A matrix where rows are samples and columns are genes.
- **Survival Data**: An $n \times 2$ matrix or data frame with columns `time` (failure/censoring time) and `status` (1 for failure, 0 for censoring).
- **Interaction Network**: An `igraph` object representing the gene interaction network (e.g., KEGG).

```r
library(RLassoCox)
data(mRNA_matrix)
data(survData)
data(dGMMirGraph)
```

### 2. Training the Model
Use `RLassoCox` to fit the model over a grid of $\lambda$ values.

```r
# Train the model
mod <- RLassoCox(x = x.train, y = y.train, globalGraph = dGMMirGraph)

# View topological weights calculated via random walk
head(mod$PT)

# Access the underlying glmnet object
print(mod$glmnetRes)
plot(mod$glmnetRes)
```

### 3. Cross-Validation
Use `cvRLassoCox` to determine the optimal $\lambda$ via k-fold cross-validation.

```r
cv.mod <- cvRLassoCox(x = x.train, y = y.train, globalGraph = dGMMirGraph, nfolds = 5)

# Plot cross-validation error
plot(cv.mod$glmnetRes)

# Get optimal lambda values
best_lambda <- cv.mod$glmnetRes$lambda.min
lambda_1se <- cv.mod$glmnetRes$lambda.1se
```

### 4. Feature Selection and Prediction
Extract coefficients and predict risk scores for new patients.

```r
# Extract coefficients at optimal lambda
coef_min <- coef(cv.mod$glmnetRes, s = "lambda.min")

# Identify selected features (non-zero coefficients)
active_genes <- rownames(coef_min)[which(coef_min[,1] != 0)]

# Predict risk scores for test data
risk_scores <- predict(cv.mod, newx = x.test, s = "lambda.min")
```

## Key Functions

- `RLassoCox()`: Fits the topologically weighted Lasso-Cox model. Returns a list containing the `glmnet` object and the topological weight vector `PT`.
- `cvRLassoCox()`: Performs k-fold cross-validation. Returns a `cv.glmnet` object and the topological weights.
- `predict.cvRLassoCox()`: Predicts survival risk for new samples using the cross-validated model.

## Tips for Success

- **Gene Identifiers**: Ensure that the gene names in your expression matrix match the node names in the `igraph` object.
- **Survival Format**: The `y` input must strictly contain `time` and `status` columns. If using a `Surv` object, convert it to a matrix or data frame first.
- **Network Choice**: The quality of the biomarkers depends heavily on the relevance of the `globalGraph` provided. Common choices include KEGG pathways or protein-protein interaction (PPI) networks.
- **Glmnet Integration**: Since the package returns `glmnet` objects, you can use standard `glmnet` methods like `coef()`, `plot()`, and `print()` on the `$glmnetRes` component.

## Reference documentation

- [RLassoCox](./references/RLassoCox.md)