# Plot performance summaries

Angelo Duò, Mark D Robinson and Charlotte Soneson

#### 2025-11-06

#### Package

DuoClustering2018 1.28.0

# Contents

* [1 Introduction](#introduction)
* [2 Load the necessary packages](#load-the-necessary-packages)
* [3 Retrieve a data set](#retrieve-a-data-set)
* [4 Read a set of clustering results](#read-a-set-of-clustering-results)
* [5 Define consistent method colors](#define-consistent-method-colors)
* [6 Plot](#plot)
  + [6.1 Performance](#performance)
  + [6.2 Stability](#stability)
  + [6.3 Entropy](#entropy)
  + [6.4 Timing](#timing)
  + [6.5 Differences in k](#differences-in-k)
* [7 Session info](#session-info)
* [References](#references)

# 1 Introduction

In this vignette we describe the basic usage of the `DuoClustering2018` package:
how to retrieve data sets and clustering results, and how to construct various
plots summarizing the performance of different methods across several data sets.

# 2 Load the necessary packages

```
suppressPackageStartupMessages({
  library(ExperimentHub)
  library(SingleCellExperiment)
  library(DuoClustering2018)
  library(plyr)
})
```

# 3 Retrieve a data set

The clustering evaluation (Duò, Robinson, and Soneson [2018](#ref-Duo2018-F1000)) is based on 12 data sets (9 real and
3 simulated), which are all provided via `ExperimentHub` and retrievable via
this package. We include the full data sets (after quality filtering of cells
and removal of genes with zero counts across all cells) as well as three
filtered versions of each data set (by expression, variability and dropout
pattern, respectively), each containing 10% of the genes in the full data set.

To get an overview, we can list all records from this package that are available
in `ExperimentHub`:

```
eh <- ExperimentHub()
query(eh, "DuoClustering2018")
```

```
## ExperimentHub with 122 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Robinson group (UZH), 10x Genomics, Zheng et al (2017), SRA...
## # $species: Homo sapiens, Mus musculus, NA
## # $rdataclass: data.frame, SingleCellExperiment, list
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH1499"]]'
##
##            title
##   EH1499 | duo_clustering_all_parameter_settings_v1
##   EH1500 | sce_full_Koh
##   EH1501 | sce_filteredExpr10_Koh
##   EH1502 | sce_filteredHVG10_Koh
##   EH1503 | sce_filteredM3Drop10_Koh
##   ...      ...
##   EH1651 | clustering_summary_filteredHVG10_SimKumar4hard_v2
##   EH1652 | clustering_summary_filteredM3Drop10_SimKumar4hard_v2
##   EH1653 | clustering_summary_filteredExpr10_SimKumar8hard_v2
##   EH1654 | clustering_summary_filteredHVG10_SimKumar8hard_v2
##   EH1655 | clustering_summary_filteredM3Drop10_SimKumar8hard_v2
```

The records with names starting in `sce_` represent (filtered or unfiltered)
data sets (in `SingleCellExperiment` format). The records with names starting in
`clustering_summary_` correspond to `data.frame` objects with clustering results
for each of the filtered data sets. Finally, the
`duo_clustering_all_parameter_settings` object contains the parameter settings
we used for all the clustering methods. For clustering summaries and parameter
settings, the version number (e.g., `_v2`) corresponds to the version of the
publication.

The records can be retrieved using their `ExperimentHub` ID, e.g.:

```
eh[["EH1500"]]
```

```
## see ?DuoClustering2018 and browseVignettes('DuoClustering2018') for documentation
```

```
## loading from cache
```

```
## class: SingleCellExperiment
## dim: 48981 531
## metadata(1): log.exprs.offset
## assays(3): counts logcounts normcounts
## rownames(48981): ENSG00000000003.14 ENSG00000000005.5 ...
##   ENSG00000283122.1 ENSG00000283124.1
## rowData names(8): is_feature_control mean_counts ... total_counts
##   log10_total_counts
## colnames(531): SRR3952323 SRR3952325 ... SRR3952970 SRR3952971
## colData names(15): Run LibraryName ... feature.drop sizeFactor
## reducedDimNames(2): PCA TSNE
## mainExpName: NULL
## altExpNames(0):
```

Alternatively, the shortcut functions provided by this package can be used:

```
sce_filteredExpr10_Koh()
```

```
## see ?DuoClustering2018 and browseVignettes('DuoClustering2018') for documentation
```

```
## loading from cache
```

```
## class: SingleCellExperiment
## dim: 4898 531
## metadata(1): log.exprs.offset
## assays(3): counts logcounts normcounts
## rownames(4898): ENSG00000198804.2 ENSG00000210082.2 ...
##   ENSG00000072134.15 ENSG00000090061.17
## rowData names(8): is_feature_control mean_counts ... total_counts
##   log10_total_counts
## colnames(531): SRR3952323 SRR3952325 ... SRR3952970 SRR3952971
## colData names(15): Run LibraryName ... is_cell_control sizeFactor
## reducedDimNames(2): PCA TSNE
## mainExpName: NULL
## altExpNames(0):
```

# 4 Read a set of clustering results

For each included data set, we have applied a range of clustering methods (see
the `run_clustering` vignette for more details on how this was done, and how to
apply additional methods). As mentioned above, the results of these clusterings
are also available from `ExperimentHub`, and can be loaded either by their
`ExperimentHub` ID or using the provided shortcut functions, as above. For
simplicity, the results of all methods for a given data set are combined into
a single object. As an illustration, we load the clustering summaries for two
different data sets (`Koh` and `Zhengmix4eq`), each with two different gene
filterings (`Expr10` and `HVG10`):

```
res <- plyr::rbind.fill(
  clustering_summary_filteredExpr10_Koh_v2(),
  clustering_summary_filteredHVG10_Koh_v2(),
  clustering_summary_filteredExpr10_Zhengmix4eq_v2(),
  clustering_summary_filteredHVG10_Zhengmix4eq_v2()
)
```

```
## see ?DuoClustering2018 and browseVignettes('DuoClustering2018') for documentation
```

```
## loading from cache
```

```
## see ?DuoClustering2018 and browseVignettes('DuoClustering2018') for documentation
```

```
## loading from cache
```

```
## see ?DuoClustering2018 and browseVignettes('DuoClustering2018') for documentation
```

```
## loading from cache
```

```
## see ?DuoClustering2018 and browseVignettes('DuoClustering2018') for documentation
```

```
## loading from cache
```

```
dim(res)
```

```
## [1] 5625885      10
```

The resulting `data.frame` contains 10 columns:

* `dataset`: The name of the data set
* `method`: The name of the clustering method
* `cell`: The cell identifier
* `run`: The run ID (each method was run five times for each data set and number
  of clusters)
* `k`: The imposed number of clusters (for all methods except Seurat)
* `resolution`: The imposed resolution (only for Seurat)
* `cluster`: The assigned cluster label
* `trueclass`: The true class of the cell
* `est_k`: The estimated number of clusters (for methods allowing such
  estimation)
* `elapsed`: The elapsed time of the run

```
head(res)
```

```
##                  dataset    method       cell run k resolution cluster
## 1 sce_filteredExpr10_Koh PCAKmeans SRR3952323   1 2         NA       1
## 2 sce_filteredExpr10_Koh PCAKmeans SRR3952325   1 2         NA       1
## 3 sce_filteredExpr10_Koh PCAKmeans SRR3952326   1 2         NA       1
## 4 sce_filteredExpr10_Koh PCAKmeans SRR3952327   1 2         NA       1
## 5 sce_filteredExpr10_Koh PCAKmeans SRR3952328   1 2         NA       1
## 6 sce_filteredExpr10_Koh PCAKmeans SRR3952329   1 2         NA       1
##   trueclass est_k elapsed
## 1    H7hESC    NA  14.318
## 2    H7hESC    NA  14.318
## 3    H7hESC    NA  14.318
## 4    H7hESC    NA  14.318
## 5    H7hESC    NA  14.318
## 6    H7hESC    NA  14.318
```

# 5 Define consistent method colors

For some of the plots generated below, the points will be colored according to
the clustering method. We can enforce a consistent set of colors for the methods
by defining a named vector of colors to use for all plots.

```
method_colors <- c(CIDR = "#332288", FlowSOM = "#6699CC", PCAHC = "#88CCEE",
            PCAKmeans = "#44AA99", pcaReduce = "#117733",
            RtsneKmeans = "#999933", Seurat = "#DDCC77", SC3svm = "#661100",
            SC3 = "#CC6677", TSCAN = "grey34", ascend = "orange", SAFE = "black",
            monocle = "red", RaceID2 = "blue")
```

# 6 Plot

Each plotting function described below returns a list of `ggplot` objects. These
can be plotted directly, or further modified if desired.

## 6.1 Performance

The `plot_performance()` function generates plots related to the performance of
the clustering methods. We quantify performance using the adjusted Rand Index
(ARI) (Hubert and Arabie [1985](#ref-hubert1985comparing)), comparing the obtained clustering to the true
clusters. As we noted in the publication (Duò, Robinson, and Soneson [2018](#ref-Duo2018-F1000)), defining a true
partitioning of the cells is difficult, since they can often be grouped together
in several different, but still interpretable, ways. We refer to our paper for
more information on how the true clusters were defined for each of the data
sets.

```
perf <- plot_performance(res, method_colors = method_colors)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the DuoClustering2018 package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
names(perf)
```

```
## [1] "median_ari_vs_k"           "scatter_time_vs_ari_truek"
## [3] "median_ari_heatmap_truek"  "median_ari_heatmap_bestk"
## [5] "median_ari_heatmap_estk"
```

```
perf$median_ari_vs_k
```

```
## Warning: Removed 4 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![](data:image/png;base64...)

```
perf$median_ari_heatmap_truek
```

![](data:image/png;base64...)

## 6.2 Stability

The `plot_stability()` function evaluates the stability of the clustering
results from each method, with respect to random starts. Each method was run
five times on each data set (for each k), and we quantify the stability by
comparing each pair of such runs using the adjusted Rand Index.

```
stab <- plot_stability(res, method_colors = method_colors)
```

```
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
## Aggregation function missing: defaulting to length
```

```
## Warning: `cols` is now required when using `unnest()`.
## ℹ Please use `cols = c(stability)`.
```

```
names(stab)
```

```
## [1] "stability_vs_k"          "stability_truek"
## [3] "stability_heatmap_truek"
```

```
stab$stability_vs_k
```

```
## Warning: Removed 4 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![](data:image/png;base64...)

```
stab$stability_heatmap_truek
```

![](data:image/png;base64...)

## 6.3 Entropy

In order to evaluate the tendency of the clustering methods to favor equally
sized clusters, we calculate the Shannon entropy (Shannon [1948](#ref-Shannon1948-cw)) of each
clustering solution (based on the proportions of cells in the different
clusters) and plot this using the `plot_entropy()` function. Since the maximal
entropy that can be obtained depends on the number of clusters, we use
normalized entropies, defined by dividing the observed entropy by `log2(k)`. We
also compare the entropies for the clusterings to the entropy of the true
partition for each data set.

```
entr <- plot_entropy(res, method_colors = method_colors)
names(entr)
```

```
## [1] "entropy_vs_k"           "entropy_vs_ari"         "normentropy"
## [4] "deltaentropy_truek"     "deltanormentropy_truek"
```

```
entr$entropy_vs_k
```

![](data:image/png;base64...)

```
entr$normentropy
```

![](data:image/png;base64...)

## 6.4 Timing

The `plot_timing()` function plots various aspects of the timing of the
different methods.

```
timing <- plot_timing(res, method_colors = method_colors,
                      scaleMethod = "RtsneKmeans")
names(timing)
```

```
## [1] "time_boxplot"           "time_normalized_by_ref" "time_vs_k"
```

```
timing$time_normalized_by_ref
```

```
## Ignoring unknown labels:
## • size : "16"
```

```
## Warning: Removed 32 rows containing non-finite outside the scale range
## (`stat_boxplot()`).
```

![](data:image/png;base64...)

## 6.5 Differences in k

Most performance evaluations above are performed on the clustering solutions
obtained by imposing the “true” number of clusters. The `plot_k_diff()` function
evaluates the difference between the true number of cluster and the number of
clusters giving the best agreement with the true partition, as well as the
difference between the estimated and the true number of clusters, for the
methods that allow estimation of k.

```
kdiff <- plot_k_diff(res, method_colors = method_colors)
names(kdiff)
```

```
## [1] "diff_kmax_ktrue" "diff_kest_ktrue"
```

```
kdiff$diff_kest_ktrue
```

```
## Bin width defaults to 1/30 of the range of the data. Pick better value with
## `binwidth`.
```

![](data:image/png;base64...)

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

Hubert, L, and P Arabie. 1985. “Comparing Partitions.” *Journal of Classification* 2 (1): 193–218.

Shannon, C E. 1948. “A Mathematical Theory of Communication.” *The Bell System Technical Journal* 27 (3): 379–423.