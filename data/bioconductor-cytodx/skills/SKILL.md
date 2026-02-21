---
name: bioconductor-cytodx
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CytoDx.html
---

# bioconductor-cytodx

name: bioconductor-cytodx
description: Predicts clinical outcomes from single-cell data (flow cytometry or CyTOF) without cell gating. Use this skill when you need to build predictive models from .fcs files, perform rank transformation to reduce batch effects, or identify cell subsets associated with specific clinical outcomes using decision trees.

# bioconductor-cytodx

## Overview

CytoDx is a Bioconductor package designed to associate single-cell cytometry data with clinical outcomes using a two-stage statistical model. Unlike traditional methods, it bypasses the need for manual or automated cell gating. It first models the association between individual cells and the outcome, then aggregates these predictions at the sample level to make a final clinical prediction. This approach is robust across different platforms and provides high interpretability by identifying key markers and cell subsets.

## Core Workflow

### 1. Data Preparation
Load .fcs files and convert them into a data frame format suitable for modeling.

```r
library(CytoDx)

# Convert FCS files to Data Frame
# b: cofactor for arcsinh transformation (1/150 for FCM, 1/5 for CyTOF)
train_data <- fcs2DF(fcsFiles = file_paths,
                     y = labels,
                     assay = "FCM",
                     b = 1/150,
                     excludeTransformParameters = c("FSC-A", "FSC-W", "FSC-H", "Time"))
```

### 2. Rank Transformation
To minimize batch effects and improve robustness across different instruments, apply a rank transformation.

```r
# Perform rank transformation per sample
x_train <- pRank(x = train_data[, marker_columns], 
                 xSample = train_data$xSample)

# Optional: Include interaction terms
x_train_mat <- model.matrix(~.*., x_train)
```

### 3. Model Training
Build the predictive model using `CytoDx.fit`.

```r
fit <- CytoDx.fit(x = x_train_mat,
                  y = (train_data$y == "target_label"),
                  xSample = train_data$xSample,
                  family = "binomial",
                  reg = FALSE)
```

### 4. Prediction
Apply the trained model to new testing data.

```r
# Prepare test data (must follow same transformation as training)
x_test <- pRank(x = test_data[, marker_columns], xSample = test_data$xSample)
x_test_mat <- model.matrix(~.*., x_test)

# Predict outcomes
pred <- CytoDx.pred(fit, xNew = x_test_mat, xSampleNew = test_data$xSample)

# Access sample-level probabilities
probabilities <- pred$xNew.Pred.sample
```

### 5. Interpreting Results (Cell Subset Identification)
Use `treeGate` to find the specific cell populations driving the prediction. Note: Use the original (non-ranked) data for this step to maintain interpretable marker scales.

```r
# TG identifies cell subsets associated with the outcome
TG <- treeGate(P = fit$train.Data.cell$y.Pred.s0,
               x = train_data[, marker_columns])

# Plot the resulting decision tree
plot(TG)
```

## Tips and Best Practices
- **Transformation**: Always use `fcs2DF` for initial loading as it handles the necessary arcsinh transformations.
- **Interactions**: Including 2-way interactions (`~.*.`) in the model matrix often improves predictive power by capturing complex cell phenotypes.
- **Batch Effects**: If data comes from multiple centers or different days, `pRank` is highly recommended to normalize the feature space.
- **Memory**: For very large datasets, ensure you have sufficient RAM as `model.matrix` with interactions can significantly increase the feature space size.

## Reference documentation
- [CytoDx Vignette](./references/CytoDx_Vignette.md)