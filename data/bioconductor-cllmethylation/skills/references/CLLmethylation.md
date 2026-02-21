# CLLmethylation

Małgorzata Oleś

#### 4 November 2025

```
library("ExperimentHub")
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
library("SummarizedExperiment")
```

```
## Loading required package: MatrixGenerics
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'MatrixGenerics'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
##     colWeightedMeans, colWeightedMedians, colWeightedSds,
##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
##     rowWeightedSds, rowWeightedVars
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
## Attaching package: 'Biobase'
```

```
## The following object is masked from 'package:MatrixGenerics':
##
##     rowMedians
```

```
## The following objects are masked from 'package:matrixStats':
##
##     anyMissing, rowMedians
```

```
## The following object is masked from 'package:ExperimentHub':
##
##     cache
```

```
## The following object is masked from 'package:AnnotationHub':
##
##     cache
```

```
library("ggplot2")
```

# 1 Introduction

The resource *[CLLmethylation](https://bioconductor.org/packages/3.22/CLLmethylation)* contains complete DNA methylation data for chronic lymphocytic leukemia (CLL) patient samples. The subset of this data (for only most variable CpG sites) and the rest of the datasets and analysis resulting from the PACE project is available in *[BloodCancerMultiOmics2017](https://bioconductor.org/packages/3.22/BloodCancerMultiOmics2017)*. All of the data mentioned above was used in the analysis, which results are included in:

S Dietrich\*, M Oleś\*, J Lu\* et al. *Drug-perturbation-based stratification of blood cancer*

*J. Clin. Invest.* (2018); 128(1):427–445. doi:10.1172/JCI93801.

\* equal contribution

The raw data from 450k DNA methylation arrays is stored in the European Genome-Phenome Archive (EGA) under accession number EGAS0000100174.

# 2 Example of analysis

This dataset in combination with the *[BloodCancerMultiOmics2017](https://bioconductor.org/packages/3.22/BloodCancerMultiOmics2017)* package contain rich resource for nearly 200 CLL primary samples. Here we show simple principal component analysis for the DNA methylation data.

Obtain the data.

```
eh = ExperimentHub()
query(eh, "CLLmethylation")
```

```
## ExperimentHub with 1 record
## # snapshotDate(): 2025-10-29
## # names(): EH1071
## # package(): CLLmethylation
## # $dataprovider: European Molecular Biology Laboratory
## # $species: Homo sapiens
## # $rdataclass: RangedSummarizedExperiment
## # $rdatadateadded: 2018-02-02
## # $title: DNA methylation data of CLL primary samples
## # $description: The data was produced with the use of 450k and 850k methylat...
## # $taxonomyid: 9606
## # $genome: hg19
## # $sourcetype: IDAT
## # $sourceurl: https://wwwdev.ebi.ac.uk/ega/datasets/EGAD00010000948
## # $sourcesize: NA
## # $tags: c("ExperimentData", "DiseaseModel", "CancerData",
## #   "LeukemiaCancerData")
## # retrieve record with 'object[["EH1071"]]'
```

```
meth = eh[["EH1071"]] # extract the methylation data
```

```
## see ?CLLmethylation and browseVignettes('CLLmethylation') for documentation
```

```
## loading from cache
```

Subset most variable CpG sites.

```
methData = t(assay(meth))
#filter to only include top 5000 most variable sites
ntop = 5000
methData = methData[,order(apply(methData, 2, var, na.rm=TRUE),
                          decreasing=TRUE)[1:ntop]]
```

Perform principal component analysis.

```
# principal component analysis
pcaMeth = prcomp(methData, center=TRUE, scale. = FALSE)
```

Summary of components.

```
summary(pcaMeth)
```

```
## Importance of components:
##                          PC1     PC2    PC3     PC4     PC5     PC6     PC7
## Standard deviation     9.797 4.32470 3.7835 3.31975 2.70291 2.48083 2.38076
## Proportion of Variance 0.189 0.03684 0.0282 0.02171 0.01439 0.01212 0.01116
## Cumulative Proportion  0.189 0.22589 0.2541 0.27579 0.29018 0.30230 0.31347
##                            PC8     PC9    PC10    PC11    PC12    PC13    PC14
## Standard deviation     2.29235 2.12396 1.99809 1.94241 1.85233 1.82499 1.78618
## Proportion of Variance 0.01035 0.00889 0.00786 0.00743 0.00676 0.00656 0.00628
## Cumulative Proportion  0.32382 0.33270 0.34057 0.34800 0.35476 0.36132 0.36760
##                           PC15    PC16    PC17    PC18    PC19    PC20    PC21
## Standard deviation     1.75348 1.72802 1.72478 1.69280 1.69024 1.67947 1.66557
## Proportion of Variance 0.00606 0.00588 0.00586 0.00564 0.00563 0.00556 0.00546
## Cumulative Proportion  0.37366 0.37954 0.38540 0.39104 0.39667 0.40222 0.40769
##                           PC22    PC23   PC24    PC25   PC26    PC27    PC28
## Standard deviation     1.65248 1.65090 1.6397 1.63538 1.6245 1.62047 1.61097
## Proportion of Variance 0.00538 0.00537 0.0053 0.00527 0.0052 0.00517 0.00511
## Cumulative Proportion  0.41307 0.41843 0.4237 0.42900 0.4342 0.43937 0.44448
##                           PC29    PC30    PC31    PC32    PC33    PC34    PC35
## Standard deviation     1.60339 1.59524 1.58948 1.58488 1.58002 1.57605 1.56581
## Proportion of Variance 0.00506 0.00501 0.00498 0.00495 0.00492 0.00489 0.00483
## Cumulative Proportion  0.44954 0.45456 0.45953 0.46448 0.46940 0.47429 0.47912
##                           PC36   PC37    PC38    PC39    PC40    PC41    PC42
## Standard deviation     1.56470 1.5608 1.55914 1.55632 1.54959 1.54240 1.53450
## Proportion of Variance 0.00482 0.0048 0.00479 0.00477 0.00473 0.00469 0.00464
## Cumulative Proportion  0.48394 0.4887 0.49353 0.49830 0.50303 0.50771 0.51235
##                           PC43    PC44    PC45    PC46    PC47   PC48    PC49
## Standard deviation     1.53243 1.52707 1.52616 1.52263 1.52003 1.5109 1.51022
## Proportion of Variance 0.00463 0.00459 0.00459 0.00457 0.00455 0.0045 0.00449
## Cumulative Proportion  0.51697 0.52157 0.52616 0.53072 0.53527 0.5398 0.54426
##                           PC50    PC51    PC52    PC53    PC54    PC55    PC56
## Standard deviation     1.50507 1.49904 1.49716 1.49182 1.48680 1.48313 1.47911
## Proportion of Variance 0.00446 0.00443 0.00441 0.00438 0.00435 0.00433 0.00431
## Cumulative Proportion  0.54872 0.55315 0.55756 0.56195 0.56630 0.57063 0.57494
##                           PC57    PC58    PC59    PC60   PC61    PC62    PC63
## Standard deviation     1.47646 1.47397 1.46902 1.46321 1.4605 1.45694 1.45493
## Proportion of Variance 0.00429 0.00428 0.00425 0.00422 0.0042 0.00418 0.00417
## Cumulative Proportion  0.57924 0.58352 0.58777 0.59198 0.5962 0.60037 0.60453
##                           PC64    PC65    PC66    PC67    PC68    PC69    PC70
## Standard deviation     1.44915 1.44814 1.44175 1.43938 1.43670 1.43360 1.42897
## Proportion of Variance 0.00414 0.00413 0.00409 0.00408 0.00407 0.00405 0.00402
## Cumulative Proportion  0.60867 0.61280 0.61690 0.62098 0.62504 0.62909 0.63311
##                          PC71    PC72    PC73    PC74    PC75    PC76    PC77
## Standard deviation     1.4252 1.42318 1.41449 1.41432 1.40982 1.40837 1.40315
## Proportion of Variance 0.0040 0.00399 0.00394 0.00394 0.00391 0.00391 0.00388
## Cumulative Proportion  0.6371 0.64110 0.64504 0.64898 0.65290 0.65680 0.66068
##                           PC78    PC79    PC80    PC81    PC82    PC83    PC84
## Standard deviation     1.40071 1.39952 1.39412 1.39254 1.39100 1.38728 1.38393
## Proportion of Variance 0.00386 0.00386 0.00383 0.00382 0.00381 0.00379 0.00377
## Cumulative Proportion  0.66455 0.66840 0.67223 0.67605 0.67986 0.68365 0.68743
##                           PC85    PC86    PC87    PC88    PC89    PC90    PC91
## Standard deviation     1.38267 1.37672 1.37320 1.37188 1.36688 1.36467 1.35839
## Proportion of Variance 0.00377 0.00373 0.00371 0.00371 0.00368 0.00367 0.00363
## Cumulative Proportion  0.69119 0.69492 0.69864 0.70235 0.70603 0.70969 0.71333
##                           PC92    PC93    PC94    PC95    PC96    PC97    PC98
## Standard deviation     1.35657 1.35419 1.35001 1.34718 1.34345 1.34137 1.33888
## Proportion of Variance 0.00362 0.00361 0.00359 0.00357 0.00355 0.00354 0.00353
## Cumulative Proportion  0.71695 0.72056 0.72415 0.72773 0.73128 0.73483 0.73836
##                          PC99   PC100   PC101   PC102   PC103   PC104   PC105
## Standard deviation     1.3328 1.33178 1.33021 1.32766 1.32044 1.31707 1.31605
## Proportion of Variance 0.0035 0.00349 0.00349 0.00347 0.00343 0.00342 0.00341
## Cumulative Proportion  0.7419 0.74535 0.74884 0.75231 0.75574 0.75916 0.76257
##                          PC106   PC107   PC108   PC109   PC110   PC111   PC112
## Standard deviation     1.31225 1.30600 1.30497 1.30237 1.30046 1.29975 1.29727
## Proportion of Variance 0.00339 0.00336 0.00335 0.00334 0.00333 0.00333 0.00331
## Cumulative Proportion  0.76596 0.76932 0.77268 0.77602 0.77935 0.78267 0.78599
##                          PC113   PC114   PC115   PC116   PC117  PC118  PC119
## Standard deviation     1.29250 1.29130 1.28839 1.28462 1.27665 1.2744 1.2738
## Proportion of Variance 0.00329 0.00328 0.00327 0.00325 0.00321 0.0032 0.0032
## Cumulative Proportion  0.78928 0.79256 0.79583 0.79908 0.80229 0.8055 0.8087
##                          PC120   PC121   PC122   PC123   PC124   PC125   PC126
## Standard deviation     1.27108 1.26869 1.26381 1.26235 1.26090 1.25997 1.25220
## Proportion of Variance 0.00318 0.00317 0.00315 0.00314 0.00313 0.00313 0.00309
## Cumulative Proportion  0.81187 0.81504 0.81819 0.82133 0.82446 0.82758 0.83067
##                          PC127   PC128   PC129   PC130   PC131   PC132  PC133
## Standard deviation     1.24923 1.24775 1.24538 1.24189 1.23873 1.23812 1.2339
## Proportion of Variance 0.00307 0.00307 0.00305 0.00304 0.00302 0.00302 0.0030
## Cumulative Proportion  0.83375 0.83681 0.83987 0.84290 0.84593 0.84895 0.8519
##                          PC134   PC135   PC136   PC137  PC138   PC139   PC140
## Standard deviation     1.22914 1.22539 1.22316 1.22287 1.2142 1.20960 1.20581
## Proportion of Variance 0.00298 0.00296 0.00295 0.00295 0.0029 0.00288 0.00286
## Cumulative Proportion  0.85492 0.85788 0.86083 0.86377 0.8667 0.86956 0.87242
##                          PC141   PC142  PC143  PC144   PC145   PC146   PC147
## Standard deviation     1.20109 1.19975 1.1932 1.1915 1.18824 1.18591 1.18275
## Proportion of Variance 0.00284 0.00284 0.0028 0.0028 0.00278 0.00277 0.00276
## Cumulative Proportion  0.87526 0.87810 0.8809 0.8837 0.88648 0.88925 0.89200
##                          PC148   PC149   PC150  PC151   PC152   PC153   PC154
## Standard deviation     1.18191 1.17804 1.17350 1.1703 1.16769 1.16514 1.16096
## Proportion of Variance 0.00275 0.00273 0.00271 0.0027 0.00269 0.00267 0.00265
## Cumulative Proportion  0.89475 0.89749 0.90020 0.9029 0.90558 0.90826 0.91091
##                          PC155   PC156   PC157  PC158   PC159   PC160   PC161
## Standard deviation     1.15883 1.15493 1.15319 1.1500 1.14370 1.14003 1.13519
## Proportion of Variance 0.00264 0.00263 0.00262 0.0026 0.00258 0.00256 0.00254
## Cumulative Proportion  0.91356 0.91618 0.91880 0.9214 0.92398 0.92654 0.92908
##                          PC162   PC163   PC164   PC165   PC166   PC167   PC168
## Standard deviation     1.13294 1.12480 1.12204 1.12100 1.11807 1.11314 1.10881
## Proportion of Variance 0.00253 0.00249 0.00248 0.00248 0.00246 0.00244 0.00242
## Cumulative Proportion  0.93161 0.93410 0.93658 0.93906 0.94152 0.94396 0.94638
##                          PC169   PC170   PC171   PC172   PC173   PC174  PC175
## Standard deviation     1.10253 1.09688 1.09550 1.09146 1.08897 1.08206 1.0800
## Proportion of Variance 0.00239 0.00237 0.00236 0.00235 0.00234 0.00231 0.0023
## Cumulative Proportion  0.94878 0.95115 0.95351 0.95586 0.95819 0.96050 0.9628
##                          PC176   PC177   PC178   PC179   PC180   PC181   PC182
## Standard deviation     1.07744 1.06860 1.06076 1.04951 1.04362 1.03643 1.02953
## Proportion of Variance 0.00229 0.00225 0.00222 0.00217 0.00215 0.00212 0.00209
## Cumulative Proportion  0.96508 0.96733 0.96955 0.97172 0.97386 0.97598 0.97807
##                          PC183  PC184   PC185   PC186   PC187   PC188   PC189
## Standard deviation     1.02162 1.0074 1.00170 0.98416 0.97791 0.96693 0.95399
## Proportion of Variance 0.00206 0.0020 0.00198 0.00191 0.00188 0.00184 0.00179
## Cumulative Proportion  0.98012 0.9821 0.98410 0.98600 0.98789 0.98973 0.99152
##                          PC190   PC191  PC192   PC193   PC194   PC195     PC196
## Standard deviation     0.95055 0.93319 0.9283 0.90959 0.89557 0.19769 4.351e-15
## Proportion of Variance 0.00178 0.00172 0.0017 0.00163 0.00158 0.00008 0.000e+00
## Cumulative Proportion  0.99330 0.99502 0.9967 0.99834 0.99992 1.00000 1.000e+00
```

Visualize the components.

```
tmp = data.frame(pcaMeth$x)
ggplot(data=tmp, aes(x=PC1, y=PC2)) + geom_point() + theme_bw()
```

![](data:image/png;base64...)

# 3 End of session

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
##  [1] CLLmethylation_1.30.0       ggplot2_4.0.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] ExperimentHub_3.0.0         AnnotationHub_4.0.0
## [13] BiocFileCache_3.0.0         dbplyr_2.5.1
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      gtable_0.3.6         xfun_0.54
##  [4] bslib_0.9.0          httr2_1.2.1          lattice_0.22-7
##  [7] vctrs_0.6.5          tools_4.5.1          curl_7.0.0
## [10] tibble_3.3.0         AnnotationDbi_1.72.0 RSQLite_2.4.3
## [13] blob_1.2.4           pkgconfig_2.0.3      Matrix_1.7-4
## [16] RColorBrewer_1.1-3   S7_0.2.0             lifecycle_1.0.4
## [19] farver_2.1.2         compiler_4.5.1       Biostrings_2.78.0
## [22] tinytex_0.57         htmltools_0.5.8.1    sass_0.4.10
## [25] yaml_2.3.10          pillar_1.11.1        crayon_1.5.3
## [28] jquerylib_0.1.4      DelayedArray_0.36.0  cachem_1.1.0
## [31] magick_2.9.0         abind_1.4-8          tidyselect_1.2.1
## [34] digest_0.6.37        purrr_1.1.0          dplyr_1.1.4
## [37] bookdown_0.45        BiocVersion_3.22.0   labeling_0.4.3
## [40] fastmap_1.2.0        grid_4.5.1           SparseArray_1.10.1
## [43] cli_3.6.5            magrittr_2.0.4       S4Arrays_1.10.0
## [46] dichromat_2.0-0.1    withr_3.0.2          scales_1.4.0
## [49] filelock_1.0.3       rappdirs_0.3.3       bit64_4.6.0-1
## [52] rmarkdown_2.30       XVector_0.50.0       httr_1.4.7
## [55] bit_4.6.0            png_0.1-8            memoise_2.0.1
## [58] evaluate_1.0.5       knitr_1.50           rlang_1.1.6
## [61] Rcpp_1.1.0           glue_1.8.0           DBI_1.2.3
## [64] BiocManager_1.30.26  jsonlite_2.0.0       R6_2.6.1
```