# CAMTHC User Manual

Lulu Chen

#### *2018-10-30*

# Contents

* [1 Introduction](#introduction)
* [2 Quick Start](#quick-start)
* [3 Unsupervised Deconvolution](#unsupervised-deconvolution)
  + [3.1 Datatypes and Input Format](#datatypes-and-input-format)
  + [3.2 CAM Workflow](#cam-workflow)
    - [3.2.1 Analysis by CAM](#analysis-by-cam)
    - [3.2.2 Estimated A and S matrix](#estimated-a-and-s-matrix)
    - [3.2.3 Detected Marker Genes](#detected-marker-genes)
    - [3.2.4 Simplex Plot - 2D](#simplex-plot---2d)
    - [3.2.5 Simplex Plot - 3D](#simplex-plot---3d)
    - [3.2.6 Model Selection by MDL Curves](#model-selection-by-mdl-curves)
    - [3.2.7 Validation with Ground Truth](#validation-with-ground-truth)
  + [3.3 Alternative CAM Workflow](#alternative-cam-workflow)
  + [3.4 Optional Sample Clustering](#optional-sample-clustering)
  + [3.5 Case Study](#case-study)
    - [3.5.1 GSE11058](#gse11058)
    - [3.5.2 GSE41826 (methylation)](#gse41826-methylation)
* [4 Supervised/Semi-supervised Deconvolution](#supervisedsemi-supervised-deconvolution)
  + [4.1 Molecular markers are known](#molecular-markers-are-known)
  + [4.2 S matrix is known](#s-matrix-is-known)
  + [4.3 A matrix is known](#a-matrix-is-known)
  + [4.4 Semi-supervised Deconvolution](#semi-supervised-deconvolution)

# 1 Introduction

Convex Analysis of Mixtures (CAM) is a fully unsupervised computational method to analyze tissue samples composed of unknown numbers and varying proportions of distinct subpopulations. CAM assumes that the measured expression level is the weighted sum of each subpopulation’s expression, where the contribution from a single subpopulation is proportional to the abundance and specific expression of that subpopulation. This linear mixing model can be formulated as \(\mathbf{X'=AS'}\). CAM can identify molecular markers directly from the original mixed expression matrix, \(\mathbf{X}\), and further estimate the constituent proportion matrix, \(\mathbf{A}\), as well as subpopulation-specific expression profile matrix, \(\mathbf{S}\).

`CAMTHC` is an R package developed for tissue heterogeneity characterization by CAM algorithm. It provides basic functions to perform unsupervised deconvolution on mixture expression profiles by CAM and some auxiliary functions to help understand the subpopulation-specific results. `CAMTHC` also implements functions to perform supervised deconvolution based on prior knowledge of molecular markers, S matrix or A matrix. Semi-supervised deconvolution can also be achieved by combining molecular markers from CAM and from prior knowledge to analyze mixture expressions.

# 2 Quick Start

The function `CAM()` includes all necessary steps to decompose a matrix of mixture expression profiles. There are some optional steps upstream of `CAM()` that downsample the matrix for reducing running time. Each step in `CAM()` can also be performed separately if you prefer a more flexible workflow. More details will be introduced in sections below.

Starting your analysis by `CAM()`, you need to specify the range of possible subpopulation numbers and the percentage of low/high-expressed molecules to be removed. Typically, 30% ~ 50% low-expressed genes can be removed from gene expression data. Much less low-expressed proteins are removed, e.g. 0% ~ 10%, due to a limited number of proteins in proteomics data. The removal of high-expressed molecules has much less impact on results, and usually set to be 0% ~ 10%.

```
rCAM <- CAM(data, K = 2:5, thres.low = 0.30, thres.high = 0.95)
```

# 3 Unsupervised Deconvolution

## 3.1 Datatypes and Input Format

Theoretically, `CAMTHC` accepts any molecular expression data types as long as the expressions follow the linear mixing model. We have validated the feasibility of CAM in gene expression data (microarray, RNAseq), proteomics data and DNA methylation data. Requirements for the input expression data:

* be in non-log linear space with non-negative numerical values (i.e.>=0).
* be already processed by normalization and batch effect removal.
* no missing values; the molecules containing missing values should be removed prior to CAM.
* no all-zero expressed molecules; otherwise, all-zero expressed molecules will be removed internally.

The input expression data should be stored in a matrix. Data frame, SummarizedExperiment or ExpressionSet object is also accepted and will be internally coerced into a matrix format before analysis. Each column in the matrix should be a tissue sample. Each row should be a probe/gene/protein/etc. Row names should be provided so that CAM can return the names of detected markers. Otherwise, rows will be automatically named by 1,2,3,…

## 3.2 CAM Workflow

We use a data set downsampled from [GSE19830](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE19830) as an example to show CAM workflow. This data set provides gene expression profiles of pure tissues (brain, liver, lung) and their biological mixtures with different proportions.

```
library(CAMTHC)

data(ratMix3)
#ratMix3$X: X matrix containing mixture expression profiles to be analyzed
#ratMix3$A: ground truth A matrix containing proportions
#ratMix3$S: ground truth S matrix containing subpopulation-specific expression profiles

data <- ratMix3$X
#10000 genes * 21 tissues
#meet the input data requirements
```

### 3.2.1 Analysis by CAM

Unsupervised deconvolution can be achieved by the function `CAM()` with a simple setting as Section [2](#quick-start) introduced. Other critical parameters are `dim.rdc` (reduced data dimension) and `cluster.num` (number of clusters). Increasing them will bring more time complexity. We can also specify `cores` for parallel computing configured by *[BiocParallel](https://bioconductor.org/packages/3.8/BiocParallel)*. `cores = 0` will disable parallel computing. No `cores` argument will invoke one core for each element in `K`. Setting the seed of the random number generator prior to CAM can generate reproducible results.

```
set.seed(111) # set seed for internal clustering to generate reproducible results
rCAM <- CAM(data, K = 2:5, thres.low = 0.30, thres.high = 0.95)
#CAM return three sub results:
#rCAM@PrepResult contains details corresponding to data preprocessing.
#rCAM@MGResult contains details corresponding to marker gene clusters detection.
#rCAM@ASestResult contains details corresponding to A and S matrix estimation.
```

### 3.2.2 Estimated A and S matrix

The A and S matrix estimated by CAM with a fixed subpopulation number, e.g. K = 3, can be obtained by

```
Aest <- Amat(rCAM, 3)
Sest <- Smat(rCAM, 3)
```

### 3.2.3 Detected Marker Genes

The marker genes detected by CAM and used for A matrix estimation can be obtained by

```
MGlist <- MGsforA(rCAM, K = 3) #for three subpopulations
```

Data preprocessing has filtered many genes, among which there are also some biologically-meaningful marker genes. So we need to check each gene again to find all the possible markers. Two statistics based on the subpopulation-specific expressions are exploited to identify marker genes with certain thresholds. The first is OVE-FC (one versus everyone - fold change) (Yu et al. 2010). The second is the lower confidence bound of bootstrapped OVE-FC at \(\alpha\) level.

```
MGstat <- MGstatistic(data, Aest, boot.alpha = 0.05, nboot = 1000)
MGlist.FC <- lapply(seq_len(3), function(x)
    rownames(MGstat)[MGstat$idx == x & MGstat$OVE.FC > 10])
MGlist.FCboot <- lapply(seq_len(3), function(x)
    rownames(MGstat)[MGstat$idx == x & MGstat$OVE.FC.alpha > 10])
```

### 3.2.4 Simplex Plot - 2D

Fundamental to the success of CAM is that the scatter simplex of mixed expressions is a rotated and compressed version of the scatter simplex of pure expressions, where the marker genes are located at each vertex. `simplexplot()` function can show the scatter simplex and detected marker genes in a 2D plot. The vertices in the high-dimensional simplex will still locate at extreme points of the low-dimensional simplex.

```
simplexplot(data, Aest, MGlist)
```

![](data:image/png;base64...)

```
simplexplot(data, Aest, MGlist.FC)
```

![](data:image/png;base64...)

```
simplexplot(data, Aest, MGlist.FCboot)
```

![](data:image/png;base64...)

The colors and the vertex order displayed in 2D plot can be changed as

```
simplexplot(data, Aest, MGlist.FCboot, corner.order = c(2,1,3),
            data.col = "blue", corner.col = c("red","orange","green"))
```

![](data:image/png;base64...)

### 3.2.5 Simplex Plot - 3D

We can also observe the convex cone and simplex of mixture expressions in 3D space by PCA. Note that PCA cannot guarantee that vertices are still preserved as extreme points of the dimension-reduced simplex.

Code to show convex cone:

```
library(rgl)
Xp <- data %*% t(PCAmat(rCAM))
plot3d(Xp[, 1:3], col='gray', size=3,
       xlim=range(Xp[,1]), ylim=range(Xp[,2:3]), zlim=range(Xp[,2:3]))
abclines3d(0,0,0, a=diag(3), col="black")
for(i in seq_along(MGlist)){
    points3d(Xp[MGlist[[i]], 1:3], col= rainbow(3)[i], size = 8)
}
```

Code to show simplex:

```
library(rgl)
clear3d()
Xproj <- XWProj(data, PCAmat(rCAM))
Xp <- Xproj[,-1]
plot3d(Xp[, 1:3], col='gray', size=3,
       xlim=range(Xp[,1:3]), ylim=range(Xp[,1:3]), zlim=range(Xp[,1:3]))
abclines3d(0,0,0, a=diag(3), col="black")
for(i in seq_along(MGlist)){
    points3d(Xp[MGlist[[i]], 1:3], col= rainbow(3)[i], size = 8)
}
```

### 3.2.6 Model Selection by MDL Curves

We used MDL, a widely-adopted and consistent information theoretic criterion, to guide model selection. The underlying subpopulation number can be decided by minimizing the total description code length:

```
plot(MDL(rCAM), data.term = TRUE)
```

![](data:image/png;base64...)

### 3.2.7 Validation with Ground Truth

If the ground truth A and S matrix are available, the estimation from CAM can be evaluated:

```
cor(Aest, ratMix3$A)
#>           Liver      Brain       Lung
#> [1,] -0.3986516  0.9842754 -0.4877084
#> [2,]  0.9872393 -0.5979561 -0.4879628
#> [3,] -0.4755304 -0.5258829  0.9853197
cor(Sest, ratMix3$S)
#>          Liver     Brain      Lung
#> [1,] 0.5063181 0.9749882 0.5638470
#> [2,] 0.9717924 0.2543765 0.3412716
#> [3,] 0.4658303 0.5726226 0.9934400
```

Considering the presence of many co-expressed genes (housekeeping genes) may dominate the correlation coefficients between ground truth and estimated expression profiles, it is better to assess correlation coefficients over marker genes only.

```
unlist(lapply(seq_len(3), function(k) {
    k.match <- which.max(cor(Aest[,k], ratMix3$A));
    mgk <- MGlist.FCboot[[k]];
    corr <- cor(Sest[mgk, k], ratMix3$S[mgk, k.match]);
    names(corr) <- colnames(ratMix3$A)[k.match];
    corr}))
#>     Brain     Liver      Lung
#> 0.9982725 0.9950601 0.9985467
```

## 3.3 Alternative CAM Workflow

There major steps in CAM (data preprocessing, marker gene cluster detection, and matrix decomposition) can also be performed separately as a more flexible choice.

```
set.seed(111)

#Data preprocession
rPrep <- CAMPrep(data, thres.low = 0.30, thres.high = 0.95)
#> outlier cluster number: 0
#> convex hull cluster number: 44

#Marker gene cluster detection with a fixed K
rMGC <- CAMMGCluster(3, rPrep)

#A and S matrix estimation
rASest <- CAMASest(rMGC, rPrep, data)

#Obtain A and S matrix
Aest <- Amat(rASest)
Sest <- Smat(rASest)

#obtain marker gene list detected by CAM and used for A estimation
MGlist <- MGsforA(PrepResult = rPrep, MGResult = rMGC)

#obtain a full list of marker genes
MGstat <- MGstatistic(data, Aest, boot.alpha = 0.05, nboot = 1000)
MGlist.FC <- lapply(seq_len(3), function(x)
    rownames(MGstat)[MGstat$idx == x & MGstat$OVE.FC > 10])
MGlist.FCboot <- lapply(seq_len(3), function(x)
    rownames(MGstat)[MGstat$idx == x & MGstat$OVE.FC.alpha > 10])
```

## 3.4 Optional Sample Clustering

We have implemented PCA in `CAM()`/`CAMPrep()` to reduce data dimensions. Sample clustering, as another data dimension reduction method, is optional prior to `CAM()`/`CAMPrep()`.

```
#clustering
library(apcluster)
apres <- apclusterK(negDistMat(r=2), t(data),  K = 10)
#> Trying p = -2427050
#>    Number of clusters: 10
#> Trying p = -15246196
#>    Number of clusters: 7
#> Trying p = -8124448 (bisection step no. 1 )
#>    Number of clusters: 7
#> Trying p = -4563575 (bisection step no. 2 )
#>    Number of clusters: 8
#> Trying p = -2783138 (bisection step no. 3 )
#>    Number of clusters: 9
#>
#> Number of clusters: 9 for p = -2783138
#You can also use apcluster(), but need to make sure the number of clusters is large than potential subpopulation number.

data.clusterMean <- lapply(slot(apres,"clusters"),
                           function(x) rowMeans(data[, x, drop = FALSE]))
data.clusterMean <- do.call(cbind, data.clusterMean)

set.seed(111)
rCAM <- CAM(data.clusterMean, K = 2:5, thres.low = 0.30, thres.high = 0.95)
# or rPrep <- CAMPrep(data.clusterMean, thres.low = 0.30, thres.high = 0.95)
```

We can still follow the workflow in [3.2](#cam-workflow) or [3.3](#alternative-cam-workflow) to obtain marker gene list and estimated S matrix. However, the estimated A matrix is for the new data composed of cluster centers. The A matrix for the original data can be obtained by

```
Sest <- Smat(rCAM,3)
MGlist <- MGsforA(rCAM, K = 3)
Aest <- AfromMarkers(data, MGlist)
```

## 3.5 Case Study

### 3.5.1 GSE11058

[GSE11058](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE11058) run four immune cell lines on microarrays as well as their mixtures of various relative proportions. The code chunk below shows how to use CAM to blindly separate the four mixtures into four pure cell lines. Note that this data set contains 54613 probe/probesets. We can reduce running time by downsampling probe/probesets or remove more low-expressed genes (e.g. 70%).

```
#download data and phenotypes
library(GEOquery)
gsm<- getGEO('GSE11058')
pheno <- pData(phenoData(gsm[[1]]))$characteristics_ch1
mat <- exprs(gsm[[1]])
mat <- mat[-grep("^AFFX", rownames(mat)),]
mat.aggre <- sapply(unique(pheno), function(x) rowMeans(mat[,pheno == x]))
data <- mat.aggre[,5:8]

#running CAM
set.seed(111)
rCAM <- CAM(data, K = 4, thres.low = 0.70, thres.high = 0.95)
Aest <- Amat(rCAM, 4)
Aest
#>           [,1]      [,2]      [,3]       [,4]
#> [1,] 0.4028161 0.2418041 0.1020896 0.25329022
#> [2,] 0.2213951 0.4948602 0.2021001 0.08164461
#> [3,] 0.3505424 0.1831931 0.4321002 0.03416430
#> [4,] 0.3780136 0.3249908 0.2740140 0.02298166

#Use ground truth A to validate CAM-estimated A matrix
Atrue <- matrix(c(2.50, 0.50, 0.10, 0.02,
              1.25, 3.17, 4.95, 3.33,
              2.50, 4.75, 1.65, 3.33,
              3.75, 1.58, 3.30, 3.33), 4,4,
              dimnames = list(c("MixA", "MixB", "MixC","MixD"),
                               c("Jurkat", "IM-9", "Raji", "THP-1")))
Atrue <- Atrue / rowSums(Atrue)
Atrue
#>           Jurkat      IM-9      Raji     THP-1
#> MixA 0.250000000 0.1250000 0.2500000 0.3750000
#> MixB 0.050000000 0.3170000 0.4750000 0.1580000
#> MixC 0.010000000 0.4950000 0.1650000 0.3300000
#> MixD 0.001998002 0.3326673 0.3326673 0.3326673
cor(Aest, Atrue)
#>          Jurkat       IM-9       Raji       THP-1
#> [1,]  0.3725502 -0.2613393 -0.7516873  0.99172438
#> [2,] -0.1987591 -0.1501336  0.9935634 -0.88653613
#> [3,] -0.7885817  0.9696095 -0.4515971  0.04908184
#> [4,]  0.9982001 -0.8746573 -0.1056444  0.31225365
```

### 3.5.2 GSE41826 (methylation)

[GSE41826](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE41826) conducted a reconstitution experiment by mixing neuron and glial derived DNA from a single individual from 10% ~ 90%. The code chunk below shows how to use CAM to blindly separate 9 mixtures into neuron and glial specific CpG methylation quantification. Additional requirements of running CAM on methylation data:

* Use beta-value, not M-value, as methylation quantification.
* CpG sites in X or Y chromosomes must be removed if mixture tissues are from both males and females.
* CpG sites needs to be downsampled since the huge number of CpG sites will slow the clustering process.

```
#download data
library(GEOquery)
gsm <- getGEO('GSE41826')
mixtureId <- unlist(lapply(paste0('Mix',seq_len(9)),
    function(x) gsm[[1]]$geo_accession[gsm[[1]]$title==x]))
data <- gsm[[1]][,mixtureId]

#Remove CpG sites in sex chromosomes if tissues are from both males and females
#Not necessary in this example as mixtures are from the same subject
#gpl<- getGEO('GPL13534')
#annot<-dataTable(gpl)@table[,c('Name','CHR')]
#rownames(annot) <- annot$Name
#annot <- annot[rownames(data),]
#data <- data[annot$CHR != 'X' & annot$CHR != 'Y',]

#downsample CpG sites
featureId <- sample(seq_len(nrow(gsm[[1]])), 20000)

#running CAM
rCAM <- CAM(data[featureId,], K = 2, thres.low = 0.10, thres.high = 0.60)
Aest <- Amat(rCAM, 2)
Atrue <- cbind(seq(0.1, 0.9, 0.1), seq(0.9, 0.1, -0.1))
cor(Aest, Atrue)

#obtain a full list of marker CpG sites
MGstat <- MGstatistic(data, Aest)
MGlist.FC <- lapply(seq_len(2), function(x)
    rownames(MGstat)[MGstat$idx == x & MGstat$OVE.FC > 10])
```

We can also run CAM on unmethylated quantification, 1 - beta, to obtain quite similar results since the underlying linear mixing model is also applicable for unmethylated probe intensity.

```
rCAM <- CAM(1 - exprs(data[featureId,]),
            K = 2, thres.low = 0.10, thres.high = 0.60)
```

# 4 Supervised/Semi-supervised Deconvolution

## 4.1 Molecular markers are known

CAM algorithm can estimate A and S matrix based on blindly detected markers. Thus, we can also use part of CAM algorithm to estimate A and S matrix based on known markers.

```
Aest <- AfromMarkers(data, MGlist)
#MGlist is a list of vectors, each of which contains known markers for one subpopulation
```

## 4.2 S matrix is known

Many datasets provide expression profiles for purified cell lines or even every single cell, which can be treated as references of S matrix. Some methods use least squares techniques or support vector regression (CIBERSORT) to estimate A matrix based on known S matrix. `CAMTHC` will estimate A matrix by identified markers from known S matrix, which has better performance in terms of correlation coefficient with ground truth A matrix.

```
data <- ratMix3$X
S <- ratMix3$S #known S matrix

pMGstat <- MGstatistic(S, c("Liver","Brain","Lung"))
pMGlist.FC <- lapply(c("Liver","Brain","Lung"), function(x)
    rownames(pMGstat)[pMGstat$idx == x & pMGstat$OVE.FC > 10])

Aest <- AfromMarkers(data, pMGlist.FC)
```

## 4.3 A matrix is known

With known A matrix, `CAMTHC` estimates S matrix using non-negative least squares (NNLS) from *[NMF](https://CRAN.R-project.org/package%3DNMF)*, and further identify markers

```
data <- ratMix3$X
A <- ratMix3$A #known A matrix

Sest <- t(NMF::.fcnnls(A, t(data))$coef)
MGstat <- MGstatistic(data, A)
```

## 4.4 Semi-supervised Deconvolution

When prior information of markers, S matrix and/or A matrix is available, semi-supervised deconvolution can also be performed by combining markers from prior information and markers identified by CAM. While supervised deconvolution cannot handle the underlying subpopulations without prior information, unsupervised deconvolution may miss the subpopulation without enough discrimination power. Therefore, semi-supervised deconvolution can take advantage of both methods.

```
Aest <- AfromMarkers(data, MGlist)
#MGlist is a list of vectors, each of which contains known markers and/or CAM-detected markers for one subpopulation
```