# scNMT Mouse Gastrulation

Marcel Ramos Pérez

#### 4 November 2025

#### Package

SingleCellMultiModal 1.22.0

# 1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SingleCellMultiModal")
```

## 1.1 Load packages

```
library(SingleCellMultiModal)
library(MultiAssayExperiment)
```

# 2 scNMT: single-cell nucleosome, methylation and transcription sequencing

The dataset was graciously provided by Argelaguet et al. ([2019](#ref-Argelaguet2019-et)).

Scripts used to process the raw data were written and maintained by Argelaguet
and colleagues and reside on GitHub:
<https://github.com/rargelaguet/scnmt_gastrulation>

For more information on the protocol, see Clark et al. ([2018](#ref-Clark2018-qg)).

## 2.1 Dataset lookup

The user can see the available datasets by using the `dry.run` argument:

```
scNMT("mouse_gastrulation", mode = "*", version = "1.0.0", dry.run = TRUE)
```

```
##     ah_id         mode file_size rdataclass rdatadateadded rdatadateremoved
## 1  EH3738      acc_cgi      7 Mb     matrix     2020-09-03             <NA>
## 2  EH3739     acc_CTCF    1.2 Mb     matrix     2020-09-03             <NA>
## 3  EH3740      acc_DHS    0.3 Mb     matrix     2020-09-03             <NA>
## 4  EH3741 acc_genebody   49.6 Mb     matrix     2020-09-03             <NA>
## 5  EH3742     acc_p300    0.2 Mb     matrix     2020-09-03             <NA>
## 6  EH3743 acc_promoter   27.2 Mb     matrix     2020-09-03             <NA>
## 7  EH3745      met_cgi    4.6 Mb     matrix     2020-09-03             <NA>
## 8  EH3746     met_CTCF    0.1 Mb     matrix     2020-09-03             <NA>
## 9  EH3747      met_DHS    0.1 Mb     matrix     2020-09-03             <NA>
## 10 EH3748 met_genebody   26.8 Mb     matrix     2020-09-03             <NA>
## 11 EH3749     met_p300    0.1 Mb     matrix     2020-09-03             <NA>
## 12 EH3750 met_promoter   11.5 Mb     matrix     2020-09-03             <NA>
## 13 EH3751          rna   18.6 Mb     matrix     2020-09-03             <NA>
```

Or by simply running the `scNMT` function with defaults:

```
scNMT("mouse_gastrulation", version = "1.0.0")
```

```
##     ah_id         mode file_size rdataclass rdatadateadded rdatadateremoved
## 1  EH3738      acc_cgi      7 Mb     matrix     2020-09-03             <NA>
## 2  EH3739     acc_CTCF    1.2 Mb     matrix     2020-09-03             <NA>
## 3  EH3740      acc_DHS    0.3 Mb     matrix     2020-09-03             <NA>
## 4  EH3741 acc_genebody   49.6 Mb     matrix     2020-09-03             <NA>
## 5  EH3742     acc_p300    0.2 Mb     matrix     2020-09-03             <NA>
## 6  EH3743 acc_promoter   27.2 Mb     matrix     2020-09-03             <NA>
## 7  EH3745      met_cgi    4.6 Mb     matrix     2020-09-03             <NA>
## 8  EH3746     met_CTCF    0.1 Mb     matrix     2020-09-03             <NA>
## 9  EH3747      met_DHS    0.1 Mb     matrix     2020-09-03             <NA>
## 10 EH3748 met_genebody   26.8 Mb     matrix     2020-09-03             <NA>
## 11 EH3749     met_p300    0.1 Mb     matrix     2020-09-03             <NA>
## 12 EH3750 met_promoter   11.5 Mb     matrix     2020-09-03             <NA>
## 13 EH3751          rna   18.6 Mb     matrix     2020-09-03             <NA>
```

## 2.2 Data versions

A more recent release of the ‘mouse\_gastrulation’ dataset was provided
by Argelaguet and colleagues. This dataset includes additional cells that
did not pass the original quality metrics as imposed for the version `1.0.0`
dataset.

Use the `version` argument to indicate the newer dataset version
(i.e., `2.0.0`):

```
scNMT("mouse_gastrulation", version = '2.0.0', dry.run = TRUE)
```

```
##     ah_id         mode file_size rdataclass rdatadateadded rdatadateremoved
## 1  EH3753      acc_cgi   21.1 Mb     matrix     2020-09-03             <NA>
## 2  EH3754     acc_CTCF    1.2 Mb     matrix     2020-09-03             <NA>
## 3  EH3755      acc_DHS   16.2 Mb     matrix     2020-09-03             <NA>
## 4  EH3756 acc_genebody   60.1 Mb     matrix     2020-09-03             <NA>
## 5  EH3757     acc_p300    0.2 Mb     matrix     2020-09-03             <NA>
## 6  EH3758 acc_promoter   33.8 Mb     matrix     2020-09-03             <NA>
## 7  EH3760      met_cgi   12.1 Mb     matrix     2020-09-03             <NA>
## 8  EH3761     met_CTCF    0.1 Mb     matrix     2020-09-03             <NA>
## 9  EH3762      met_DHS    3.9 Mb     matrix     2020-09-03             <NA>
## 10 EH3763 met_genebody   33.9 Mb     matrix     2020-09-03             <NA>
## 11 EH3764     met_p300    0.1 Mb     matrix     2020-09-03             <NA>
## 12 EH3765 met_promoter   18.7 Mb     matrix     2020-09-03             <NA>
## 13 EH3766          rna   43.5 Mb     matrix     2020-09-03             <NA>
```

## 2.3 Downloading the data

To obtain the data, we can use the `mode` argument to indicate specific
datasets using ‘glob’ patterns that will match the outputs above. For example,
if we would like to have all ‘genebody’ datasets for all available assays,
we would use `*_genebody` as an input to `mode`.

```
nmt <- scNMT("mouse_gastrulation", mode = c("*_DHS", "*_cgi", "*_genebody"),
    version = "1.0.0", dry.run = FALSE)
```

```
## Warning: sampleMap[['assay']] coerced with as.factor()
```

```
nmt
```

```
## A MultiAssayExperiment object of 6 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 6:
##  [1] acc_DHS: matrix with 290 rows and 826 columns
##  [2] met_DHS: matrix with 66 rows and 826 columns
##  [3] acc_cgi: matrix with 4459 rows and 826 columns
##  [4] met_cgi: matrix with 5536 rows and 826 columns
##  [5] acc_genebody: matrix with 17139 rows and 826 columns
##  [6] met_genebody: matrix with 15837 rows and 826 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

## 2.4 Checking the cell metadata

Included in the `colData` `DataFrame` within the `MultiAssayExperiment` class
are the variables `cellID`, `stage`, `lineage10x_2`, and `stage_lineage`.
To extract this `DataFrame`, one has to use `colData` on the
`MultiAssayExperiment` object:

```
colData(nmt)
```

```
## DataFrame with 826 rows and 4 columns
##                            cellID       stage     lineage10x_2
##                       <character> <character>      <character>
## E7.5_Plate1_A3     E7.5_Plate1_A3        E7.5         Endoderm
## E7.5_Plate1_H3     E7.5_Plate1_H3        E7.5         Endoderm
## E7.5_Plate1_D2     E7.5_Plate1_D2        E7.5         Endoderm
## E7.5_Plate1_D7     E7.5_Plate1_D7        E7.5         Endoderm
## E7.5_Plate1_F5     E7.5_Plate1_F5        E7.5         Endoderm
## ...                           ...         ...              ...
## PS_VE_Plate9_C11 PS_VE_Plate9_C11        E6.5         Epiblast
## PS_VE_Plate9_E11 PS_VE_Plate9_E11        E6.5         Epiblast
## PS_VE_Plate9_D11 PS_VE_Plate9_D11        E6.5 Primitive_Streak
## PS_VE_Plate9_A11 PS_VE_Plate9_A11        E6.5 Primitive_Streak
## PS_VE_Plate9_B11 PS_VE_Plate9_B11        E6.5         Mesoderm
##                          stage_lineage
##                            <character>
## E7.5_Plate1_A3           E7.5_Endoderm
## E7.5_Plate1_H3           E7.5_Endoderm
## E7.5_Plate1_D2           E7.5_Endoderm
## E7.5_Plate1_D7           E7.5_Endoderm
## E7.5_Plate1_F5           E7.5_Endoderm
## ...                                ...
## PS_VE_Plate9_C11         E6.5_Epiblast
## PS_VE_Plate9_E11         E6.5_Epiblast
## PS_VE_Plate9_D11 E6.5_Primitive_Streak
## PS_VE_Plate9_A11 E6.5_Primitive_Streak
## PS_VE_Plate9_B11         E6.5_Mesoderm
```

## 2.5 Exploring the data structure

Check row annotations:

```
rownames(nmt)
```

```
## CharacterList of length 6
## [["acc_DHS"]] ESC_DHS_118970 ESC_DHS_118919 ... ESC_DHS_68996 ESC_DHS_109494
## [["met_DHS"]] ESC_DHS_20778 ESC_DHS_14504 ... ESC_DHS_72133 ESC_DHS_72129
## [["acc_cgi"]] CGI_5278 CGI_6058 CGI_10627 ... CGI_7832 CGI_11329 CGI_10964
## [["met_cgi"]] CGI_3481 CGI_8941 CGI_956 CGI_9461 ... CGI_2867 CGI_3499 CGI_365
## [["acc_genebody"]] ENSMUSG00000036181 ENSMUSG00000071862 ... ENSMUSG00000025576
## [["met_genebody"]] ENSMUSG00000059334 ENSMUSG00000024026 ... ENSMUSG00000078302
```

The `sampleMap` is a graph representation of the relationships between cells
and ‘assay’ datasets:

```
sampleMap(nmt)
```

```
## DataFrame with 4956 rows and 3 columns
##             assay                primary                colname
##          <factor>            <character>            <character>
## 1    met_genebody E4.5-5.5_new_Plate1_.. E4.5-5.5_new_Plate1_..
## 2    met_genebody E4.5-5.5_new_Plate1_.. E4.5-5.5_new_Plate1_..
## 3    met_genebody E4.5-5.5_new_Plate1_.. E4.5-5.5_new_Plate1_..
## 4    met_genebody E4.5-5.5_new_Plate1_.. E4.5-5.5_new_Plate1_..
## 5    met_genebody E4.5-5.5_new_Plate1_.. E4.5-5.5_new_Plate1_..
## ...           ...                    ...                    ...
## 4952      acc_DHS       PS_VE_Plate9_G05       PS_VE_Plate9_G05
## 4953      acc_DHS       PS_VE_Plate9_G08       PS_VE_Plate9_G08
## 4954      acc_DHS       PS_VE_Plate9_G09       PS_VE_Plate9_G09
## 4955      acc_DHS       PS_VE_Plate9_G12       PS_VE_Plate9_G12
## 4956      acc_DHS       PS_VE_Plate9_H08       PS_VE_Plate9_H08
```

Take a look at the cell identifiers or barcodes across assays:

```
colnames(nmt)
```

```
## CharacterList of length 6
## [["acc_DHS"]] E4.5-5.5_new_Plate1_A02 ... PS_VE_Plate9_H08
## [["met_DHS"]] E4.5-5.5_new_Plate1_A02 ... PS_VE_Plate9_H08
## [["acc_cgi"]] E4.5-5.5_new_Plate1_A02 ... PS_VE_Plate9_H08
## [["met_cgi"]] E4.5-5.5_new_Plate1_A02 ... PS_VE_Plate9_H08
## [["acc_genebody"]] E4.5-5.5_new_Plate1_A02 ... PS_VE_Plate9_H08
## [["met_genebody"]] E4.5-5.5_new_Plate1_A02 ... PS_VE_Plate9_H08
```

## 2.6 Chromatin Accessibility (acc\_\*)

See the accessibilty levels (as proportions) for DNase Hypersensitive Sites:

```
head(assay(nmt, "acc_DHS"))[, 1:4]
```

```
##                E4.5-5.5_new_Plate1_A02 E4.5-5.5_new_Plate1_A04
## ESC_DHS_118970              0.66666667                      NA
## ESC_DHS_118919              0.76190476                      NA
## ESC_DHS_66330               0.81818182               0.7142857
## ESC_DHS_43318                       NA               0.8000000
## ESC_DHS_6229                0.85714286               0.8000000
## ESC_DHS_9413                0.06666667               0.6800000
##                E4.5-5.5_new_Plate1_A07 E4.5-5.5_new_Plate1_A08
## ESC_DHS_118970                      NA               0.2631579
## ESC_DHS_118919               0.3636364               0.8421053
## ESC_DHS_66330                0.7391304               0.6086957
## ESC_DHS_43318                0.5000000               0.8888889
## ESC_DHS_6229                 0.3333333               0.7142857
## ESC_DHS_9413                 0.2142857               0.5217391
```

## 2.7 DNA Methylation (met\_\*)

See the methylation percentage / proportion:

```
head(assay(nmt, "met_DHS"))[, 1:4]
```

```
##                E4.5-5.5_new_Plate1_A02 E4.5-5.5_new_Plate1_A04
## ESC_DHS_20778                0.8000000                      NA
## ESC_DHS_14504                0.8000000                     0.8
## ESC_DHS_112143                      NA                     0.4
## ESC_DHS_34593                0.6666667                     0.6
## ESC_DHS_20747                0.4000000                     0.6
## ESC_DHS_33671                       NA                     0.6
##                E4.5-5.5_new_Plate1_A07 E4.5-5.5_new_Plate1_A08
## ESC_DHS_20778                0.8571429               0.8000000
## ESC_DHS_14504                0.8000000               0.6000000
## ESC_DHS_112143               0.5714286               0.5000000
## ESC_DHS_34593                0.7142857               0.8000000
## ESC_DHS_20747                       NA               0.6000000
## ESC_DHS_33671                0.8333333               0.6666667
```

For protocol information, see the references below.

# 3 sessionInfo

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
##  [1] scater_1.38.0               ggplot2_4.0.0
##  [3] scran_1.38.0                scuttle_1.20.0
##  [5] rhdf5_2.54.0                RaggedExperiment_1.34.0
##  [7] SingleCellExperiment_1.32.0 SingleCellMultiModal_1.22.0
##  [9] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                gridExtra_2.3            httr2_1.2.1
##   [4] formatR_1.14             rlang_1.1.6              magrittr_2.0.4
##   [7] RcppAnnoy_0.0.22         compiler_4.5.1           RSQLite_2.4.3
##  [10] png_0.1-8                vctrs_0.6.5              pkgconfig_2.0.3
##  [13] SpatialExperiment_1.20.0 crayon_1.5.3             fastmap_1.2.0
##  [16] dbplyr_2.5.1             magick_2.9.0             XVector_0.50.0
##  [19] labeling_0.4.3           rmarkdown_2.30           ggbeeswarm_0.7.2
##  [22] UpSetR_1.4.0             tinytex_0.57             purrr_1.1.0
##  [25] bit_4.6.0                xfun_0.54                bluster_1.20.0
##  [28] cachem_1.1.0             beachmat_2.26.0          jsonlite_2.0.0
##  [31] blob_1.2.4               rhdf5filters_1.22.0      DelayedArray_0.36.0
##  [34] Rhdf5lib_1.32.0          BiocParallel_1.44.0      irlba_2.3.5.1
##  [37] parallel_4.5.1           cluster_2.1.8.1          R6_2.6.1
##  [40] RColorBrewer_1.1-3       bslib_0.9.0              limma_3.66.0
##  [43] jquerylib_0.1.4          Rcpp_1.1.0               bookdown_0.45
##  [46] knitr_1.50               BiocBaseUtils_1.12.0     Matrix_1.7-4
##  [49] igraph_2.2.1             tidyselect_1.2.1         viridis_0.6.5
##  [52] dichromat_2.0-0.1        abind_1.4-8              yaml_2.3.10
##  [55] codetools_0.2-20         curl_7.0.0               plyr_1.8.9
##  [58] lattice_0.22-7           tibble_3.3.0             S7_0.2.0
##  [61] withr_3.0.2              KEGGREST_1.50.0          evaluate_1.0.5
##  [64] BiocFileCache_3.0.0      ExperimentHub_3.0.0      Biostrings_2.78.0
##  [67] pillar_1.11.1            BiocManager_1.30.26      filelock_1.0.3
##  [70] BiocVersion_3.22.0       scales_1.4.0             glue_1.8.0
##  [73] metapod_1.18.0           tools_4.5.1              AnnotationHub_4.0.0
##  [76] BiocNeighbors_2.4.0      ScaledMatrix_1.18.0      locfit_1.5-9.12
##  [79] cowplot_1.2.0            grid_4.5.1               AnnotationDbi_1.72.0
##  [82] edgeR_4.8.0              beeswarm_0.4.0           BiocSingular_1.26.0
##  [85] HDF5Array_1.38.0         vipor_0.4.7              cli_3.6.5
##  [88] rsvd_1.0.5               rappdirs_0.3.3           viridisLite_0.4.2
##  [91] S4Arrays_1.10.0          dplyr_1.1.4              uwot_0.2.3
##  [94] gtable_0.3.6             sass_0.4.10              digest_0.6.37
##  [97] ggrepel_0.9.6            SparseArray_1.10.1       dqrng_0.4.1
## [100] farver_2.1.2             rjson_0.2.23             memoise_2.0.1
## [103] htmltools_0.5.8.1        lifecycle_1.0.4          h5mread_1.2.0
## [106] httr_1.4.7               statmod_1.5.1            bit64_4.6.0-1
```

# References

Argelaguet, Ricard, Stephen J Clark, Hisham Mohammed, L Carine Stapel, Christel Krueger, Chantriolnt-Andreas Kapourani, Ivan Imaz-Rosshandler, et al. 2019. “Multi-Omics Profiling of Mouse Gastrulation at Single-Cell Resolution.” *Nature* 576 (7787): 487–91.

Clark, Stephen J, Ricard Argelaguet, Chantriolnt-Andreas Kapourani, Thomas M Stubbs, Heather J Lee, Celia Alda-Catalinas, Felix Krueger, et al. 2018. “scNMT-seq Enables Joint Profiling of Chromatin Accessibility DNA Methylation and Transcription in Single Cells.” *Nat. Commun.* 9 (1): 781.