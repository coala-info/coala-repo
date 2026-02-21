# Predicting cell cycle phase using peco

#### Joyce Hsiao

#### 2025-10-30

## Installation

To install and load the package, run:

```
install.packages("devtools")
library(devtools)
install_github("jhsiao999/peco")
```

`peco` uses `SingleCellExperiment` class objects.

```
library(peco)
library(SingleCellExperiment)
#> Loading required package: SummarizedExperiment
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#>
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#>
#>     anyMissing, rowMedians
library(doParallel)
#> Loading required package: foreach
#> Loading required package: iterators
#> Loading required package: parallel
library(foreach)
```

## Overview

`peco` is a supervised approach for PrEdicting cell cycle phase in a COntinuum using single-cell RNA sequencing data. The R package provides functions to build training dataset and also functions to use existing training data to predict cell cycle on a continuum.

Our work demonstrated that peco is able to predict continuous cell cylce phase using a small set of cylcic genes: *CDK1*, *UBE2C*, *TOP2A*, *HISTH1E*, and *HISTH1C* (identified as cell cycle marker genes in studies of yeast ([Spellman et al., 1998](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC25624)) and HeLa cells ([Whitfield et al., 2002](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC117619))).

Below we provide two use cases. Vignette 1 shows how to use the built-training dataset to predict continuous cell cycle. Vignette 2 shows how to make a training datast and build a predictor using training data.

Users can also view the vigenettes via `browseVignettes("peco")`.

## About the training dataset

`training_human` stores built-in training data of 101 significant cyclic genes. Below are the slots contained in `training_human`:

* `predict.yy`: a gene by sample matrix (101 by 888) that stores predict cyclic expression values.
* `cellcycle_peco_reordered`: cell cycle phase in a unit circle (angle), ordered from 0 to 2\(pi\)
* `cellcycle_function`: lists of 101 function corresponding to the top 101 cyclic genes identified in our dataset
* `sigma`: standard error associated with cyclic trends of gene expression
* `pve`: proportion of variance explained by the cyclic trend

```
data("training_human")
```

## Predict cell cycle phase using gene expression data

`peco` is integrated with `SingleCellExperiment` object in Bioconductor. Below shows an example of inputting `SingleCellExperiment` object to perform cell cycle phase prediction.

`sce_top101genes` includes 101 genes and 888 single-cell samples and one assay slot of `counts`.

```
data("sce_top101genes")
assays(sce_top101genes)
#> List of length 1
#> names(1): counts
```

Transform the expression values to quantile-normalizesd counts-per-million values. `peco` uses the `cpm_quantNormed` slot as input data for predictions.

```
sce_top101genes <- data_transform_quantile(sce_top101genes)
#> computing on 2 cores
assays(sce_top101genes)
#> List of length 3
#> names(3): counts cpm cpm_quantNormed
```

Apply the prediction model using function `cycle_npreg_outsample` and generate prediction results contained in a list object `pred_top101genes`.

```
pred_top101genes <- cycle_npreg_outsample(
    Y_test=sce_top101genes,
    sigma_est=training_human$sigma[rownames(sce_top101genes),],
    funs_est=training_human$cellcycle_function[rownames(sce_top101genes)],
    method.trend="trendfilter",
    ncores=1,
    get_trend_estimates=FALSE)
```

The `pred_top101genes$Y` contains a SingleCellExperiment object with the predict cell cycle phase in the `colData` slot.

```
head(colData(pred_top101genes$Y)$cellcycle_peco)
#> 20170905-A01 20170905-A02 20170905-A03 20170905-A06 20170905-A07 20170905-A08
#>     1.099557     4.680973     2.544690     4.303982     4.052655     1.413717
```

Visualize results of prediction for one gene. Below we choose CDK1 (“ENSG00000170312”). Because CDK1 is a known cell cycle gene, this visualization serves as a sanity check for the results of fitting. The fitted function `training_human$cellcycle_function[[1]]` was obtained from our training data.

```
plot(y=assay(pred_top101genes$Y,"cpm_quantNormed")["ENSG00000170312",],
     x=colData(pred_top101genes$Y)$theta_shifted, main = "CDK1",
     ylab = "quantile normalized expression")
points(y=training_human$cellcycle_function[["ENSG00000170312"]](seq(0,2*pi, length.out=100)),
       x=seq(0,2*pi, length.out=100), col = "blue", pch =16)
```

![](data:image/png;base64...)

## Visualize cyclic expression trend based on predicted phase

Visualize results of prediction for the top 10 genesone genes. Use `fit_cyclical_many` to estimate cyclic function based on the input data.

```
# predicted cell time in the input data
theta_predict = colData(pred_top101genes$Y)$cellcycle_peco
names(theta_predict) = rownames(colData(pred_top101genes$Y))

# expression values of 10 genes in the input data
yy_input = assay(pred_top101genes$Y,"cpm_quantNormed")[1:6,]

# apply trendfilter to estimate cyclic gene expression trend
fit_cyclic <- fit_cyclical_many(Y=yy_input,
                                theta=theta_predict)
#> computing on 2 cores

gene_symbols = rowData(pred_top101genes$Y)$hgnc[rownames(yy_input)]

par(mfrow=c(2,3))
for (i in 1:6) {
plot(y=yy_input[i,],
     x=fit_cyclic$cellcycle_peco_ordered,
     main = gene_symbols[i],
     ylab = "quantile normalized expression")
points(y=fit_cyclic$cellcycle_function[[i]](seq(0,2*pi, length.out=100)),
       x=seq(0,2*pi, length.out=100), col = "blue", pch =16)
}
```

![](data:image/png;base64...)

## Session information

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] doParallel_1.0.17           iterators_1.0.14
#>  [3] foreach_1.5.2               SingleCellExperiment_1.32.0
#>  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [9] IRanges_2.44.0              S4Vectors_0.48.0
#> [11] BiocGenerics_0.56.0         generics_0.1.4
#> [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [15] peco_1.22.0
#>
#> loaded via a namespace (and not attached):
#>  [1] beeswarm_0.4.0      gtable_0.3.6        xfun_0.53
#>  [4] bslib_0.9.0         ggplot2_4.0.0       ggrepel_0.9.6
#>  [7] lattice_0.22-7      vctrs_0.6.5         tools_4.5.1
#> [10] tibble_3.3.0        pkgconfig_2.0.3     BiocNeighbors_2.4.0
#> [13] Matrix_1.7-4        RColorBrewer_1.1-3  S7_0.2.0
#> [16] assertthat_0.2.1    lifecycle_1.0.4     compiler_4.5.1
#> [19] farver_2.1.2        circular_0.5-2      conicfit_1.0.4
#> [22] codetools_0.2-20    vipor_0.4.7         htmltools_0.5.8.1
#> [25] sass_0.4.10         yaml_2.3.10         pracma_2.4.6
#> [28] pillar_1.11.1       jquerylib_0.1.4     BiocParallel_1.44.0
#> [31] DelayedArray_0.36.0 cachem_1.1.0        viridis_0.6.5
#> [34] boot_1.3-32         abind_1.4-8         tidyselect_1.2.1
#> [37] rsvd_1.0.5          digest_0.6.37       mvtnorm_1.3-3
#> [40] dplyr_1.1.4         BiocSingular_1.26.0 fastmap_1.2.0
#> [43] grid_4.5.1          cli_3.6.5           SparseArray_1.10.0
#> [46] scater_1.38.0       magrittr_2.0.4      S4Arrays_1.10.0
#> [49] genlasso_1.6.1      dichromat_2.0-0.1   scales_1.4.0
#> [52] ggbeeswarm_0.7.2    rmarkdown_2.30      XVector_0.50.0
#> [55] igraph_2.2.1        gridExtra_2.3       ScaledMatrix_1.18.0
#> [58] beachmat_2.26.0     evaluate_1.0.5      knitr_1.50
#> [61] viridisLite_0.4.2   irlba_2.3.5.1       rlang_1.1.6
#> [64] Rcpp_1.1.0          glue_1.8.0          scuttle_1.20.0
#> [67] geigen_2.3          jsonlite_2.0.0      R6_2.6.1
```