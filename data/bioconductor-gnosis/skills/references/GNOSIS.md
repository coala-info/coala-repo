# 1 Introduction

Exploratory, statistical and survival analysis of cancer genomic data is
extremely important and can lead to new discoveries, such as the identification
of novel genomic prognostic markers, that have the potential to advance our
understanding of cancer and ultimately benefit patients. These analyses are
often performed on data available from a number of consortia websites, such as
cBio Cancer Genomics Portal (cBioPortal), which is one of the best known and
commonly used consolidated curations that hosts data from large consortium
efforts. While cBioPortal provides both graphical user interface (GUI)-based and
representational state transfer mediated means for researchers to explore and
analyse clinical and genomics data, its capabilities have their limitations and
oftentimes, to explore specific hypotheses, users need to perform a more
sophisticated ‘off site’ analysis that typically requires users to have some
prior programming experience.

To overcome these limitations and provide a GUI that facilitates the
visualisation and interrogation of cancer genomics data, particularly
cBioPortal-hosted data, using standard biostatistical methodologies, we
developed an R Shiny app called GeNomics explOrer using StatistIcal and Survival
analysis in R (GNOSIS). GNOSIS was initially developed as part of our study,
using the METABRIC data, to investigate whether survival outcomes are associated
with genomic instability in luminal breast cancers and was further developed to
enable the exploration, analysis and incorporation of a diverse range of genomic
features with clinical data in a research or clinical setting.

GNOSIS leverages a number of R packages and provides an intuitive GUI with
multiple tab panels supporting a range of functionalities, including data upload
and initial exploration, data recoding and subsetting, data visualisations,
statistical analysis, mutation analysis and, in particular, survival analysis
to identify prognostic markers. In addition, GNOSIS also helps researchers carry
out reproducible research by providing downloadable input logs (Shiny\_Log.txt)
from each session.

GNOSIS has been submitted to Bioconductor to aid researchers in carrying out a
reproducable, comprehensive statistical and survival analysis using data
obtained from cBioPortal, or otherwise.

# 2 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("GNOSIS")
```

# 3 Loading the package

```
library(GNOSIS)
```

# 4 Launching GNOSIS

```
GNOSIS()
```

# 5 GNOSIS layout

The GNOSIS GUI has 4 main elements:
(1) A sidebar where each analysis tab can be selected, the Exploratory Tables tab
is selected and displayed.
(2) Tab panels within each tab, allowing multiple operations to be carried out
and viewed in the one tab.
(3) A box sidebar allowing users to select inputs, alter arguments and customise
and export visualisations.
(4) Main viewing panel displaying output.

![](data:image/png;base64...)

# 6 Data upload and preview

Users can upload their own clinical, CNA or mutation data stored on their local
machine, or select a cBioPortal study to upload:

![](data:image/png;base64...)

![](data:image/png;base64...)

A preview of the uploaded/selected data is provided in the GNOSIS viewing panel
to ensure that the data has been read in correctly:

![](data:image/png;base64...)

![](data:image/png;base64...)

![](data:image/png;base64...)

In the case where a cBioPortal study does not contain CNA and/or MAF data, a
warning will be produced alerting users to this.

In addition, users can select specific columns of each dataframe to inspect:

![](data:image/png;base64...)

# 7 Data reformatting and filtering

To prepare the data for downstream analysis a number a things can be done.
Firstly users can change the type of variables to numeric or factors using the
box sidebar, which contains a space to select relevant variables:

![](data:image/png;base64...)

Subsequently, users can subset the data based on up to three categorical
variables and carry out survival variable recoding.

Here we filter the data to only include patients who received chemotherapy:

![](data:image/png;base64...)

We also recode the overall and disease-specific survival to 0/1:

![](data:image/png;base64...)

In cases where CNA data is uploaded, users may produce and segment CNA metrics
for each patient, as well as select and extract specific genes for further
analysis:

![](data:image/png;base64...)

# 8 Data visualisation

Users can produce a range of visualisations including boxplots, scatterplots,
barplots, histograms and density plots.

Here is an example of a customisable boxplot, that can also be downloaded:

![](data:image/png;base64...)

# 9 Statistical and survival analysis

The primary function offered by GNOSIS is statistically robust survival analysis.
GNOSIS contains several step-wise tabs to provide a complete survival analysis
of the data under investigation.

Users can produce KM survival curves and the corresponding logrank tests to
identify survival-associated categorical variables, both visually and
statistically.

![](data:image/png;base64...)

![](data:image/png;base64...)

Users can perform a selection of association tests to identify variables that
are associated with each other. This enables users to identify potential
confounding variables in the analysis.

Statistical association tests available include the Chi-squared test, Fisher’s
exact test, simulated Fisher’s exact test, ANOVA, Kruskal-Wallis test,
pairwise t-test and Dunn’s test.

![](data:image/png;base64...)

Users can produce both univariate and multivariable Cox models to identify
survival-associated variables, and test the assumptions of these models using
graphical diagnostics based on the scaled Schoenfeld residuals:

![](data:image/png;base64...)

![](data:image/png;base64...)

![](data:image/png;base64...)

The corresponding adjusted survival curves, survival curves adjusted for the
covariates in the multivariable Cox model, can also be produced and customised:

![](data:image/png;base64...)

In the case where the PH assumption of the multivariable Cox model is violated,
users can apply recursive partitioning survival trees:

![](data:image/png;base64...)

# 10 Mutation Analysis

An additional function of GNOSIS is the ability to summarise, analyse and
visualise mutation annotation format (MAF) files using maftools.

![](data:image/png;base64...)

![](data:image/png;base64...)

![](data:image/png;base64...)

# 11 Input Log

GNOSIS facilitates reproducible research by allowing users to download an input
log containing information on all the inputs selected throughout the session:

![](data:image/png;base64...)

# 12 Additional Resources

For details on the implementation, layout and application of GNOSIS see the
corresponding [publication](https://hrbopenresearch.org/articles/5-8).
Demonstration videos providing a walkthrough of GNOSIS are also provided on
[Zenodo](https://zenodo.org/record/5788659).

# 13 Session Info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] GNOSIS_1.8.0             maftools_2.26.0          operator.tools_1.6.3
##  [4] lubridate_1.9.4          forcats_1.0.1            stringr_1.5.2
##  [7] dplyr_1.1.4              purrr_1.1.0              readr_2.1.5
## [10] tidyr_1.3.1              tibble_3.3.0             ggplot2_4.0.0
## [13] tidyverse_2.0.0          shinymeta_0.2.1          shinyWidgets_0.9.0
## [16] dashboardthemes_1.1.6    shinydashboardPlus_2.0.6 shinydashboard_0.7.3
## [19] shiny_1.11.1             BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] IRanges_2.44.0              dichromat_2.0-0.1
##   [3] RcppCCTZ_0.2.13             gld_2.6.8
##   [5] nnet_7.3-20                 TCGAutils_1.30.0
##   [7] DT_0.34.0                   Biostrings_2.78.0
##   [9] vctrs_0.6.5                 kSamples_1.2-12
##  [11] partykit_1.2-24             digest_0.6.37
##  [13] png_0.1-8                   shape_1.4.6.1
##  [15] proxy_0.4-27                Exact_3.3
##  [17] BiocBaseUtils_1.12.0        parallelly_1.45.1
##  [19] MASS_7.3-65                 fontLiberation_0.1.0
##  [21] reshape2_1.4.4              rmdformats_1.0.4
##  [23] httpuv_1.6.16               foreach_1.5.2
##  [25] BiocGenerics_0.56.0         withr_3.0.2
##  [27] xfun_0.53                   ggpubr_0.6.2
##  [29] survival_3.8-3              BWStest_0.2.3
##  [31] memoise_2.0.1               Seqinfo_1.0.0
##  [33] gmp_0.7-5                   systemfonts_1.3.1
##  [35] AnVIL_1.22.0                zoo_1.8-14
##  [37] ragg_1.5.0                  DNAcopy_1.84.0
##  [39] Formula_1.2-5               RTCGAToolbox_2.40.0
##  [41] KEGGREST_1.50.0             promises_1.4.0
##  [43] otel_0.2.0                  httr_1.4.7
##  [45] rstatix_0.7.3               restfulr_0.0.16
##  [47] globals_0.18.0              ps_1.9.1
##  [49] rstudioapi_0.17.1           nanotime_0.3.12
##  [51] pan_1.9                     UCSC.utils_1.6.0
##  [53] miniUI_0.1.2                generics_0.1.4
##  [55] processx_3.8.6              inum_1.0-5
##  [57] SuppDists_1.1-9.9           curl_7.0.0
##  [59] S4Vectors_0.48.0            SparseArray_1.10.0
##  [61] xtable_1.8-4                evaluate_1.0.5
##  [63] S4Arrays_1.10.0             BiocFileCache_3.0.0
##  [65] hms_1.1.4                   glmnet_4.1-10
##  [67] GenomicRanges_1.62.0        GCPtools_1.0.0
##  [69] bookdown_0.45               filelock_1.0.3
##  [71] readxl_1.4.5                magrittr_2.0.4
##  [73] later_1.4.4                 lattice_0.22-7
##  [75] future.apply_1.20.0         XML_3.99-0.19
##  [77] matrixStats_1.5.0           class_7.3-23
##  [79] pillar_1.11.1               nlme_3.1-168
##  [81] iterators_1.0.14            compiler_4.5.1
##  [83] stringi_1.8.7               shinycssloaders_1.1.0
##  [85] DescTools_0.99.60           jomo_2.7-6
##  [87] minqa_1.2.8                 SummarizedExperiment_1.40.0
##  [89] GenomicAlignments_1.46.0    plyr_1.8.9
##  [91] crayon_1.5.3                abind_1.4-8
##  [93] BiocIO_1.20.0               truncnorm_1.0-9
##  [95] chron_2.3-62                haven_2.5.5
##  [97] bit_4.6.0                   rootSolve_1.8.2.4
##  [99] chromote_0.5.1              libcoin_1.0-10
## [101] GenomicDataCommons_1.34.0   codetools_0.2-20
## [103] textshaping_1.0.4           openssl_2.3.4
## [105] flextable_0.9.10            AnVILBase_1.4.0
## [107] bslib_0.9.0                 e1071_1.7-16
## [109] lmom_3.2                    mime_0.13
## [111] MultiAssayExperiment_1.36.0 RaggedExperiment_1.34.0
## [113] anytime_0.3.12              splines_4.5.1
## [115] Rcpp_1.1.0                  dbplyr_2.5.1
## [117] cellranger_1.1.0            knitr_1.50
## [119] blob_1.2.4                  lme4_1.1-37
## [121] RJSONIO_2.0.0               fs_1.6.6
## [123] listenv_0.9.1               Rdpack_2.6.4
## [125] expm_1.0-0                  ggsignif_0.6.4
## [127] Matrix_1.7-4                tzdb_0.5.0
## [129] svglite_2.2.2               pkgconfig_2.0.3
## [131] tools_4.5.1                 cachem_1.1.0
## [133] fabricatr_1.0.2             rbibutils_2.3
## [135] cigarillo_1.0.0             RSQLite_2.4.3
## [137] viridisLite_0.4.2           rvest_1.0.5
## [139] DBI_1.2.3                   numDeriv_2016.8-1.1
## [141] fastmap_1.2.0               rmarkdown_2.30
## [143] scales_1.4.0                grid_4.5.1
## [145] rapiclient_0.1.8            Rsamtools_2.26.0
## [147] broom_1.0.10                sass_0.4.10
## [149] officer_0.7.0               BiocManager_1.30.26
## [151] carData_3.0-5               rpart_4.1.24
## [153] fontawesome_0.5.3           farver_2.1.2
## [155] reformulas_0.4.2            survminer_0.5.1
## [157] yaml_2.3.10                 MatrixGenerics_1.22.0
## [159] rtracklayer_1.70.0          cli_3.6.5
## [161] writexl_1.5.4               stats4_4.5.1
## [163] PMCMRplus_1.9.12            lifecycle_1.0.4
## [165] askpass_1.2.1               Biobase_2.70.0
## [167] mvtnorm_1.3-3               lambda.r_1.2.4
## [169] backports_1.5.0             BiocParallel_1.44.0
## [171] timechange_0.3.0            gtable_0.3.6
## [173] rjson_0.2.23                shinylogs_0.2.1
## [175] parallel_4.5.1              jsonlite_2.0.0
## [177] mitml_0.4-5                 bitops_1.0-9
## [179] kableExtra_1.4.0            multcompView_0.1-10
## [181] bit64_4.6.0-1               zip_2.3.3
## [183] futile.options_1.0.1        mice_3.18.0
## [185] jquerylib_0.1.4             survMisc_0.5.6
## [187] shinyjs_2.1.0               htmltools_0.5.8.1
## [189] KMsurv_0.1-6                rappdirs_0.3.3
## [191] formatR_1.14                glue_1.8.0
## [193] compareGroups_4.10.1        httr2_1.2.1
## [195] XVector_0.50.0              gdtools_0.4.4
## [197] RCurl_1.98-1.17             gridExtra_2.3
## [199] Rsolnp_2.0.1                futile.logger_1.4.3
## [201] boot_1.3-32                 R6_2.6.1
## [203] km.ci_0.5-6                 Rmpfr_1.1-2
## [205] GenomicFeatures_1.62.0      GenomeInfoDb_1.46.0
## [207] sourcetools_0.1.7-1         nloptr_2.2.1
## [209] DelayedArray_0.36.0         tidyselect_1.2.1
## [211] xml2_1.4.1                  fontBitstreamVera_0.1.1
## [213] car_3.1-3                   AnnotationDbi_1.72.0
## [215] future_1.67.0               S7_0.2.0
## [217] fontquiver_0.2.1            cBioPortalData_2.22.0
## [219] data.table_1.17.8           websocket_1.4.4
## [221] htmlwidgets_1.6.4           RColorBrewer_1.1-3
## [223] rlang_1.1.6                 uuid_1.2-1
## [225] HardyWeinberg_1.7.9
```