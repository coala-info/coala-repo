[[![](data:image/png;base64...)](http://bioconductor.org/packages/release/bioc/html/knowYourCG.html)](index.html)

* [Sequencing Data](Sequencing.html)
* [Array Data](Array.html)
* [Continuous Data](Continuous.html)
* [Visualization](visualization.html)

# Continuous Data Analysis

There are four testing scenarios depending on the type format of the query set and database sets. They are shown with the respective testing scenario in the table below. `testEnrichment`, `testEnrichmentSEA` are for Fisher’s exact test and Set Enrichment Analysis respectively.

Four knowYourCG Testing Scenarios

|  | Continuous Database Set | Discrete Database Set |
| --- | --- | --- |
| Continuous Query | Correlation-based | Set Enrichment Analysis |
| Discrete Query | Set Enrichment Analysis | Fisher’s Exact Test |

# CONTINUOUS VARIABLE ENRICHMENT

The query may be a named continuous vector. In that case, either a gene enrichment score will be calculated (if the database is discrete) or a Spearman correlation will be calculated (if the database is continuous as well). The three other cases are shown below using biologically relevant examples.

To display this functionality, let’s load two numeric database sets individually. One is a database set for CpG density and the other is a database set corresponding to the distance of the nearest transcriptional start site (TSS) to each probe.

```
library(knowYourCG)
query <- getDBs("KYCG.MM285.designGroup")[["TSS"]]
```

```
sesameDataCache(data_titles = c("KYCG.MM285.seqContextN.20210630"))
res <- testEnrichmentSEA(query, "MM285.seqContextN")
main_stats <- c("dbname", "test", "estimate", "FDR", "nQ", "nD", "overlap")
res[,main_stats]
```

The estimate here is enrichment score.

> **NOTE:** Negative enrichment score suggests enrichment of the categorical database with the higher values (in the numerical database). Positive enrichment score represent enrichment with the smaller values. As expected, the designed TSS CpGs are significantly enriched in smaller TSS distance and higher CpG density.

Alternatively one can test the enrichment of a continuous query with discrete databases. Here we will use the methylation level from a sample as the query and test it against the chromHMM chromatin states.

```
library(sesame)
sesameDataCache(data_titles = c("MM285.1.SigDF"))
beta_values <- getBetas(sesameDataGet("MM285.1.SigDF"))
res <- testEnrichmentSEA(beta_values, "MM285.chromHMM")
main_stats <- c("dbname", "test", "estimate", "FDR", "nQ", "nD", "overlap")
res[,main_stats]
```

As expected, chromatin states `Tss`, `Enh` has negative enrichment score, meaning these databases are associated with small values of the query (DNA methylation level). On the contrary, `Het` and `Quies` states are associated with high methylation level.

# SESSION INFO

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
##  [1] sesame_1.28.1               knitr_1.51
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.1        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] sesameData_1.28.0           ExperimentHub_3.0.0
## [13] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [15] dbplyr_2.5.1                BiocGenerics_0.56.0
## [17] generics_0.1.4              knowYourCG_1.6.3
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1      dplyr_1.1.4           farver_2.1.2
##  [4] blob_1.2.4            filelock_1.0.3        Biostrings_2.78.0
##  [7] S7_0.2.1              fastmap_1.2.0         digest_0.6.39
## [10] lifecycle_1.0.5       KEGGREST_1.50.0       RSQLite_2.4.5
## [13] magrittr_2.0.4        compiler_4.5.2        rlang_1.1.6
## [16] sass_0.4.10           tools_4.5.2           yaml_2.3.12
## [19] S4Arrays_1.10.1       bit_4.6.0             curl_7.0.0
## [22] DelayedArray_0.36.0   plyr_1.8.9            RColorBrewer_1.1-3
## [25] BiocParallel_1.44.0   abind_1.4-8           withr_3.0.2
## [28] purrr_1.2.0           grid_4.5.2            preprocessCore_1.72.0
## [31] wheatmap_0.2.0        colorspace_2.1-2      ggplot2_4.0.1
## [34] scales_1.4.0          dichromat_2.0-0.1     cli_3.6.5
## [37] rmarkdown_2.30        crayon_1.5.3          otel_0.2.0
## [40] httr_1.4.7            reshape2_1.4.5        tzdb_0.5.0
## [43] DBI_1.2.3             cachem_1.1.0          stringr_1.6.0
## [46] parallel_4.5.2        AnnotationDbi_1.72.0  BiocManager_1.30.27
## [49] XVector_0.50.0        vctrs_0.6.5           Matrix_1.7-4
## [52] jsonlite_2.0.0        hms_1.1.4             bit64_4.6.0-1
## [55] ggrepel_0.9.6         fontawesome_0.5.3     jquerylib_0.1.4
## [58] glue_1.8.0            codetools_0.2-20      stringi_1.8.7
## [61] gtable_0.3.6          BiocVersion_3.22.0    tibble_3.3.0
## [64] pillar_1.11.1         rappdirs_0.3.3        htmltools_0.5.9
## [67] R6_2.6.1              httr2_1.2.2           evaluate_1.0.5
## [70] lattice_0.22-7        readr_2.1.6           png_0.1-8
## [73] memoise_2.0.1         bslib_0.9.0           Rcpp_1.1.0
## [76] SparseArray_1.10.8    xfun_0.55             pkgconfig_2.0.3
```