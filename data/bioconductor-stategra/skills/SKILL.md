---
name: bioconductor-stategra
description: "STATegRa is a framework for the integration and analysis of multiple omics datasets using component analysis, clustering, and differential expression. Use when user asks to integrate multi-omics data, decompose variability into common and distinctive components, cluster features across different data types, or combine p-values using non-parametric combination."
homepage: https://bioconductor.org/packages/release/bioc/html/STATegRa.html
---


# bioconductor-stategra

## Overview

The `STATegRa` package provides a framework for the integration of multiple omics datasets. It focuses on three main analytical pillars:
1.  **Component Analysis**: Decomposing variability into "common" (shared across omics) and "distinctive" (specific to one omic) structures.
2.  **Omics Clustering**: Clustering features (e.g., genes and miRNAs) together by using mapping information to create a unified distance metric.
3.  **omicsNPC**: A holistic approach to differential expression that combines p-values from different omics types using Non-Parametric Combination (NPC) to account for inter-dataset correlations.

## Typical Workflows

### 1. Omics Component Analysis
Used to distinguish between underlying biological mechanisms affecting all datasets versus those affecting each dataset separately.

**Data Preparation:**
Convert matrices to `ExpressionSet` objects.
```R
library(STATegRa)
B1 <- createOmicsExpressionSet(Data=matrix1, pData=metadata, pDataDescr=c("condition"))
B2 <- createOmicsExpressionSet(Data=matrix2, pData=metadata, pDataDescr=c("condition"))
input_list <- list(B1, B2)
```

**Model Selection:**
Determine the optimal number of common and distinctive components.
```R
ms <- modelSelection(Input=input_list, Rmax=3, fac.sel="single%", 
                     varthreshold=0.03, center=TRUE, scale=TRUE, weight=TRUE)
# ms$common contains suggested common components
# ms$dist contains suggested distinctive components
```

**Analysis:**
Apply DISCO-SCA, JIVE, or O2PLS.
```R
# Example using DISCO-SCA
res <- omicsCompAnalysis(Input=input_list, method="DISCOSCA", 
                         Rcommon=2, Rspecific=c(2, 2),
                         center=TRUE, scale=TRUE, weight=TRUE)

# Access results
getScores(res, part="common")
getLoadings(res, part="distinctive", block=1)
plotVAF(res)
plotRes(res, comps=c(1, 2), what="scores", type="common")
```

### 2. Omics Clustering
Used to find similarities between features of different types (e.g., which miRNAs behave like which genes).

**Workflow:**
1.  **Compute Reference Distances**: Calculate distances for the primary feature (e.g., mRNA).
2.  **Define Mapping**: Create a `bioMap` object linking surrogate features (miRNA) to reference features (mRNA).
3.  **Compute Surrogate Distances**: Use `bioDist` to project surrogate data onto reference features.
4.  **Weighted Integration**: Combine distances using `bioDistW`.

```R
# 1. Reference distance
distmRNA <- bioDistclass(name="mRNA", distance=cor(t(exprs(mRNA.ds)), method="spearman"))

# 2. Mapping
mapObj <- bioMap(name="miRNA-to-Gene", map=mapping_dataframe)

# 3. Surrogate distance
distMiRNA <- bioDist(referenceFeatures=rownames(mRNA.ds), mapping=mapObj, 
                     surrogateData=miRNA.ds, referenceData=mRNA.ds, distance="spearman")

# 4. Weighted combination
wList <- bioDistW(referenceFeatures=rownames(mRNA.ds), 
                  bioDistList=list(distmRNA, distMiRNA), 
                  weights=matrix(c(0.5, 0.5), 1, 2))

# Visualization
bioDistWPlot(referenceFeatures=rownames(mRNA.ds), listDistW=wList)
```

### 3. omicsNPC (Differential Expression)
Used to identify genes differentially expressed across all modalities.

```R
# dataInput is a list of ExpressionSets
# dataTypes: 'count' (for RNAseq/voom) or 'continuous' (for arrays)
dataTypes <- c("count", "continuous")
combMethods <- c("Fisher", "Liptak", "Tippett")

results <- omicsNPC(dataInput=my_list, dataTypes=dataTypes, 
                    combMethods=combMethods, numPerms=1000)

# results$pvaluesNPC contains the combined global p-values
```

## Tips for Success
-   **Weighting**: Always set `weight=TRUE` in `omicsCompAnalysis` if the number of features differs significantly between blocks (e.g., 20,000 genes vs 500 miRNAs).
-   **NPC Interpretation**: 
    -   *Tippett*: Significant if at least one omic shows a signal.
    -   *Liptak*: Significant if most omics show a signal.
    -   *Fisher*: Intermediate behavior.
-   **Mapping**: For Omics Clustering, ensure the mapping covers at least 15-25% of the reference features for reliable results.

## Reference documentation
- [STATegRa User’s Guide](./references/STATegRa.md)