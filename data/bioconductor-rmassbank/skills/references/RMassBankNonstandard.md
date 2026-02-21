# RMassBank: Non-standard usage

Michael Stravs

#### 30 October 2025

# 1 Introduction

```
##
## Attaching package: 'gplots'
```

```
## The following object is masked from 'package:stats':
##
##     lowess
```

This vignette assumes you are familiar with the standard usage of
*RMassBank*, which is documented in

```
vignette("RMassBank")
```

# 2 Skipping recalibration

For instances where recalibration is not wanted, e.g. there is
not enough data, or the user wants to use non-recalibrated
data, recalibration can be deactivated. To do this, the `recalibrator`
entry in the settings must be set to `recalibrate.identity`. This can be
done in the settings file directly (preferred):

```
recalibrator:
    MS1: recalibrate.identity
    MS2: recalibrate.identity
```

Or, alternatively, the settings can be adapted directly via R code.

```
RmbDefaultSettings()
rmbo <- getOption("RMassBank")
rmbo$recalibrator <- list(
        "MS1" = "recalibrate.identity",
        "MS2" = "recalibrate.identity"
    )
options("RMassBank" = rmbo)
```

To show the results of using a non-recalibrated workflow, we load a workspace
with pre-processed data:

```
w <- loadMsmsWorkspace(system.file("results/pH_narcotics_RF.RData",
                package="RMassBankData"))
```

```
## Warning in .updateObject.RmbWorkspace.1to2(w, ..., verbose): You are
## loading an archive from an old RMassBank version. The aggregate tables
## are not loaded from the original object, but recomputed.
```

```
## Warning in .updateObject.RmbWorkspace.1to2(w, ..., verbose): If you
## hand-edited any aggregate table, the information might not be retained in
## the new object.
```

```
## Warning in .updateObject.RmbWorkspace.1to2(w, ..., verbose): You are
## loading an archive from an old RMassBank version. The aggregate tables
## are not loaded from the original object, but recomputed.
```

```
## Warning in .updateObject.RmbWorkspace.1to2(w, ..., verbose): If you
## hand-edited any aggregate table, the information might not be retained in
## the new object.
```

```
## Warning in .updateObject.RmbWorkspace.1to2(w, ..., verbose): You are
## loading an archive from an old RMassBank version. The multiplicity
## filtering results are not loaded from the original object, but
## recomputed.
```

```
## Warning in .updateObject.RmbWorkspace.1to2(w, ..., verbose): If you
## hand-edited any multiplicity filtering results, the information might not
## be retained in the new object.
```

The recalibration curve:

```
recal <- makeRecalibration(w@parent,
                recalibrateBy = rmbo$recalibrateBy,
                recalibrateMS1 = rmbo$recalibrateMS1,
                recalibrator = list(MS1="recalibrate.loess",MS2="recalibrate.loess"),
                recalibrateMS1Window = 15)
```

![](data:image/png;base64...)

```
w@rc <- recal$rc
w@rc.ms1 <- recal$rc.ms1
w@parent <- w
plotRecalibration(w)
```

![](data:image/png;base64...)

Some example peaks to show the effect of recalibration:

```
w@spectra[[1]]@parent@mz[30:32]
```

```
## [1] 133.0346 133.0381 133.9772
```

```
w@spectra[[1]]@children[[1]]@mz[15:17]
```

```
## [1] 87.00286 88.13592 97.10767
```

Now reprocess the recalibration step with the
above set `recalibration.identity`:

```
w <- msmsWorkflow(w, steps=4)
```

![](data:image/png;base64...)

The recalibration graph shows that the recalibration “curve” will do no
recalibration. To verify, we can show the same peaks as before:

```
w@spectra[[1]]@parent@mz[30:32]
```

```
## [1] 133.0346 133.0381 133.9772
```

```
w@spectra[[1]]@children[[1]]@mz[15:17]
```

```
## [1] 87.00286 88.13592 97.10767
```

# 3 Combining multiplicities

Standard multiplicity filtering, which is configurable in the settings,
eliminates peaks which are observed only once for a compound. This eliminates
spurious formula matches for random noise efficiently. It works
well if either many spectra are recorded per compound, or if the same collision energy
is present twice (e.g. with different resolutions). It sometimes fails
for spectra on the “outer end” of the recorded collision energies when that
spectrum is only present once – peaks which appear only in the highest or only
in the lowest recorded energy can be erroneously deleted. To prevent this, one
can re-run the workflow, read a second set of spectra for every compound (the
second most intense) and combine the peak multiplicities of the two analyzed
runs. (Mutiplicity filtering can also be switched off completely.)

Example:

```
RmbDefaultSettings()
getOption("RMassBank")$multiplicityFilter
```

```
## [1] 2
```

```
# to make processing faster, we only use 3 spectra per compound
rmbo <- getOption("RMassBank")
rmbo$spectraList <- list(
    list(mode="CID", ces = "35%", ce = "35 % (nominal)", res = 7500),
    list(mode="HCD", ces = "15%", ce = "15 % (nominal)", res = 7500),
    list(mode="HCD", ces = "30%", ce = "30 % (nominal)", res = 7500)
)
options(RMassBank = rmbo)

loadList(system.file("list/NarcoticsDataset.csv",
        package="RMassBankData"))

w <- newMsmsWorkspace()
files <- list.files(system.file("spectra", package="RMassBankData"),
        ".mzML", full.names = TRUE)
w@files <- files[1:2]
```

First, the spectra are read and processed until reanalysis (step 7) normally:

```
w1 <- msmsWorkflow(w, mode="pH", steps=c(1))
# Here we artificially cut spectra out to make the workflow run faster for the vignette:
w1@spectra <- as(lapply(w1@spectra, function(s)
    {
        s@children <- s@children[1:3]
        s
    }),"SimpleList")
w1 <- msmsWorkflow(w1, mode="pH", steps=c(2:7))
```

![](data:image/png;base64...)

Subsequently, we re-read and process the “confirmation spectra”, i.e. the
second-best spectra from the files. Therefore, we will have two sets of spectra
for each compound and every real peak should in theory occur twice.

```
w2 <- msmsWorkflow(w, mode="pH", steps=c(1), confirmMode = 1)
# Here we artificially cut spectra out to make the workflow run faster for the vignette:

w2@spectra <- as(lapply(w2@spectra, function(s)
    {
        s@children <- s@children[1:3]
        s
    }),"SimpleList")
w2 <- msmsWorkflow(w2, mode="pH", steps=c(2:7))
```

![](data:image/png;base64...)

Finally, we combine the two workspaces for multiplicity filtering, and apply the
last step in the workflow (multiplicity filtering).

```
wTotal <- combineMultiplicities(c(w1, w2))
wTotal <- msmsWorkflow(wTotal, steps=8, mode="pH", archivename = "output")
```

Subsequently, we can proceed as usual with `mbWorkflow`:

```
mb <- newMbWorkspace(wTotal)
# [...] load lists, execute workflow etc.
```

# 4 Session information

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
##  [1] LC_CTYPE=en_US.UTF-8          LC_NUMERIC=C
##  [3] LC_TIME=en_GB                 LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8       LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8          LC_NAME=en_US.UTF-8
##  [9] LC_ADDRESS=en_US.UTF-8        LC_TELEPHONE=en_US.UTF-8
## [11] LC_MEASUREMENT=en_US.UTF-8    LC_IDENTIFICATION=en_US.UTF-8
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] gplots_3.2.0         RMassBankData_1.47.0 RMassBank_3.20.0
## [4] Rcpp_1.1.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] MultiAssayExperiment_1.36.0 magrittr_2.0.4
##   [5] magick_2.9.0                farver_2.1.2
##   [7] MALDIquant_1.22.3           rmarkdown_2.30
##   [9] fs_1.6.6                    vctrs_0.6.5
##  [11] RCurl_1.98-1.17             base64enc_0.1-3
##  [13] tinytex_0.57                htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0             BiocBaseUtils_1.12.0
##  [17] itertools_0.1-3             curl_7.0.0
##  [19] SparseArray_1.10.0          mzID_1.48.0
##  [21] sass_0.4.10                 KernSmooth_2.23-26
##  [23] bslib_0.9.0                 htmlwidgets_1.6.4
##  [25] plyr_1.8.9                  httr2_1.2.1
##  [27] impute_1.84.0               cachem_1.1.0
##  [29] igraph_2.2.1                lifecycle_1.0.4
##  [31] iterators_1.0.14            pkgconfig_2.0.3
##  [33] Matrix_1.7-4                R6_2.6.1
##  [35] fastmap_1.2.0               MatrixGenerics_1.22.0
##  [37] clue_0.3-66                 digest_0.6.37
##  [39] pcaMethods_2.2.0            rsvg_2.7.0
##  [41] ps_1.9.1                    S4Vectors_0.48.0
##  [43] GenomicRanges_1.62.0        Spectra_1.20.0
##  [45] httr_1.4.7                  abind_1.4-8
##  [47] compiler_4.5.1              withr_3.0.2
##  [49] bit64_4.6.0-1               doParallel_1.0.17
##  [51] S7_0.2.0                    BiocParallel_1.44.0
##  [53] DBI_1.2.3                   logger_0.4.1
##  [55] fingerprint_3.5.7           R.utils_2.13.0
##  [57] MASS_7.3-65                 ChemmineR_3.62.0
##  [59] rappdirs_0.3.3              DelayedArray_0.36.0
##  [61] rjson_0.2.23                caTools_1.18.3
##  [63] gtools_3.9.5                mzR_2.44.0
##  [65] chromote_0.5.1              tools_4.5.1
##  [67] otel_0.2.0                  PSMatch_1.14.0
##  [69] R.oo_1.27.1                 webchem_1.3.1
##  [71] glue_1.8.0                  promises_1.4.0
##  [73] QFeatures_1.20.0            grid_4.5.1
##  [75] cluster_2.1.8.1             readJDX_0.6.4
##  [77] reshape2_1.4.4              generics_0.1.4
##  [79] gtable_0.3.6                rcdk_3.8.1
##  [81] tzdb_0.5.0                  R.methodsS3_1.8.2
##  [83] preprocessCore_1.72.0       websocket_1.4.4
##  [85] tidyr_1.3.1                 data.table_1.17.8
##  [87] hms_1.1.4                   MetaboCoreUtils_1.18.0
##  [89] xml2_1.4.1                  XVector_0.50.0
##  [91] BiocGenerics_0.56.0         foreach_1.5.2
##  [93] pillar_1.11.1               stringr_1.5.2
##  [95] vroom_1.6.6                 limma_3.66.0
##  [97] later_1.4.4                 rJava_1.0-11
##  [99] dplyr_1.1.4                 lattice_0.22-7
## [101] bit_4.6.0                   tidyselect_1.2.1
## [103] knitr_1.50                  gridExtra_2.3
## [105] bookdown_0.45               IRanges_2.44.0
## [107] Seqinfo_1.0.0               ProtGenerics_1.42.0
## [109] SummarizedExperiment_1.40.0 stats4_4.5.1
## [111] xfun_0.53                   Biobase_2.70.0
## [113] statmod_1.5.1               MSnbase_2.36.0
## [115] matrixStats_1.5.0           DT_0.34.0
## [117] stringi_1.8.7               lazyeval_0.2.2
## [119] yaml_2.3.10                 evaluate_1.0.5
## [121] codetools_0.2-20            data.tree_1.2.0
## [123] rcdklibs_2.9                archive_1.1.12
## [125] MsCoreUtils_1.22.0          tibble_3.3.0
## [127] BiocManager_1.30.26         cli_3.6.5
## [129] affyio_1.80.0               processx_3.8.6
## [131] jquerylib_0.1.4             dichromat_2.0-0.1
## [133] png_0.1-8                   XML_3.99-0.19
## [135] parallel_4.5.1              ggplot2_4.0.0
## [137] readr_2.1.5                 assertthat_0.2.1
## [139] AnnotationFilter_1.34.0     bitops_1.0-9
## [141] scales_1.4.0                affy_1.88.0
## [143] crayon_1.5.3                ncdf4_1.24
## [145] purrr_1.1.0                 rlang_1.1.6
## [147] vsn_3.78.0                  rvest_1.0.5
```