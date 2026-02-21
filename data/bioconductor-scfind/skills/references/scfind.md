# `scfind` package vignette

Vladimir Kiselev

#### *2019-01-04*

# Contents

* [1 Introduction](#introduction)
* [2 `SingleCellExperiment` class](#singlecellexperiment-class)
* [3 `scfind` Input](#scfind-input)
* [4 Cell Type Search](#cell-type-search)
* [5 Cell Search](#cell-search)
* [6 sessionInfo()](#sessioninfo)

# 1 Introduction

# 2 `SingleCellExperiment` class

`scfind` is built on top of the Bioconductor’s [SingleCellExperiment](https://bioconductor.org/packages/SingleCellExperiment) class. `scfind` operates on objects of class `SingleCellExperiment` and writes all of its results back to the the object.

# 3 `scfind` Input

If you already have an `SCESet` object, then proceed to the next chapter.

If you have a matrix or a data frame containing expression data then you first need to create an `SingleCellExperiment` object containing your data. For illustrative purposes we will use an example expression matrix provided with `scfind`. The dataset (`yan`) represents **FPKM** gene expression of 90 cells derived from human embryo. The authors ([Yan et al.](http://dx.doi.org/10.1038/nsmb.2660)) have defined developmental stages of all cells in the original publication (`ann` data frame). We will use these stages in projection later.

```
library(SingleCellExperiment)
library(scfind)

head(ann)
```

```
##                 cell_type1
## Oocyte..1.RPKM.     zygote
## Oocyte..2.RPKM.     zygote
## Oocyte..3.RPKM.     zygote
## Zygote..1.RPKM.     zygote
## Zygote..2.RPKM.     zygote
## Zygote..3.RPKM.     zygote
```

```
yan[1:3, 1:3]
```

```
##          Oocyte..1.RPKM. Oocyte..2.RPKM. Oocyte..3.RPKM.
## C9orf152             0.0             0.0             0.0
## RPS11             1219.9          1021.1           931.6
## ELMO2                7.0            12.2             9.3
```

Note that the cell type information has to be stored in the `cell_type1` column of the `rowData` slot of the `SingleCellExperiment` object.

Now let’s create a `SingleCellExperiment` object of the `yan` dataset:

```
sce <- SingleCellExperiment(assays = list(normcounts = as.matrix(yan)), colData = ann)
# this is needed to calculate dropout rate for feature selection
# important: normcounts have the same zeros as raw counts (fpkm)
counts(sce) <- normcounts(sce)
logcounts(sce) <- log2(normcounts(sce) + 1)
# use gene names as feature symbols
rowData(sce)$feature_symbol <- rownames(sce)
isSpike(sce, "ERCC") <- grepl("^ERCC-", rownames(sce))
# remove features with duplicated names
sce <- sce[!duplicated(rownames(sce)), ]
sce
```

```
## class: SingleCellExperiment
## dim: 20214 90
## metadata(0):
## assays(3): normcounts counts logcounts
## rownames(20214): C9orf152 RPS11 ... CTSC AQP7
## rowData names(1): feature_symbol
## colnames(90): Oocyte..1.RPKM. Oocyte..2.RPKM. ...
##   Late.blastocyst..3..Cell.7.RPKM. Late.blastocyst..3..Cell.8.RPKM.
## colData names(1): cell_type1
## reducedDimNames(0):
## spikeNames(1): ERCC
```

# 4 Cell Type Search

If one has a list of genes that you would like to check against you dataset,
i.e. find the cell types that most likely represent your genes (highest expression), then `scfind` allows one to do that by first creating a gene index and then very quickly searching the index:

```
geneIndex <- buildCellTypeIndex(sce)
p_values <- -log10(findCellType(geneIndex, c("SOX6", "SNAI3")))
barplot(p_values, ylab = "-log10(pval)", las = 2)
```

![](data:image/png;base64...)

The calculation above shows that a list of genes containing `SOX6` and `SNAI3` is specific for the `zygote` cell type.

# 5 Cell Search

If one is more interested in finding out in which cells all the genes from your
gene list are expressed than you can build a cell index instead of a
cell type index. `buildCellIndex` function should be used for building the index
and `findCell` for searching the index:

```
geneIndex <- buildCellIndex(sce)
res <- findCell(geneIndex, c("SOX6", "SNAI3"))
res$common_exprs_cells
```

```
##   cell_id cell_type
## 1       2    zygote
## 2       3    zygote
## 3       5    zygote
## 4       6    zygote
## 5      23     4cell
## 6      25     8cell
## 7      27     8cell
## 8      58    16cell
## 9      68     blast
```

Cell search reports the p-values corresponding to cell types as well:

```
barplot(-log10(res$p_values), ylab = "-log10(pval)", las = 2)
```

![](data:image/png;base64...)

# 6 sessionInfo()

```
## R version 3.5.2 (2018-12-20)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] bindrcpp_0.2.2              scfind_1.4.1
##  [3] SingleCellExperiment_1.4.1  SummarizedExperiment_1.12.0
##  [5] DelayedArray_0.8.0          BiocParallel_1.16.5
##  [7] matrixStats_0.54.0          Biobase_2.42.0
##  [9] GenomicRanges_1.34.0        GenomeInfoDb_1.18.1
## [11] IRanges_2.16.0              S4Vectors_0.20.1
## [13] BiocGenerics_0.28.0         knitr_1.21
## [15] BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.0             plyr_1.8.4             pillar_1.3.1
##  [4] bindr_0.1.1            compiler_3.5.2         BiocManager_1.30.4
##  [7] XVector_0.22.0         bitops_1.0-6           tools_3.5.2
## [10] zlibbioc_1.28.0        digest_0.6.18          bit_1.1-14
## [13] tibble_2.0.0           evaluate_0.12          lattice_0.20-38
## [16] pkgconfig_2.0.2        rlang_0.3.0.1          Matrix_1.2-15
## [19] yaml_2.2.0             xfun_0.4               GenomeInfoDbData_1.2.0
## [22] stringr_1.3.1          dplyr_0.7.8            tidyselect_0.2.5
## [25] grid_3.5.2             glue_1.3.0             R6_2.3.0
## [28] hash_2.2.6             rmarkdown_1.11         bookdown_0.9
## [31] reshape2_1.4.3         purrr_0.2.5            magrittr_1.5
## [34] codetools_0.2-16       htmltools_0.3.6        assertthat_0.2.0
## [37] stringi_1.2.4          RCurl_1.95-4.11        crayon_1.3.4
```