[[![](data:image/png;base64...)](http://bioconductor.org/packages/release/bioc/html/sesame.html)](index.html)

* [Basics](sesame.html)
* [QC](QC.html)
* [Non-human Array](nonhuman.html)
* [Modeling](modeling.html)
* [Inference](inferences.html)
* [KnowYourCG](https://bioconductor.org/packages/release/bioc/html/knowYourCG.html)
* [Supplemental](https://zhou-lab.github.io/sesame/dev/supplemental.html)

# Quality Control

#### 25 November 2025

```
library(sesame)
sesameDataCache()
```

# Calculate Quality Metrics

The main function to calculate the quality metrics is `sesameQC_calcStats`. This function takes a SigDF, calculates the QC statistics, and returns a single S4 `sesameQC` object, which can be printed directly to the console. To calculate QC metrics on a given list of samples or all IDATs in a folder, one can use `sesameQC_calcStats` within the standard `openSesame` pipeline. When used with `openSesame`, a list of `sesameQC`s will be returned. Note that one should turn off preprocessing using `prep=""`:

```
## calculate metrics on all IDATs in a specific folder
sesameQCtoDF(openSesame(idat_dir, prep="", func=sesameQC_calcStats))
## or a list of prefixes, with parallel processing
sesameQCtoDF(openSesame(sprintf("%s/%s", idat_dir, idat_prefixes), prep="",
    func=sesameQC_calcStats, BPPARAM=BiocParallel::MulticoreParam(24)))
```

The results display `frac_dt_cg`, `RGratio`, `RGdistort` by default. For other QC metrics, SeSAMe divides sample quality metrics into multiple groups. These groups are listed below and can be referred to by short keys. For example, “intensity” generates signal intensity-related quality metrics.

| Short.Key | Description |
| --- | --- |
| detection | Signal Detection |
| numProbes | Number of Probes |
| intensity | Signal Intensity |
| channel | Color Channel |
| dyeBias | Dye Bias |
| betas | Beta Value |

By default, `sesameQC_calcStats` calculates all QC groups. To save time, one can compute a specific QC group by specifying one or multiple short keys in the `funs=` argument:

```
sdfs <- sesameDataGet("EPIC.5.SigDF.normal")[1:2] # get two examples
## only compute signal detection stats
qcs = openSesame(sdfs, prep="", func=sesameQC_calcStats, funs="detection")
qcs[[1]]
```

```
##
## =====================
## | Detection
## =====================
## N. Probes w/ Missing Raw Intensity   : 0 (num_dtna)
## % Probes w/ Missing Raw Intensity    : 0.0 % (frac_dtna)
## N. Probes w/ Detection Success       : 838020 (num_dt)
## % Detection Success                  : 96.7 % (frac_dt)
## N. Detection Succ. (after masking)   : 838020 (num_dt_mk)
## % Detection Succ. (after masking)    : 96.7 % (frac_dt_mk)
## N. Probes w/ Detection Success (cg)  : 835491 (num_dt_cg)
## % Detection Success (cg)             : 96.7 % (frac_dt_cg)
## N. Probes w/ Detection Success (ch)  : 2471 (num_dt_ch)
## % Detection Success (ch)             : 84.3 % (frac_dt_ch)
## N. Probes w/ Detection Success (rs)  : 58 (num_dt_rs)
## % Detection Success (rs)             : 98.3 % (frac_dt_rs)
```

> We consider signal detection the most important QC metric.

One can retrieve the actual stat numbers from `sesameQC` using the sesameQC\_getStats (the following generates the fraction of probes with detection success):

```
sesameQC_getStats(qcs[[1]], "frac_dt")
```

```
## [1] 0.9666915
```

After computing the QCs, one can optionally combine the `sesameQC` objects into a data frame for easy comparison.

```
## combine a list of sesameQC into a data frame
head(do.call(rbind, lapply(qcs, as.data.frame)))
```

Note that when the input is an `SigDF` object, calling `sesameQC_calcStats` within `openSesame` and as a standalone function are equivalent.

```
sdf <- sesameDataGet('EPIC.1.SigDF')
qc = openSesame(sdf, prep="", func=sesameQC_calcStats, funs=c("detection"))
## equivalent direct call
qc = sesameQC_calcStats(sdf, c("detection"))
qc
```

```
##
## =====================
## | Detection
## =====================
## N. Probes w/ Missing Raw Intensity   : 0 (num_dtna)
## % Probes w/ Missing Raw Intensity    : 0.0 % (frac_dtna)
## N. Probes w/ Detection Success       : 834922 (num_dt)
## % Detection Success                  : 96.3 % (frac_dt)
## N. Detection Succ. (after masking)   : 834922 (num_dt_mk)
## % Detection Succ. (after masking)    : 96.3 % (frac_dt_mk)
## N. Probes w/ Detection Success (cg)  : 832046 (num_dt_cg)
## % Detection Success (cg)             : 96.4 % (frac_dt_cg)
## N. Probes w/ Detection Success (ch)  : 2616 (num_dt_ch)
## % Detection Success (ch)             : 89.2 % (frac_dt_ch)
## N. Probes w/ Detection Success (rs)  : 58 (num_dt_rs)
## % Detection Success (rs)             : 98.3 % (frac_dt_rs)
```

# Rank Quality Metrics

SeSAMe features comparison of your sample with public data sets. The `sesameQC_rankStats()` function ranks the input `sesameQC` object with `sesameQC` calculated from public datasets. It shows the rank percentage of the input sample as well as the number of datasets compared.

```
sdf <- sesameDataGet('EPIC.1.SigDF')
qc <- sesameQC_calcStats(sdf, "intensity")
qc
```

```
##
## =====================
## | Signal Intensity
## =====================
## Mean sig. intensity          : 3171.21 (mean_intensity)
## Mean sig. intensity (M+U)    : 6342.41 (mean_intensity_MU)
## Mean sig. intensity (Inf.II) : 2991.85 (mean_ii)
## Mean sig. intens.(I.Grn IB)  : 3004.33 (mean_inb_grn)
## Mean sig. intens.(I.Red IB)  : 4670.97 (mean_inb_red)
## Mean sig. intens.(I.Grn OOB) : 318.55 (mean_oob_grn)
## Mean sig. intens.(I.Red OOB) : 606.99 (mean_oob_red)
## N. NA in M (all probes)      : 0 (na_intensity_M)
## N. NA in U (all probes)      : 0 (na_intensity_U)
## N. NA in raw intensity (IG)  : 0 (na_intensity_ig)
## N. NA in raw intensity (IR)  : 0 (na_intensity_ir)
## N. NA in raw intensity (II)  : 0 (na_intensity_ii)
```

```
sesameQC_rankStats(qc, platform="EPIC")
```

```
##
## =====================
## | Signal Intensity
## =====================
## Mean sig. intensity          : 3171.21 (mean_intensity) - Rank 15.7% (N=636)
## Mean sig. intensity (M+U)    : 6342.41 (mean_intensity_MU)
## Mean sig. intensity (Inf.II) : 2991.85 (mean_ii) - Rank 15.6% (N=636)
## Mean sig. intens.(I.Grn IB)  : 3004.33 (mean_inb_grn) - Rank 7.5% (N=636)
## Mean sig. intens.(I.Red IB)  : 4670.97 (mean_inb_red) - Rank 21.2% (N=636)
## Mean sig. intens.(I.Grn OOB) : 318.55 (mean_oob_grn) - Rank 4.2% (N=636)
## Mean sig. intens.(I.Red OOB) : 606.99 (mean_oob_red) - Rank 3.6% (N=636)
## N. NA in M (all probes)      : 0 (na_intensity_M)
## N. NA in U (all probes)      : 0 (na_intensity_U)
## N. NA in raw intensity (IG)  : 0 (na_intensity_ig)
## N. NA in raw intensity (IR)  : 0 (na_intensity_ir)
## N. NA in raw intensity (II)  : 0 (na_intensity_ii)
```

# Quality Control Plots

SeSAMe provides functions to create QC plots. Some functions takes sesameQC as input while others directly plot the SigDF objects. Here are some examples:

* `sesameQC_plotBar()` takes a list of sesameQC objects and creates bar plot for each metric calculated.
* `sesameQC_plotRedGrnQQ()` graphs the dye bias between the two color channels.
* `sesameQC_plotIntensVsBetas()` plots the relationship between *β* values and signal intensity and can be used to diagnose artificial readout and influence of signal background.
* `sesameQC_plotHeatSNPs()` plots SNP probes and can be used to detect sample swaps.

More about quality control plots can be found in [Supplemental Vignette](https://zhou-lab.github.io/sesame/v1.16/supplemental.html#qc).

# Session Info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] knitr_1.50          sesame_1.28.1       sesameData_1.28.0
## [4] ExperimentHub_3.0.0 AnnotationHub_4.0.0 BiocFileCache_3.0.0
## [7] dbplyr_2.5.1        BiocGenerics_0.56.0 generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                blob_1.2.4
##  [5] filelock_1.0.3              Biostrings_2.78.0
##  [7] S7_0.2.1                    fastmap_1.2.0
##  [9] digest_0.6.39               lifecycle_1.0.4
## [11] KEGGREST_1.50.0             RSQLite_2.4.4
## [13] magrittr_2.0.4              compiler_4.5.2
## [15] rlang_1.1.6                 sass_0.4.10
## [17] tools_4.5.2                 yaml_2.3.10
## [19] S4Arrays_1.10.0             bit_4.6.0
## [21] curl_7.0.0                  DelayedArray_0.36.0
## [23] plyr_1.8.9                  RColorBrewer_1.1-3
## [25] abind_1.4-8                 BiocParallel_1.44.0
## [27] withr_3.0.2                 purrr_1.2.0
## [29] grid_4.5.2                  stats4_4.5.2
## [31] preprocessCore_1.72.0       wheatmap_0.2.0
## [33] colorspace_2.1-2            ggplot2_4.0.1
## [35] scales_1.4.0                dichromat_2.0-0.1
## [37] SummarizedExperiment_1.40.0 cli_3.6.5
## [39] rmarkdown_2.30              crayon_1.5.3
## [41] reshape2_1.4.5              httr_1.4.7
## [43] tzdb_0.5.0                  DBI_1.2.3
## [45] cachem_1.1.0                stringr_1.6.0
## [47] parallel_4.5.2              AnnotationDbi_1.72.0
## [49] BiocManager_1.30.27         XVector_0.50.0
## [51] matrixStats_1.5.0           vctrs_0.6.5
## [53] Matrix_1.7-4                jsonlite_2.0.0
## [55] IRanges_2.44.0              hms_1.1.4
## [57] S4Vectors_0.48.0            bit64_4.6.0-1
## [59] jquerylib_0.1.4             glue_1.8.0
## [61] codetools_0.2-20            stringi_1.8.7
## [63] gtable_0.3.6                BiocVersion_3.22.0
## [65] GenomicRanges_1.62.0        tibble_3.3.0
## [67] pillar_1.11.1               rappdirs_0.3.3
## [69] htmltools_0.5.8.1           Seqinfo_1.0.0
## [71] R6_2.6.1                    httr2_1.2.1
## [73] evaluate_1.0.5              Biobase_2.70.0
## [75] lattice_0.22-7              readr_2.1.6
## [77] png_0.1-8                   memoise_2.0.1
## [79] BiocStyle_2.38.0            bslib_0.9.0
## [81] Rcpp_1.1.0                  SparseArray_1.10.3
## [83] xfun_0.54                   MatrixGenerics_1.22.0
## [85] pkgconfig_2.0.3
```