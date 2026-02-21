# NeuCA Package User’s Guide

Ziyi Li1 and Hao Feng2\*

1Department of Biostatistics, The University of Texas MD Anderson Cancer Center
2Department of Population and Quantitative Health Sciences, Case Western Reserve University

\*hxf155@case.edu

#### 26 October 2021

#### Abstract

NEUral-network based Cell Annotation, `NeuCA`, is a tool for cell type annotation using single-cell RNA-seq data. It is a supervised cell label assignment method that uses existing scRNA-seq data with known labels to train a neural network-based classifier, and then predict cell labels in single-cell RNA-seq data of interest.

#### Package

NeuCA 1.0.0

# Contents

* [1 Introduction](#introduction)
* [2 Preparing NeuCA input files: `SingleCellExperiment` class](#preparing-neuca-input-files-singlecellexperiment-class)
* [3 NeuCA training and prediction](#neuca-training-and-prediction)
* [4 Predicted cell types](#predicted-cell-types)
* [Session info](#session-info)

# 1 Introduction

The fast advancing single cell RNA sequencing (scRNA-seq) technology enables transcriptome study in heterogeneous tissues at a single cell level. The initial important step of analyzing scRNA-seq data is to accurately annotate cell labels. We present a neural-network based cell annotation method `NeuCA`.
When closely correlated cell types exist, `NeuCA` uses the cell type tree information through a hierarchical structure of neural networks to improve annotation accuracy. Feature selection is performed in hierarchical structure to further improve classification accuracy. When cell type correlations are not high, a feed-forward neural network is adopted.

`NeuCA` depends on the following packages:

* *[keras](https://CRAN.R-project.org/package%3Dkeras)*, for neural-network interface in *R*,
* *[limma](https://bioconductor.org/packages/3.14/limma)*, for linear model framework and testing markers,
* *[SingleCellExperiment](https://bioconductor.org/packages/3.14/SingleCellExperiment)*, for data organization formatting,
* *[e1071](https://CRAN.R-project.org/package%3De1071)*, for probability and predictive functions.

# 2 Preparing NeuCA input files: `SingleCellExperiment` class

The scRNA-seq data input for `NeuCA` must be objects of the *Bioconductor* *[SingleCellExperiment](https://bioconductor.org/packages/3.14/SingleCellExperiment)*. You may need to read corresponding vignettes on how to create a SingleCellExperiment from your own data. An example is provided here to show how to do that, but please note this is not a comprehensive guidance for *[SingleCellExperiment](https://bioconductor.org/packages/3.14/SingleCellExperiment)*.

**Step 1**: Load in example scRNA-seq data.

We are using two example datasets here: `Baron_scRNA` and `Seg_scRNA`. `Baron_scRNA` is a droplet(inDrop)-based, single-cell RNA-seq data generated from pancrease ([Baron et al.](https://doi.org/10.1016/j.cels.2016.08.011)). Around 10,000 human and 2,000 mouse pancreatic cells from four cadaveric donors and two strains of mice were sequenced. `Seg_scRNA` is a Smart-Seq2 based, single-cell RNA-seq dataset ([Segerstolpe et al.](https://doi.org/10.1016/j.cmet.2016.08.020)). It has thousands of human islet cells from healthy and type-2 diabetic donors. A total of 3,386 cells were collected, with around 350 cells from each donor. Here, subsets of these two datasets (with cell type labels for each cell) were included as examples.

```
library(NeuCA)
data("Baron_scRNA")
data("Seg_scRNA")
```

**Step 2a**: Prepare training data as a SingleCellExperiment object.

```
Baron_anno = data.frame(Baron_true_cell_label, row.names = colnames(Baron_counts))
Baron_sce = SingleCellExperiment(
    assays = list(normcounts = as.matrix(Baron_counts)),
    colData = Baron_anno
    )
# use gene names as feature symbols
rowData(Baron_sce)$feature_symbol <- rownames(Baron_sce)
# remove features with duplicated names
Baron_sce <- Baron_sce[!duplicated(rownames(Baron_sce)), ]
```

**Step 2b**: Similarly, prepare testing data as a SingleCellExperiment object. Note the true cell type labels are not necessary (and of course often not available).

```
Seg_anno = data.frame(Seg_true_cell_label, row.names = colnames(Seg_counts))
Seg_sce <- SingleCellExperiment(
    assays = list(normcounts = as.matrix(Seg_counts)),
    colData = Seg_anno
)
# use gene names as feature symbols
rowData(Seg_sce)$feature_symbol <- rownames(Seg_sce)
# remove features with duplicated names
Seg_sce <- Seg_sce[!duplicated(rownames(Seg_sce)), ]
```

# 3 NeuCA training and prediction

**Step 3**: with both training and testing data as objects in `SingleCellExperiment` class, now we can train the classifier in `NeuCA` and predict testing dataset’s cell types. This process can be achieved with one line of code:

```
predicted.label = NeuCA(train = Baron_sce, test = Seg_sce,
                        model.size = "big", verbose = FALSE)
#Baron_scRNA is used as the training scRNA-seq dataset
#Seg_scRNA is used as the testing scRNA-seq dataset
```

`NeuCA` can detect whether highly-correlated cell types exist in the training dataset, and automatically determine if a general neural-network model will be adopted or a marker-guided hierarchical neural-network will be adopted for classification.

[**Tuning parameter**] In neural-network, the numbers of layers and nodes are tunable parameters. Users have the option to determine the complexity of the neural-network used in `NeuCA` by specifying the desired `model.size` argument. Here, “big”, “medium” and “small” are 3 possible choices, reflecting large, medium and small number of nodes and layers in neural-network, respectively. The model size details are shown in the following Table 1. From our experience, “big” or “medium” can often produce
high accuracy predictions.

Table 1: Tuning model sizes in the neural-network classifier training.

|  | Number of layers | Number of nodes in hidden layers |
| --- | --- | --- |
| Small | 3 | 64 |
| Medium | 4 | 64,128 |
| Big | 5 | 64,128,256 |

# 4 Predicted cell types

`predicted.label` is a vector of the same length with the number of cells in the testing dataset, containing all cell’s predicted cell type. It can be viewed directly:

```
head(predicted.label)
```

```
## [1] "alpha" "gamma" "gamma" "gamma" "gamma" "alpha"
```

```
table(predicted.label)
```

```
## predicted.label
##       alpha        beta       delta      ductal endothelial       gamma
##         328         109          56          65           9         135
```

[**Optional**] If you have the true cell type labels for the testing dataset, you may evaluate the predictive performance by a confusion matrix:

```
table(predicted.label, Seg_true_cell_label)
```

```
##                Seg_true_cell_label
## predicted.label alpha beta delta ductal endothelial gamma
##     alpha         328    0     0      0           0     0
##     beta            0  109     0      0           0     0
##     delta           0    0    56      0           0     0
##     ductal          1    0     0     64           0     0
##     endothelial     0    0     0      0           9     0
##     gamma           0    0     0      0           0   135
```

You may also draw a Sankey diagram to visualize the prediction accuracy:

# Session info

```
## R version 4.1.1 (2021-08-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.14-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.14-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] networkD3_0.4               kableExtra_1.3.4
##  [3] knitr_1.36                  NeuCA_1.0.0
##  [5] SingleCellExperiment_1.16.0 SummarizedExperiment_1.24.0
##  [7] Biobase_2.54.0              GenomicRanges_1.46.0
##  [9] GenomeInfoDb_1.30.0         IRanges_2.28.0
## [11] S4Vectors_0.32.0            BiocGenerics_0.40.0
## [13] MatrixGenerics_1.6.0        matrixStats_0.61.0
## [15] e1071_1.7-9                 limma_3.50.0
## [17] keras_2.6.1                 BiocStyle_2.22.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.7             svglite_2.0.0          here_1.0.1
##  [4] lattice_0.20-45        png_0.1-7              class_7.3-19
##  [7] zeallot_0.1.0          rprojroot_2.0.2        digest_0.6.28
## [10] R6_2.5.1               evaluate_0.14          httr_1.4.2
## [13] tfruns_1.5.0           zlibbioc_1.40.0        rlang_0.4.12
## [16] rstudioapi_0.13        whisker_0.4            jquerylib_0.1.4
## [19] Matrix_1.3-4           reticulate_1.22        rmarkdown_2.11
## [22] webshot_0.5.2          stringr_1.4.0          htmlwidgets_1.5.4
## [25] igraph_1.2.7           RCurl_1.98-1.5         munsell_0.5.0
## [28] proxy_0.4-26           DelayedArray_0.20.0    compiler_4.1.1
## [31] xfun_0.27              pkgconfig_2.0.3        systemfonts_1.0.3
## [34] base64enc_0.1-3        tensorflow_2.6.0       htmltools_0.5.2
## [37] GenomeInfoDbData_1.2.7 bookdown_0.24          viridisLite_0.4.0
## [40] bitops_1.0-7           rappdirs_0.3.3         grid_4.1.1
## [43] jsonlite_1.7.2         lifecycle_1.0.1        magrittr_2.0.1
## [46] scales_1.1.1           stringi_1.7.5          XVector_0.34.0
## [49] xml2_1.3.2             bslib_0.3.1            ellipsis_0.3.2
## [52] generics_0.1.1         tools_4.1.1            glue_1.4.2
## [55] fastmap_1.1.0          yaml_2.2.1             colorspace_2.0-2
## [58] BiocManager_1.30.16    rvest_1.0.2            sass_0.4.0
```