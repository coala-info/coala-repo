# Modeling continuous cell-level covariates

### Collapse using mean value for pseudobulk data

Developed by [Gabriel Hoffman](http://gabrielhoffman.github.io/)

#### Run on 2025-10-29 23:43:38

# 1 Introduction

Since read counts are summed across cells in a pseudobulk approach, modeling continuous cell-level covariates also requires a collapsing step. Here we summarize the values of a variable from a set of cells using the mean, and store the value for each cell type. Including these variables in a regression formula uses the summarized values from the corresponding cell type.

We demonstrate this feature on a lightly modified analysis of PBMCs from 8 individuals stimulated with interferon-β ([Kang, et al, 2018, Nature Biotech](https://www.nature.com/articles/nbt.4042)).

# 2 Standard processing

Here is the code from the main vignette:

```
library(dreamlet)
library(muscat)
library(ExperimentHub)
library(scater)

# Download data, specifying EH2259 for the Kang, et al study
eh <- ExperimentHub()
sce <- eh[["EH2259"]]

# only keep singlet cells with sufficient reads
sce <- sce[rowSums(counts(sce) > 0) > 0, ]
sce <- sce[, colData(sce)$multiplets == "singlet"]

# compute QC metrics
qc <- perCellQCMetrics(sce)

# remove cells with few or many detected genes
ol <- isOutlier(metric = qc$detected, nmads = 2, log = TRUE)
sce <- sce[, !ol]

# set variable indicating stimulated (stim) or control (ctrl)
sce$StimStatus <- sce$stim
```

In many datasets, continuous cell-level variables could be mapped reads, gene count, mitochondrial rate, etc. There are no continuous cell-level variables in this dataset, so we can simulate two from a normal distribution:

```
sce$value1 <- rnorm(ncol(sce))
sce$value2 <- rnorm(ncol(sce))
```

# 3 Pseudobulk

Now compute the pseudobulk using standard code:

```
sce$id <- paste0(sce$StimStatus, sce$ind)

# Create pseudobulk
pb <- aggregateToPseudoBulk(sce,
  assay = "counts",
  cluster_id = "cell",
  sample_id = "id",
  verbose = FALSE
)
```

The means per variable, cell type, and sample are stored in the pseudobulk `SingleCellExperiment` object:

```
metadata(pb)$aggr_means
```

```
## # A tibble: 128 × 5
## # Groups:   cell [8]
##    cell    id       cluster   value1   value2
##    <fct>   <fct>      <dbl>    <dbl>    <dbl>
##  1 B cells ctrl101     3.96  0.0121   0.139
##  2 B cells ctrl1015    4.00 -0.0249  -0.0639
##  3 B cells ctrl1016    4    -0.0852   0.0432
##  4 B cells ctrl1039    4.04  0.0418   0.116
##  5 B cells ctrl107     4    -0.0596  -0.170
##  6 B cells ctrl1244    4     0.0745   0.202
##  7 B cells ctrl1256    4.01  0.0523  -0.0268
##  8 B cells ctrl1488    4.02  0.0849   0.00632
##  9 B cells stim101     4.09  0.184    0.105
## 10 B cells stim1015    4.06 -0.00221  0.0343
## # ℹ 118 more rows
```

# 4 Analysis

Including these variables in a regression formula uses the summarized values from the corresponding cell type. This happens behind the scenes, so the user doesn’t need to distinguish bewteen sample-level variables stored in `colData(pb)` and cell-level variables stored in `metadata(pb)$aggr_means`.

Variance partition and hypothesis testing proceeds as ususal:

```
form <- ~ StimStatus + value1 + value2

# Normalize and apply voom/voomWithDreamWeights
res.proc <- processAssays(pb, form, min.count = 5)

# run variance partitioning analysis
vp.lst <- fitVarPart(res.proc, form)

# Summarize variance fractions genome-wide for each cell type
plotVarPart(vp.lst, label.angle = 60)
```

![](data:image/png;base64...)

```
# Differential expression analysis within each assay
res.dl <- dreamlet(res.proc, form)

# dreamlet results include coefficients for value1 and value2
res.dl
```

```
## class: dreamletResult
## assays(8): B cells CD14+ Monocytes ... Megakaryocytes NK cells
## Genes:
##  min: 164
##  max: 5262
## details(7): assay n_retain ... n_errors error_initial
## coefNames(4): (Intercept) StimStatusstim value1 value2
```

# 5 Details

A variable in `colData(sce)` is handled according to if the variable is

* continuous: the mean per donor/cell type is stored in `metadata(pb)$aggr_means`
* discrete
  + [constant within each donor/cell type] it is stored in `colData(pb)`
  + [varies within each donor/cell type] there is no good way to summarize it. The variable is dropped.

# 6 Session Info

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
##  [1] muscData_1.23.0             scater_1.38.0
##  [3] scuttle_1.20.0              ExperimentHub_3.0.0
##  [5] AnnotationHub_4.0.0         BiocFileCache_3.0.0
##  [7] dbplyr_2.5.1                muscat_1.24.0
##  [9] dreamlet_1.8.0              SingleCellExperiment_1.32.0
## [11] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [13] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [15] IRanges_2.44.0              S4Vectors_0.48.0
## [17] BiocGenerics_0.56.0         generics_0.1.4
## [19] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [21] variancePartition_1.40.0    BiocParallel_1.44.0
## [23] limma_3.66.0                ggplot2_4.0.0
## [25] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] bitops_1.0-9              httr_1.4.7
##   [3] RColorBrewer_1.1-3        doParallel_1.0.17
##   [5] Rgraphviz_2.54.0          numDeriv_2016.8-1.1
##   [7] sctransform_0.4.2         tools_4.5.1
##   [9] backports_1.5.0           utf8_1.2.6
##  [11] R6_2.6.1                  metafor_4.8-0
##  [13] mgcv_1.9-3                GetoptLong_1.0.5
##  [15] withr_3.0.2               gridExtra_2.3
##  [17] prettyunits_1.2.0         fdrtool_1.2.18
##  [19] cli_3.6.5                 sandwich_3.1-1
##  [21] labeling_0.4.3            slam_0.1-55
##  [23] sass_0.4.10               KEGGgraph_1.70.0
##  [25] SQUAREM_2021.1            mvtnorm_1.3-3
##  [27] S7_0.2.0                  blme_1.0-6
##  [29] mixsqp_0.3-54             zenith_1.12.0
##  [31] dichromat_2.0-0.1         parallelly_1.45.1
##  [33] invgamma_1.2              RSQLite_2.4.3
##  [35] shape_1.4.6.1             gtools_3.9.5
##  [37] dplyr_1.1.4               Matrix_1.7-4
##  [39] metadat_1.4-0             ggbeeswarm_0.7.2
##  [41] abind_1.4-8               lifecycle_1.0.4
##  [43] multcomp_1.4-29           yaml_2.3.10
##  [45] edgeR_4.8.0               mathjaxr_1.8-0
##  [47] gplots_3.2.0              SparseArray_1.10.0
##  [49] grid_4.5.1                blob_1.2.4
##  [51] crayon_1.5.3              lattice_0.22-7
##  [53] beachmat_2.26.0           msigdbr_25.1.1
##  [55] annotate_1.88.0           KEGGREST_1.50.0
##  [57] magick_2.9.0              pillar_1.11.1
##  [59] knitr_1.50                ComplexHeatmap_2.26.0
##  [61] rjson_0.2.23              boot_1.3-32
##  [63] estimability_1.5.1        corpcor_1.6.10
##  [65] future.apply_1.20.0       codetools_0.2-20
##  [67] glue_1.8.0                data.table_1.17.8
##  [69] vctrs_0.6.5               png_0.1-8
##  [71] Rdpack_2.6.4              gtable_0.3.6
##  [73] assertthat_0.2.1          cachem_1.1.0
##  [75] zigg_0.0.2                xfun_0.53
##  [77] rbibutils_2.3             S4Arrays_1.10.0
##  [79] Rfast_2.1.5.2             coda_0.19-4.1
##  [81] reformulas_0.4.2          survival_3.8-3
##  [83] iterators_1.0.14          tinytex_0.57
##  [85] statmod_1.5.1             TH.data_1.1-4
##  [87] nlme_3.1-168              pbkrtest_0.5.5
##  [89] bit64_4.6.0-1             filelock_1.0.3
##  [91] progress_1.2.3            EnvStats_3.1.0
##  [93] bslib_0.9.0               TMB_1.9.18
##  [95] irlba_2.3.5.1             vipor_0.4.7
##  [97] KernSmooth_2.23-26        colorspace_2.1-2
##  [99] rmeta_3.0                 DBI_1.2.3
## [101] DESeq2_1.50.0             tidyselect_1.2.1
## [103] emmeans_2.0.0             bit_4.6.0
## [105] compiler_4.5.1            curl_7.0.0
## [107] httr2_1.2.1               graph_1.88.0
## [109] BiocNeighbors_2.4.0       DelayedArray_0.36.0
## [111] bookdown_0.45             scales_1.4.0
## [113] caTools_1.18.3            remaCor_0.0.20
## [115] rappdirs_0.3.3            stringr_1.5.2
## [117] digest_0.6.37             minqa_1.2.8
## [119] rmarkdown_2.30            aod_1.3.3
## [121] XVector_0.50.0            RhpcBLASctl_0.23-42
## [123] htmltools_0.5.8.1         pkgconfig_2.0.3
## [125] lme4_1.1-37               sparseMatrixStats_1.22.0
## [127] lpsymphony_1.38.0         mashr_0.2.79
## [129] fastmap_1.2.0             rlang_1.1.6
## [131] GlobalOptions_0.1.2       DelayedMatrixStats_1.32.0
## [133] farver_2.1.2              jquerylib_0.1.4
## [135] IHW_1.38.0                zoo_1.8-14
## [137] jsonlite_2.0.0            BiocSingular_1.26.0
## [139] RCurl_1.98-1.17           magrittr_2.0.4
## [141] Rcpp_1.1.0                viridis_0.6.5
## [143] babelgene_22.9            EnrichmentBrowser_2.40.0
## [145] stringi_1.8.7             MASS_7.3-65
## [147] plyr_1.8.9                listenv_0.9.1
## [149] parallel_4.5.1            ggrepel_0.9.6
## [151] Biostrings_2.78.0         splines_4.5.1
## [153] hms_1.1.4                 circlize_0.4.16
## [155] locfit_1.5-9.12           reshape2_1.4.4
## [157] ScaledMatrix_1.18.0       BiocVersion_3.22.0
## [159] XML_3.99-0.19             evaluate_1.0.5
## [161] RcppParallel_5.1.11-1     BiocManager_1.30.26
## [163] nloptr_2.2.1              foreach_1.5.2
## [165] tidyr_1.3.1               purrr_1.1.0
## [167] future_1.67.0             clue_0.3-66
## [169] scattermore_1.2           ashr_2.2-63
## [171] rsvd_1.0.5                broom_1.0.10
## [173] xtable_1.8-4              fANCOVA_0.6-1
## [175] viridisLite_0.4.2         truncnorm_1.0-9
## [177] tibble_3.3.0              lmerTest_3.1-3
## [179] glmmTMB_1.1.13            memoise_2.0.1
## [181] beeswarm_0.4.0            AnnotationDbi_1.72.0
## [183] cluster_2.1.8.1           globals_0.18.0
## [185] GSEABase_1.72.0
```