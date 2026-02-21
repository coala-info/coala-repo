# Apply clustering method

Angelo Duò, Mark D Robinson and Charlotte Soneson

#### 2025-11-06

#### Package

DuoClustering2018 1.28.0

# Contents

* [1 Introduction](#introduction)
* [2 Applying a new clustering algorithm to a provided data set](#applying-a-new-clustering-algorithm-to-a-provided-data-set)
* [3 Session info](#session-info)
* [References](#references)

# 1 Introduction

This vignette describes how each of the included clustering methods was applied
to the collection of data sets in order to generate the clustering result
summaries provided with the package. It also shows how to apply a new clustering
method to the included data sets, to generate results that can be compared to
those already included.

# 2 Applying a new clustering algorithm to a provided data set

The code below describes how we applied each of the included clustering methods
to the data sets for our paper (Duò, Robinson, and Soneson [2018](#ref-Duo2018-F1000)). The `apply_*()` functions,
describing how the respective clustering methods were run, are available from
the [GitHub
repository](https://github.com/markrobinsonuzh/scRNAseq_clustering_comparison/tree/master/Rscripts/clustering)
corresponding to the publication. In order to apply a new clustering algorithm
to one of the data sets using the same framework, it is necessary to generate a
function with the same format. The input arguments to this function should be:

* a `SingleCellExperiment` object
* a named list of parameter values (can be empty, if no parameters are used for
  the method)
* the desired number of clusters (k).

The function should return a list with three elements:

* `st` - a vector with the timing information. Should have five elements, named
  `user.self`, `sys.self`, `user.child`, `sys.child` and `elapsed`.
* `cluster` - a named vector of cluster assignments for all cells.
* `est_k` - the number of clusters estimated by the method (if available,
  otherwise `NA`).

If the method does not allow specification of the desired number of clusters,
but has another parameter affecting the resolution, this can be accommodated as
well (see the solution for `Seurat` in the code below).

First, load the package and define the data set and clustering method to use
(note that in order to apply a method named `<method>`, there has to be a
function named `apply_<method>()`, with the above specifications, available in
the workspace).

```
suppressPackageStartupMessages({
  library(DuoClustering2018)
})

scename <- "sce_filteredExpr10_Koh"
sce <- sce_filteredExpr10_Koh()
```

```
## see ?DuoClustering2018 and browseVignettes('DuoClustering2018') for documentation
```

```
## loading from cache
```

```
method <- "PCAHC"
```

Next, define the list of hyperparameter values. The package contains the
hyperparameter values for the methods included in our paper.

```
## Load parameter files. General dataset and method parameters as well as
## dataset/method-specific parameters
params <- duo_clustering_all_parameter_settings_v2()[[paste0(scename, "_",
                                                             method)]]
```

```
## see ?DuoClustering2018 and browseVignettes('DuoClustering2018') for documentation
```

```
## loading from cache
```

```
params
```

```
## $nPC
## [1] 30
##
## $range_clusters
##  [1]  2  3  4  5  6  7  8  9 10 11 12 13 14 15
```

Finally, define the number of times to apply the clustering method (for each
value of the number of clusters), and run the clustering across a range of
imposed numbers of clusters (defined in the parameter list).

```
## Set number of times to run clustering for each k
n_rep <- 5

## Run clustering
set.seed(1234)
L <- lapply(seq_len(n_rep), function(i) {  ## For each run
  cat(paste0("run = ", i, "\n"))
  if (method == "Seurat") {
    tmp <- lapply(params$range_resolutions, function(resolution) {
      ## For each resolution
      cat(paste0("resolution = ", resolution, "\n"))
      ## Run clustering
      res <- get(paste0("apply_", method))(sce = sce, params = params,
                                           resolution = resolution)

      ## Put output in data frame
      df <- data.frame(dataset = scename,
                       method = method,
                       cell = names(res$cluster),
                       run = i,
                       k = length(unique(res$cluster)),
                       resolution = resolution,
                       cluster = res$cluster,
                       stringsAsFactors = FALSE, row.names = NULL)
      tm <- data.frame(dataset = scename,
                       method = method,
                       run = i,
                       k = length(unique(res$cluster)),
                       resolution = resolution,
                       user.self = res$st[["user.self"]],
                       sys.self = res$st[["sys.self"]],
                       user.child = res$st[["user.child"]],
                       sys.child = res$st[["sys.child"]],
                       elapsed = res$st[["elapsed"]],
                       stringsAsFactors = FALSE, row.names = NULL)
      kest <- data.frame(dataset = scename,
                         method = method,
                         run = i,
                         k = length(unique(res$cluster)),
                         resolution = resolution,
                         est_k = res$est_k,
                         stringsAsFactors = FALSE, row.names = NULL)
      list(clusters = df, timing = tm, kest = kest)
    })  ## End for each resolution
  } else {
    tmp <- lapply(params$range_clusters, function(k) {  ## For each k
      cat(paste0("k = ", k, "\n"))
      ## Run clustering
      res <- get(paste0("apply_", method))(sce = sce, params = params, k = k)

      ## Put output in data frame
      df <- data.frame(dataset = scename,
                       method = method,
                       cell = names(res$cluster),
                       run = i,
                       k = k,
                       resolution = NA,
                       cluster = res$cluster,
                       stringsAsFactors = FALSE, row.names = NULL)
      tm <- data.frame(dataset = scename,
                       method = method,
                       run = i,
                       k = k,
                       resolution = NA,
                       user.self = res$st[["user.self"]],
                       sys.self = res$st[["sys.self"]],
                       user.child = res$st[["user.child"]],
                       sys.child = res$st[["sys.child"]],
                       elapsed = res$st[["elapsed"]],
                       stringsAsFactors = FALSE, row.names = NULL)
      kest <- data.frame(dataset = scename,
                         method = method,
                         run = i,
                         k = k,
                         resolution = NA,
                         est_k = res$est_k,
                         stringsAsFactors = FALSE, row.names = NULL)
      list(clusters = df, timing = tm, kest = kest)
    })  ## End for each k
  }

  ## Summarize across different values of k
  assignments <- do.call(rbind, lapply(tmp, function(w) w$clusters))
  timings <- do.call(rbind, lapply(tmp, function(w) w$timing))
  k_estimates <- do.call(rbind, lapply(tmp, function(w) w$kest))
  list(assignments = assignments, timings = timings, k_estimates = k_estimates)
})  ## End for each run

## Summarize across different runs
assignments <- do.call(rbind, lapply(L, function(w) w$assignments))
timings <- do.call(rbind, lapply(L, function(w) w$timings))
k_estimates <- do.call(rbind, lapply(L, function(w) w$k_estimates))

## Add true group for each cell
truth <- data.frame(cell = as.character(rownames(colData(sce))),
                    trueclass = as.character(colData(sce)$phenoid),
                    stringsAsFactors = FALSE)
assignments$trueclass <- truth$trueclass[match(assignments$cell, truth$cell)]

## Combine results
res <- list(assignments = assignments, timings = timings,
            k_estimates = k_estimates)

df <- dplyr::full_join(res$assignments %>%
                         dplyr::select(dataset, method, cell, run, k,
                                       resolution, cluster, trueclass),
                       res$k_estimates %>%
                         dplyr::select(dataset, method, run, k,
                                       resolution, est_k)
) %>% dplyr::full_join(res$timings %>% dplyr::select(dataset, method, run, k,
                                                     resolution, elapsed))
```

The resulting `df` data frames can then be combined across data sets, filterings
and methods and used as input to the provided plotting functions.

# 3 Session info

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
##  [1] plyr_1.8.9                  ExperimentHub_3.0.0
##  [3] AnnotationHub_4.0.0         BiocFileCache_3.0.0
##  [5] dbplyr_2.5.1                tidyr_1.3.1
##  [7] dplyr_1.1.4                 DuoClustering2018_1.28.0
##  [9] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1     viridisLite_0.4.2    farver_2.1.2
##  [4] blob_1.2.4           Biostrings_2.78.0    filelock_1.0.3
##  [7] viridis_0.6.5        S7_0.2.0             fastmap_1.2.0
## [10] digest_0.6.37        lifecycle_1.0.4      KEGGREST_1.50.0
## [13] RSQLite_2.4.3        magrittr_2.0.4       compiler_4.5.1
## [16] rlang_1.1.6          sass_0.4.10          tools_4.5.1
## [19] yaml_2.3.10          knitr_1.50           labeling_0.4.3
## [22] S4Arrays_1.10.0      bit_4.6.0            mclust_6.1.2
## [25] curl_7.0.0           DelayedArray_0.36.0  RColorBrewer_1.1-3
## [28] abind_1.4-8          withr_3.0.2          purrr_1.2.0
## [31] grid_4.5.1           ggplot2_4.0.0        scales_1.4.0
## [34] tinytex_0.57         dichromat_2.0-0.1    cli_3.6.5
## [37] crayon_1.5.3         rmarkdown_2.30       httr_1.4.7
## [40] reshape2_1.4.4       DBI_1.2.3            cachem_1.1.0
## [43] stringr_1.6.0        ggthemes_5.1.0       AnnotationDbi_1.72.0
## [46] BiocManager_1.30.26  XVector_0.50.0       vctrs_0.6.5
## [49] Matrix_1.7-4         jsonlite_2.0.0       bookdown_0.45
## [52] bit64_4.6.0-1        magick_2.9.0         jquerylib_0.1.4
## [55] glue_1.8.0           stringi_1.8.7        gtable_0.3.6
## [58] BiocVersion_3.22.0   tibble_3.3.0         pillar_1.11.1
## [61] rappdirs_0.3.3       htmltools_0.5.8.1    R6_2.6.1
## [64] httr2_1.2.1          evaluate_1.0.5       lattice_0.22-7
## [67] png_0.1-8            memoise_2.0.1        bslib_0.9.0
## [70] Rcpp_1.1.0           gridExtra_2.3        SparseArray_1.10.1
## [73] xfun_0.54            pkgconfig_2.0.3
```

# References

Duò, A, MD Robinson, and D Soneson. 2018. “A Systematic Performance Evaluation of Clustering Methods for Single-Cell RNA-seq Data.” *F1000Research* 7: 1141.