# Identifying DMCs using Bayesian functional regressions in BS-Seq data

Farhad Shokoohi1\*

1Department of Mathematical Sciences, University of Nevada, Las Vegas

\*shokoohi@icloud.com

#### 29 October 2025

#### Abstract

`Instructions on using the DMCFB package.`

#### Package

DMCFB 1.24.0

# Contents

* [1 Reading data](#reading-data)
  + [1.1 Reading bisulfite data (using files)](#reading-bisulfite-data-using-files)
  + [1.2 Reading bisulfite data (using matrices)](#reading-bisulfite-data-using-matrices)
* [2 Identifying DMCs](#identifying-dmcs)
* [3 Figures](#figures)
* [4 Session info](#session-info)

The `DMCFB` package is a pipeline to identify differentially methylated
cytosine (DMC) in bisulfite sequencing data using Bayesian functional
regression models.
In what follows we provides some guidelines on how to read your data and analyze
them.

# 1 Reading data

## 1.1 Reading bisulfite data (using files)

The R-method `readBismark()` is used to read bisulfite data files that are
created by `Bismark`. Each file must include six columns, with no header, that
represent

* Chromosome
* Start position in the chromosome
* End position in the chromosome
* Methylation level (m/(m+u))
* Number of methylated reads (m)
* Number of un-methylated reads (u)

and each row is a cytosine (or a small region) in DNA.

The function `readBismark(<files' paths>, <files' names>)` has two inputs:
‘the paths of the files’ and ‘the names of the files’.
Using this function an object of class `BSDMC` is created.
Extra information about data such as Age, Gender, Group, etc, must be assigned
to the object using `DataFrame` function.
As an example, we have provided three files in the package that can be read as
follows:

```
library(DMCFB)
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
#> Loading required package: BiocParallel
#> DMCFB package, Version 1.24.0, Released 2025-10-29
#> DMCFB is a pipeline for identifying differentially methylated
#>     cytosines using a Bayesian functional regression model in bisulfite
#>     sequencing data. By using a functional regression data model, it tries to
#>     capture position-specific, group-specific and other covariates-specific
#>     methylation patterns as well as spatial correlation patterns and unknown
#>     underlying models of methylation data. It is robust and flexible with
#>     respect to the true underlying models and inclusion of any covariates, and
#>     the missing values are imputed using spatial correlation between positions
#>     and samples. A Bayesian approach is adopted for estimation and inference in
#>     the proposed method.
#> BugReports: https://github.com/shokoohi/DMCFB/issues
#>
#> Attaching package: 'DMCFB'
#> The following object is masked from 'package:Biobase':
#>
#>     combine
#> The following object is masked from 'package:BiocGenerics':
#>
#>     combine
fn <- list.files(system.file("extdata",package = "DMCFB"))
fn.f <- list.files(system.file("extdata",package="DMCFB"), full.names=TRUE)
OBJ <- readBismark(fn.f, fn, mc.cores = 2)
#>
  |
  |                                                                      |   0%
#>
#> Processing sample blk.BCU1568_BC_BS_1 ...
#> Read 23710 records
#>
  |
  |=======================                                               |  33%
#>
#> Processing sample blk.BCU173_TC_BS_1 ...
#> Read 24421 records
#>
  |
  |===============================================                       |  67%
#>
#> Processing sample blk.BCU551_Mono_BS_1 ...
#> Read 23541 records
#>
  |
  |======================================================================| 100%
#>
#> Building BSDMC object.
cdOBJ <- DataFrame(Cell = factor(c("BC", "TC","Mono"),
levels = c("BC", "TC", "Mono")), row.names = c("BCU1568","BCU173","BCU551"))
colData(OBJ) <- cdOBJ
OBJ
#> class: BSDMC
#> dim: 25668 3
#> metadata(0):
#> assays(3): methReads totalReads methLevels
#> rownames(25668): 1 2 ... 25667 25668
#> rowData names(0):
#> colnames(3): BCU1568 BCU173 BCU551
#> colData names(1): Cell
```

## 1.2 Reading bisulfite data (using matrices)

Alternatively, one can use two integer matrices and a `DataFrame` to create
`BSDMC` object using `cBSDMC()` function. One matrix includes the read-depth and
the other one includes methylation reads. The columns of these matrices
represent samples and the rows represent cytosine positions.

Additional information about the genomic positions and covariates must be stored
in a `DataFrame` and then assign to the object.

The following exampel shows the details.

```
library(DMCFB)
set.seed(1980)
nr <- 1000
nc <- 8
metht <- matrix(as.integer(runif(nr * nc, 0, 100)), nr)
methc <- matrix(rbinom(n=nr*nc,c(metht),prob = runif(nr*nc)),nr,nc)
methl <- methc/metht
r1 <- GRanges(rep('chr1', nr), IRanges(1:nr, width=1), strand='*')
names(r1) <- 1:nr
cd1 <- DataFrame(Group=rep(c('G1','G2'),each=nc/2),row.names=LETTERS[1:nc])
OBJ2 <- cBSDMC(rowRanges=r1,methReads=methc,totalReads=metht,
  methLevels=methl,colData=cd1)
OBJ2
#> class: BSDMC
#> dim: 1000 8
#> metadata(0):
#> assays(3): methReads totalReads methLevels
#> rownames(1000): 1 2 ... 999 1000
#> rowData names(0):
#> colnames(8): A B ... G H
#> colData names(1): Group
```

# 2 Identifying DMCs

To identify DMCs, one need to use the function `findDMCFB()` function.
The function

```
library(DMCFB)
start.time <- Sys.time()
path0 <- "..//BCData/" # provide the path to the files
namelist.new <- list.files(path0,pattern="blk",full.names=F)
namelist.new.f <- list.files(path0,pattern="blk",full.names=T)
type <- NULL
for(i in seq_along(namelist.new)){
    type[i] <- unlist(strsplit(namelist.new[i], split=c('_'), fixed=TRUE))[2]
}
type
table(type)
indTC <- which(type=="TC")
indBC <- which(type=="BC")
indMono <- which(type=="Mono")
namelist.new <- namelist.new[c(indBC,indMono,indTC)]
namelist.new.f <- namelist.new.f[c(indBC,indMono,indTC)]
BLKDat <- readBismark(namelist.new.f, namelist.new, mc.cores = 2)
colData1 <- DataFrame(Group = factor(
  c(rep("BC",length(indBC)), rep("Mono",length(indMono)),
  rep("TC", length(indTC))), levels = c("BC", "Mono", "TC")),
  row.names = colnames(BLKData))
colData(BLKDat) <- colData1
BLK.BC.Mono.TC <- sort(BLKDat)
DMC.obj = findDMCFB(object = BLKDat, bwa = 30, bwb = 30, nBurn = 300, nMC = 300,
  nThin = 1, alpha = 5e-5, pSize = 500, sfiles = FALSE)
```

# 3 Figures

To plot DMCs one can use the `plotDMCFB()` function to plot an `BSDMC` object
that resulted from running `findDMCFB()` function.
To illustrate use the following example:

```
library(DMCFB)
set.seed(1980)
nr <- 1000
nc <- 8
metht <- matrix(as.integer(runif(nr * nc, 0, 100)), nr)
methc <- matrix(rbinom(n=nr*nc,c(metht),prob = runif(nr*nc)),nr,nc)
methl <- methc/metht
r1 <- GRanges(rep('chr1', nr), IRanges(1:nr, width=1), strand='*')
names(r1) <- 1:nr
cd1 <- DataFrame(Group=rep(c('G1','G2'),each=nc/2),row.names=LETTERS[1:nc])
OBJ1 <- cBSDMC(rowRanges=r1,methReads=methc,totalReads=metht,
  methLevels=methl,colData=cd1)
OBJ2 = findDMCFB(object = OBJ1, bwa = 30, bwb = 30, nBurn = 10, nMC = 10,
  nThin = 1, alpha = 0.05, pSize = 500, sfiles = FALSE)
#> ------------------------------------------------------------
#> Running Bayesian functional regression model ...
#> The priors's SD = 0.3027, estimated from data ...
#> Number of assigned cores: 4 ...
#> ------------------------------------------------------------
#> Fitted model:
#> logit(MethRead/ReadDepth) ~ F(Group)
#> ------------------------------------------------------------
#> Creating 1 batches of genomic positions ...
#> Running batch 1/1; chr1; 1000 positions; Region [   1, 1000]; Date 2025-10-29 23:39:31.906078
#> ------------------------------------------------------------
#> Combining 1 objects ...
#> Objects are combined.
#> ------------------------------------------------------------
#> Identifying DMCs ...
#> DMCs are identified.
#> ------------------------------------------------------------
#> Percentage of non-DMCs and DMCs:
#> Equal(%)   DMC(%)
#>     25.5     74.5
#> ------------------------------------------------------------
#> Percentage of hyper-, hypo-, and equal-methylated positions:
#>        Equal(%) Hyper(%) Hypo(%)
#> G2vsG1     25.5     37.4    37.1
#> ------------------------------------------------------------
plotDMCFB(OBJ2, region = c(1,400), nSplit = 2)
```

![](data:image/png;base64...)![](data:image/png;base64...)

# 4 Session info

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] DMCFB_1.24.0                BiocParallel_1.44.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1         dplyr_1.1.4              Biostrings_2.78.0
#>  [4] bitops_1.0-9             fastmap_1.2.0            RCurl_1.98-1.17
#>  [7] GenomicAlignments_1.46.0 XML_3.99-0.19            digest_0.6.37
#> [10] lifecycle_1.0.4          magrittr_2.0.4           compiler_4.5.1
#> [13] rlang_1.1.6              sass_0.4.10              tools_4.5.1
#> [16] yaml_2.3.10              data.table_1.17.8        rtracklayer_1.70.0
#> [19] knitr_1.50               S4Arrays_1.10.0          curl_7.0.0
#> [22] DelayedArray_0.36.0      abind_1.4-8              grid_4.5.1
#> [25] fastDummies_1.7.5        iterators_1.0.14         MASS_7.3-65
#> [28] tinytex_0.57             cli_3.6.5                rmarkdown_2.30
#> [31] crayon_1.5.3             reformulas_0.4.2         biglm_0.9-3
#> [34] httr_1.4.7               rjson_0.2.23             DBI_1.2.3
#> [37] minqa_1.2.8              cachem_1.1.0             stringr_1.5.2
#> [40] splines_4.5.1            parallel_4.5.1           BiocManager_1.30.26
#> [43] XVector_0.50.0           restfulr_0.0.16          vctrs_0.6.5
#> [46] boot_1.3-32              Matrix_1.7-4             jsonlite_2.0.0
#> [49] benchmarkme_1.0.8        bookdown_0.45            magick_2.9.0
#> [52] foreach_1.5.2            speedglm_0.3-5           jquerylib_0.1.4
#> [55] snow_0.4-4               glue_1.8.0               benchmarkmeData_1.0.4
#> [58] nloptr_2.2.1             codetools_0.2-20         stringi_1.8.7
#> [61] BiocIO_1.20.0            lme4_1.1-37              tibble_3.3.0
#> [64] pillar_1.11.1            htmltools_0.5.8.1        R6_2.6.1
#> [67] Rdpack_2.6.4             doParallel_1.0.17        evaluate_1.0.5
#> [70] lattice_0.22-7           rbibutils_2.3            Rsamtools_2.26.0
#> [73] cigarillo_1.0.0          arm_1.14-4               bslib_0.9.0
#> [76] Rcpp_1.1.0               coda_0.19-4.1            SparseArray_1.10.0
#> [79] nlme_3.1-168             xfun_0.53                pkgconfig_2.0.3
```