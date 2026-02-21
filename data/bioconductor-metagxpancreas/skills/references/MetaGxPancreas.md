# MetaGxPancreas: A Package for Pancreatic Cancer Gene Expression Analysis

Michael Zon1, Vandana Sandhu1 and Benjamin Haibe-Kains1,2\*

1Department of Medical Biophysics, University of Toronto, Toronto, Canada
2Bioinformatics and Computational Genomics Laboratory, Princess Margaret Cancer Center, University Health Network, Toronto, Ontario, Canada

\*benjamin.haibe.kains@utoronto.ca

#### 4 November 2025

## 0.1 Installing the Package

The MetaGxPancreas package is a compendium of Pancreatic Cancer datasets.
The package is publicly available and can be installed from Bioconductor into R
version 3.6.0 or higher. Currently, the phenoData for the datasets is overall
survival status and overall survival time. This survival information is
available for 11 of the 15 datasets.

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("MetaGxPancreas")
```

## 0.2 Loading Datasets

First we load the MetaGxPancreas package into the workspace.

```
library(MetaGxPancreas)
```

```
## Loading required package: SummarizedExperiment
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
## Loading required package: ExperimentHub
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
##
## Attaching package: 'AnnotationHub'
```

```
## The following object is masked from 'package:Biobase':
##
##     cache
```

Then we load the datasets.

```
pancreasData <- loadPancreasDatasets()
```

```
## Filtered out duplicated samples: ICGC_0400, ICGC_0402, GSM388116, GSM388118, GSM388120, GSM388145, GSM299238, GSM299239, GSM299240
```

```
duplicates <- pancreasData$duplicates
SEs <- pancreasData$SummarizedExperiments
```

This will load 15 expression datasets. Users can modify the parameters of the function to restrict datasets that do not
meet certain criteria for loading. Some example parameters are shown below:

* removeDuplicates: remove patients with a Spearman correlation greater than or equal to 0.98 with other patient expression
  profiles (default TRUE)
* quantileCutoff: A numeric between 0 and 1 specifying to remove genes with standard deviation below the required
  quantile (default 0)
* rescale: apply centering and scaling to the expression sets (default FALSE)
* minNumberGenes: an integer specifying to remove expression sets with less genes than this number (default 0)
* minSampleSize: an integer specifying the minimum number of patients required in an SE (default 0)
* minNumberEvents: an integer specifying how man survival events must be in the dataset to keep the dataset (default 0)
* removeSeqSubset currently only removes the ICGSSEQ dataset as it contains the same patients as the ICGS microarray
  dataset (defeault TRUE, currently just ICGSSEQ)
* keepCommonOnly remove probes not common to all datasets (default FALSE)
* imputeMissing impute missing expression value via knn

## 0.3 Obtaining Sample Counts in Datasets

To obtain the number of samples per dataset, run the following:

```
numSamples <- vapply(
  SEs,
  function(SE) length(colnames(SE)),
  FUN.VALUE = numeric(1)
)

sampleNumberByDataset <- data.frame(
  numSamples = numSamples,
  row.names = names(SEs)
)

totalNumSamples <- sum(sampleNumberByDataset$numSamples)
sampleNumberByDataset <- rbind(sampleNumberByDataset, totalNumSamples)
rownames(sampleNumberByDataset)[nrow(sampleNumberByDataset)] <- 'Total'

knitr::kable(sampleNumberByDataset)
```

|  | numSamples |
| --- | --- |
| BADEA\_SumExp | 35 |
| BALAGURANATH\_SumExp | 25 |
| CHEN\_SumExp | 63 |
| COLLISON\_SumExp | 27 |
| GRUTZMANN\_SumExp | 11 |
| ICGCSEQ\_SumExp | 95 |
| ICGCMICRO\_SumExp | 265 |
| KIRBY\_SumExp | 51 |
| OUH\_SumExp | 48 |
| PCSI\_SumExp | 210 |
| PEI\_SumExp | 36 |
| TCGA\_SumExp | 146 |
| UNC\_SumExp | 125 |
| WINTER\_SumExp | 30 |
| ZHANG\_SumExp | 42 |
| HAMIDI\_SumExp | 46 |
| YANG\_SumExp | 69 |
| LUNARDI\_SumExp | 45 |
| JANKY\_SumExp | 118 |
| BAUER\_SumExp | 195 |
| HAIDER\_SumExp | 28 |
| Total | 1710 |

## 0.4 SessionInfo

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
##  [1] MetaGxPancreas_1.30.0       ExperimentHub_3.0.0
##  [3] AnnotationHub_4.0.0         BiocFileCache_3.0.0
##  [5] dbplyr_2.5.1                SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      impute_1.84.0        xfun_0.54
##  [4] bslib_0.9.0          httr2_1.2.1          lattice_0.22-7
##  [7] vctrs_0.6.5          tools_4.5.1          curl_7.0.0
## [10] tibble_3.3.0         AnnotationDbi_1.72.0 RSQLite_2.4.3
## [13] blob_1.2.4           pkgconfig_2.0.3      Matrix_1.7-4
## [16] lifecycle_1.0.4      compiler_4.5.1       Biostrings_2.78.0
## [19] htmltools_0.5.8.1    sass_0.4.10          yaml_2.3.10
## [22] pillar_1.11.1        crayon_1.5.3         jquerylib_0.1.4
## [25] DelayedArray_0.36.0  cachem_1.1.0         abind_1.4-8
## [28] tidyselect_1.2.1     digest_0.6.37        purrr_1.1.0
## [31] dplyr_1.1.4          bookdown_0.45        BiocVersion_3.22.0
## [34] fastmap_1.2.0        grid_4.5.1           cli_3.6.5
## [37] SparseArray_1.10.1   magrittr_2.0.4       S4Arrays_1.10.0
## [40] withr_3.0.2          filelock_1.0.3       rappdirs_0.3.3
## [43] bit64_4.6.0-1        rmarkdown_2.30       XVector_0.50.0
## [46] httr_1.4.7           bit_4.6.0            png_0.1-8
## [49] memoise_2.0.1        evaluate_1.0.5       knitr_1.50
## [52] rlang_1.1.6          glue_1.8.0           DBI_1.2.3
## [55] BiocManager_1.30.26  jsonlite_2.0.0       R6_2.6.1
```