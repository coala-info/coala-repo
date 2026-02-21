# A quick tour of RCSL

Qinglin Mei

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Run RCSL](#run-rcsl)
  + [3.1 Load dataset (yan)](#load-dataset-yan)
  + [3.2 1. Pre-processing](#pre-processing)
  + [3.3 2. Calculate the initial similarity matrix S](#calculate-the-initial-similarity-matrix-s)
  + [3.4 3. Estimate the number of clusters C](#estimate-the-number-of-clusters-c)
  + [3.5 4. Calculate the block diagonal matrix B](#calculate-the-block-diagonal-matrix-b)
* [4 Calculate accuracy of the clustering](#calculate-accuracy-of-the-clustering)
* [5 Trajectory analysis to time-series datasets](#trajectory-analysis-to-time-series-datasets)
* [6 Display the constructed MST](#display-the-constructed-mst)
* [7 Display the plot of the pseudo-temporal ordering](#display-the-plot-of-the-pseudo-temporal-ordering)
* [8 Display the plot of the inferred developmental trajectory](#display-the-plot-of-the-inferred-developmental-trajectory)

# 1 Introduction

`RCSL` is an R toolkit for single-cell clustering and trajectory analysis using single-cell RNA-seq data.

# 2 Installation

### 2.0.1 Install RCSL package and other requirements

`RCSL` can be installed directly from GitHub with ‘devtools’.

```
library(devtools)
devtools::install_github("QinglinMei/RCSL")
```

Now we can load `RCSL`. We also load the `SingleCellExperiment`, `ggplot2` and `igraph` package.

```
library(RCSL)
library(SingleCellExperiment)
library(ggplot2)
library(igraph)
library(umap)
```

# 3 Run RCSL

## 3.1 Load dataset (yan)

We illustrate the usage of RCSL on a human preimplantation embryos and embryonic stem cells(*Yan et al., (2013)*). The yan data is distributed together with the RCSL package, with 90 cells and 20,214 genes:

```
data(yan, package = "RCSL")
head(ann)
```

```
##                 cell_type1
## Oocyte..1.RPKM.     zygote
## Oocyte..2.RPKM.     zygote
## Oocyte..3.RPKM.     zygote
## Zygote..1.RPKM.     zygote
## Zygote..2.RPKM.     zygote
## Zygote..3.RPKM.     zygote
```

```
yan[1:3, 1:3]
```

```
##          Oocyte..1.RPKM. Oocyte..2.RPKM. Oocyte..3.RPKM.
## C9orf152             0.0             0.0             0.0
## RPS11             1219.9          1021.1           931.6
## ELMO2                7.0            12.2             9.3
```

```
origData <- yan
label <- ann$cell_type1
```

## 3.2 1. Pre-processing

In practice, we find it always beneficial to pre-process single-cell RNA-seq datasets, including:
1. Log transformation.
2. Gene filter

```
data <- log2(as.matrix(origData) + 1)
gfData <- GenesFilter(data)
```

## 3.3 2. Calculate the initial similarity matrix S

```
resSimS <- SimS(gfData)
```

```
## Calculate the Spearman correlation
## Calculate the Nerighbor Representation
## Find neighbors by KNN(Euclidean)
```

## 3.4 3. Estimate the number of clusters C

```
Estimated_C <- EstClusters(resSimS$drData,resSimS$S)
```

```
## ======== Calculate maximal strongly connected components ========
## ======== Calculate maximal strongly connected components ========
## ======== Calculate maximal strongly connected components ========
```

## 3.5 4. Calculate the block diagonal matrix B

```
resBDSM <- BDSM(resSimS$S, Estimated_C)
```

```
## ======== Calculate maximal strongly connected components ========
```

# 4 Calculate accuracy of the clustering

```
ARI_RCSL <- igraph::compare(resBDSM$y, label, method = "adjusted.rand")
```

# 5 Trajectory analysis to time-series datasets

```
DataName <- "Yan"
res_TrajecAnalysis <- TrajectoryAnalysis(gfData, resSimS$drData, resSimS$S,
                                         clustRes = resBDSM$y, TrueLabel = label,
                                         startPoint = 1, dataName = DataName)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the RCSL package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

# 6 Display the constructed MST

```
res_TrajecAnalysis$MSTPlot
```

![](data:image/png;base64...)

# 7 Display the plot of the pseudo-temporal ordering

```
res_TrajecAnalysis$PseudoTimePlot
```

![](data:image/png;base64...)

# 8 Display the plot of the inferred developmental trajectory

```
res_TrajecAnalysis$TrajectoryPlot
```

![](data:image/png;base64...)