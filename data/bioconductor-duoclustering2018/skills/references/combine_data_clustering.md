# Visualize data sets and clustering results with `iSEE`

Angelo Duò, Mark D Robinson and Charlotte Soneson

#### 2025-11-06

#### Package

DuoClustering2018 1.28.0

# Contents

* [1 Introduction](#introduction)
* [2 Load the necessary packages](#load-the-necessary-packages)
* [3 Retrieve a data set](#retrieve-a-data-set)
* [4 Read a set of clustering results](#read-a-set-of-clustering-results)
* [5 Merge data and clustering results](#merge-data-and-clustering-results)
* [6 Visualize with `iSEE`](#visualize-with-isee)
* [7 Session info](#session-info)
* [References](#references)

# 1 Introduction

In this vignette we describe how to generate a `SingleCellExperiment` object
combining observed values and clustering results for a data set from the
`DuoClustering2018` package, and how the resulting object can be explored and
visualized with the `iSEE` package (Rue-Albrecht et al. [2018](#ref-Rue-Albrecht2018-wz)).

# 2 Load the necessary packages

```
suppressPackageStartupMessages({
  library(SingleCellExperiment)
  library(DuoClustering2018)
  library(dplyr)
  library(tidyr)
})
```

# 3 Retrieve a data set

The different ways of retrieving a data set from the package are described in
the `plot_performance` vignette. Here, we will load a data set using the
shortcut function provided in the package.

```
dat <- sce_filteredExpr10_Koh()
```

```
## see ?DuoClustering2018 and browseVignettes('DuoClustering2018') for documentation
```

```
## loading from cache
```

# 4 Read a set of clustering results

For this data set, we also load a set of clustering results obtained using
different clustering methods.

```
res <- clustering_summary_filteredExpr10_Koh_v2()
```

```
## see ?DuoClustering2018 and browseVignettes('DuoClustering2018') for documentation
```

```
## loading from cache
```

# 5 Merge data and clustering results

We add the cluster labels for one run and for a set of different imposed number
of clusters to the data set.

```
res <- res %>% dplyr::filter(run == 1 & k %in% c(3, 5, 9)) %>%
  dplyr::group_by(method, k) %>%
  dplyr::filter(is.na(resolution) | resolution == resolution[1]) %>%
  dplyr::ungroup() %>%
  tidyr::unite(col = method_k, method, k, sep = "_", remove = TRUE) %>%
  dplyr::select(cell, method_k, cluster) %>%
  tidyr::spread(key = method_k, value = cluster)

colData(dat) <- DataFrame(
  as.data.frame(colData(dat)) %>%
    dplyr::left_join(res, by = c("Run" = "cell"))
)
head(colData(dat))
```

```
## DataFrame with 6 rows and 55 columns
##           Run LibraryName     phenoid libsize.drop feature.drop total_features
##   <character> <character> <character>    <logical>    <logical>      <integer>
## 1  SRR3952323      H7hESC      H7hESC        FALSE        FALSE           4895
## 2  SRR3952325      H7hESC      H7hESC        FALSE        FALSE           4887
## 3  SRR3952326      H7hESC      H7hESC        FALSE        FALSE           4888
## 4  SRR3952327      H7hESC      H7hESC        FALSE        FALSE           4879
## 5  SRR3952328      H7hESC      H7hESC        FALSE        FALSE           4873
## 6  SRR3952329      H7hESC      H7hESC        FALSE        FALSE           4893
##   log10_total_features total_counts log10_total_counts
##              <numeric>    <numeric>          <numeric>
## 1              3.68984      2248411            6.35188
## 2              3.68913      2271617            6.35634
## 3              3.68922       584682            5.76692
## 4              3.68842      3191810            6.50404
## 5              3.68789      2190385            6.34052
## 6              3.68966      2187289            6.33991
##   pct_counts_top_50_features pct_counts_top_100_features
##                    <numeric>                   <numeric>
## 1                    18.2790                     25.9754
## 2                    24.6725                     32.2228
## 3                    22.7328                     30.2060
## 4                    20.8674                     29.0039
## 5                    21.2879                     29.4237
## 6                    20.5931                     27.7401
##   pct_counts_top_200_features pct_counts_top_500_features is_cell_control
##                     <numeric>                   <numeric>       <logical>
## 1                     35.5376                     52.4109           FALSE
## 2                     41.5474                     57.9692           FALSE
## 3                     39.4313                     55.2858           FALSE
## 4                     38.7856                     56.0209           FALSE
## 5                     39.3077                     56.6410           FALSE
## 6                     36.7819                     52.7547           FALSE
##   sizeFactor      CIDR_3      CIDR_5      CIDR_9   FlowSOM_3   FlowSOM_5
##    <numeric> <character> <character> <character> <character> <character>
## 1   1.889865           1           1           1           2           2
## 2   1.810539           1           1           1           2           2
## 3   0.486899           1           1           1           2           2
## 4   2.562950           1           1           1           2           2
## 5   1.848037           1           1           1           2           2
## 6   1.897451           1           1           1           2           2
##     FlowSOM_9     PCAHC_3     PCAHC_5     PCAHC_9 PCAKmeans_3 PCAKmeans_5
##   <character> <character> <character> <character> <character> <character>
## 1           4           1           1           1           3           1
## 2           4           1           1           1           3           1
## 3           4           1           1           1           3           1
## 4           4           1           1           1           3           1
## 5           4           1           1           1           3           1
## 6           4           1           1           1           3           1
##   PCAKmeans_9   RaceID2_3   RaceID2_5   RaceID2_9 RtsneKmeans_3 RtsneKmeans_5
##   <character> <character> <character> <character>   <character>   <character>
## 1           4           1           1           1             1             1
## 2           4           2           2           2             1             1
## 3           4           2           2           2             1             1
## 4           4           1           1           1             1             1
## 5           4           1           1           1             1             1
## 6           4           1           2           2             1             1
##   RtsneKmeans_9      SAFE_3      SAFE_5      SAFE_9       SC3_3       SC3_5
##     <character> <character> <character> <character> <character> <character>
## 1             9           2           1           3           1           3
## 2             9           2           1           5           1           3
## 3             9           2           1           3           1           3
## 4             9           2           1           5           1           3
## 5             9           2           1           5           1           3
## 6             9           2           1           5           1           3
##         SC3_9    SC3svm_3    SC3svm_5    SC3svm_9    Seurat_9     TSCAN_3
##   <character> <character> <character> <character> <character> <character>
## 1           4           3           3           3           5           1
## 2           4           3           3           3           5           1
## 3           4           3           3           3           5           3
## 4           4           3           3           3           5           1
## 5           4           3           3           3           5           2
## 6           4           3           3           3           5           1
##       TSCAN_5     TSCAN_9    ascend_3    ascend_5    ascend_9   monocle_3
##   <character> <character> <character> <character> <character> <character>
## 1           1           1           1          NA          NA           3
## 2           1           2           1          NA          NA           3
## 3           3           2           1          NA          NA           3
## 4           1           1           1          NA          NA           3
## 5           2           2           1          NA          NA           3
## 6           1           1           1          NA          NA           3
##     monocle_5   monocle_9 pcaReduce_3 pcaReduce_5 pcaReduce_9
##   <character> <character> <character> <character> <character>
## 1           3           3           1           5           5
## 2           3           3           1           5           5
## 3           3           3           1           5           5
## 4           3           3           1           5           5
## 5           3           3           1           5           5
## 6           3           3           1           5           5
```

# 6 Visualize with `iSEE`

The resulting `SingleCellExperiment` can be interactively explored using, e.g.,
the `iSEE` package. This can be useful to gain additional understanding of the
partitions inferred by the different clustering methods, to visualize these in
low-dimensional representations (PCA or t-SNE), and to investigate how well they
agree with known or inferred groupings of the cells.

```
if (require(iSEE)) {
  iSEE(dat)
}
```

# 7 Session info

```
sessionInfo()
```

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] tidyr_1.3.1                 dplyr_1.1.4
##  [3] DuoClustering2018_1.28.0    SingleCellExperiment_1.32.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1     viridisLite_0.4.2    farver_2.1.2
##  [4] blob_1.2.4           Biostrings_2.78.0    filelock_1.0.3
##  [7] viridis_0.6.5        S7_0.2.0             fastmap_1.2.0
## [10] BiocFileCache_3.0.0  digest_0.6.37        lifecycle_1.0.4
## [13] KEGGREST_1.50.0      RSQLite_2.4.3        magrittr_2.0.4
## [16] compiler_4.5.1       rlang_1.1.6          sass_0.4.10
## [19] tools_4.5.1          yaml_2.3.10          knitr_1.50
## [22] S4Arrays_1.10.0      bit_4.6.0            mclust_6.1.2
## [25] curl_7.0.0           DelayedArray_0.36.0  plyr_1.8.9
## [28] RColorBrewer_1.1-3   abind_1.4-8          withr_3.0.2
## [31] purrr_1.2.0          grid_4.5.1           ExperimentHub_3.0.0
## [34] ggplot2_4.0.0        scales_1.4.0         dichromat_2.0-0.1
## [37] cli_3.6.5            crayon_1.5.3         rmarkdown_2.30
## [40] httr_1.4.7           reshape2_1.4.4       DBI_1.2.3
## [43] cachem_1.1.0         stringr_1.6.0        ggthemes_5.1.0
## [46] AnnotationDbi_1.72.0 BiocManager_1.30.26  XVector_0.50.0
## [49] vctrs_0.6.5          Matrix_1.7-4         jsonlite_2.0.0
## [52] bookdown_0.45        bit64_4.6.0-1        jquerylib_0.1.4
## [55] glue_1.8.0           stringi_1.8.7        gtable_0.3.6
## [58] BiocVersion_3.22.0   tibble_3.3.0         pillar_1.11.1
## [61] rappdirs_0.3.3       htmltools_0.5.8.1    R6_2.6.1
## [64] dbplyr_2.5.1         httr2_1.2.1          evaluate_1.0.5
## [67] lattice_0.22-7       AnnotationHub_4.0.0  png_0.1-8
## [70] memoise_2.0.1        bslib_0.9.0          Rcpp_1.1.0
## [73] gridExtra_2.3        SparseArray_1.10.1   xfun_0.54
## [76] pkgconfig_2.0.3
```

# References

Rue-Albrecht, K, F Marini, C Soneson, and ATL Lun. 2018. “iSEE: Interactive SummarizedExperiment Explorer.” *F1000Research* 7: 741.