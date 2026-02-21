# Compare observed Retention Time versus Sequence-specific calculated retention time using (F255744)

Christian Panse

#### 2017-10-30

# Contents

* [1 Comparizon](#comparizon)
* [2 Session info](#session-info)
* [References](#references)

# 1 Comparizon

To validate our Retention Time (RT) prediction in this vignette file, we compare the predicted hydrophobicity value using the `ssrc` method Krokhin et al. ([2004](#ref-pmid15238601)) implemented in the
*[protViz](https://CRAN.R-project.org/package%3DprotViz)* package Panse and Grossmann ([2019](#ref-protViz)).

The following code snippet performs the comparison on the F255744 data.
The file contains amino acid sequences representing the designed flycodes.

```
library(NestLink)
```

```
# load(url("http://fgcz-ms.uzh.ch/~cpanse/p1875/F255744.RData"))
# F255744 <- as.data.frame.mascot(F255744)
# now available through ExperimentHub

library(ExperimentHub)
eh <- ExperimentHub();

load(query(eh, c("NestLink", "F255744.RData"))[[1]])
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
```

```
## loading from cache
```

```
.ssrc.mascot(F255744, scores = c(10, 20, 40, 50),
             pch = 16,
             col = rgb(0.1,0.1,0.1,
                       alpha = 0.1)
)
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

```
## [[1]]
##
## Call:
## lm(formula = xx.ssrc ~ xx$RTINSECONDS)
##
## Residuals:
##     Min      1Q  Median      3Q     Max
## -38.954  -2.248   0.015   2.228  71.167
##
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)
## (Intercept)    -5.580e+00  2.030e-01  -27.48   <2e-16 ***
## xx$RTINSECONDS  8.849e-03  7.434e-05  119.04   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 5.884 on 12295 degrees of freedom
## Multiple R-squared:  0.5354, Adjusted R-squared:  0.5354
## F-statistic: 1.417e+04 on 1 and 12295 DF,  p-value: < 2.2e-16
##
##
## [[2]]
##
## Call:
## lm(formula = xx.ssrc ~ xx$RTINSECONDS)
##
## Residuals:
##     Min      1Q  Median      3Q     Max
## -37.387  -2.040  -0.042   1.930  46.035
##
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)
## (Intercept)    -6.976e+00  1.621e-01  -43.03   <2e-16 ***
## xx$RTINSECONDS  9.447e-03  6.018e-05  156.99   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 4.12 on 9835 degrees of freedom
## Multiple R-squared:  0.7148, Adjusted R-squared:  0.7147
## F-statistic: 2.464e+04 on 1 and 9835 DF,  p-value: < 2.2e-16
##
##
## [[3]]
##
## Call:
## lm(formula = xx.ssrc ~ xx$RTINSECONDS)
##
## Residuals:
##     Min      1Q  Median      3Q     Max
## -15.260  -1.963  -0.114   1.735  45.342
##
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)
## (Intercept)    -7.690e+00  1.784e-01  -43.11   <2e-16 ***
## xx$RTINSECONDS  9.781e-03  6.724e-05  145.46   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 3.506 on 5574 degrees of freedom
## Multiple R-squared:  0.7915, Adjusted R-squared:  0.7915
## F-statistic: 2.116e+04 on 1 and 5574 DF,  p-value: < 2.2e-16
##
##
## [[4]]
##
## Call:
## lm(formula = xx.ssrc ~ xx$RTINSECONDS)
##
## Residuals:
##    Min     1Q Median     3Q    Max
## -9.570 -2.019 -0.142  1.754 45.200
##
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)
## (Intercept)    -7.827e+00  2.173e-01  -36.02   <2e-16 ***
## xx$RTINSECONDS  9.848e-03  8.271e-05  119.06   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 3.579 on 3650 degrees of freedom
## Multiple R-squared:  0.7952, Adjusted R-squared:  0.7952
## F-statistic: 1.418e+04 on 1 and 3650 DF,  p-value: < 2.2e-16
```

# 2 Session info

Here is the output of the `sessionInfo()`
command.

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
##  [1] scales_1.4.0                ggplot2_4.0.0
##  [3] NestLink_1.26.0             ShortRead_1.68.0
##  [5] GenomicAlignments_1.46.0    SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [9] matrixStats_1.5.0           Rsamtools_2.26.0
## [11] GenomicRanges_1.62.0        BiocParallel_1.44.0
## [13] protViz_0.7.9               gplots_3.2.0
## [15] Biostrings_2.78.0           Seqinfo_1.0.0
## [17] XVector_0.50.0              IRanges_2.44.0
## [19] S4Vectors_0.48.0            ExperimentHub_3.0.0
## [21] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [23] dbplyr_2.5.1                BiocGenerics_0.56.0
## [25] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3            bitops_1.0-9         deldir_2.0-4
##  [4] httr2_1.2.1          rlang_1.1.6          magrittr_2.0.4
##  [7] compiler_4.5.1       RSQLite_2.4.3        mgcv_1.9-3
## [10] png_0.1-8            vctrs_0.6.5          pwalign_1.6.0
## [13] pkgconfig_2.0.3      crayon_1.5.3         fastmap_1.2.0
## [16] magick_2.9.0         labeling_0.4.3       caTools_1.18.3
## [19] rmarkdown_2.30       tinytex_0.57         purrr_1.1.0
## [22] bit_4.6.0            xfun_0.54            cachem_1.1.0
## [25] cigarillo_1.0.0      jsonlite_2.0.0       blob_1.2.4
## [28] DelayedArray_0.36.0  jpeg_0.1-11          parallel_4.5.1
## [31] R6_2.6.1             bslib_0.9.0          RColorBrewer_1.1-3
## [34] jquerylib_0.1.4      Rcpp_1.1.0           bookdown_0.45
## [37] knitr_1.50           splines_4.5.1        Matrix_1.7-4
## [40] tidyselect_1.2.1     dichromat_2.0-0.1    abind_1.4-8
## [43] yaml_2.3.10          codetools_0.2-20     hwriter_1.3.2.1
## [46] curl_7.0.0           lattice_0.22-7       tibble_3.3.0
## [49] withr_3.0.2          KEGGREST_1.50.0      S7_0.2.0
## [52] evaluate_1.0.5       pillar_1.11.1        BiocManager_1.30.26
## [55] filelock_1.0.3       KernSmooth_2.23-26   BiocVersion_3.22.0
## [58] gtools_3.9.5         glue_1.8.0           tools_4.5.1
## [61] interp_1.1-6         grid_4.5.1           latticeExtra_0.6-31
## [64] AnnotationDbi_1.72.0 nlme_3.1-168         cli_3.6.5
## [67] rappdirs_0.3.3       S4Arrays_1.10.0      dplyr_1.1.4
## [70] gtable_0.3.6         sass_0.4.10          digest_0.6.37
## [73] SparseArray_1.10.1   farver_2.1.2         memoise_2.0.1
## [76] htmltools_0.5.8.1    lifecycle_1.0.4      httr_1.4.7
## [79] bit64_4.6.0-1
```

# References

Krokhin, O. V., R. Craig, V. Spicer, W. Ens, K. G. Standing, R. C. Beavis, and J. A. Wilkins. 2004. “An improved model for prediction of retention times of tryptic peptides in ion pair reversed-phase HPLC: its application to protein peptide mapping by off-line HPLC-MALDI MS.” *Mol. Cell Proteomics* 3 (9): 908–19.

Panse, Christian, and Jonas Grossmann. 2019. *protViz: Visualizing and Analyzing Mass Spectrometry Related Data in Proteomics*. Vienna, Austria: R Foundation for Statistical Computing. <https://www.R-project.org>.