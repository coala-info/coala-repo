---
name: bioconductor-rscudo
description: This tool performs signature-based clustering and classification of gene expression data using a rank-based method. Use when user asks to identify sample-specific gene signatures, generate similarity networks for transcriptomic data, or perform supervised classification of gene expression profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/rScudo.html
---

# bioconductor-rscudo

name: bioconductor-rscudo
description: Comprehensive signature-based clustering and classification of gene expression data using the SCUDO rank-based method. Use when Claude needs to perform diagnostic signature identification, sample-specific gene ranking, network-based sample clustering, or supervised classification of transcriptomic profiles.

# bioconductor-rscudo

## Overview

The `rScudo` package implements the SCUDO (Signature-based Clustering for Diagnostic Purposes) method. This is a rank-based approach for analyzing gene expression profiles. Instead of relying on absolute expression values, it identifies sample-specific gene signatures (up-regulated and down-regulated genes) and computes a similarity matrix based on the enrichment of one sample's signature in another's profile. This similarity is then used to generate a network where samples are nodes and edges represent high similarity, allowing for the discovery of clusters or the classification of new samples.

## Core Workflow

### 1. Training and Signature Identification
The `scudoTrain` function performs feature selection, ranks genes for each sample, and computes an all-to-all distance matrix.

```r
library(rScudo)

# trainData: ExpressionSet or matrix (features in rows, samples in columns)
# groups: Factor defining sample classes
trainRes <- scudoTrain(trainData, 
                       groups = groups, 
                       nTop = 100, 
                       nBottom = 100, 
                       alpha = 0.1)

# Inspect results
trainRes
upSignatures(trainRes)[1:5, 1:5]
consensusUpSignatures(trainRes)
```

### 2. Network Generation and Visualization
The distance matrix is converted into a network using `scudoNetwork`. The parameter `N` determines the density of the network (the quantile of distances used as a threshold for edges).

```r
# Create igraph object
trainNet <- scudoNetwork(trainRes, N = 0.25)

# Plot the network
scudoPlot(trainNet, vertex.label = NA)

# Optional: Export to Cytoscape (requires Cytoscape to be open)
# scudoCytoscape(trainNet)
```

### 3. Testing New Samples
To analyze a testing set using the features selected during training, use `scudoTest`.

```r
testRes <- scudoTest(trainRes, testData, testGroups, nTop = 100, nBottom = 100)
testNet <- scudoNetwork(testRes, N = 0.25)
scudoPlot(testNet)
```

### 4. Supervised Classification
`scudoClassify` uses a nearest-neighbor approach within the network to predict the class of unknown samples.

```r
classRes <- scudoClassify(trainData, testData, 
                          N = 0.25, nTop = 100, nBottom = 100, 
                          trainGroups = groups, alpha = 0.1)

# Evaluate performance
caret::confusionMatrix(classRes$predicted, actualTestGroups)
```

## Parameter Tuning

The performance of SCUDO depends heavily on `nTop`, `nBottom`, and `N`. You can use the `caret` framework to perform a grid search.

```r
# Define a model for caret
model <- scudoModel(nTop = c(20, 40, 60), nBottom = c(20, 40, 60), N = 0.25)

# Run cross-validation
control <- caret::trainControl(method = "cv", number = 5)
cvRes <- caret::train(x = t(exprs(trainData)), y = groups, 
                      method = model, trControl = control)

# Use best parameters
bestNTop <- cvRes$bestTune$nTop
bestNBottom <- cvRes$bestTune$nBottom
```

## Tips for Success
- **Feature Selection**: `scudoTrain` performs feature selection by default using parametric or non-parametric tests depending on the number of groups. You can adjust this via the `alpha` parameter.
- **Data Input**: While `rScudo` handles `ExpressionSet` objects, you can also pass standard matrices. Ensure features are rows and samples are columns.
- **Network Density**: If the network is too dense (a "hairball"), decrease `N`. If it is too sparse, increase `N`.
- **Consensus Signatures**: Use `consensusUpSignatures` and `consensusDownSignatures` to identify genes that consistently characterize a specific group across the training set.

## Reference documentation
- [An introduction to rScudo](./references/rScudo-vignette.Rmd)
- [An introduction to rScudo (Markdown)](./references/rScudo-vignette.md)