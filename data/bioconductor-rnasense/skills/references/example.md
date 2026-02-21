# RNAsense

* [Introduction](#introduction)
* [Installation](#installation)
* [Step-by-step Tutorial](#step-by-step-tutorial)
* [Session Info](#session-info)

## Introduction

RNAsense is a tool to facilitate interpretation of time-resolved RNA-seq data. Typically it compares gene expression time curves for two different experimental conditions, e.g. wild-type and mutant. The aim is to provide basic functions to easily create plots of stage-specific gene sets like in Figure 1C of <https://www.ncbi.nlm.nih.gov/pubmed/20212526>.

Following the method of the paper, genes are sorted into different groups in two ways. First, wild-type and mutant condition are compared at each time point to get groups of differentially expressed transcripts that are up- or downregulated in the mutant. This is achieved by the function `getFC` whose usage is described below. Second, the expression profiles of one experimental condition (typically wild-type) are tested for significant growth or decay. Similar to the idea in <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1920252/>, a one-step and a zero-step (in fact the mean) function are fitted to the time-resolved data and compared by means of likelihood-ratio test. Thus, genes are sorted into non-overlapping groups by the time point of switch up or down. This step is achieved by the function `getStep`.

Finally, the function `plotSSGS` analyzes correlations between the outputs of `getFC` and `getStep` by means of Fisher’s exact test and plots the result in form of a heat map, with time profiles and differential expression groups at y- and x-axis, respectively.

## Installation

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RNAsense")
```

## Step-by-step Tutorial

First of all, data has to be provided in the right format. We made use of the S4-class `SummarizedExperiment` that gives the possibility to provide additional information for example on covariates for the measurements that themselves are given as a numeric matrix. Here is an example how your data should look like:

```
library(RNAsense)
data("MZsox") # load MZsox.RData in variable mydata
print(MZsox)
```

```
## class: SummarizedExperiment
## dim: 15775 40
## metadata(0):
## assays(1): mydata
## rownames: NULL
## rowData names(2): name genename
## colnames(40): WT_2.5_B1 WT_3_B1 ... MZsox_5.5_B1 MZsox_6_B1
## colData names(3): condition time replicate
```

```
mydata <- MZsox
```

`SummarizedExperiment` provides a constructor to easily bring your data into this format. When constructing your object, make sure to provide genenames in the `rowData` argument and information on condition, time point and, if available, replicate identifier, in the `colData` argument.

Next, the conditions that should be analyzed are specified and a threshold is provided which is used to exclude genes with expression levels below this threshold for all conditions. This can be useful, if expression levels are in the range of your detection limit. Since `RNAseq` makes use of the `parallel` package, you may specify a number of cores in order to speed up your computation time.

```
analyzeConditions <- c("WT", "MZsox")
thCount <- 100
nrcores <- 1
library(SummarizedExperiment)
#if(Sys.info()[[1]]=="Windows"){nrcores <- 1} # use parallelization only on Linux and Mac
mydata <- mydata[seq(1,nrow(mydata), by=4),]
vec2Keep <- which(vapply(1:dim(mydata)[1],function(i)
  !Reduce("&",assays(mydata)[[1]][i,]<thCount), c(TRUE)))
mydata <- mydata[vec2Keep,] # threshold is applied
times <- unique(sort(as.numeric(colData(mydata)$time))) # get measurement times from input data
```

After data preparation, fold change detection can be performed. The function `getFC` internally calles functions from the `NBPSeq` package to perform fold change analysis for each gene and at each time point. The result is saved in a `data.frame` with corresponding p-values.

```
resultFC <- getFC(dataset = mydata,
                  myanalyzeConditions = analyzeConditions,
                  cores = nrcores,
                  mytimes = times)
head(resultFC)
```

```
##      name logFoldChange       pValue time FCdetect
## 1    enc3     1.0018883 8.968193e-03  2.5 WT>MZsox
## 2   crtap    -2.5849625 1.266534e-01  2.5 WT=MZsox
## 3    rpl3    -0.1511741 4.893689e-01  2.5 WT=MZsox
## 4   zic2b    -0.5036624 3.696352e-01  2.5 WT=MZsox
## 5    ccn1    -2.5269793 8.092739e-09  2.5 WT<MZsox
## 6 vipas39     0.9626110 1.519843e-02  2.5 WT=MZsox
```

Note that each gene appears in the data frame as often as the number of time points. The result of the fold change analysis can be visualized as a vulcano plot:

```
library(ggplot2)
ggplot(subset(resultFC, FCdetect!="none"),
       aes(x=logFoldChange, y=-log10(pValue), color=FCdetect)) +
       xlab("log2(Fold Change)") + geom_point(shape=20)
```

![](data:image/png;base64...)

Next, the gene expression profiles are analyzed for switches. A switch appears if the profile shows a statistically significant up- or downregulation at a specific time point. If up- or downregulation is detected at multiple time points, the time point with the best likelihood value (for the one-step model) is chosen. The result is saved in a `data.frame` with information on whether a switch has been detected, at which time point and with which p-value based on the likelihood ratio test.

```
resultSwitch <- getSwitch(dataset = mydata,
                          experimentStepDetection = "WT",
                          cores = nrcores,
                          mytimes = times)
head(resultSwitch)
```

```
##            name genename timepoint switch pvalueSwitch experiment
## 7  NM_001001402     enc3        NA   none   0.40773375         WT
## 71 NM_001001406    crtap        NA   none   0.11729573         WT
## 6  NM_001001590     rpl3        NA   none   0.10784956         WT
## 5  NM_001001820    zic2b        NA   none   0.07115325         WT
## 2  NM_001001826     ccn1        NA   none   0.16854030         WT
## 4  NM_001001836  vipas39         4   down   0.04349482         WT
```

After fold change and switch analysis have been performed, results shall be collected in one and the same data.frame using the `combineResults` function. This function basically prepares the results to be handed over to `plotSSGS`.

```
resultCombined <- combineResults(resultSwitch, resultFC)
head(resultCombined)
```

```
##            name genename timepoint switch pvalueSwitch experiment
## 7  NM_001001402     enc3        NA   none   0.40773375         WT
## 71 NM_001001406    crtap        NA   none   0.11729573         WT
## 6  NM_001001590     rpl3        NA   none   0.10784956         WT
## 5  NM_001001820    zic2b        NA   none   0.07115325         WT
## 2  NM_001001826     ccn1        NA   none   0.16854030         WT
## 4  NM_001001836  vipas39         4   down   0.04349482         WT
##                  FCdown                                      FCup
## 7  2.5hpf 3.0hpf 4.0hpf
## 71 5.0hpf 5.5hpf 6.0hpf
## 6
## 5  3.0hpf 3.5hpf 4.0hpf
## 2                       2.5hpf 3.0hpf 3.5hpf 5.0hpf 5.5hpf 6.0hpf
## 4                                            5.0hpf 5.5hpf 6.0hpf
```

Finally, the `plotSSGS` function performs Fisher’s exact test for each combination of fold change time point and switch time point. Results are plotted as a heat map highlighting combinations with a high significance.

```
plotSSGS(resultCombined, times[-length(times)])
```

![](data:image/png;base64...)

In order to document the result of the analysis, the function `outputGeneTables` provides a possibility to automatically output switch and fold change information into table files (.txt).

```
outputGeneTables(resultCombined)
```

```
## [1] "Results written to /tmp/RtmpmGoj25/Rbuild2b87915d720f62/RNAsense/vignettes"
```

The function `outputGeneTables` generates five .txt files. Two of them (geneNamelist) contain gene lists with gene name for genes that switch up and down respectively. The other two (genelist) contain exactly the same output but with gene identifiers instead of gene names depending on what you prefer for further analysis. Each column corresponds to a combination of switch time point, fold change direction and time point of fold change. All genes for which fold change was detected at the indicated time point and switch was detected at the indicated time point are listed in the corresponding column. Note that a single gene may appear multiple times. The fifth .txt file (switchList) contains information on detected switches in a different format. The output consists of table with six columns with each row corresponding to one gene. Detected switches are indicated by 1, -1 and 0 for switch up, switch down and no switch, respectively. If a switch was detected, the column timepoint indicated the corresponding time point of switch detection.

## Session Info

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
##  [1] ggplot2_4.0.0               SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           RNAsense_1.24.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         SparseArray_1.10.0  stringi_1.8.7
##  [4] lattice_0.22-7      digest_0.6.37       magrittr_2.0.4
##  [7] evaluate_1.0.5      grid_4.5.1          RColorBrewer_1.1-3
## [10] fastmap_1.2.0       plyr_1.8.9          jsonlite_2.0.0
## [13] Matrix_1.7-4        scales_1.4.0        jquerylib_0.1.4
## [16] abind_1.4-8         cli_3.6.5           rlang_1.1.6
## [19] XVector_0.50.0      splines_4.5.1       withr_3.0.2
## [22] cachem_1.1.0        DelayedArray_0.36.0 yaml_2.3.10
## [25] S4Arrays_1.10.0     tools_4.5.1         parallel_4.5.1
## [28] reshape2_1.4.4      dplyr_1.1.4         vctrs_0.6.5
## [31] R6_2.6.1            NBPSeq_0.3.1        lifecycle_1.0.4
## [34] stringr_1.5.2       pkgconfig_2.0.3     bslib_0.9.0
## [37] pillar_1.11.1       gtable_0.3.6        Rcpp_1.1.0
## [40] glue_1.8.0          xfun_0.53           tibble_3.3.0
## [43] tidyselect_1.2.1    qvalue_2.42.0       knitr_1.50
## [46] dichromat_2.0-0.1   farver_2.1.2        htmltools_0.5.8.1
## [49] labeling_0.4.3      rmarkdown_2.30      compiler_4.5.1
## [52] S7_0.2.0
```