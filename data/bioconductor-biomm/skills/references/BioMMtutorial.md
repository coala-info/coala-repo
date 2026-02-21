# BioMM: Biological-informed Multi-stage Machine learning framework for phenotype prediction using omics data

Junfang Chen and Emanuel Schwarz1

1Central Institute of Mental Health, Heidelberg University, Germany

#### Modified: 01 May 2019. Compiled: 02 May 2019

# Contents

* [1 Overview](#overview)
  + [1.1 Motivation](#motivation)
  + [1.2 Deliverables](#deliverables)
* [2 Getting started](#getting-started)
  + [2.1 Installation](#installation)
* [3 Omics data](#omics-data)
* [4 Feature stratification](#feature-stratification)
* [5 BioMM framework](#biomm-framework)
  + [5.1 Introduction](#introduction)
  + [5.2 End-to-end prediction modules](#end-to-end-prediction-modules)
    - [5.2.1 Interface to machine learning models](#interface-to-machine-learning-models)
    - [5.2.2 Interface to biological stratification strategies](#interface-to-biological-stratification-strategies)
  + [5.3 Stage-2 data exploration](#stage-2-data-exploration)
    - [5.3.1 Reconstruction](#reconstruction)
    - [5.3.2 Visualization](#visualization)
  + [5.4 Computational consideration](#computational-consideration)
* [6 Session information](#session-information)
* [7 References](#references)
* [8 Questions & Comments](#questions-comments)

# 1 Overview

## 1.1 Motivation

The identification of reproducible biological patterns from high-dimensional
omics data is a key factor in understanding the biology of complex disease or
traits. Incorporating prior biological knowledge into machine learning is an
important step in advancing such research.

## 1.2 Deliverables

We have implemented a biologically informed multi-stage machine learing
framework termed **BioMM** [1] specifically for phenotype prediction using
omics-scale data based on biological prior information.

**Features of BioMM in a nutshell**:

1. Applicability for all omics data modalities.
2. Different biological stratification strategies.
3. Prioritizing outcome-associated functional patterns.
4. End-to-end prediction at the individual level based on biological
   stratified patterns.
5. Possibility for extension to machine learning models of interest.
6. Parallel computing.

# 2 Getting started

## 2.1 Installation

Development version from Github:

* Install BioMM in R

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("transbioZI/BioMM")
```

* Load required libraries

```
library(BioMM)
library(BiocParallel)
library(ranger)
library(rms)
library(glmnet)
library(e1071)
library(variancePartition)
```

# 3 Omics data

A wide range of genome-wide omics data is supported for the use of BioMM
including whole-genome DNA methylation, gene expression and genome-wide SNP
data. Other types of omics data that can map into genes, pathways or
chromosomes are also encouraging.
For better understanding of the framework, we used a preprocessed genome-wide
DNA methylation data with 26486 CpGs and 40 samples consisting of 20 controls
and 20 patients. (0: healthy control and 1: patient) for demonstration.

```
## Get DNA methylation data
studyData <- readRDS(system.file("extdata", "/methylData.rds",
                     package="BioMM"))
head(studyData[,1:5])
```

```
##           label cg00000292 cg00002426 cg00003994 cg00005847
## GSM951223     1     0.0274     0.0029    -0.0027    -0.0196
## GSM951231     1     0.0644     0.0181    -0.0088     0.0057
## GSM951249     1    -0.0304    -0.0013    -0.0083    -0.0116
## GSM951273     1     0.0252     0.0039    -0.0091     0.0030
## GSM951214     1     0.0289    -0.0011    -0.0129     0.0173
## GSM951270     1     0.0635     0.0329     0.0184    -0.0023
```

```
dim(studyData)
```

```
## [1]    40 26487
```

# 4 Feature stratification

Features like CpGs and SNPs can be mapped into genes, pathways and chromosomes
based on genomic location and gene ontology categories, as implemented in
three different functions `omics2genelist()`, `omics2pathlist()` and
`omics2chrlist()`. The choice of feature stratification method depends on the
research questions and objectives.

```
## Load annotation data
featureAnno <- readRDS(system.file("extdata", "cpgAnno.rds", package="BioMM"))
pathlistDB <- readRDS(system.file("extdata", "goDB.rds", package="BioMM"))
head(featureAnno)
```

```
##           ID chr entrezID symbol
## 1 cg00000292  16      487 ATP2A1
## 2 cg00002426   3     7871  SLMAP
## 3 cg00003994   7     4223  MEOX2
## 4 cg00005847   2     3232  HOXD3
## 5 cg00006414   7    57541 ZNF398
## 6 cg00007981  11    24145  PANX1
```

```
str(pathlistDB[1:3])
```

```
## List of 3
##  $ GO:0000002: Named chr [1:12] "291" "1890" "4205" "4358" ...
##   ..- attr(*, "names")= chr [1:12] "TAS" "IMP" "ISS" "IMP" ...
##  $ GO:0000012: Named chr [1:11] "3981" "7141" "7515" "23411" ...
##   ..- attr(*, "names")= chr [1:11] "IDA" "IDA" "IEA" "IMP" ...
##  $ GO:0000027: Named chr [1:31] "4839" "6122" "6123" "6125" ...
##   ..- attr(*, "names")= chr [1:31] "IMP" "IBA" "IBA" "IBA" ...
```

```
## Map to chromosomes
chrlist <- omics2chrlist(data=studyData, probeAnno=featureAnno)
```

```
##  [1] "1"  "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "2"  "20" "21" "22" "3"  "4"  "5"  "6"
## [20] "7"  "8"  "9"
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   315.0   845.8  1117.5  1203.9  1527.5  2904.0
```

```
## Map to pathways (input 100 pathways only)
pathlistDBsub <- pathlistDB[1:100]
pathlist <- omics2pathlist(data=studyData, pathlistDBsub, featureAnno,
                           restrictUp=100, restrictDown=20, minPathSize=10)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   12.00   38.00   50.50   60.84   74.25  164.00
```

```
## Map to genes
studyDataSub <- studyData[,1:2000]
genelist <- omics2genelist(data=studyDataSub, featureAnno,
                           restrictUp=200, restrictDown=2)
```

# 5 BioMM framework

## 5.1 Introduction

Briefly, the BioMM framework consists of two learning stages [1]. During the
first stage, biological meta-information is used to ‘compress’ the variables
of the original dataset into functional-level ‘latent variables’ (henceforth
called stage-2 data) using either supervised or unsupervised learning models.
In the second stage, a supervised model is built using the stage-2 data with
non-negative outcome-associated features for prediction.

## 5.2 End-to-end prediction modules

### 5.2.1 Interface to machine learning models

The end-to-end prediction is performed using `BioMM()` function. Both
supervised and unsupervised learning are implemented in the BioMM framework,
which are indicated by the argument `supervisedStage1=TRUE` or
`supervisedStage1=FALSE`. Commonly used supervised classifiers: generalized
regression models with lasso, ridge or elastic net regularization (GLM) [4],
support vector machine (SVM) [3] and random forest [2] are included. For the
unsupervised method, regular or sparse constrained principal component
analysis (PCA) [5] is used. Generic resampling methods include
cross-validation (CV) and bootstrapping (BS) procedures as the argument
`resample1="CV"` or `resample1="BS"`. Stage-2 data is reconstructed using
either resampling methods during machine learning prediction or independent
test set prediction if the argument `testData` is provided.

#### 5.2.1.1 Example

To apply random forest model, we use the argument `classifier1=randForest` and
`classifier2=randForest` in `BioMM()` with the classification mode at both
stages. `predMode1` and `predMode2` indicate the prediction type, here we use
classification for binary outcome prediction. A set of model hyper-parameters
are supplied by the argument `paramlist1` at stage 1 and `paramlist2` at
stage 2. Chromosome-based stratification is carried out in this example. We
focused on the autosomal region to limit the potential influence of sex on
machine learning due to the phenomenon of X chromosome inactivation or the
existence of an additional X chromosome in female samples. Therefore it’s
suggested to exclude sex chromosome in the user-supplied `featureAnno` input
file.

```
## Parameters
supervisedStage1=TRUE
classifier1=classifier2 <- "randForest"
predMode1=predMode2 <- "classification"
paramlist1=paramlist2 <- list(ntree=300, nthreads=10)
param1 <- MulticoreParam(workers = 1)
param2 <- MulticoreParam(workers = 10)

studyDataSub <- studyData[,1:2000] ## less computation
result <- BioMM(trainData=studyDataSub, testData=NULL,
                stratify="chromosome", pathlistDB, featureAnno,
                restrictUp=10, restrictDown=200, minPathSize=10,
                supervisedStage1, typePCA="regular",
                resample1="BS", resample2="CV", dataMode="allTrain",
                repeatA1=50, repeatA2=1, repeatB1=20, repeatB2=1,
                nfolds=10, FSmethod1=NULL, FSmethod2=NULL,
                cutP1=0.1, cutP2=0.1, fdr1=NULL, fdr2=NULL, FScore=param1,
                classifier1, classifier2, predMode1, predMode2,
                paramlist1, paramlist2, innerCore=param2,
                outFileA2=NULL, outFileB2=NULL)
```

```
##  [1] "1"  "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "2"  "20" "21" "22" "3"  "4"  "5"  "6"
## [20] "7"  "8"  "9"
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   27.00   64.00   86.00   90.86  118.00  216.00
##
##  Levels of predicted Y = 2
```

```
print(result)
```

```
##             pv  cor  AUC  ACC    R2
## R2 0.001381613 0.56 0.78 0.78 0.375
```

Other machine learning models can be employed with the following respective
parameter settings. For the classifier `"SVM"`, parameters can be tuned using
an internal cross validation if `tuneP=TRUE`. For generalized regression model
`glmnet`, elastic net is specified by the input argument `alpha=0.5`.
Alternatively, `alpha=1` is for the lasso and `alpha=0` is the ridge. For the
unsupervised learning `supervisedStage1=FALSE`, regular PCA
`typePCA="regular"` is applied and followed with random forest classification
`classifier2=TRUE`.

```
## SVM
supervisedStage1=TRUE
classifier1=classifier2 <- "SVM"
predMode1=predMode2 <- "classification"
paramlist1=paramlist2 <- list(tuneP=FALSE, kernel="radial",
                              gamma=10^(-3:-1), cost=10^(-3:1))

## GLM with elastic-net
supervisedStage1=TRUE
classifier1=classifier2 <- "glmnet"
predMode1=predMode2 <- "classification"
paramlist1=paramlist2 <- list(family="binomial", alpha=0.5,
                              typeMeasure="mse", typePred="class")

## PCA + random forest
supervisedStage1=FALSE
classifier2 <- "randForest"
predMode2 <- "classification"
paramlist2 <- list(ntree=300, nthreads=10)
```

### 5.2.2 Interface to biological stratification strategies

For stratification of predictors using biological information, various
strategies can be applied. Currently, `BioMM()` integrates three different
ways of stratification. Gene-based prediction is defined by the argument
`stratify="gene"`, which can be used when multiple predictors exist within
one gene. For instance, DNA methylation or GWAS data, each gene might have
multiple CpGs or SNPs. But this is not applicable for gene expression data.
Pathway-based analysis is described by the argument `stratify="pathway"`,
which would account for epistasis between variables within the functional
category; therefore, this may provide better information on functional
insight. Chromosome-based analysis `stratify="chromosome"` might be helpful
to cover non-coding features residing on each chromosome apart from the
coding region probes.

#### 5.2.2.1 Example

End-to-end prediction based on pathway-wide stratification on genome-wide DNA
methylation data is demonstrated below. PCA is used at stage-1 to reconstruct
pathway level data, then the random forest model with 10-fold cross validation
is applied on stage-2 data to estimate the prediction performance.

```
## Parameters
supervisedStage1=FALSE
classifier <- "randForest"
predMode <- "classification"
paramlist <- list(ntree=300, nthreads=10)
param1 <- MulticoreParam(workers = 1)
param2 <- MulticoreParam(workers = 10)

result <- BioMM(trainData=studyData, testData=NULL,
                stratify="pathway", pathlistDBsub, featureAnno,
                restrictUp=100, restrictDown=10, minPathSize=10,
                supervisedStage1, typePCA="regular",
                resample1="BS", resample2="CV", dataMode="allTrain",
                repeatA1=40, repeatA2=1, repeatB1=40, repeatB2=1,
                nfolds=10, FSmethod1=NULL, FSmethod2=NULL,
                cutP1=0.1, cutP2=0.1, fdr1=NULL, fdr2=NULL, FScore=param1,
                classifier1, classifier2, predMode1, predMode2,
                paramlist1, paramlist2, innerCore=param2,
                outFileA2=NULL, outFileB2=NULL)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   12.00   20.00   37.00   45.57   55.00  164.00
##
##  Levels of predicted Y = 2
```

```
print(result)
```

```
##            pv  cor  AUC  ACC    R2
## R2 0.05004352 0.36 0.68 0.68 0.168
```

## 5.3 Stage-2 data exploration

### 5.3.1 Reconstruction

Here we demonstrate using supervised random forest method on genome-wide DNA
methylation. Gene ontological pathways are used for the generation of stage-2
data.

```
## Pathway level data or stage-2 data prepared by BioMMreconData()
stage2dataA <- readRDS(system.file("extdata", "/stage2dataA.rds",
                       package="BioMM"))

head(stage2dataA[,1:5])
```

```
##           label GO:0000027 GO:0000045 GO:0000050 GO:0000060
## GSM951223     1      0.663      0.557      0.707      0.653
## GSM951231     1      0.655      0.710      0.737      0.686
## GSM951249     1      0.776      0.568      0.757      0.533
## GSM951273     1      0.664      0.510      0.741      0.642
## GSM951214     1      0.662      0.632      0.530      0.582
## GSM951270     1      0.419      0.366      0.474      0.415
```

```
dim(stage2dataA)
```

```
## [1] 40 51
```

```
#### Alternatively, 'stage2dataA' can be created by the following code:
## Parameters
classifier <- "randForest"
predMode <- "probability"
paramlist <- list(ntree=300, nthreads=40)
param1 <- MulticoreParam(workers = 1)
param2 <- MulticoreParam(workers = 10)
set.seed(123)
## This will take a bit longer to run
stage2dataA <- BioMMreconData(trainDataList=pathlist, testDataList=NULL,
                            resample="BS", dataMode="allTrain",
                            repeatA=25, repeatB=1, nfolds=10,
                            FSmethod=NULL, cutP=0.1, fdr=NULL, FScore=param1,
                            classifier, predMode, paramlist,
                            innerCore=param2, outFileA=NULL, outFileB=NULL)
```

### 5.3.2 Visualization

#### 5.3.2.1 Explained variation of stage-2 data

The distribution of the proportion of variance explained for the individual
generated feature of stage-2 data for the classification task is illustrated
`plotVarExplained()` below. Nagelkerke pseudo R-squared measure is used to
compute the explained variance. The argument `posF=TRUE` indicates that only
positively outcome-associated features are plotted, since negative
associations likely reflect random effects in the underlying data [6].

```
param <- MulticoreParam(workers = 1)
plotVarExplained(data=stage2dataA, posF=TRUE,
                 stratify="pathway", core=param, fileName=NULL)
```

```
## png
##   2
```

![](data:image/png;base64...)

#### 5.3.2.2 Prioritization of outcome-associated functional patterns

`plotRankedFeature()` is employed to rank and visualize the outcome-associated
features from stage-2 data. The argument `topF=10` and `posF=TRUE` are used to
define the top 10 positively outcome-associated features. Nagelkerke pseudo
R-squared measure is utilized to evaluate the importance of the ranked
features as indicated by the argument `rankMetric="R2"`. The size of the
investigated pathway is pictured as the argument `colorMetric="size"`.

```
param <- MulticoreParam(workers = 1)
plotRankedFeature(data=stage2dataA,
                  posF=TRUE, topF=10,
                  blocklist=pathlist,
                  stratify="pathway",
                  rankMetric="R2",
                  colorMetric="size",
                  core=param, fileName=NULL)
```

```
## png
##   2
```

![](data:image/png;base64...)

## 5.4 Computational consideration

BioMM with supervised models at both stages and gene or pathway based
stratification methods will take longer to run than unsupervised
approaches or chromosome based stratification. But the prediction
is more powerful in many scenarios. Therefore, we suggest the former even
if the computation is more demanding, as the adoption of 5G is pushing advances
in computational storage and speed. Parallel computing is implemented and
recommended for such scenario. In this vignette, due to the runtime, we
only showcased the smaller examples and models with less computation.

# 6 Session information

```
sessionInfo()
```

```
## R version 3.6.0 (2019-04-26)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.9-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.9-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] parallel  stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] variancePartition_1.14.0 Biobase_2.44.0           BiocGenerics_0.30.0
##  [4] scales_1.0.0             limma_3.40.0             e1071_1.7-1
##  [7] glmnet_2.0-16            foreach_1.4.4            Matrix_1.2-17
## [10] rms_5.1-3.1              SparseM_1.77             Hmisc_4.2-0
## [13] ggplot2_3.1.1            Formula_1.2-3            survival_2.44-1.1
## [16] lattice_0.20-38          ranger_0.11.2            BiocParallel_1.18.0
## [19] BioMM_1.0.0              BiocStyle_2.12.0
##
## loaded via a namespace (and not attached):
##  [1] nlme_3.1-139        bitops_1.0-6        pbkrtest_0.4-7      doParallel_1.0.14
##  [5] RColorBrewer_1.1-2  progress_1.2.0      tools_3.6.0         backports_1.1.4
##  [9] R6_2.4.0            rpart_4.1-15        KernSmooth_2.23-15  lazyeval_0.2.2
## [13] colorspace_1.4-1    nnet_7.3-12         withr_2.1.2         tidyselect_0.2.5
## [17] gridExtra_2.3       prettyunits_1.0.2   compiler_3.6.0      quantreg_5.38
## [21] htmlTable_1.13.1    sandwich_2.5-1      labeling_0.3        bookdown_0.9
## [25] caTools_1.17.1.2    checkmate_1.9.1     polspline_1.1.14    mvtnorm_1.0-10
## [29] stringr_1.4.0       digest_0.6.18       foreign_0.8-71      minqa_1.2.4
## [33] rmarkdown_1.12      colorRamps_2.3      base64enc_0.1-3     pkgconfig_2.0.2
## [37] htmltools_0.3.6     lme4_1.1-21         htmlwidgets_1.3     rlang_0.3.4
## [41] rstudioapi_0.10     zoo_1.8-5           gtools_3.8.1        acepack_1.4.1
## [45] dplyr_0.8.0.1       magrittr_1.5        Rcpp_1.0.1          munsell_0.5.0
## [49] stringi_1.4.3       multcomp_1.4-10     yaml_2.2.0          MASS_7.3-51.4
## [53] gplots_3.0.1.1      plyr_1.8.4          grid_3.6.0          gdata_2.18.0
## [57] crayon_1.3.4        splines_3.6.0       hms_0.4.2           knitr_1.22
## [61] pillar_1.3.1        boot_1.3-22         nsprcomp_0.5.1-2    reshape2_1.4.3
## [65] codetools_0.2-16    glue_1.3.1          evaluate_0.13       latticeExtra_0.6-28
## [69] data.table_1.12.2   BiocManager_1.30.4  nloptr_1.2.1        MatrixModels_0.4-1
## [73] gtable_0.3.0        purrr_0.3.2         assertthat_0.2.1    xfun_0.6
## [77] class_7.3-15        tibble_2.1.1        iterators_1.0.10    cluster_2.0.9
## [81] TH.data_1.0-10
```

# 7 References

[1] NIPS ML4H submission: Chen, J. and Schwarz, E., 2017. BioMM:
Biologically-informed Multi-stage Machine learning for identification of
epigenetic fingerprints. arXiv preprint arXiv:1712.00336.

[2] Breiman, L. (2001). “Random forests.” Machine learning 45(1): 5-32.

[3] Cortes, C., & Vapnik, V. (1995). “Support-vector networks.”
Machine learning 20(3): 273-297.

[4] Friedman, J., Hastie, T., & Tibshirani, R. (2010). “Regularization paths
for generalized linear models via coordinate descent.”
Journal of statistical software 33(1): 1.

[5] Wold, S., Esbensen, K., & Geladi, P. (1987). “Principal component
analysis.” Chemometrics and intelligent laboratory systems 2(1-3): 37-52.

[6] Claudia Perlich and Grzegorz Swirszcz. On cross-validation and stacking:
Building seemingly predictive models on random data. ACM SIGKDD Explorations
Newsletter, 12(2):11-15, 2011.

# 8 Questions & Comments

If you have any questions or comments ?

Contact: junfang.chen@zi-mannheim.de