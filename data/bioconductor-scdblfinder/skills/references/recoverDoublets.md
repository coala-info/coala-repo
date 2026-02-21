# Recovering intra-sample doublets

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### 2025-10-30

#### Package

scDblFinder 1.24.0

# Contents

* [1 tl;dr](#tldr)
* [2 Mathematical background](#mathematical-background)
* [3 Obtaining explicit calls](#obtaining-explicit-calls)
* [4 Discussion](#discussion)
* [Session information](#session-information)

# 1 tl;dr

See the relevant section of the [OSCA book](https://osca.bioconductor.org/doublet-detection.html#doublet-detection-in-multiplexed-experiments) for an example of the `recoverDoublets()` function in action on real data.
A toy example is also provided in `?recoverDoublets`.

# 2 Mathematical background

Consider any two cell states \(C\_1\) and \(C\_2\) forming a doublet population \(D\_{12}\).
We will focus on the relative frequency of inter-sample to intra-sample doublets in \(D\_{12}\).
Given a vector \(\vec p\_X\) containing the proportion of cells from each sample in state \(X\), and assuming that doublets form randomly between pairs of samples, the expected proportion of intra-sample doublets in \(D\_{12}\) is \(\vec p\_{C\_1} \cdot \vec p\_{C\_2}\).
Subtracting this from 1 gives us the expected proportion of inter-sample doublets \(q\_{D\_{12}}\).
Similarly, the expected proportion of inter-sample doublets in \(C\_1\) is just \(q\_{C\_1} =1 - \| \vec p\_{C\_1} \|\_2^2\).

Now, let’s consider the observed proportion of events \(r\_X\) in each state \(X\) that are known doublets.
We have \(r\_{D\_{12}} = q\_{D\_{12}}\) as there are no other events in \(D\_{12}\) beyond actual doublets.
On the other hand, we expect that \(r\_{C\_1} \ll q\_{C\_1}\) due to presence of a large majority of non-doublet cells in \(C\_1\) (same for \(C\_2\)).
If we assume that \(q\_{D\_{12}} \ge q\_{C\_1}\) and \(q\_{C\_2}\), the observed proportion \(r\_{D\_{12}}\) should be larger than \(r\_{C\_1}\) and \(r\_{C\_2}\).
(The last assumption is not always true but the \(\ll\) should give us enough wiggle room to be robust to violations.)

The above reasoning motivates the use of the proportion of known doublet neighbors as a “doublet score” to identify events that are most likely to be themselves doublets.
`recoverDoublets()` computes the proportion of known doublet neighbors for each cell by performing a \(k\)-nearest neighbor search against all other cells in the dataset.
It is then straightforward to calculate the proportion of neighboring cells that are marked as known doublets, representing our estimate of \(r\_X\) for each cell.

# 3 Obtaining explicit calls

While the proportions are informative, there comes a time when we need to convert these into explicit doublet calls.
This is achieved with \(\vec S\), the vector of the proportion of cells from each sample across the entire dataset (i.e., `samples`).
We assume that all cell states contributing to doublet states have proportion vectors equal to \(\vec S\), such that the expected proportion of doublets that occur between cells from the same sample is \(\| \vec S\|\_2^2\).
We then solve

\[
\frac{N\_{intra}}{(N\_{intra} + N\_{inter}} = \| \vec S\|\_2^2
\]

for \(N\_{intra}\), where \(N\_{inter}\) is the number of observed inter-sample doublets.
The top \(N\_{intra}\) events with the highest scores (and, obviously, are not already inter-sample doublets) are marked as putative intra-sample doublets.

# 4 Discussion

The rate and manner of doublet formation is (mostly) irrelevant as we condition on the number of events in \(D\_{12}\).
This means that we do not have to make any assumptions about the relative likelihood of doublets forming between pairs of cell types, especially when cell types have different levels of “stickiness” (or worse, stick specifically to certain other cell types).
Such convenience is only possible because of the known doublet calls that allow us to focus on the inter- to intra-sample ratio.

The most problematic assumption is that required to obtain \(N\_{intra}\) from \(\vec S\).
Obtaining a better estimate would require, at least, the knowledge of the two parent states for each doublet population.
This can be determined with some simulation-based heuristics but it is likely to be more trouble than it is worth.

In this theoretical framework, we can easily spot a case where our method fails.
If both \(C\_1\) and \(C\_2\) are unique to a given sample, all events in \(D\_{12}\) will be intra-sample doublets.
This means that no events in \(D\_{12}\) will ever be detected as inter-sample doublets, which precludes their detection as intra-sample doublets by `recoverDoublets`.
The computational remedy is to augment the predictions with simulation-based methods (e.g., `scDblFinder()`) while the experimental remedy is to ensure that multiplexed samples include technical or biological replicates.

# Session information

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
##  [1] bluster_1.20.0              scDblFinder_1.24.0
##  [3] scater_1.38.0               ggplot2_4.0.0
##  [5] scran_1.38.0                scuttle_1.20.0
##  [7] ensembldb_2.34.0            AnnotationFilter_1.34.0
##  [9] GenomicFeatures_1.62.0      AnnotationDbi_1.72.0
## [11] scRNAseq_2.23.1             SingleCellExperiment_1.32.0
## [13] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [15] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [17] IRanges_2.44.0              S4Vectors_0.48.0
## [19] BiocGenerics_0.56.0         generics_0.1.4
## [21] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [23] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       jsonlite_2.0.0           magrittr_2.0.4
##   [4] magick_2.9.0             ggbeeswarm_0.7.2         gypsum_1.6.0
##   [7] farver_2.1.2             rmarkdown_2.30           BiocIO_1.20.0
##  [10] vctrs_0.6.5              memoise_2.0.1            Rsamtools_2.26.0
##  [13] RCurl_1.98-1.17          tinytex_0.57             htmltools_0.5.8.1
##  [16] S4Arrays_1.10.0          AnnotationHub_4.0.0      curl_7.0.0
##  [19] BiocNeighbors_2.4.0      xgboost_1.7.11.1         Rhdf5lib_1.32.0
##  [22] SparseArray_1.10.0       rhdf5_2.54.0             sass_0.4.10
##  [25] alabaster.base_1.10.0    bslib_0.9.0              alabaster.sce_1.10.0
##  [28] httr2_1.2.1              cachem_1.1.0             GenomicAlignments_1.46.0
##  [31] igraph_2.2.1             lifecycle_1.0.4          pkgconfig_2.0.3
##  [34] rsvd_1.0.5               Matrix_1.7-4             R6_2.6.1
##  [37] fastmap_1.2.0            digest_0.6.37            dqrng_0.4.1
##  [40] irlba_2.3.5.1            ExperimentHub_3.0.0      RSQLite_2.4.3
##  [43] beachmat_2.26.0          labeling_0.4.3           filelock_1.0.3
##  [46] httr_1.4.7               abind_1.4-8              compiler_4.5.1
##  [49] bit64_4.6.0-1            withr_3.0.2              S7_0.2.0
##  [52] BiocParallel_1.44.0      viridis_0.6.5            DBI_1.2.3
##  [55] HDF5Array_1.38.0         alabaster.ranges_1.10.0  alabaster.schemas_1.10.0
##  [58] MASS_7.3-65              rappdirs_0.3.3           DelayedArray_0.36.0
##  [61] rjson_0.2.23             tools_4.5.1              vipor_0.4.7
##  [64] beeswarm_0.4.0           glue_1.8.0               h5mread_1.2.0
##  [67] restfulr_0.0.16          rhdf5filters_1.22.0      grid_4.5.1
##  [70] Rtsne_0.17               cluster_2.1.8.1          gtable_0.3.6
##  [73] data.table_1.17.8        BiocSingular_1.26.0      ScaledMatrix_1.18.0
##  [76] metapod_1.18.0           XVector_0.50.0           ggrepel_0.9.6
##  [79] BiocVersion_3.22.0       pillar_1.11.1            limma_3.66.0
##  [82] dplyr_1.1.4              BiocFileCache_3.0.0      lattice_0.22-7
##  [85] rtracklayer_1.70.0       bit_4.6.0                tidyselect_1.2.1
##  [88] locfit_1.5-9.12          Biostrings_2.78.0        knitr_1.50
##  [91] gridExtra_2.3            bookdown_0.45            ProtGenerics_1.42.0
##  [94] edgeR_4.8.0              xfun_0.53                statmod_1.5.1
##  [97] UCSC.utils_1.6.0         lazyeval_0.2.2           yaml_2.3.10
## [100] evaluate_1.0.5           codetools_0.2-20         cigarillo_1.0.0
## [103] tibble_3.3.0             alabaster.matrix_1.10.0  BiocManager_1.30.26
## [106] cli_3.6.5                jquerylib_0.1.4          dichromat_2.0-0.1
## [109] Rcpp_1.1.0               GenomeInfoDb_1.46.0      dbplyr_2.5.1
## [112] png_0.1-8                XML_3.99-0.19            parallel_4.5.1
## [115] blob_1.2.4               bitops_1.0-9             viridisLite_0.4.2
## [118] alabaster.se_1.10.0      scales_1.4.0             purrr_1.1.0
## [121] crayon_1.5.3             rlang_1.1.6              cowplot_1.2.0
## [124] KEGGREST_1.50.0
```