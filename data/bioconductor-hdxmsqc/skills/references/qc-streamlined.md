# qc-tidying

Oliver M. Crook

#### 30 October 2025

#### Abstract

This vignette describes how to pefrom quality control for mass-spectrometry based hydrogen deuterium exchange experiment.

#### Package

hdxmsqc 1.6.0

# 1 Introduction

The `hdxmsqc` package is a quality control assessment package
from hydrogen-deuterium exchange mass-spectrometry (HDX-MS) data. The functions
look for outliers in retention time and ion mobility. They also examine missing
values, mass errors, intensity based outliers, deviations of the data from
monotonicity, the correlation of charge states, whether uptake values
are coherent based on overlapping peptides and finally the similarity of the
observed to the theoretical spectra observed. This package is designed
to help those performing iterative quality control through manual inspection
but also a set of metric and visualizations by which practitioners can use
to demonstrate they have high quality data.

# 2 packages

The packages required are the following.

```
suppressMessages(require(hdxmsqc))
require(S4Vectors)
suppressMessages(require(dplyr))
require(tidyr)
```

```
## Loading required package: tidyr
```

```
##
## Attaching package: 'tidyr'
```

```
## The following object is masked from 'package:S4Vectors':
##
##     expand
```

```
require(QFeatures)
require(RColorBrewer)
```

```
## Loading required package: RColorBrewer
```

```
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```
require(MASS)
```

```
## Loading required package: MASS
```

```
##
## Attaching package: 'MASS'
```

```
## The following object is masked from 'package:dplyr':
##
##     select
```

```
require(pheatmap)
```

```
## Loading required package: pheatmap
```

```
require(Spectra)
require(patchwork)
```

```
## Loading required package: patchwork
```

```
##
## Attaching package: 'patchwork'
```

```
## The following object is masked from 'package:MASS':
##
##     area
```

# 3 Data

We first load the data, as exported from HDExaminer.

```
BRD4uncurated <- data.frame(read.csv(system.file("extdata", "ELN55049_AllResultsTables_Uncurated.csv", package = "hdxmsqc", mustWork = TRUE)))
```

The following code chunk tidies dataset, which improves the formatting and converts
to wide format. It will also note the number of states, timepoints and peptides.

```
BRD4uncurated_wide <- processHDE(HDExaminerFile = BRD4uncurated,
                                 proteinStates = c("wt", "iBET"))
```

```
## Number of peptide sequence: 167
## Number of timepoints: 7
## Number of Protein States: 2
```

```
## Warning in FUN(X[[i]], ...): NAs introduced by coercion
## Warning in FUN(X[[i]], ...): NAs introduced by coercion
## Warning in FUN(X[[i]], ...): NAs introduced by coercion
## Warning in FUN(X[[i]], ...): NAs introduced by coercion
## Warning in FUN(X[[i]], ...): NAs introduced by coercion
## Warning in FUN(X[[i]], ...): NAs introduced by coercion
```

The next code chunk extracts the columns with the quantitative data.

```
i <- grep(pattern = "X..Deut",
          x = names(BRD4uncurated_wide))
```

We now parse the object into an object of class `Qfeatures`. This standardises
the formatting of the data.

```
BRD4df <- readQFeatures(assayData = BRD4uncurated_wide,
                        ecol = i,
                        names = "Deuteration",
                        fnames = "fnames")
```

```
## Checking arguments.
```

```
## Warning in .checkWarnEcol(quantCols, ecol): 'ecol' is deprecated, use
## 'quantCols' instead.
```

```
## Loading data as a 'SummarizedExperiment' object.
```

```
## Formatting sample annotations (colData).
```

```
## Formatting data as a 'QFeatures' object.
```

```
## Setting assay rownames.
```

# 4 Visualisation

A simple heatmap of our data can give us a sense of it.

```
pheatmap(assay(BRD4df), cluster_rows = FALSE, scale = "row")
```

![](data:image/png;base64...)

# 5 Examining missing values

Here, we can plot where the missing values are:

```
plotMissing(object = BRD4df)
```

![](data:image/png;base64...)

Here, we can filter data that is not missing at random:

```
BRD4df_filtered <- isMissingAtRandom(object = BRD4df)
```

```
## 'mnar' found in 1 out of 1 assay(s).
```

```
## Number of peptides filtered:10
```

We can then replot missing-ness:

```
plotMissing(object = BRD4df_filtered)
```

![](data:image/png;base64...)
The values that are missing are all at the zero time-points where deuterium
uptake should be 0, we can simply impute these values.

```
BRD4df_filtered_imputed <- impute(BRD4df_filtered, method = "zero", i = 1)
```

# 6 Empirical vs Theoretical errors

```
massError <- computeMassError(object = BRD4df_filtered_imputed)
plotMassError(object = BRD4df_filtered_imputed)
```

```
## Warning: Removed 8 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

![](data:image/png;base64...)

# 7 Intensity based outlier detection

Using linear-model based outlier detection we see whether there
are Spectra that have variable intensity based on their mean intensity. A linear
model is fitted to the log-mean and log-variance of the intensities. These
should follow a linear trend. Cook’s distance is used to determine outliers are
consider if their distance is greater than 2/\(\sqrt(n)\), where \(n\) is the
number of peptides.

```
intensityOutlier <- intensityOutliers(object = BRD4df_filtered_imputed)
plotIntensityOutliers(object = BRD4df_filtered_imputed)
```

![](data:image/png;base64...)

# 8 Retention time analysis

Retention time outlier detection looks at the
usual variability of retention time search window and the
actual left/right windows of the retention time. Outliers are flagged
if their retention time falls outside 1.5 \* interquartile range.

```
dfrt <- rTimeOutliers(object = BRD4df_filtered_imputed)
plotrTimeOutliers(object = BRD4df_filtered_imputed)
```

```
## $leftRTgg
```

![](data:image/png;base64...)

```
##
## $rightRTgg
```

![](data:image/png;base64...)

# 9 Monotonicity statistics

This uses a statistic to detect differences from monotonic behavior. First,
we need to specify the experimental design and the timepoints used.

```
experiment <- c("wt", "iBET")
timepoints <- rep(c(0, 15, 60, 600, 3600, 14000), each = 3)
```

The monotonicity statistic measure the deviation from monotoncity. Whilst
some deviation is expected from random fluctuations, it is worth double
checking those that are strong deviates compare to the rest of the data.

```
monoStat <- computeMonotoneStats(object = BRD4df_filtered_imputed,
                                 experiment = experiment,
                                 timepoints = timepoints)
out <- plotMonotoneStat(object = BRD4df_filtered_imputed,
                                 experiment = experiment,
                                 timepoints = timepoints)
out
```

```
## [[1]]
```

![](data:image/png;base64...)

```
##
## [[2]]
```

![](data:image/png;base64...)

# 10 Ion Mobility Time analysis

In a similar analysis to the retention time analysis, for ion mobility time
we can also see whether there are random deviation in the ion mobility windows.
Again, we define outliers that deviate outside the typical 1.5 \* IQR.

```
imTimeOut <- imTimeOutlier(object = BRD4df_filtered_imputed)
plotImTimeOutlier(object = BRD4df_filtered_imputed)
```

```
## $leftIMSgg
```

![](data:image/png;base64...)

```
##
## $rightIMSgg
```

![](data:image/png;base64...)

# 11 Charge state correlation

We check that charge states are correlated. Whilst we don’t expect exactly
the same before - low correlation maybe concerning.

```
csCor <- chargeCorrelationHdx(object = BRD4df_filtered_imputed,
                              experiment = experiment,
                              timepoints = timepoints)
csCor
```

```
## $wt
##   LNLPDYYKIIKTPMDMGTIKKR LNLPDYYKIIKTPMDMGTIKKRLENN
## 1              1.0000000                  1.0000000
## 2              0.9248554                  0.9953514
## 3              0.9248554                  0.9953514
## 4              1.0000000                  1.0000000
##
## $iBET
##   LNLPDYYKIIKTPMDMGTIKKR LNLPDYYKIIKTPMDMGTIKKRLENN
## 1              1.0000000                  1.0000000
## 2              0.8947091                  0.9919185
## 3              0.8947091                  0.9919185
## 4              1.0000000                  1.0000000
```

# 12 Using replicates to determine outliers and variability

```
replicateVar <- replicateCorrelation(object = BRD4df_filtered_imputed,
                                     experiment = experiment,
                                     timepoints = timepoints)

replicateOut <- replicateOutlier(object = BRD4df_filtered_imputed,
                                     experiment = experiment,
                                     timepoints = timepoints)
```

# 13 Using sequence overlap information are uptake values compatible

We can also check whether uptakes are compatible with overlapping peptides.
The difference in uptake cannot be more different than the difference
in the number of exchangeable amides. The default methodology only checks
whether sequence with up-to 5 different exchangeable amides are compatible
to keep run-times lower. Larger difference may indicate different
chemical changes or back-exchange properties.

```
tocheck <- compatibleUptake(object = BRD4df_filtered_imputed,
                 experiment = experiment,
                 timepoints = timepoints)
```

# 14 Comparison of Spectra

In this section, we can directly examine the differences between the
theoretical spectra one would expect from the computed deuterium uptake and
the actual observed spectra. Deviations observed in the spectra could
suggest contamination, false identifications or poor quality spectra.
A score is generated using the cosine similarity between the spectra - which
is equivalent to the normalized dot product. The spectra pairs can be
also be visualized.

Load in some Spectra from HDsite which should match those of HDExaminer

```
hdxsite <- data.frame(read.csv(system.file("extdata", "BRD4_RowChecked_20220628_HDsite.csv",
                                           package = "hdxmsqc", mustWork = TRUE),
                               header = TRUE, fileEncoding = 'UTF-8-BOM'))
BRD4matched <- read.csv(system.file("extdata", "BRD4_RowChecked_20220628_HDE.csv",
                                           package = "hdxmsqc", mustWork = TRUE),
                               header = TRUE, fileEncoding = 'UTF-8-BOM')
```

```
spectraCompare <- spectraSimilarity(peaks = hdxsite,
                                    object = BRD4matched,
                                    experiment = experiment,
                                    numSpectra = NULL)
```

The scores can be accesses as follows:

```
head(spectraCompare$observedSpectra$score)
```

```
## [1] 0.8878149 0.8492476 0.8093282 0.6894649 0.5788934 0.7713417
```

To visualise these spectra we can use the following function

```
plotSpectraMirror(spectraCompare$observedSpectra[1,], spectraCompare$matchedSpectra[1,], ppm = 300)
```

![](data:image/png;base64...)

Finally, a summarise quality control table can be produced and saved in a
.csv file if desired.

```
qctable <- qualityControl(object = BRD4df_filtered_imputed,
                           massError = massError,
                           intensityOutlier = intensityOutlier,
                           retentionOutlier = dfrt,
                           monotonicityStat = monoStat,
                           mobilityOutlier = imTimeOut,
                           chargeCorrelation = csCor,
                           replicateCorrelation = replicateVar,
                           replicateOutlier = replicateOut,
                           sequenceCheck = tocheck,
                           spectraCheck = spectraCompare,
                           experiment = experiment,
                           timepoints = timepoints )
```

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
##  [1] patchwork_1.3.2             pheatmap_1.0.13
##  [3] MASS_7.3-65                 ggplot2_4.0.0
##  [5] RColorBrewer_1.1-3          tidyr_1.3.1
##  [7] dplyr_1.1.4                 hdxmsqc_1.6.0
##  [9] Spectra_1.20.0              BiocParallel_1.44.0
## [11] QFeatures_1.20.0            MultiAssayExperiment_1.36.0
## [13] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [15] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [17] IRanges_2.44.0              S4Vectors_0.48.0
## [19] BiocGenerics_0.56.0         generics_0.1.4
## [21] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [23] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6            xfun_0.53               bslib_0.9.0
##  [4] lattice_0.22-7          vctrs_0.6.5             tools_4.5.1
##  [7] parallel_4.5.1          tibble_3.3.0            cluster_2.1.8.1
## [10] pkgconfig_2.0.3         BiocBaseUtils_1.12.0    Matrix_1.7-4
## [13] S7_0.2.0                lifecycle_1.0.4         farver_2.1.2
## [16] compiler_4.5.1          stringr_1.5.2           tinytex_0.57
## [19] codetools_0.2-20        clue_0.3-66             htmltools_0.5.8.1
## [22] sass_0.4.10             yaml_2.3.10             lazyeval_0.2.2
## [25] pillar_1.11.1           jquerylib_0.1.4         DelayedArray_0.36.0
## [28] cachem_1.1.0            magick_2.9.0            MetaboCoreUtils_1.18.0
## [31] abind_1.4-8             tidyselect_1.2.1        digest_0.6.37
## [34] stringi_1.8.7           reshape2_1.4.4          purrr_1.1.0
## [37] bookdown_0.45           labeling_0.4.3          fastmap_1.2.0
## [40] grid_4.5.1              cli_3.6.5               SparseArray_1.10.0
## [43] magrittr_2.0.4          S4Arrays_1.10.0         dichromat_2.0-0.1
## [46] withr_3.0.2             scales_1.4.0            rmarkdown_2.30
## [49] XVector_0.50.0          igraph_2.2.1            evaluate_1.0.5
## [52] knitr_1.50              rlang_1.1.6             Rcpp_1.1.0
## [55] glue_1.8.0              BiocManager_1.30.26     jsonlite_2.0.0
## [58] AnnotationFilter_1.34.0 R6_2.6.1                plyr_1.8.9
## [61] fs_1.6.6                ProtGenerics_1.42.0     MsCoreUtils_1.22.0
```