# Visualizing Dendrogram using ggtree

#### Guangchuang Yu

Department of Bioinformatics, School of Basic Medical Sciences, Southern Medical University
guangchuangyu@gmail.com

#### 2025-10-30

# Introduction

```
library(ggtree)
library(ggtreeDendro)
library(aplot)
scale_color_subtree <- ggtreeDendro::scale_color_subtree
```

Clustering is very importance method to classify items into different categories and to infer functions since similar objects tend to behavior similarly. There are more than 200 packages in Bioconductor implement clustering algorithms or employ clustering methods for omic-data analysis.

Albeit the methods are important for data analysis, the visualization is quite limited. Most the the packages only have the ability to visualize the hierarchical tree structure using `stats:::plot.hclust()`. This package is design to visualize hierarchical tree structure with associated data (e.g., clinical information collected with the samples) using the powerful in-house developed [ggtree](http://bioconductor.org/packages/ggtree) package.

This package implements a set of `autoplot()` methods to display tree structure. We will implement more `autoplot()` methods to support more objects. The output of these `autoplot()` methods is a `ggtree` object, which can be further annotated by adding layers using [ggplot2](https://CRAN.R-project.org/package%3Dggplot2) syntax. Integrating associated data to annotate the tree is also supported by [ggtreeExtra](http://bioconductor.org/packages/ggtreeExtra) package.

Here are some demonstrations of using `autoplot()` methods to visualize common hierarchical clustering tree objects.

## `hclust` and `dendrogram` objects

These two classes are defined in the [stats](https://CRAN.R-project.org/package%3Dstats) package.

```
d <- dist(USArrests)

hc <- hclust(d, "ave")
den <- as.dendrogram(hc)

p1 <- autoplot(hc) + geom_tiplab()
p2 <- autoplot(den)
plot_list(p1, p2, ncol=2)
```

![](data:image/png;base64...)

## `linkage` object

The class `linkage` is defined in the [mdendro](https://CRAN.R-project.org/package%3Dmdendro) package.

```
library("mdendro")
lnk <- linkage(d, digits = 1, method = "complete")
autoplot(lnk, layout = 'circular') + geom_tiplab() +
  scale_color_subtree(4) + theme_tree()
```

![](data:image/png;base64...)

## `agnes`, `diana` and `twins` objects

These classes are defined in the [cluster](https://CRAN.R-project.org/package%3Dcluster) package.

```
library(cluster)
x1 <- agnes(mtcars)
x2 <- diana(mtcars)

p1 <- autoplot(x1) + geom_tiplab()
p2 <- autoplot(x2) + geom_tiplab()
plot_list(p1, p2, ncol=2)
```

![](data:image/png;base64...)

## `pvclust` object

The `pvclust` class is defined in the [pvclust](https://CRAN.R-project.org/package%3Dpvclust) package.

```
library(pvclust)
data(Boston, package = "MASS")

set.seed(123)
result <- pvclust(Boston, method.dist="cor", method.hclust="average", nboot=1000, parallel=TRUE)
```

```
## Creating a temporary cluster...done:
## socket cluster with 71 nodes on host 'localhost'
## Multiscale bootstrap... Done.
```

```
autoplot(result, label_edge=TRUE, pvrect = TRUE) + geom_tiplab()
```

![](data:image/png;base64...)

The `pvclust` object contains two types of p-values: AU (Approximately Unbiased) p-value and BP (Boostrap Probability) value. These values will be automatically labelled on the tree.

# Session information

Here is the output of sessionInfo() on the system on which this document was compiled:

```
## R version 4.5.1 Patched (2025-08-23 r88802)
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] pvclust_2.2-0       cluster_2.1.8.1     mdendro_2.2.3
## [4] aplot_0.2.9         ggtreeDendro_1.12.0 ggtree_4.0.1
## [7] yulab.utils_0.2.1
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3          sass_0.4.10             generics_0.1.4
##  [4] tidyr_1.3.1             fontLiberation_0.1.0    prettydoc_0.4.1
##  [7] ggplotify_0.1.3         lattice_0.22-7          digest_0.6.37
## [10] magrittr_2.0.4          evaluate_1.0.5          grid_4.5.1
## [13] RColorBrewer_1.1-3      fastmap_1.2.0           jsonlite_2.0.0
## [16] ape_5.8-1               purrr_1.1.0             scales_1.4.0
## [19] fontBitstreamVera_0.1.1 lazyeval_0.2.2          jquerylib_0.1.4
## [22] cli_3.6.5               rlang_1.1.6             fontquiver_0.2.1
## [25] tidytree_0.4.6          withr_3.0.2             cachem_1.1.0
## [28] yaml_2.3.10             gdtools_0.4.4           tools_4.5.1
## [31] parallel_4.5.1          dplyr_1.1.4             ggplot2_4.0.0
## [34] vctrs_0.6.5             R6_2.6.1                gridGraphics_0.5-1
## [37] lifecycle_1.0.4         htmlwidgets_1.6.4       fs_1.6.6
## [40] ggfun_0.2.0             treeio_1.34.0           pkgconfig_2.0.3
## [43] pillar_1.11.1           bslib_0.9.0             gtable_0.3.6
## [46] glue_1.8.0              Rcpp_1.1.0              systemfonts_1.3.1
## [49] xfun_0.54               tibble_3.3.0            tidyselect_1.2.1
## [52] ggiraph_0.9.2           knitr_1.50              dichromat_2.0-0.1
## [55] farver_2.1.2            htmltools_0.5.8.1       nlme_3.1-168
## [58] patchwork_1.3.2         labeling_0.4.3          rmarkdown_2.30
## [61] compiler_4.5.1          S7_0.2.0
```