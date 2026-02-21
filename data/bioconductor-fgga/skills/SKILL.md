---
name: bioconductor-fgga
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/fgga.html
---

# bioconductor-fgga

## Overview

The `fgga` package implements a hierarchical ensemble method for Gene Ontology (GO) annotation. It uses Factor Graphs (FG) to model the logical relationships (True Path Rule) and statistical constraints of GO terms. The workflow involves training base binary SVM classifiers for individual GO terms and then using a message-passing algorithm to reconcile these "flat" predictions into consistent marginal probabilities that respect the GO DAG structure.

## Typical Workflow

### 1. Data Preparation
Input data should consist of characterized gene product sequences (e.g., physico-chemical properties, motifs).
```r
library(fgga)
data(CfData)

# dxCf: Characterized data matrix (features)
# tableCfGO: Binary annotation matrix (1 if annotated, 0 otherwise)
# nodesGO: Character vector of GO terms
```

### 2. GO Subgraph Building
Build a GO-DAG for a specific subdomain (BP, MF, or CC) or a combined "GO-Plus" graph.
```r
library(GO.db)
library(GOstats)

# For a single subdomain (e.g., MF)
mygraph <- GOGraph(CfData$nodesGO, GOMFPARENTS)
mygraph <- subGraph(CfData$nodesGO, mygraph)
mygraph <- t(as(mygraph, "matrix"))
mygraphGO <- as(mygraph, "graphNEL")

# For multiple subdomains or automated linking
mygraphGO <- preCoreFG(CfData$nodesGO, domains = "GOMF")
```

### 3. Model Training
Map the GO-DAG to a Factor Graph and train the base SVM classifiers.
```r
# Convert graph to bipartite Factor Graph structure
modelFGGA <- fgga2bipartite(mygraphGO)

# Train SVMs for each GO term
idsTrain <- CfData$indexGO[["indexTrain"]][1:750]
modelSVMs <- lapply(CfData[["nodesGO"]], FUN = svmTrain,
                    tableOntoTerms = CfData[["tableCfGO"]][idsTrain, ],
                    dxCharacterized = CfData[["dxCf"]][idsTrain, ],
                    graphOnto = mygraphGO, kernelSVM = "radial")

# Calculate reliability (variance) for each GO term
rootGO <- leaves(mygraphGO, "in")
varianceGOs <- varianceOnto(tableOntoTerms = CfData[["tableCfGO"]][idsTrain, ],
                            dxCharacterized = CfData[["dxCf"]][idsTrain, ],
                            kFold = 5, graphOnto = mygraphGO, 
                            rootNode = rootGO, kernelSVM = "radial")
```

### 4. Prediction and Message Passing
Generate raw predictions and then apply the message-passing algorithm to ensure hierarchical consistency.
```r
# Flat prediction (SVM scores)
dxTest <- CfData[["dxCf"]][CfData$indexGO[["indexTest"]][1:50], ]
matrixGOTest <- svmOnto(svmMoldel = modelSVMs,
                        dxCharacterized = dxTest,
                        rootNode = rootGO,
                        varianceSVM = varianceGOs)

# Hierarchical refinement via Message Passing
matrixFGGATest <- t(apply(matrixGOTest, MARGIN = 1, FUN = msgFGGA,
                          matrixFGGA = modelFGGA, graphOnto = mygraphGO,
                          tmax = 50, epsilon = 0.001))
```

### 5. Performance Evaluation
Evaluate results using hierarchical metrics (Precision, Recall, F-score) or standard AUC.
```r
# Hierarchical measures
perf <- fHierarchicalMeasures(CfData$tableCfGO[rownames(matrixFGGATest), ],
                              matrixFGGATest, mygraphGO)
# perf$HP (Precision), perf$HR (Recall), perf$HF (F-score)
```

## Key Functions
- `preCoreFG`: Builds a graph respecting GO constraints across subdomains.
- `fgga2bipartite`: Converts a GO-DAG into the factor graph format required for inference.
- `svmTrain` / `svmOnto`: Wrapper functions for training and applying base SVM classifiers.
- `msgFGGA`: The core iterative message-passing algorithm to compute marginal probabilities.
- `fHierarchicalMeasures`: Calculates metrics specifically designed for hierarchical classification.

## Tips
- **Annotation Density**: Ensure at least 50 annotations per GO term for reliable SVM training.
- **Normalization**: Use normalized numerical values for sequence characterization to improve SVM efficiency.
- **Root Nodes**: Always identify the root nodes of your subgraph (using `leaves(graph, "in")`) as they are required for the prediction functions.

## Reference documentation
- [FGGA: Factor Graph GO Annotation](./references/fgga.md)