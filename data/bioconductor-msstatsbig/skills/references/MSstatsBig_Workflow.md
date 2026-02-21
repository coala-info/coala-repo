# MSstatsBig Workflow

#### Devon Kohler (kohler.d@northeastern.edu)

#### 2025-12-15

## MSstatsBig Package Description

`MSstatsBig` is designed to overcome challenges when analyzing very large mass spectrometry (MS)-based proteomics experiments. These experiments are generally (but not always) acquired with DIA and include a large number of MS runs. `MSstatsBig` leverages software that can work on datasets without loading them into memory. This avoids a major problem where a dataset cannot be loaded into a standard computers RAM.

`MSstatsBig` includes functions which are designed to replace the converters included in the `MSstats` package. The goal of these converters is to perform filtering on the PSM files of identified and quantified data to remove data that is not required for differential analysis. Once this data is filtered down it should be able to be loaded into your computer’s memory. After the converters are run, the standard `MSstats` workflow can be followed.

`MSstatsBig` currently includes converters for Spectronaut and FragPipe. Beyond these converters, users can manually use the underlying functions by putting their data into `MSstats` format and running the underlying `MSstatsPreprocessBig` function. This way, either by using native export format of signal processing tools or by converting raw data chunk by chunk (for example with the readr::read\_delim\_chunked function), `MSstatsBig` can be used with other popular tools such as DIA-NN.

```
library(MSstatsBig)
```

## Dataset description

The dataset included in this package is a small subset of a work by Clark et al. [1]. It is a large DIA dataset that includes over 100 runs. The experimental data was identified and quantified by FragPipe and the included dataset is the `msstats.csv` output for FragPipe.

```
head(read.csv(system.file("extdata", "fgexample.csv", package = "MSstatsBig")))
```

```
##   ProteinName            PeptideSequence PrecursorCharge FragmentIon
## 1      Q86U42 (UniMod:1)AAAAAAAAAAGAAGGR               1          b4
## 2      Q86U42 (UniMod:1)AAAAAAAAAAGAAGGR               1          y6
## 3      Q86U42 (UniMod:1)AAAAAAAAAAGAAGGR               1          y7
## 4      Q86U42 (UniMod:1)AAAAAAAAAAGAAGGR               1          b5
## 5      Q86U42 (UniMod:1)AAAAAAAAAAGAAGGR               1          y8
## 6      Q86U42 (UniMod:1)AAAAAAAAAAGAAGGR               1          y9
##   ProductCharge IsotopeLabelType Condition BioReplicate
## 1             1                L         T         1522
## 2             1                L         T         1522
## 3             1                L         T         1522
## 4             1                L         T         1522
## 5             1                L         T         1522
## 6             1                L         T         1522
##                                            Run  Intensity
## 1 CPTAC_CCRCC_W_JHU_20190112_LUMOS_C3N-01522_T 3747562.00
## 2 CPTAC_CCRCC_W_JHU_20190112_LUMOS_C3N-01522_T  770585.44
## 3 CPTAC_CCRCC_W_JHU_20190112_LUMOS_C3N-01522_T 1379359.12
## 4 CPTAC_CCRCC_W_JHU_20190112_LUMOS_C3N-01522_T 3706759.50
## 5 CPTAC_CCRCC_W_JHU_20190112_LUMOS_C3N-01522_T   77361.97
## 6 CPTAC_CCRCC_W_JHU_20190112_LUMOS_C3N-01522_T  338863.41
```

## Run MSstatsBig converter

First we run the `MSstatsBig` converter. The converter will save the dataset to a place on your computer, and will return an arrow object. Once then, you can read the data from text file or load the arrow data.frame into memory by using the `dplyr::collect` function. The “collected” data can then be treated as a standard R `data.frame`.

```
setwd(tempdir())

converted_data = bigFragPipetoMSstatsFormat(
  system.file("extdata", "fgexample.csv", package = "MSstatsBig"),
  "output_file.csv",
  backend="arrow",
  max_feature_count = 20)

# The returned arrow object needs to be collected for the remaining workflow
converted_data = as.data.frame(dplyr::collect(converted_data))
```

## Remaining workflow

Once the converter is run the standard `MSstats` workflow can be followed:

* `dataProcess` function summarizes peptide-level data into protein-level estimates.
* `groupComparison` function fits a linear model to protein-level data and performs statistical inference for comparisons of selected groups.

Details of the MSstats workflow can be found in [2].

```
library(MSstats)
```

```
##
## Attaching package: 'MSstats'
```

```
## The following object is masked from 'package:grDevices':
##
##     savePlot
```

```
# converted_data = read.csv("output_file.csv")
summarized_data = dataProcess(converted_data,
                              use_log_file = FALSE)
```

```
## INFO  [2025-12-15 19:03:08] ** Features with one or two measurements across runs are removed.
## INFO  [2025-12-15 19:03:08] ** Fractionation handled.
## INFO  [2025-12-15 19:03:08] ** Updated quantification data to make balanced design. Missing values are marked by NA
## INFO  [2025-12-15 19:03:08] ** Log2 intensities under cutoff = 12.59  were considered as censored missing values.
## INFO  [2025-12-15 19:03:08] ** Log2 intensities = NA were considered as censored missing values.
## INFO  [2025-12-15 19:03:08] ** Use top100 features that have highest average of log2(intensity) across runs.
## INFO  [2025-12-15 19:03:08]
##  # proteins: 1
##  # peptides per protein: 1-1
##  # features per peptide: 11-11
## INFO  [2025-12-15 19:03:08]
##                     NAT  T
##              # runs  56 50
##     # bioreplicates  56 50
##  # tech. replicates   1  1
## INFO  [2025-12-15 19:03:08]  == Start the summarization per subplot...
##   |                                                                              |                                                                      |   0%  |                                                                              |======================================================================| 100%
## INFO  [2025-12-15 19:03:08]  == Summarization is done.
```

```
# Build contrast matrix
comparison = matrix(c(-1, 1),
    nrow=1, byrow=TRUE)
row.names(comparison) <- c("T-NAT")
colnames(comparison) <- c("NAT", "T")

model_results = groupComparison(contrast.matrix = comparison,
                                data = summarized_data,
                                use_log_file = FALSE)
```

```
## INFO  [2025-12-15 19:03:09]  == Start to test and get inference in whole plot ...
##   |                                                                              |                                                                      |   0%  |                                                                              |======================================================================| 100%
## INFO  [2025-12-15 19:03:09]  == Comparisons for all proteins are done.
```

## Session info

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
## [1] MSstats_4.18.0   MSstatsBig_1.8.1
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6          xfun_0.54             bslib_0.9.0
##  [4] ggplot2_4.0.1         htmlwidgets_1.6.4     caTools_1.18.3
##  [7] ggrepel_0.9.6         lattice_0.22-7        vctrs_0.6.5
## [10] tools_4.5.2           Rdpack_2.6.4          bitops_1.0-9
## [13] generics_0.1.4        parallel_4.5.2        tibble_3.3.0
## [16] pkgconfig_2.0.3       Matrix_1.7-4          KernSmooth_2.23-26
## [19] data.table_1.17.8     checkmate_2.3.3       RColorBrewer_1.1-3
## [22] S7_0.2.1              assertthat_0.2.1      lifecycle_1.0.4
## [25] compiler_4.5.2        farver_2.1.2          gplots_3.3.0
## [28] statmod_1.5.1         htmltools_0.5.9       sass_0.4.10
## [31] yaml_2.3.12           lazyeval_0.2.2        preprocessCore_1.72.0
## [34] marray_1.88.0         plotly_4.11.0         pillar_1.11.1
## [37] nloptr_2.2.1          jquerylib_0.1.4       tidyr_1.3.1
## [40] MASS_7.3-65           cachem_1.1.0          limma_3.66.0
## [43] reformulas_0.4.2      boot_1.3-32           nlme_3.1-168
## [46] gtools_3.9.5          tidyselect_1.2.1      digest_0.6.39
## [49] dplyr_1.1.4           purrr_1.2.0           arrow_22.0.0
## [52] splines_4.5.2         fastmap_1.2.0         grid_4.5.2
## [55] cli_3.6.5             magrittr_2.0.4        dichromat_2.0-0.1
## [58] survival_3.8-3        withr_3.0.2           scales_1.4.0
## [61] backports_1.5.0       bit64_4.6.0-1         rmarkdown_2.30
## [64] httr_1.4.7            bit_4.6.0             lme4_1.1-38
## [67] evaluate_1.0.5        knitr_1.50            log4r_0.4.4
## [70] rbibutils_2.4         MSstatsConvert_1.20.0 viridisLite_0.4.2
## [73] rlang_1.1.6           Rcpp_1.1.0            glue_1.8.0
## [76] minqa_1.2.8           jsonlite_2.0.0        R6_2.6.1
```

## References

1. D. J. Clark, S. M. Dhanasekaran, F. Petralia, P. Wang and H. Zhang, “Integrated Proteogenomic Characterization of Clear Cell Renal Cell Carcinoma,” Cell, vol. 179, pp. 964-983, 2019.
2. D. Kohler et al., “MSstats Version 4.0: Statistical Analyses of Quantitative Mass Spectrometry-Based Proteomic Experiments with Chromatography-Based Quantification at Scale”, J. Proteome Res. 22, 5, pp. 1466–1482, J. Proteome Res. 2023, 22, 5, 1466–1482