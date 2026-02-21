# DMCHMM: Differentially Methylated CpG using Hidden Markov Model

#### Farhad Shokoohi

#### 2025-10-29

DNA methylation studies have increased in number over the past decade thanks to the recent advances in next-generation sequencing (NGS) and microarray technology (MA), providing many data sets at high resolution, enabling researchers to understand methylation patterns and their regulatory roles in biological processes and diseases.
Notwithstanding that diverse methods and software have created ample opportunities for researchers to do quantitative analysis, they make it difficult for practitioners to choose the one that is suitable and efficient in analyzing DNA methylation data. Having examined most of differentially methylation identification tools for bisulfite sequencing (BS-Seq) data, we observed several drawbacks in the existing analytic tools. To address these issues we have developed a novel differentially methylated CpG site identification tool which is based on Hidden Markov models (HMM) called `DMCHMM`. This vignette provides some guidelines on how to use the package and analyze BS-Seq data.

Following topics will be discussed in this vignette:

* **Reading BS-Seq data**
* **Simulating BS-Seq data**
* **Predicting methylation levels using HMM and EM algorithm**
* **Predicting methylation levels using HMM and MCMC algorithm**
* **Identifying DMCs**

## S4 Classes

Two different classes are defined by extending the `SummarizedExperiment-class`. The `BSData-class` is designed to hold BS-Seq data. Similarly, `cBSData-method` is defined to create a `BSData` object. This class includes two slots: the `methReads`, a matrix with columns representing samples and rows representing genomic positions (CpG sites) and elements of matrix representing methylation counts at each position in each sample; the `totalReads`, a matrix with similar columns and rows except the elements representing total number of reads.

## Reading BS-Seq data

For reading raw BS-Seq data we adopted The `readBismark` function from `BiSeq` package. The `readBismark-method` reads samples stored in different files with six columns of *chromosome*, *start position*, *end position*, *methylation percentage*, *number of Cs* and *number of Ts*.

Three data files are included in the `DMCHMM` package for illustration. The data can be imported using following code.

```
library(DMCHMM)
fn <- list.files(system.file("extdata",package = "DMCHMM"))
fn.f <- list.files(system.file("extdata",package="DMCHMM"), full.names=TRUE)
OBJ <- readBismark(fn.f, fn, mc.cores = 2)
```

```
##   |                                                                              |                                                                      |   0%
```

```
##   |                                                                              |=======================                                               |  33%
```

```
##   |                                                                              |===============================================                       |  67%
```

```
##   |                                                                              |======================================================================| 100%
##
## Building BSData object.
```

```
cdOBJ <- DataFrame(Cell = factor(c("BC", "TC","Mono"),
labels = c("BC", "TC", "Mono")), row.names = c("BCU1568","BCU173","BCU551"))
colData(OBJ) <- cdOBJ
OBJ
```

```
## class: BSData
## dim: 25668 3
## metadata(0):
## assays(2): totalReads methReads
## rownames(25668): 1 2 ... 25667 25668
## rowData names(0):
## colnames(3): BCU1568 BCU173 BCU551
## colData names(1): Cell
```

## Simulating BS-Seq data

The above data set only include one sample for each cell type. We need more samples to be able to compare their methylations and find DMCs. For illustration we generate a sample of BS-Seq data as follows.

```
nr <- 150; nc <- 8
metht <- matrix(as.integer(runif(nr * nc, 0, 20)), nr)
methc <- matrix(rbinom(n=nr*nc,c(metht),prob = runif(nr*nc)),nr,nc)
r1 <- GRanges(rep("chr1", nr), IRanges(1:nr, width=1), strand="*")
names(r1) <- 1:nr
cd1 <- DataFrame(Group=rep(c("G1","G2"),each=nc/2),row.names=LETTERS[1:nc])
OBJ1 <- cBSData(rowRanges=r1,methReads=methc,totalReads=metht,colData=cd1)
OBJ1
```

```
## class: BSData
## dim: 150 8
## metadata(0):
## assays(2): totalReads methReads
## rownames(150): 1 2 ... 149 150
## rowData names(0):
## colnames(8): A B ... G H
## colData names(1): Group
```

## Predicting methylation levels using HMM and EM algorithm

There are two approaches to smoothed the data before testing for DMCs. Either EM or MCMC can be used to predict methylation levels utilizing HMM. The `methHMEM-method` which is developed to predict methylation levels. The output is a `BSDMCs-class` that can be either used to find DMCs or use MCMC algorithm to re-smooth the raw data. The process is as follows.

```
OBJ2 <- methHMEM(OBJ1, MaxK=2)
```

```
##   |                                                                              |                                                                      |   0%  |                                                                              |=========                                                             |  12%  |                                                                              |==================                                                    |  25%  |                                                                              |==========================                                            |  38%  |                                                                              |===================================                                   |  50%  |                                                                              |============================================                          |  62%  |                                                                              |====================================================                  |  75%  |                                                                              |=============================================================         |  88%  |                                                                              |======================================================================| 100%
```

```
OBJ2
```

```
## class: BSDMCs
## dim: 150 8
## metadata(3): K Beta Pm
## assays(5): methReads totalReads methLevels methStates methVars
## rownames(150): 1 2 ... 149 150
## rowData names(0):
## colnames(8): A B ... G H
## colData names(1): Group
```

## Predicting methylation levels using HMM and MCMC algorithm

Although EM algorithm is a fast way to smooth the data but the results are not as good as the MCMC algorithm. The MCMC algorithm, however, is slow. In order to increase the speed, we first use `methHMEM-method` to find the HMM order for each sample and then we use `methHMCMC-method` to predict methylation levels. The procedure is as follows.

```
OBJ3 <- methHMMCMC(OBJ2)
```

```
##   |                                                                              |                                                                      |   0%  |                                                                              |=========                                                             |  12%  |                                                                              |==================                                                    |  25%  |                                                                              |==========================                                            |  38%  |                                                                              |===================================                                   |  50%  |                                                                              |============================================                          |  62%  |                                                                              |====================================================                  |  75%  |                                                                              |=============================================================         |  88%  |                                                                              |======================================================================| 100%
```

```
OBJ3
```

```
## class: BSDMCs
## dim: 150 8
## metadata(3): K Beta Pm
## assays(5): methReads totalReads methLevels methStates methVars
## rownames(150): 1 2 ... 149 150
## rowData names(0):
## colnames(8): A B ... G H
## colData names(1): Group
```

## Identifying DMCs

Having smoothed the data using HMM, we run linear between predicted methylation levels and grouping covariate. In case other covariates exist, one can use the `formula` argument to specify a linear model. When there is no covariates no action is required. The following command identifies the DMCs. The results are stored in a `BSDMCs-class` and can be retrieved by calling `metadata` command.

```
OBJ4 <- findDMCs(OBJ3)
```

```
##   |                                                                              |                                                                      |   0%  |                                                                              |                                                                      |   1%  |                                                                              |=                                                                     |   1%  |                                                                              |=                                                                     |   2%  |                                                                              |==                                                                    |   3%  |                                                                              |===                                                                   |   4%  |                                                                              |===                                                                   |   5%  |                                                                              |====                                                                  |   5%  |                                                                              |====                                                                  |   6%  |                                                                              |=====                                                                 |   7%  |                                                                              |======                                                                |   8%  |                                                                              |======                                                                |   9%  |                                                                              |=======                                                               |   9%  |                                                                              |=======                                                               |  10%  |                                                                              |=======                                                               |  11%  |                                                                              |========                                                              |  11%  |                                                                              |========                                                              |  12%  |                                                                              |=========                                                             |  13%  |                                                                              |==========                                                            |  14%  |                                                                              |==========                                                            |  15%  |                                                                              |===========                                                           |  15%  |                                                                              |===========                                                           |  16%  |                                                                              |============                                                          |  17%  |                                                                              |=============                                                         |  18%  |                                                                              |=============                                                         |  19%  |                                                                              |==============                                                        |  19%  |                                                                              |==============                                                        |  20%  |                                                                              |==============                                                        |  21%  |                                                                              |===============                                                       |  21%  |                                                                              |===============                                                       |  22%  |                                                                              |================                                                      |  23%  |                                                                              |=================                                                     |  24%  |                                                                              |=================                                                     |  25%  |                                                                              |==================                                                    |  25%  |                                                                              |==================                                                    |  26%  |                                                                              |===================                                                   |  27%  |                                                                              |====================                                                  |  28%  |                                                                              |====================                                                  |  29%  |                                                                              |=====================                                                 |  29%  |                                                                              |=====================                                                 |  30%  |                                                                              |=====================                                                 |  31%  |                                                                              |======================                                                |  31%  |                                                                              |======================                                                |  32%  |                                                                              |=======================                                               |  33%  |                                                                              |========================                                              |  34%  |                                                                              |========================                                              |  35%  |                                                                              |=========================                                             |  35%  |                                                                              |=========================                                             |  36%  |                                                                              |==========================                                            |  37%  |                                                                              |===========================                                           |  38%  |                                                                              |===========================                                           |  39%  |                                                                              |============================                                          |  39%  |                                                                              |============================                                          |  40%  |                                                                              |============================                                          |  41%  |                                                                              |=============================                                         |  41%  |                                                                              |=============================                                         |  42%  |                                                                              |==============================                                        |  43%  |                                                                              |===============================                                       |  44%  |                                                                              |===============================                                       |  45%  |                                                                              |================================                                      |  45%  |                                                                              |================================                                      |  46%  |                                                                              |=================================                                     |  47%  |                                                                              |==================================                                    |  48%  |                                                                              |==================================                                    |  49%  |                                                                              |===================================                                   |  49%  |                                                                              |===================================                                   |  50%  |                                                                              |===================================                                   |  51%  |                                                                              |====================================                                  |  51%  |                                                                              |====================================                                  |  52%  |                                                                              |=====================================                                 |  53%  |                                                                              |======================================                                |  54%  |                                                                              |======================================                                |  55%  |                                                                              |=======================================                               |  55%  |                                                                              |=======================================                               |  56%  |                                                                              |========================================                              |  57%  |                                                                              |=========================================                             |  58%  |                                                                              |=========================================                             |  59%  |                                                                              |==========================================                            |  59%  |                                                                              |==========================================                            |  60%  |                                                                              |==========================================                            |  61%  |                                                                              |===========================================                           |  61%  |                                                                              |===========================================                           |  62%  |                                                                              |============================================                          |  63%  |                                                                              |=============================================                         |  64%  |                                                                              |=============================================                         |  65%  |                                                                              |==============================================                        |  65%  |                                                                              |==============================================                        |  66%  |                                                                              |===============================================                       |  67%  |                                                                              |================================================                      |  68%  |                                                                              |================================================                      |  69%  |                                                                              |=================================================                     |  69%  |                                                                              |=================================================                     |  70%  |                                                                              |=================================================                     |  71%  |                                                                              |==================================================                    |  71%  |                                                                              |==================================================                    |  72%  |                                                                              |===================================================                   |  73%  |                                                                              |====================================================                  |  74%  |                                                                              |====================================================                  |  75%  |                                                                              |=====================================================                 |  75%  |                                                                              |=====================================================                 |  76%  |                                                                              |======================================================                |  77%  |                                                                              |=======================================================               |  78%  |                                                                              |=======================================================               |  79%  |                                                                              |========================================================              |  79%  |                                                                              |========================================================              |  80%  |                                                                              |========================================================              |  81%  |                                                                              |=========================================================             |  81%  |                                                                              |=========================================================             |  82%  |                                                                              |==========================================================            |  83%  |                                                                              |===========================================================           |  84%  |                                                                              |===========================================================           |  85%  |                                                                              |============================================================          |  85%  |                                                                              |============================================================          |  86%  |                                                                              |=============================================================         |  87%  |                                                                              |==============================================================        |  88%  |                                                                              |==============================================================        |  89%  |                                                                              |===============================================================       |  89%  |                                                                              |===============================================================       |  90%  |                                                                              |===============================================================       |  91%  |                                                                              |================================================================      |  91%  |                                                                              |================================================================      |  92%  |                                                                              |=================================================================     |  93%  |                                                                              |==================================================================    |  94%  |                                                                              |==================================================================    |  95%  |                                                                              |===================================================================   |  95%  |                                                                              |===================================================================   |  96%  |                                                                              |====================================================================  |  97%  |                                                                              |===================================================================== |  98%  |                                                                              |===================================================================== |  99%  |                                                                              |======================================================================|  99%  |                                                                              |======================================================================| 100%
```

```
## Warning in fdrtool(x, statistic = "pvalue", plot = FALSE, verbose = FALSE):
## There may be too few input test statistics for reliable FDR calculations!
```

```
head(metadata(OBJ4)$DMCHMM)
```

```
##   DMCs   pvalues qvalues DMCsGroupG1vsG2 methDirGroupG1vsG2
## 1    0 0.6295781       1               0               hypo
## 2    0 0.7036725       1               0               hypo
## 3    0 0.6700588       1               0               hypo
## 4    0 0.1835498       1               0               hypo
## 5    0 0.5179005       1               0               hypo
## 6    0 0.9818744       1               0              equal
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
##  [1] DMCHMM_1.32.0               fdrtool_1.2.18
##  [3] BiocParallel_1.44.0         SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0
##
## loaded via a namespace (and not attached):
##  [1] sandwich_3.1-1           sass_0.4.10              bitops_1.0-9
##  [4] SparseArray_1.10.0       lattice_0.22-7           digest_0.6.37
##  [7] evaluate_1.0.5           grid_4.5.1               calibrate_1.7.7
## [10] mvtnorm_1.3-3            fastmap_1.2.0            jsonlite_2.0.0
## [13] Matrix_1.7-4             cigarillo_1.0.0          restfulr_0.0.16
## [16] survival_3.8-3           multcomp_1.4-29          httr_1.4.7
## [19] TH.data_1.1-4            Biostrings_2.78.0        XML_3.99-0.19
## [22] codetools_0.2-20         jquerylib_0.1.4          abind_1.4-8
## [25] cli_3.6.5                crayon_1.5.3             rlang_1.1.6
## [28] XVector_0.50.0           splines_4.5.1            cachem_1.1.0
## [31] DelayedArray_0.36.0      yaml_2.3.10              S4Arrays_1.10.0
## [34] tools_4.5.1              parallel_4.5.1           Rsamtools_2.26.0
## [37] curl_7.0.0               R6_2.6.1                 BiocIO_1.20.0
## [40] zoo_1.8-14               lifecycle_1.0.4          rtracklayer_1.70.0
## [43] MASS_7.3-65              bslib_0.9.0              GenomicAlignments_1.46.0
## [46] xfun_0.53                knitr_1.50               rjson_0.2.23
## [49] htmltools_0.5.8.1        rmarkdown_2.30           compiler_4.5.1
## [52] RCurl_1.98-1.17
```