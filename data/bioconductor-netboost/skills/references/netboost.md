# The Netboost users guide

Pascal Schlosser, Jochen Knaus

#### 29 January 2026

#### Package

netboost 2.18.1

# Contents

* [1 Introduction](#introduction)
* [2 Loading an example dataset](#loading-an-example-dataset)
* [3 Session Info](#session-info)

# 1 Introduction

The *[netboost](https://bioconductor.org/packages/3.22/netboost)* package, implements a three-step dimension reduction
technique. First, a boosting-based filter is combined with the topological
overlap measure to identify the essential edges of the network. Second, sparse
hierarchical clustering is applied on the selected edges to identify modules
and finally module information is aggregated by the first principal
components. The primary analysis is then carried out on these summary measures
instead of the original data.

# 2 Loading an example dataset

The package comes with an example dataset included. We import the acute myeloid
leukemia patient data from The Cancer Genome Atlas public domain database.
The dataset consists of one thousand DNA methylation sites and gene expression levels on
chromosome 18 for 80 patients.

```
require("netboost")
```

```
## Loading required package: netboost
```

```
##
```

```
## netboost 2.18.1 loadedDefault CPU cores: 1
```

```
data("tcga_aml_meth_rna_chr18", package = "netboost")
dim(tcga_aml_meth_rna_chr18)
```

```
## [1]  80 500
```

The `netboost()` function integrates all major analysis steps and generates
multiple plots. In this step we also set analysis parameters:

`stepno` defines the number of boosting steps taken

`soft_power` (if null, automatically chosen) the exponent in the transformation
of the correlation

`min_cluster_size` the minimal size of clusters, `n_pc` the number of maximally
computed principal components

`scale` if data should be scaled and centered prior to analysis

`ME_diss_thres` defines the merging threshold for identified clusters.

For details on the options please see `?netboost` and the corresponding paper
Schlosser et al. 2020.

```
results <- netboost(datan = tcga_aml_meth_rna_chr18, stepno = 20L,
soft_power = 3L, min_cluster_size = 10L, n_pc = 2, scale = TRUE, ME_diss_thres = 0.25)
```

```
## idx: 1 (0.2%) - Thu Jan 29 20:03:58 2026
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

```
##
## Netboost extracted 10 modules (including background) with an average size of 17.5555555555556 (excluding background) from Tree 1.
```

```
##
## Netboost detected 9 modules and 1 background modules in 1 trees resulting in 15 aggregate measures.
```

```
## Average size of the modules was 17.5555555555556.
```

```
## 342 of 500 features (68.4%) were not assigned to modules.
```

For each detected
independent tree in the dataset (here one) the first graph shows a dendrogram of
initial modules and at which level they are merged, the second graph a module
dendrogram after merging and the third the dendrogram of features including the
module-color-code.

`results` contains the dendrograms (dendros), feature identifier (names) matched
to module assignment (colors), the aggregated dataset (MEs), the rotation matrix
to compute the aggregated dataset (rotation) and the proportion of variance
explained by the aggregate measures (var\_explained).
Dependent on the minimum proportion of variance explained set in the
`netboost()` call (default 0.5) up to `n_pc` principal components are exported.

```
names(results)
```

```
## [1] "dendros"       "names"         "colors"        "MEs"
## [5] "rotation"      "var_explained" "filter"
```

```
colnames(results$MEs)
```

```
##  [1] "ME0_1_pc1" "ME0_1_pc2" "ME7_pc1"   "ME1_pc1"   "ME1_pc2"   "ME2_pc1"
##  [7] "ME2_pc2"   "ME8_pc1"   "ME5_pc1"   "ME3_pc1"   "ME3_pc2"   "ME4_pc1"
## [13] "ME4_pc2"   "ME9_pc1"   "ME6_pc1"
```

As you see for most modules the first principal component already explained more
than 50% of the variance in the original features of this module.
ME0\_*X*\_pc*Y* denotes the background module (unclustered features) of the
independent tree *X*.

Explained variance is reported by a matrix for the first `n_pc` principal
components. Here we list the first 5 modules:

```
results$var_explained[,1:5]
```

```
##          ME0_1        ME7       ME1        ME2        ME8
## PC1 0.06700469 0.61004480 0.4403646 0.49237958 0.59426699
## PC2 0.05502278 0.07484705 0.1174992 0.07779346 0.08341562
```

`results$colors` use a numeric coding for the modules which matches their module
name. To list features of module ME8 we can extract them by:

```
results$names[results$colors==8]
```

```
##  [1] "cg00027037" "cg00034852" "cg00220661" "cg00228017" "cg00366917"
##  [6] "cg00430895" "cg00474194" "cg00481457" "cg00511081" "cg00539368"
## [11] "cg00576121" "cg00615915" "cg00736530" "cg00917154" "cg00940278"
## [16] "cg00955482"
```

The final dendrogram including all trees can be plotted including labels (`results$names`) for
individual features. `colorsrandom` controls if module-color matching should be
randomized to get a clearly differentiable pattern of the potentially many
modules. Labels are only suitable in applications with few features or with a
appropriately large pdf device.

```
set.seed(123)
nb_plot_dendro(nb_summary = results, labels = FALSE, colorsrandom = TRUE)
```

![](data:image/png;base64...)

Next the primary analysis on the aggregated dataset (`results$MEs`) can be
computed.
We also implemented a convenience function to transfer a clustering to a new
dataset. Here, we transfer the clustering to the same dataset resulting in
identical aggregate measures.

```
    ME_transfer <- nb_transfer(nb_summary = results,
    new_data = tcga_aml_meth_rna_chr18, scale = TRUE)
    all(round(results$MEs, 10) == round(ME_transfer, 10))
```

```
## [1] TRUE
```

Netboost now also has a fully non-parametric implementation. Code is not run here to showcase the multicore option (Bioconductor vignette builder does not allow for multicore execution). Adjust `cores` to your machine:

```
#results <- netboost(datan = tcga_aml_meth_rna_chr18,cores=10L,
#soft_power = 3L, min_cluster_size = 10L, n_pc = 2, qc_plot = FALSE,
#filter_method = "spearman", robust_PCs = TRUE, method = "spearman")
```

# 3 Session Info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] netboost_2.18.1  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1      WGCNA_1.73            dplyr_1.1.4
##  [4] farver_2.1.2          blob_1.3.0            R.utils_2.13.0
##  [7] Biostrings_2.78.0     S7_0.2.1              fastmap_1.2.0
## [10] digest_0.6.39         rpart_4.1.24          lifecycle_1.0.5
## [13] cluster_2.1.8.1       survival_3.8-6        KEGGREST_1.50.0
## [16] RSQLite_2.4.5         magrittr_2.0.4        compiler_4.5.2
## [19] rlang_1.1.7           Hmisc_5.2-5           sass_0.4.10
## [22] tools_4.5.2           yaml_2.3.12           data.table_1.18.2.1
## [25] knitr_1.51            htmlwidgets_1.6.4     bit_4.6.0
## [28] RColorBrewer_1.1-3    foreign_0.8-91        BiocGenerics_0.56.0
## [31] R.oo_1.27.1           nnet_7.3-20           dynamicTreeCut_1.63-1
## [34] grid_4.5.2            stats4_4.5.2          preprocessCore_1.72.0
## [37] colorspace_2.1-2      fastcluster_1.3.0     GO.db_3.22.0
## [40] ggplot2_4.0.1         scales_1.4.0          iterators_1.0.14
## [43] tinytex_0.58          dichromat_2.0-0.1     cli_3.6.5
## [46] rmarkdown_2.30        crayon_1.5.3          generics_0.1.4
## [49] otel_0.2.0            RcppParallel_5.1.11-1 rstudioapi_0.18.0
## [52] httr_1.4.7            DBI_1.2.3             cachem_1.1.0
## [55] stringr_1.6.0         splines_4.5.2         parallel_4.5.2
## [58] impute_1.84.0         AnnotationDbi_1.72.0  BiocManager_1.30.27
## [61] XVector_0.50.0        matrixStats_1.5.0     base64enc_0.1-3
## [64] vctrs_0.7.1           Matrix_1.7-4          jsonlite_2.0.0
## [67] bookdown_0.46         IRanges_2.44.0        S4Vectors_0.48.0
## [70] bit64_4.6.0-1         Formula_1.2-5         htmlTable_2.4.3
## [73] magick_2.9.0          foreach_1.5.2         jquerylib_0.1.4
## [76] glue_1.8.0            codetools_0.2-20      stringi_1.8.7
## [79] gtable_0.3.6          tibble_3.3.1          pillar_1.11.1
## [82] htmltools_0.5.9       Seqinfo_1.0.0         R6_2.6.1
## [85] doParallel_1.0.17     evaluate_1.0.5        lattice_0.22-7
## [88] Biobase_2.70.0        backports_1.5.0       R.methodsS3_1.8.2
## [91] png_0.1-8             memoise_2.0.1         bslib_0.10.0
## [94] Rcpp_1.1.1            checkmate_2.3.3       gridExtra_2.3
## [97] xfun_0.56             pkgconfig_2.0.3
```

```
warnings()
```