# Testing non-linear effects

### Categories and continuous variables

Developed by [Gabriel Hoffman](http://gabrielhoffman.github.io/)

#### Run on 2025-10-29 23:48:02

# 1 Introduction

Typical analysis using regression models assumes a linear affect of the covariate on the response. Here we consider testing non-linear effects in the case of 1) continuous and 2) ordered categorical variables.

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

sce$id <- paste0(sce$StimStatus, sce$ind)

# Create pseudobulk
pb <- aggregateToPseudoBulk(sce,
  assay = "counts",
  cluster_id = "cell",
  sample_id = "id",
  verbose = FALSE
)
```

# 3 Continuous variable

Consider the continuous variable `Age`. Typical analysis only considers linear effects using a single regression coefficient, but we also want to consider the non-linear effects of age. We can peform a [basis expansion using splines](https://bmcmedresmethodol.biomedcentral.com/articles/10.1186/s12874-019-0666-3) instead use 3 coefficients to model the age effect.

```
# Simulate age between 18 and 65
pb$Age <- runif(ncol(pb), 18, 65)

# formula included non-linear effects of Age
# by using a natural spline of degree 3
# This corresponds to using 3 coefficients instead of 1
form <- ~ splines::ns(Age, 3)

# Normalize and apply voom/voomWithDreamWeights
res.proc <- processAssays(pb, form, min.count = 5)

# Differential expression analysis within each assay
res.dl <- dreamlet(res.proc, form)

# The spline has degree 3, so there are 3 coefficients
# estimated for Age effects
coefNames(res.dl)
```

```
## [1] "(Intercept)"          "splines::ns(Age, 3)1" "splines::ns(Age, 3)2"
## [4] "splines::ns(Age, 3)3"
```

```
# Jointly test effects of the 3 spline components
# The test of the 3 coefficients is performed with an F-statistic
topTable(res.dl, coef = coefNames(res.dl)[2:4], number = 3)
```

```
## DataFrame with 3 rows and 9 columns
##               assay                    ID splines..ns.Age..3.1
##         <character>           <character>            <numeric>
## 1       CD8 T cells                SNRPD1              1.42138
## 2 FCGR3A+ Monocytes SMDT1_ENSG00000183172              2.30677
## 3       CD4 T cells  DDX5_ENSG00000108654              1.18482
##   splines..ns.Age..3.2 splines..ns.Age..3.3   AveExpr         F     P.Value
##              <numeric>            <numeric> <numeric> <numeric>   <numeric>
## 1            -1.105736            -2.558864   6.77383   13.9663 5.48904e-05
## 2            -1.666835            -2.494527   6.51619   13.4177 1.25132e-04
## 3            -0.691236            -0.456264   8.51929   11.8087 2.11159e-04
##   adj.P.Val
##   <numeric>
## 1  0.795472
## 2  0.906709
## 3  0.997947
```

# 4 Ordered categorical

We can also test non-linear effects in the case of categorical variables with a natural ordering to the categories. Consider time course data with 4 time points. Each time point is a category and has a natural ordering from first to last.

We have multiple options to model the time course.

* **Continuous:** Modeling time point as a continuous variable uses a single regression coefficient to model the linear effects of the time course. This is simple, models the order of the time points, but ignores non-linear effects

  Model using `as.numeric(TimePoint)`
* **Categorical:** Including time point as a typical categorical variable uses estimated the mean response value for each category. So it estimates 4 coefficients. While this can be useful for comparing two categories, it ignores the order of the time points.

  Model using `factor(TimePoint)`
* **Ordered categorical:** Here, the trend across ordered time points is modled using orthogonal polynomials. The trend is decomposed into independent linear, quadratic, etc., effects that can be tested either jointly or by themselves.

  Model using:

  ```
  ord <- c("time_1", "time_2", "time_3", "time_4")
  ordered(factor(TimePoint), ord)
  ```

Here we simulated 4 time points, and perform differential expression analysis.

```
# Consider data generated across 4 time points
# While there are no time points in the real data
# we can add some for demonstration purposes
pb$TimePoint <- ordered(paste0("time_", rep(1:4, 4)))

# examine the ordering
pb$TimePoint
```

```
##  [1] time_1 time_2 time_3 time_4 time_1 time_2 time_3 time_4 time_1 time_2
## [11] time_3 time_4 time_1 time_2 time_3 time_4
## Levels: time_1 < time_2 < time_3 < time_4
```

```
# Use formula including time point
form <- ~TimePoint

# Normalize and apply voom/voomWithDreamWeights
res.proc <- processAssays(pb, form, min.count = 5)

# Differential expression analysis within each assay
res.dl <- dreamlet(res.proc, form)

# Examine the coefficient estimated
# for TimePoint it estimates
# linear (i.e. L)
# quadratic (i.e. Q)
# and cubic (i.e. C) effects
coefNames(res.dl)
```

```
## [1] "(Intercept)" "TimePoint.L" "TimePoint.Q" "TimePoint.C"
```

```
# Test only linear effect
topTable(res.dl, coef = "TimePoint.L", number = 3)
```

```
## DataFrame with 3 rows and 9 columns
##         assay          ID     logFC   AveExpr         t     P.Value adj.P.Val
##   <character> <character> <numeric> <numeric> <numeric>   <numeric> <numeric>
## 1 CD4 T cells        DCXR -0.671645   6.52867  -5.42880 4.78666e-05  0.393058
## 2 CD4 T cells        GGA2 -0.890112   4.98987  -5.26372 6.69370e-05  0.393058
## 3 CD8 T cells        FTH1 -0.759875  14.55380  -4.99199 8.13672e-05  0.393058
##           B     z.std
##   <numeric> <numeric>
## 1  1.686147  -5.42880
## 2  0.936906  -5.26372
## 3  1.627753  -4.99199
```

```
# Test linear, quadratic and cubic effcts
coefs <- c("TimePoint.L", "TimePoint.Q", "TimePoint.C")
topTable(res.dl, coef = coefs, number = 3)
```

```
## DataFrame with 3 rows and 9 columns
##         assay                   ID TimePoint.L TimePoint.Q TimePoint.C
##   <character>          <character>   <numeric>   <numeric>   <numeric>
## 1 CD8 T cells                 CD52    0.903032   -1.528456   -0.984065
## 2 CD8 T cells CCL5_ENSG00000161570    0.626201   -0.986502   -0.645468
## 3 CD8 T cells                  CD2    0.887578   -1.152415   -0.195616
##     AveExpr         F     P.Value adj.P.Val
##   <numeric> <numeric>   <numeric> <numeric>
## 1   8.69458   16.0946 1.90868e-05 0.0853298
## 2  11.88811   16.0433 1.94982e-05 0.0853298
## 3   9.67181   15.7793 2.17777e-05 0.0853298
```

## 4.1 Sample filtering

Due to variation in cell and read count for each sample, `processAssays()` filters out some sample. This filtering is summarized here:

```
details(res.dl)
```

```
##               assay n_retain    formula formDropsTerms n_genes n_errors
## 1           B cells       16 ~TimePoint          FALSE    1961        0
## 2   CD14+ Monocytes       16 ~TimePoint          FALSE    3087        0
## 3       CD4 T cells       16 ~TimePoint          FALSE    5262        0
## 4       CD8 T cells       16 ~TimePoint          FALSE    1030        0
## 5   Dendritic cells       13 ~TimePoint          FALSE     164        0
## 6 FCGR3A+ Monocytes       16 ~TimePoint          FALSE    1160        0
## 7    Megakaryocytes       13 ~TimePoint          FALSE     172        0
## 8          NK cells       16 ~TimePoint          FALSE    1656        0
##   error_initial
## 1         FALSE
## 2         FALSE
## 3         FALSE
## 4         FALSE
## 5         FALSE
## 6         FALSE
## 7         FALSE
## 8         FALSE
```

Whle all 16 samples are detained in B cells, only 9 are retained for megakaryocytes. This can result in a time point being dropped, and so the polynomial expansion for some cell types can have a lower degree. The combined results will then have `NA` values for these coefficients. For example, for `TIMP1` in `Megakaryocytes` above there is not enought data to fit the cubic term, so `TimePoint.C` is `NA`.

# 5 Session Info

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
##  [1] GO.db_3.22.0                org.Hs.eg.db_3.22.0
##  [3] AnnotationDbi_1.72.0        zenith_1.12.0
##  [5] muscData_1.23.0             scater_1.38.0
##  [7] scuttle_1.20.0              ExperimentHub_3.0.0
##  [9] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [11] dbplyr_2.5.1                muscat_1.24.0
## [13] dreamlet_1.8.0              SingleCellExperiment_1.32.0
## [15] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [17] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [19] IRanges_2.44.0              S4Vectors_0.48.0
## [21] BiocGenerics_0.56.0         generics_0.1.4
## [23] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [25] variancePartition_1.40.0    BiocParallel_1.44.0
## [27] limma_3.66.0                ggplot2_4.0.0
## [29] BiocStyle_2.38.0
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
##  [29] mixsqp_0.3-54             dichromat_2.0-0.1
##  [31] parallelly_1.45.1         invgamma_1.2
##  [33] RSQLite_2.4.3             shape_1.4.6.1
##  [35] gtools_3.9.5              dplyr_1.1.4
##  [37] Matrix_1.7-4              metadat_1.4-0
##  [39] ggbeeswarm_0.7.2          abind_1.4-8
##  [41] lifecycle_1.0.4           multcomp_1.4-29
##  [43] yaml_2.3.10               edgeR_4.8.0
##  [45] mathjaxr_1.8-0            gplots_3.2.0
##  [47] SparseArray_1.10.0        grid_4.5.1
##  [49] blob_1.2.4                crayon_1.5.3
##  [51] lattice_0.22-7            beachmat_2.26.0
##  [53] msigdbr_25.1.1            annotate_1.88.0
##  [55] KEGGREST_1.50.0           magick_2.9.0
##  [57] pillar_1.11.1             knitr_1.50
##  [59] ComplexHeatmap_2.26.0     rjson_0.2.23
##  [61] boot_1.3-32               estimability_1.5.1
##  [63] corpcor_1.6.10            future.apply_1.20.0
##  [65] codetools_0.2-20          glue_1.8.0
##  [67] data.table_1.17.8         vctrs_0.6.5
##  [69] png_0.1-8                 Rdpack_2.6.4
##  [71] gtable_0.3.6              assertthat_0.2.1
##  [73] cachem_1.1.0              zigg_0.0.2
##  [75] xfun_0.53                 rbibutils_2.3
##  [77] S4Arrays_1.10.0           Rfast_2.1.5.2
##  [79] coda_0.19-4.1             reformulas_0.4.2
##  [81] survival_3.8-3            iterators_1.0.14
##  [83] tinytex_0.57              statmod_1.5.1
##  [85] TH.data_1.1-4             nlme_3.1-168
##  [87] pbkrtest_0.5.5            bit64_4.6.0-1
##  [89] filelock_1.0.3            progress_1.2.3
##  [91] EnvStats_3.1.0            bslib_0.9.0
##  [93] TMB_1.9.18                irlba_2.3.5.1
##  [95] vipor_0.4.7               KernSmooth_2.23-26
##  [97] colorspace_2.1-2          rmeta_3.0
##  [99] DBI_1.2.3                 DESeq2_1.50.0
## [101] tidyselect_1.2.1          emmeans_2.0.0
## [103] bit_4.6.0                 compiler_4.5.1
## [105] curl_7.0.0                httr2_1.2.1
## [107] graph_1.88.0              BiocNeighbors_2.4.0
## [109] DelayedArray_0.36.0       bookdown_0.45
## [111] scales_1.4.0              caTools_1.18.3
## [113] remaCor_0.0.20            rappdirs_0.3.3
## [115] stringr_1.5.2             digest_0.6.37
## [117] minqa_1.2.8               rmarkdown_2.30
## [119] aod_1.3.3                 XVector_0.50.0
## [121] RhpcBLASctl_0.23-42       htmltools_0.5.8.1
## [123] pkgconfig_2.0.3           lme4_1.1-37
## [125] sparseMatrixStats_1.22.0  lpsymphony_1.38.0
## [127] mashr_0.2.79              fastmap_1.2.0
## [129] rlang_1.1.6               GlobalOptions_0.1.2
## [131] DelayedMatrixStats_1.32.0 farver_2.1.2
## [133] jquerylib_0.1.4           IHW_1.38.0
## [135] zoo_1.8-14                jsonlite_2.0.0
## [137] BiocSingular_1.26.0       RCurl_1.98-1.17
## [139] magrittr_2.0.4            Rcpp_1.1.0
## [141] viridis_0.6.5             babelgene_22.9
## [143] EnrichmentBrowser_2.40.0  stringi_1.8.7
## [145] MASS_7.3-65               plyr_1.8.9
## [147] listenv_0.9.1             parallel_4.5.1
## [149] ggrepel_0.9.6             Biostrings_2.78.0
## [151] splines_4.5.1             hms_1.1.4
## [153] circlize_0.4.16           locfit_1.5-9.12
## [155] reshape2_1.4.4            ScaledMatrix_1.18.0
## [157] BiocVersion_3.22.0        XML_3.99-0.19
## [159] evaluate_1.0.5            RcppParallel_5.1.11-1
## [161] BiocManager_1.30.26       nloptr_2.2.1
## [163] foreach_1.5.2             tidyr_1.3.1
## [165] purrr_1.1.0               future_1.67.0
## [167] clue_0.3-66               scattermore_1.2
## [169] ashr_2.2-63               rsvd_1.0.5
## [171] broom_1.0.10              xtable_1.8-4
## [173] fANCOVA_0.6-1             viridisLite_0.4.2
## [175] truncnorm_1.0-9           tibble_3.3.0
## [177] lmerTest_3.1-3            glmmTMB_1.1.13
## [179] memoise_2.0.1             beeswarm_0.4.0
## [181] cluster_2.1.8.1           globals_0.18.0
## [183] GSEABase_1.72.0
```