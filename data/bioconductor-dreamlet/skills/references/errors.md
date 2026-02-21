# Error handling

#### Developed by [Gabriel Hoffman](http://gabrielhoffman.github.io/)

#### Run on 2025-10-29 23:47:59

`dreamlet()` evaluates precision-weighted linear (mixed) models on each gene that passes standard filters. The linear mixed model used by `dream()` can be a little fragile for small sample sizes and correlated covariates. `dreamlet()` runs `variancePartition::dream()` in the backend for each cell cluster. `dream()` reports model failures for each cell cluster and `dreamlet()` reports these failures to the user. `dreamlet()` returns all **successful** model fits to be used for downstream analysis.

See details from `variancePartition` [error page](https://diseaseneurogenomics.github.io/variancePartition/articles/errors.html).

# Errors with random effects

Due to a recent [bug](https://github.com/lme4/lme4/issues/763) in the dependency `Matrix` package, all random effects models may fail for technical reasons. If your random effects analysis is failing for all genes in cases with no good explanation, this bug may be responsible. This case can be detected and resolved as follows:

```
library(lme4)

# Fit simple mixed model
lmer(Reaction ~ (1 | Subject), sleepstudy)
# Error in initializePtr() :
#  function 'chm_factor_ldetL2' not provided by package 'Matrix'
```

This error indicates incompatible installs of `Matrix` and `lme4`. This can be solved with

```
install.packages("lme4", type = "source")
```

followed by **restarting** R.

# Errors at the assay- and gene-level

The most common issue is when `dreamlet()` analysis succeeds for most genes, but a handful of genes fail in each cell cluster. These genes can fail if the iterative process of fitting the linear mixed model does not converge, or if the estimated covariance matrix that is supposed be positive definite has an eigen-value that is negative or too close to zero due to rounding errors in floating point arithmetic.

In these cases, `dreamlet()` stores a summary of these failures for all cell clusters that is accessible with `details()`. Specific failure messages for each cell cluster and gene can be extracted using `seeErrors()`

Here we demonstrate how `dreamlet()` handles model failures:

```
library(dreamlet)
library(muscat)
library(SingleCellExperiment)

data(example_sce)

# create pseudobulk for each sample and cell cluster
pb <- aggregateToPseudoBulk(example_sce,
  assay = "counts",
  cluster_id = "cluster_id",
  sample_id = "sample_id",
  verbose = FALSE
)

# voom-style normalization for each cell cluster
res.proc <- processAssays(
  pb[1:300, ],
  ~group_id
)

# Redundant formula
# This example is an extreme example of redundancy
# but more subtle cases often show up in real data
form <- ~ group_id + (1 | group_id)

# fit dreamlet model
res.dl <- dreamlet(res.proc, form)
##  B cells...7.9 secs
##  CD14+ Monocytes...10 secs
##  CD4 T cells...9 secs
##  CD8 T cells...4.4 secs
##  FCGR3A+ Monocytes...11 secs
##
## Of 1,062 models fit across all assays, 96.2% failed

# summary of models
res.dl
## class: dreamletResult
## assays(5): B cells CD14+ Monocytes CD4 T cells CD8 T cells FCGR3A+ Monocytes
## Genes:
##  min: 3
##  max: 11
## details(7): assay n_retain ... n_errors error_initial
## coefNames(2): (Intercept) group_idstim
##
## Of 1,062 models fit across all assays, 96.2% failed

# summary of models for each cell cluster
details(res.dl)
##               assay n_retain                    formula formDropsTerms n_genes n_errors error_initial
## 1           B cells        4 ~group_id + (1 | group_id)          FALSE     201      190         FALSE
## 2   CD14+ Monocytes        4 ~group_id + (1 | group_id)          FALSE     269      263         FALSE
## 3       CD4 T cells        4 ~group_id + (1 | group_id)          FALSE     216      207         FALSE
## 4       CD8 T cells        4 ~group_id + (1 | group_id)          FALSE     118      115         FALSE
## 5 FCGR3A+ Monocytes        4 ~group_id + (1 | group_id)          FALSE     258      247         FALSE
```

* `assay`: cell type
* `n_retain`: number of samples retained
* `formula`: regression formula used after variable filtering
* `formDropsTerms`: whether a variable was dropped from the formula for having zero variance following filtering
* `n_genes`: number of genes analyzed
* `n_errors`: number of genes with errors
* `error_initial`: indicator for assay-level error

## Assay-level errors

Before the full dataset is analyzed, `dreamlet()` runs a test for each assay to see if the model succeeds. If the model fails, its does not continue analysis for that assay. These assay-level errors are reported above in the `error_initial` column, and details are returned here.

```
# Extract errors as a tibble
res.err = seeErrors(res.dl)
##   Assay-level errors: 0
##   Gene-level errors: 1038

# No errors at the assay level
res.err$assayLevel

# the most common error is:
"Some predictor variables are on very different scales: consider rescaling"
```

This indicates that the scale of the predictor variables are very different and can affect the numerical stability of the iterative algorithm. This can be solved by running `scale()` on each variable in the formula:

```
form = ~ scale(x) + scale(y) + ...
```

## Gene-level errors

A model can fail for a single gene if covariates are too correlated, or for other numerical issues. Failed models are reported here and are not included in downstream analysis.

```
# See gene-level errors for each assay
res.err$geneLevel[1:2,]
## # A tibble: 2 × 3
##   assay   feature  errorText
##   <chr>   <chr>    <chr>
## B cells ISG15    "Error in lmerTest:::as_lmerModLT(model, devfun, tol = tol):…
## B cells AURKAIP1 "Error in lmerTest:::as_lmerModLT(model, devfun, tol = tol):…

# See full error message text
res.err$geneLevel$errorText[1]
"Error in lmerTest:::as_lmerModLT(model, devfun, tol = tol): (converted from warning)
Model may not have converged with 1 eigenvalue close to zero: 1.4e-09\n"
```

This message indicates that the model was numerically unstable likely because the variables are closely correlated.

# Session Info

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