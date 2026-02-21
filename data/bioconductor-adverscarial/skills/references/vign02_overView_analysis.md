title: “adverSCarial, generate and analyze the vulnerability of scRNA-seq
classifiers to adversarial attacks”
shorttitle: “adverSCarial”
author: Ghislain FIEVET ghislain.fievet@gmail.com
package: adverSCarial
abstract: >
adverSCarial is an R Package designed for generating and analyzing the vulnerability of scRNA-seq
classifiers to adversarial attacks. The package is versatile and provides a format for integrating
any type of classifier. It offers functions for studying and generating two types of attacks,
min change attack and max change attack. The single gene attack involves making a small modification
to the input to alter the classification. The max change attack involves making a large modification
to the input without changing its classification.
The package provides a comprehensive solution for evaluating the robustness of scRNA-seq classifiers
against adversarial attacks.
vignette: >
%\VignetteIndexEntry{Vign02\_overView\_analysis}
%\VignetteEngine{knitr::knitr}
%\VignetteEncoding{UTF-8}

# Load data

```
library(adverSCarial)
library(LoomExperiment)
library(DelayedArray)
```

## Load loom file

```
pbmcPath <- system.file("extdata", "pbmc_short.loom", package="adverSCarial")
lfile <- import(pbmcPath, type="SingleCellLoomExperiment")
```

```
matPbmc <- counts(lfile)
```

```
matPbmc[1:5,1:5]
```

```
## <5 x 5> DelayedMatrix object of type "integer":
##      NEK11 IL5RA OR4C5 KHDRBS3 OPA3
## [1,]     0     0     0       0    0
## [2,]     0     0     0       0    0
## [3,]     0     0     0       0    0
## [4,]     0     0     0       0    0
## [5,]     0     0     0       0    0
```

## Load cell type annotations

```
cellTypes <- rowData(lfile)$cell_type
```

```
head(cellTypes)
```

```
## [1] "Naive CD4 T"  "Naive CD4 T"  "FCGR3A+ Mono" "Naive CD4 T"  "B"
## [6] "Naive CD4 T"
```

# Run vulnerability analysis with `singleGeneOverview` and `maxChangeOverview`

The `singleGeneOverview` and `maxChangeOverview` functions are designed to provide insight into of the min and max change adversarial attacks on each cell type, on various gene modifications.

## Which attack to choose?

Before generating an attack it is judicious to choose the cell type to attack, and the modification susceptible to lead to a successful attack. Both functions run attack approximations, faster than the original, by studying splices of 100 genes.

## Which classifier is more vulnerable to adversarial attacks?

Sometimes we want to compare two classifiers and see which one is more vulnerable to adversarial attacks.

## Which modifications to compare

Here we define the modifications to analyse, the predefined `perc1`, and a custom function returning high outliers called `modifOutlier`.

```
modifOutlier <- function(x, y){
    return (max(x)*1000)
}
```

```
modifications <- list(c("perc1"), c("full_row_fct", modifOutlier))
```

We run the `singleGeneOverview`, this gives us a general idea of which cell types are more vulnerable to single gene attacks.

```
min_change_overview <- singleGeneOverview(matPbmc, cellTypes, MClassifier,
    modifications= modifications, maxSplitSize = 20, firstDichot = 5)
```

```
min_change_overview
```

```
## DataFrame with 10 rows and 2 columns
##                  perc1
##              <numeric>
## Naive CD4 T          1
## FCGR3A+ Mono         1
## B                    1
## Memory CD4 T         1
## CD14+ Mono           1
## CD8 T                1
## UNDETERMINED         0
## NK                   1
## Platelet             1
## DC                   1
##              full_row_fct_function..x..y.........return.max.x....1000...
##                                                                <numeric>
## Naive CD4 T                                                            3
## FCGR3A+ Mono                                                           2
## B                                                                      7
## Memory CD4 T                                                           8
## CD14+ Mono                                                             6
## CD8 T                                                                  4
## UNDETERMINED                                                           8
## NK                                                                     5
## Platelet                                                               0
## DC                                                                     1
```

And the `maxChangeOverview`, giving us a general idea of which cell types are more vulnerable to max change attacks.

```
max_change_overview <- maxChangeOverview(matPbmc, cellTypes, MClassifier,
    modifications= modifications, maxSplitSize = 20)
```

```
max_change_overview
```

```
## DataFrame with 10 rows and 2 columns
##                  perc1
##              <numeric>
## Naive CD4 T          1
## FCGR3A+ Mono         1
## B                    1
## Memory CD4 T         1
## CD14+ Mono           1
## CD8 T                1
## UNDETERMINED         1
## NK                   1
## Platelet             1
## DC                   1
##              full_row_fct_function..x..y.........return.max.x....1000...
##                                                                <numeric>
## Naive CD4 T                                                          163
## FCGR3A+ Mono                                                         176
## B                                                                    112
## Memory CD4 T                                                          99
## CD14+ Mono                                                           125
## CD8 T                                                                151
## UNDETERMINED                                                          86
## NK                                                                   138
## Platelet                                                             200
## DC                                                                   188
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
##  [1] DelayedArray_0.36.0         SparseArray_1.10.0
##  [3] S4Arrays_1.10.0             abind_1.4-8
##  [5] Matrix_1.7-4                LoomExperiment_1.28.0
##  [7] BiocIO_1.20.0               rhdf5_2.54.0
##  [9] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [17] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [19] generics_0.1.4              adverSCarial_1.8.0
##
## loaded via a namespace (and not attached):
##  [1] compiler_4.5.1      stringr_1.5.2       rhdf5filters_1.22.0
##  [4] lattice_0.22-7      XVector_0.50.0      commonmark_2.0.0
##  [7] knitr_1.50          h5mread_1.2.0       rlang_1.1.6
## [10] HDF5Array_1.38.0    stringi_1.8.7       litedown_0.7
## [13] xfun_0.53           cli_3.6.5           magrittr_2.0.4
## [16] Rhdf5lib_1.32.0     grid_4.5.1          markdown_2.0
## [19] lifecycle_1.0.4     evaluate_1.0.5      glue_1.8.0
## [22] tools_4.5.1
```