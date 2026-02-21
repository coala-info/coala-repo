# scds:**s**ingle **c**ell **d**oublet **s**coring: In-silico doublet annotation for single cell RNA sequencing data

#### 5 February 2026

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Quick start](#quick-start)
  + [3.1 Example data set](#example-data-set)
  + [3.2 Computational doublet annotation](#computational-doublet-annotation)
  + [3.3 Visualizing gene pairs](#visualizing-gene-pairs)
* [4 Session Info](#session-info)

# 1 Introduction

In this vignette, we provide an overview of the basic functionality and usage of the `scds` package, which interfaces with `SingleCellExperiment` objects.

# 2 Installation

Install the `scds` package using Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scds", version = "3.9")
```

Or from github:

```
library(devtools)
devtools::install_github('kostkalab/scds')
```

# 3 Quick start

`scds` takes as input a `SingleCellExperiment` object (see here *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*), where raw counts are stored in a `counts` assay, i.e. `assay(sce,"counts")`. An example dataset created by sub-sampling the cell-hashing cell-lines data set (see <https://satijalab.org/seurat/hashing_vignette.html>) is included with the package and accessible via `data("sce")`.Note that `scds` is designed to workd with larger datasets, but for the purposes of this vignette, we work with a smaller example dataset. We apply `scds` to this data and compare/visualize reasults:

## 3.1 Example data set

Get example data set provided with the package.

```
library(scds)
library(scater)
library(rsvd)
library(Rtsne)
library(cowplot)
set.seed(30519)
data("sce_chcl")
sce = sce_chcl #- less typing
dim(sce)
```

```
## [1] 2000 2000
```

We see it contains 2,000 genes and 2,000 cells, 216 of which are identified as doublets:

```
table(sce$hto_classification_global)
```

```
##
##  Doublet Negative  Singlet
##      216       83     1701
```

We can visualize cells/doublets after projecting into two dimensions:

```
logcounts(sce) = log1p(counts(sce))
vrs            = apply(logcounts(sce),1,var)
pc             = rpca(t(logcounts(sce)[order(vrs,decreasing=TRUE)[1:100],]))
ts             = Rtsne(pc$x[,1:10],verb=FALSE)

reducedDim(sce,"tsne") = ts$Y; rm(ts,vrs,pc)
plotReducedDim(sce,"tsne",color_by="hto_classification_global")
```

![](data:image/png;base64...)

## 3.2 Computational doublet annotation

We now run the `scds` doublet annotation approaches. Briefly, we identify doublets in two complementary ways: `cxds` is based on co-expression of gene pairs and works with absence/presence calls only, while `bcds` uses the full count information and a binary classification approach using artificially generated doublets. `cxds_bcds_hybrid` combines both approaches, for more details please consult [(this manuscript)](https://doi.org/10.1101/564021). Each of the three methods returns a doublet score, with higher scores indicating more “doublet-like” barcodes.

```
#- Annotate doublet using co-expression based doublet scoring:
sce = cxds(sce,retRes = TRUE)
sce = bcds(sce,retRes = TRUE,verb=TRUE)
sce = cxds_bcds_hybrid(sce)
par(mfcol=c(1,3))
boxplot(sce$cxds_score   ~ sce$doublet_true_labels, main="cxds")
boxplot(sce$bcds_score   ~ sce$doublet_true_labels, main="bcds")
boxplot(sce$hybrid_score ~ sce$doublet_true_labels, main="hybrid")
```

![](data:image/png;base64...)

## 3.3 Visualizing gene pairs

For `cxds` we can identify and visualize gene pairs driving doublet annoataions, with the expectation that the two genes in a pair might mark different types of cells ([see manuscript](https://doi.org/10.1101/564021)). In the following we look at the top three pairs, each gene pair is a row in the plot below:

```
scds =
top3 = metadata(sce)$cxds$topPairs[1:3,]
rs   = rownames(sce)
hb   = rowData(sce)$cxds_hvg_bool
ho   = rowData(sce)$cxds_hvg_ordr[hb]
hgs  = rs[ho]

l1 =  ggdraw() + draw_text("Pair 1", x = 0.5, y = 0.5)
p1 = plotReducedDim(sce,"tsne",color_by=hgs[top3[1,1]])
p2 = plotReducedDim(sce,"tsne",color_by=hgs[top3[1,2]])

l2 =  ggdraw() + draw_text("Pair 2", x = 0.5, y = 0.5)
p3 = plotReducedDim(sce,"tsne",color_by=hgs[top3[2,1]])
p4 = plotReducedDim(sce,"tsne",color_by=hgs[top3[2,2]])

l3 = ggdraw() + draw_text("Pair 3", x = 0.5, y = 0.5)
p5 = plotReducedDim(sce,"tsne",color_by=hgs[top3[3,1]])
p6 = plotReducedDim(sce,"tsne",color_by=hgs[top3[3,2]])

plot_grid(l1,p1,p2,l2,p3,p4,l3,p5,p6,ncol=3, rel_widths = c(1,2,2))
```

# 4 Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] cowplot_1.2.0               Rtsne_0.17
##  [3] rsvd_1.0.5                  scater_1.38.0
##  [5] ggplot2_4.0.2               scuttle_1.20.0
##  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.1
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           scds_1.26.1
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] beeswarm_0.4.0      gtable_0.3.6        xfun_0.56
##  [4] bslib_0.10.0        ggrepel_0.9.6       lattice_0.22-7
##  [7] vctrs_0.7.1         tools_4.5.2         parallel_4.5.2
## [10] tibble_3.3.1        pkgconfig_2.0.3     BiocNeighbors_2.4.0
## [13] Matrix_1.7-4        data.table_1.18.2.1 RColorBrewer_1.1-3
## [16] S7_0.2.1            lifecycle_1.0.5     compiler_4.5.2
## [19] farver_2.1.2        tinytex_0.58        codetools_0.2-20
## [22] vipor_0.4.7         htmltools_0.5.9     sass_0.4.10
## [25] yaml_2.3.12         pillar_1.11.1       jquerylib_0.1.4
## [28] BiocParallel_1.44.0 DelayedArray_0.36.0 cachem_1.1.0
## [31] magick_2.9.0        viridis_0.6.5       abind_1.4-8
## [34] tidyselect_1.2.1    digest_0.6.39       BiocSingular_1.26.1
## [37] dplyr_1.2.0         bookdown_0.46       labeling_0.4.3
## [40] fastmap_1.2.0       grid_4.5.2          cli_3.6.5
## [43] SparseArray_1.10.8  magrittr_2.0.4      S4Arrays_1.10.1
## [46] dichromat_2.0-0.1   withr_3.0.2         scales_1.4.0
## [49] xgboost_3.1.3.1     ggbeeswarm_0.7.3    rmarkdown_2.30
## [52] XVector_0.50.0      otel_0.2.0          gridExtra_2.3
## [55] ScaledMatrix_1.18.0 beachmat_2.26.0     evaluate_1.0.5
## [58] knitr_1.51          viridisLite_0.4.3   irlba_2.3.7
## [61] rlang_1.1.7         Rcpp_1.1.1          glue_1.8.0
## [64] BiocManager_1.30.27 pROC_1.19.0.1       jsonlite_2.0.0
## [67] R6_2.6.1
```