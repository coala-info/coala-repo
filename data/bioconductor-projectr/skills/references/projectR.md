# projectR Vignette

Gaurav Sharma, Charles Shin, Jared N. Slosberg, Loyal A. Goff and Genevieve L. Stein-O'Brien

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Getting started with projectR](#getting-started-with-projectr)
  + [2.1 Installation Instructions](#installation-instructions)
  + [2.2 Methods](#methods)
  + [2.3 The base projectR function](#the-base-projectr-function)
    - [2.3.1 Input Arguments](#input-arguments)
    - [2.3.2 Output](#output)
* [3 PCA projection](#pca-projection)
  + [3.1 Obtaining PCs to project.](#obtaining-pcs-to-project.)
  + [3.2 Projecting prcomp objects](#projecting-prcomp-objects)
* [4 NMF projection](#nmf-projection)
  + [4.0.1 Input Arguments](#input-arguments-1)
  + [4.0.2 Output](#output-1)
  + [4.1 Obtaining CoGAPS patterns to project.](#obtaining-cogaps-patterns-to-project.)
  + [4.2 Projecting CoGAPS objects](#projecting-cogaps-objects)
* [5 Clustering projection](#clustering-projection)
  + [5.1 cluster2pattern](#cluster2pattern)
    - [5.1.1 Input Arguments](#input-arguments-2)
    - [5.1.2 Output](#output-2)
  + [5.2 intersectoR](#intersector)
    - [5.2.1 Input Arguments](#input-arguments-3)
    - [5.2.2 Output](#output-3)
* [6 Correlation based projection](#correlation-based-projection)
  + [6.1 correlateR](#correlater)
    - [6.1.1 Input Arguments](#input-arguments-4)
    - [6.1.2 Output](#output-4)
  + [6.2 Obtaining and visualizing `correlateR` objects.](#obtaining-and-visualizing-correlater-objects.)
  + [6.3 Projecting correlateR objects.](#projecting-correlater-objects.)
* [7 Differential features identification.](#differential-features-identification.)
  + [7.1 projectionDriveR](#projectiondriver)
    - [7.1.1 Input Arguments](#input-arguments-5)
    - [7.1.2 Output](#output-5)
    - [7.1.3 Identifying differential features associated with learned patterns](#identifying-differential-features-associated-with-learned-patterns)
  + [7.2 plotConfidenceIntervals](#plotconfidenceintervals)
    - [7.2.1 Input](#input)
    - [7.2.2 Output](#output-6)
    - [7.2.3 Customize plotting of confidence intervals](#customize-plotting-of-confidence-intervals)
    - [7.2.4 Input](#input-1)
    - [7.2.5 Output](#output-7)
    - [7.2.6 Customize volcano plot and run FGSEA](#customize-volcano-plot-and-run-fgsea)
    - [7.2.7 Input Arguments](#input-arguments-6)
    - [7.2.8 Output](#output-8)
    - [7.2.9 Comparing differential uses of patterns across different clusters](#comparing-differential-uses-of-patterns-across-different-clusters)
* [References](#references)

# 1 Introduction

Technological advances continue to spur the exponential growth of biological data as illustrated by the rise of the omics—genomics, transcriptomics, epigenomics, proteomics, etc.—each with there own high throughput technologies. In order to leverage the full power of these resources, methods to integrate multiple data sets and data types must be developed. The reciprocal nature of the genomic, transcriptomic, epigenomic, and proteomic biology requires that the data provides a complementary view of cellular function and regulatory organization; however, the technical heterogeneity and massive size of high-throughput data even within a particular omic makes integrated analysis challenging. To address these challenges, we developed projectR, an R package for integrated analysis of high dimensional omic data. projectR uses the relationships defined within a given high dimensional data set, to interrogate related biological phenomena in an entirely new data set. By relying on relative comparisons within data type, projectR is able to circumvent many issues arising from technological variation. For a more extensive example of how the tools in the projectR package can be used for *in silico* experiments, or additional information on the algorithm, see [Stein-O’Brien, et al](https://www.sciencedirect.com/science/article/pii/S2405471219301462) and [Sharma, et al](https://academic.oup.com/bioinformatics/article/36/11/3592/5804979).

# 2 Getting started with projectR

## 2.1 Installation Instructions

For automatic Bioconductor package installation, start R, and run:

```
BiocManager::install("genesofeve/projectR@projectionDriveR")
```

## 2.2 Methods

Projection can roughly be defined as a mapping or transformation of points from one space to another often lower dimensional space. Mathematically, this can described as a function \(\varphi(x)=y : \Re^{D} \mapsto \Re^{d}\) s.t. \(d \leq D\) for \(x \in \Re^{D}, y \in \Re^{d}\) Barbakh, Wu, and Fyfe ([2009](#ref-Barbakh:2009bw)) . The projectR package uses projection functions defined in a training dataset to interrogate related biological phenomena in an entirely new data set. These functions can be the product of any one of several methods common to “omic” analyses including regression, PCA, NMF, clustering. Individual sections focusing on one specific method are included in the vignette. However, the general design of the projectR function is the same regardless.

## 2.3 The base projectR function

The generic projectR function is executed as follows:

```
projectR(data, loadings, dataNames=NULL, loadingsNames=NULL, NP = NULL, full = false)
```

### 2.3.1 Input Arguments

The inputs that must be set each time are only the data and loadings, with all other inputs having default values. However, incongruities in the feature mapping between the data and loadings, i.e. a different format for the rownames of each object, will throw errors or result in an empty mapping and should be checked before running. To overcoming mismatched feature names in the objects themselves, the `dataNames` and `loadingNames` arguments can be manually supplied by the user.

The arguments are as follows:
**`data`** a dataset to be projected into the pattern space
**`loadings`** a matrix of continous values with unique rownames to be projected
**`dataNames`** a vector containing unique name, i.e. gene names, for the rows of the target dataset to be used to match features with the loadings, if not provided by `rownames(data)`. Order of names in vector must match order of rows in data.
**`loadingsNames`** a vector containing unique names, i.e. gene names, for the rows of loadings to be used to match features with the data, if not provided by `rownames(loadings)`. Order of names in vector must match order of rows in loadings.
**`NP`** vector of integers indicating which columns of loadings object to use. The default of NP = NA will use entire matrix.
**`full`** logical indicating whether to return the full model solution. By default only the new pattern object is returned.

The `loadings` argument in the generic projectR function is suitable for use with any genernal feature space, or set of feature spaces, whose rows annotation links them to the data to be projected. Ex: the coeffients associated with individual genes as the result of regression analysis or the amplituded values of individual genes as the result of non-negative matrix factorization (NMF).

### 2.3.2 Output

The basic output of the base projectR function, i.e. `full=FALSE`, returns `projectionPatterns` representing relative weights for the samples from the new data in this previously defined feature space, or set of feature spaces. The full output of the base projectR function, i.e. `full=TRUE`, returns `projectionFit`, a list containing `projectionPatterns` and `Projection`. The `Projection` object contains additional information from the proceedure used to obtain the `projectionPatterns`. For the the the base projectR function, `Projection` is the full `lmFit` model from the package *[limma](https://bioconductor.org/packages/3.22/limma)*.

# 3 PCA projection

Projection of principal components is achieved by matrix multiplication of a new data set by previously generated eigenvectors, or gene loadings. If the original data were standardized such that each gene is centered to zero average expression level, the principal components are normalized eigenvectors of the covariance matrix of the genes. Each PC is ordered according to how much of the variation present in the data they contain. Projection of the original samples into each PC will maximize the variance of the samples in the direction of that component and uncorrelated to previous components. Projection of new data places the new samples into the PCs defined by the original data. Because the components define an orthonormal basis set, they provide an isomorphism between a vector space, \(V\), and \(\Re^n\) which preserves inner products. If \(V\) is an inner product space over \(\Re\) with orthonormal basis \(B = v\_1,...,v\_n\) and \(v \epsilon V s.t [v]\_B = (r\_1,...,r\_n)\), then finding the coordinate of \(v\_i\) in \(v\) is precisely the inner product of \(v\) with \(v\_i\), i.e. \(r\_i = \langle v,v\_i \rangle\). This formulation is implemented for only those genes belonging to both the new data and the PC space. The **`projectR`** function has S4 method for class `prcomp`.

## 3.1 Obtaining PCs to project.

```
# data to define PCs
library(ggplot2)
data(p.RNAseq6l3c3t)

# do PCA on RNAseq6l3c3t expression data
pc.RNAseq6l3c3t<-prcomp(t(p.RNAseq6l3c3t))
pcVAR <- round(((pc.RNAseq6l3c3t$sdev)^2/sum(pc.RNAseq6l3c3t$sdev^2))*100,2)
dPCA <- data.frame(cbind(pc.RNAseq6l3c3t$x,pd.RNAseq6l3c3t))

#plot pca

setCOL <- scale_colour_manual(values = c("blue","black","red"), name="Condition:")
setFILL <- scale_fill_manual(values = c("blue","black","red"),guide = FALSE)
setPCH <- scale_shape_manual(values=c(23,22,25,25,21,24),name="Cell Line:")

pPCA <- ggplot(dPCA, aes(x=PC1, y=PC2, colour=ID.cond, shape=ID.line,
        fill=ID.cond)) +
        geom_point(aes(size=days),alpha=.6)+
        setCOL + setPCH  + setFILL +
        scale_size_area(breaks = c(2,4,6), name="Day") +
        theme(legend.position=c(0,0), legend.justification=c(0,0),
              legend.direction = "horizontal",
              panel.background = element_rect(fill = "white",colour=NA),
              legend.background = element_rect(fill = "transparent",colour=NA),
              plot.title = element_text(vjust = 0,hjust=0,face="bold")) +
        labs(title = "PCA of hPSC PolyA RNAseq",
            x=paste("PC1 (",pcVAR[1],"% of varience)",sep=""),
            y=paste("PC2 (",pcVAR[2],"% of varience)",sep=""))
```

## 3.2 Projecting prcomp objects

```
# data to project into PCs from RNAseq6l3c3t expression data
data(p.ESepiGen4c1l)
library(ggplot2)

PCA2ESepi <- projectR(data = p.ESepiGen4c1l$mRNA.Seq,loadings=pc.RNAseq6l3c3t,
full=TRUE, dataNames=map.ESepiGen4c1l[["GeneSymbols"]])
```

```
## [1] "93 row names matched between data and loadings"
## [1] "Updated dimension of data: 93 9"
```

```
pd.ESepiGen4c1l<-data.frame(Condition=sapply(colnames(p.ESepiGen4c1l$mRNA.Seq),
  function(x) unlist(strsplit(x,'_'))[1]),stringsAsFactors=FALSE)
pd.ESepiGen4c1l$color<-c(rep("red",2),rep("green",3),rep("blue",2),rep("black",2))
names(pd.ESepiGen4c1l$color)<-pd.ESepiGen4c1l$Cond

dPCA2ESepi<- data.frame(cbind(t(PCA2ESepi[[1]]),pd.ESepiGen4c1l))

#plot pca
library(ggplot2)
setEpiCOL <- scale_colour_manual(values = c("red","green","blue","black"),
  guide = guide_legend(title="Lineage"))

pPC2ESepiGen4c1l <- ggplot(dPCA2ESepi, aes(x=PC1, y=PC2, colour=Condition)) +
  geom_point(size=5) + setEpiCOL +
  theme(legend.position=c(0,0), legend.justification=c(0,0),
  panel.background = element_rect(fill = "white"),
  legend.direction = "horizontal",
  plot.title = element_text(vjust = 0,hjust=0,face="bold")) +
  labs(title = "Encode RNAseq in target PC1 & PC2",
  x=paste("Projected PC1 (",round(PCA2ESepi[[2]][1],2),"% of varience)",sep=""),
  y=paste("Projected PC2 (",round(PCA2ESepi[[2]][2],2),"% of varience)",sep=""))
```

# 4 NMF projection

NMF decomposes a data matrix of \(D\) with \(N\) genes as rows and \(M\) samples as columns, into two matrices, as \(D ~ AP\). The pattern matrix P has rows associated with BPs in samples and the amplitude matrix A has columns indicating the relative association of a given gene, where the total number of BPs (k) is an input parameter. CoGAPS and GWCoGAPS seek a pattern matrix (\({\bf{P}}\)) and the corresponding distribution matrix of weights (\({\bf{A}}\)) whose product forms a mock data matrix (\({\bf{M}}\)) that represents the gene-wise data \({\bf{D}}\) within noise limits (\(\boldsymbol{\varepsilon}\)). That is,
\[\begin{equation}
{\bf{D}} = {\bf{M}} + \boldsymbol{\varepsilon} = {\bf{A}}{\bf{P}} + \boldsymbol{\varepsilon} ..............(1)
\label{eq:matrixDecomp}
\end{equation}\]
The number of rows in \({\bf{P}}\) (columns in \({\bf{A}}\)) defines the number of biological patterns (k) that CoGAPS/GWCoGAPS will infer from the number of nonorthogonal basis vectors required to span the data space. As in the Bayesian Decomposition algorithm Wang, Kossenkov, and Ochs ([2006](#ref-Ochs2006)), the matrices \({\bf{A}}\) and \({\bf{P}}\) in CoGAPS are assumed to have the atomic prior described in Sibisi and Skilling ([1997](#ref-Sibisi1997)). In the CoGAPS/GWCoGAPS implementation, \(\alpha\_{A}\) and \(\alpha\_{P}\) are corresponding parameters for the expected number of atoms which map to each matrix element in \({\bf{A}}\) and \({\bf{P}}\), respectively. The corresponding matrices \({\bf{A}}\) and \({\bf{P}}\) are found by MCMC sampling.

Projection of CoGAPS/GWCoGAPS patterns is implemented by solving the factorization in (1) for the new data matrix where \({\bf{A}}\) is the fixed nonorthogonal basis vectors comprising the average of the posterior mean for the CoGAPS/GWCoGAPS simulations performed on the original data. The patterns \({\bf{P}}\) in the new data associated with this amplitude matrix is estimated using the least-squares fit to the new data implemented with the `lmFit` function in the *[limma](https://bioconductor.org/packages/3.22/limma)* package. The `projectR` function has S4 method for class `Linear Embedding Matrix, LME`.

```
projectR(data, loadings,dataNames = NULL, loadingsNames = NULL,
     NP = NA, full = FALSE)
```

### 4.0.1 Input Arguments

The inputs that must be set each time are only the data and patterns, with all other inputs having default values. However, inconguities between gene names–rownames of the loadings object and either rownames of the data object will throw errors and, subsequently, should be checked before running.

The arguments are as follows:

**`data`** a target dataset to be projected into the pattern space
**`loadings`** a CogapsResult object
**`dataNames`** rownames (eg. gene names) of the target dataset, if different from existing rownames of data
**`loadingsNames`** loadingsNames rownames (eg. gene names) of the loadings to be matched with dataNames
**`NP`** vector of integers indicating which columns of loadings object to use. The default of NP = NA will use entire matrix.
**`full`** logical indicating whether to return the full model solution. By default only the new pattern object is returned.

### 4.0.2 Output

The basic output of the base projectR function, i.e. `full=FALSE`, returns `projectionPatterns` representing relative weights for the samples from the new data in this previously defined feature space, or set of feature spaces. The full output of the base projectR function, i.e. `full=TRUE`, returns `projectionFit`, a list containing `projectionPatterns` and `Projection`. The `Projection` object contains additional information from the procedure used to obtain the `projectionPatterns`. For the the the base projectR function, `Projection` is the full `lmFit` model from the package *[limma](https://bioconductor.org/packages/3.22/limma)*.

## 4.1 Obtaining CoGAPS patterns to project.

```
# get data

AP <- get(data("AP.RNAseq6l3c3t")) #CoGAPS run data
AP <- AP$Amean
# heatmap of gene weights for CoGAPs patterns
library(gplots)
```

```
##
## Attaching package: 'gplots'
```

```
## The following object is masked from 'package:stats':
##
##     lowess
```

```
par(mar=c(1,1,1,1))
pNMF<-heatmap.2(as.matrix(AP),col=bluered, trace='none',
          distfun=function(c) as.dist(1-cor(t(c))) ,
          cexCol=1,cexRow=.5,scale = "row",
          hclustfun=function(x) hclust(x, method="average")
      )
```

![](data:image/png;base64...)

## 4.2 Projecting CoGAPS objects

```
# data to project into PCs from RNAseq6l3c3t expression data

data('p.ESepiGen4c1l4')
```

```
## Warning in data("p.ESepiGen4c1l4"): data set 'p.ESepiGen4c1l4' not found
```

```
data('p.RNAseq6l3c3t')

NMF2ESepi <- projectR(p.ESepiGen4c1l$mRNA.Seq,loadings=AP,full=TRUE,
    dataNames=map.ESepiGen4c1l[["GeneSymbols"]])
```

```
## [1] "93 row names matched between data and loadings"
## [1] "Updated dimension of data: 93 9"
```

```
dNMF2ESepi<- data.frame(cbind(t(NMF2ESepi),pd.ESepiGen4c1l))

#plot pca
library(ggplot2)
setEpiCOL <- scale_colour_manual(values = c("red","green","blue","black"),
guide = guide_legend(title="Lineage"))

pNMF2ESepiGen4c1l <- ggplot(dNMF2ESepi, aes(x=X1, y=X2, colour=Condition)) +
  geom_point(size=5) + setEpiCOL +
  theme(legend.position=c(0,0), legend.justification=c(0,0),
  panel.background = element_rect(fill = "white"),
  legend.direction = "horizontal",
  plot.title = element_text(vjust = 0,hjust=0,face="bold"))
  labs(title = "Encode RNAseq in target PC1 & PC2",
  x=paste("Projected PC1 (",round(PCA2ESepi[[2]][1],2),"% of varience)",sep=""),
  y=paste("Projected PC2 (",round(PCA2ESepi[[2]][2],2),"% of varience)",sep=""))
```

```
## <ggplot2::labels> List of 3
##  $ x    : chr "Projected PC1 (18.32% of varience)"
##  $ y    : chr "Projected PC2 (17.12% of varience)"
##  $ title: chr "Encode RNAseq in target PC1 & PC2"
```

# 5 Clustering projection

As canonical projection is not defined for clustering objects, the projectR package offers two transfer learning inspired methods to achieve the “projection” of clustering objects. These methods are defined by the function used to quantify and transfer the relationships which define each cluster in the original data set to the new dataset. Briefly, `cluster2pattern` uses the corelation of each genes expression to the mean of each cluster to define continuous weights. These weights are output as a `pclust` object which can serve as input to `projectR`. Alternatively, the `intersectoR` function can be used to test for significant overlap between two clustering objects. Both `cluster2pattern` and `intersectoR` methods are coded for a generic list structure with additional S4 class methods for kmeans and hclust objects. Further details and examples are provided in the followin respecitive sections.

## 5.1 cluster2pattern

`cluster2pattern` uses the corelation of each genes expression to the mean of each cluster to define continuous weights.

```
data(p.RNAseq6l3c3t)

nP<-5
kClust<-kmeans(t(p.RNAseq6l3c3t),centers=nP)
kpattern<-cluster2pattern(clusters = kClust, NP = nP, data = p.RNAseq6l3c3t)
kpattern

cluster2pattern(clusters = NA, NP = NA, data = NA)
```

### 5.1.1 Input Arguments

The inputs that must be set each time are the clusters and data.

The arguments are as follows:

**`clusters`** a clustering object
**`NP`** either the number of clusters desired or the subset of clusters to use
**`data`** data used to make clusters object

### 5.1.2 Output

The output of the `cluster2pattern` function is a `pclust` class object; specifically, a matrix of genes (rows) by clusters (columns). A gene’s value outside of its assigned cluster is zero. For the cluster containing a given gene, the gene’s value is the correlation of the gene’s expression to the mean of that cluster.

## 5.2 intersectoR

`intersectoR` function can be used to test for significant overlap between two clustering objects. The base function finds and tests the intersecting values of two sets of lists, presumably the genes associated with patterns in two different datasets. S4 class methods for `hclust` and `kmeans` objects are also available.

```
intersectoR(pSet1 = NA, pSet2 = NA, pval = 0.05, full = FALSE, k = NULL)
```

### 5.2.1 Input Arguments

The inputs that must be set each time are the clusters and data.

The arguments are as follows:

**`pSet1`** a list for a set of patterns where each entry is a set of genes associated with a single pattern
**`pSet2`** a list for a second set of patterns where each entry is a set of genes associated with a single pattern
**`pval`** the maximum p-value considered significant
**`full`** logical indicating whether to return full data frame of signigicantly overlapping sets. Default is false will return summary matrix.
**`k`** numeric giving cut height for hclust objects, if vector arguments will be applied to pSet1 and pSet2 in that order

### 5.2.2 Output

The output of the `intersectoR` function is a summary matrix showing the sets with statistically significant overlap under the specified \(p\)-value threshold based on a hypergeometric test. If `full==TRUE` the full data frame of significantly overlapping sets will also be returned.

# 6 Correlation based projection

Correlation based projection requires a matrix of gene-wise correlation values to serve as the Pattern input to the `projectR` function. This matrix can be user-generated or the result of the `correlateR` function included in the projectR package. User-generated matrixes with each row corresponding to an individual gene can be input to the generic `projectR` function. The `correlateR` function allows users to create a weight matrix for projection with values quantifying the within dataset correlation of each genes expression to the expression pattern of a particular gene or set of genes as follows.

## 6.1 correlateR

```
correlateR(genes = NA, dat = NA, threshtype = "R", threshold = 0.7, absR = FALSE, ...)
```

### 6.1.1 Input Arguments

The inputs that must be set each time are only the genes and data, with all other inputs having default values.

The arguments are as follows:

**`genes`** gene or character vector of genes for reference expression pattern dat
**`data`** matrix or data frame with genes to be used for to calculate correlation
**`threshtype`** Default “R” indicates thresholding by R value or equivalent. Alternatively, “N” indicates a numerical cut off.
**`threshold`** numeric indicating value at which to make threshold
**`absR`** logical indicating where to include both positive and negatively correlated genes
**`...`** addtion imputes to the cor function

### 6.1.2 Output

The output of the `correlateR` function is a `correlateR` class object. Specifically, a matrix of correlation values for those genes whose expression pattern pattern in the dataset is correlated (and anti-correlated if absR=TRUE) above the value given in as the threshold arguement. As this information may be useful in its own right, it is recommended that users inspect the `correlateR` object before using it as input to the `projectR` function.

## 6.2 Obtaining and visualizing `correlateR` objects.

```
# data to

data("p.RNAseq6l3c3t")

# get genes correlated to T
cor2T<-correlateR(genes="T", dat=p.RNAseq6l3c3t, threshtype="N", threshold=10, absR=TRUE)
cor2T <- cor2T@corM
### heatmap of genes more correlated to T
indx<-unlist(sapply(cor2T,rownames))
indx <- as.vector(indx)
colnames(p.RNAseq6l3c3t)<-pd.RNAseq6l3c3t$sampleX
library(reshape2)
pm.RNAseq6l3c3t<-melt(cbind(p.RNAseq6l3c3t[indx,],indx))
```

```
## Using indx as id variables
```

```
library(gplots)
library(ggplot2)
library(viridis)
```

```
## Loading required package: viridisLite
```

```
pCorT<-ggplot(pm.RNAseq6l3c3t, aes(variable, indx, fill = value)) +
  geom_tile(colour="gray20", size=1.5, stat="identity") +
  scale_fill_viridis(option="B") +
  xlab("") +  ylab("") +
  scale_y_discrete(limits=indx) +
  ggtitle("Ten genes most highly pos & neg correlated with T") +
  theme(
    panel.background = element_rect(fill="gray20"),
    panel.border = element_rect(fill=NA,color="gray20", size=0.5, linetype="solid"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_text(size=rel(1),hjust=1),
    axis.text.x = element_text(angle = 90,vjust=.5),
    legend.text = element_text(color="white", size=rel(1)),
    legend.background = element_rect(fill="gray20"),
    legend.position = "bottom",
    legend.title=element_blank()
)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

## 6.3 Projecting correlateR objects.

```
# data to project into from RNAseq6l3c3t expression data
data(p.ESepiGen4c1l)

cor2ESepi <- projectR(p.ESepiGen4c1l$mRNA.Seq,loadings=cor2T[[1]],full=FALSE,
    dataNames=map.ESepiGen4c1l$GeneSymbols)
```

```
## [1] "9 row names matched between data and loadings"
## [1] "Updated dimension of data: 9 9"
```

# 7 Differential features identification.

## 7.1 projectionDriveR

Given loadings that define the weight of features (genes) in a given latent space (e.g. PCA, NMF), and the use of these patterns in samples, it is of interest to look at differential usage of these features between conditions. These conditions may be defined by user-defined annotations of cell type or by differential usage of a (projected) pattern. By examining differences in gene expression, weighted by the loadings that define their importance in a specific latent space, a unique understanding of differential expression in that context can be gained. This approach was originally proposed and developed in (Baraban et al, 2021), which demonstrates its utility in cross-celltype and cross-species interpretation of pattern usages.

```
projectionDriveR(cellgroup1, cellgroup2, loadings, loadingsNames = NULL,
                 pvalue, pattern_name, display = T, normalize_pattern = T, mode = "CI")
```

### 7.1.1 Input Arguments

The required inputs are two feature by sample (e.g. gene by cell) matrices to be compared, the loadings that define the feature weights, and the name of the pattern (column of feature loadings). If applicable, the expression matrices should already be corrected for variables such as sequencing depth.

The arguments for projectionDriveR are:

**`cellgroup1`** Matrix 1 with features as rows, samples as columns.
**`cellgroup2`** Matrix 2 with features as rows, samples as columns.
**`loadings`** Matrix or dataframe with features as rows, columns as patterns. Values define feature weights in that space
**`loadingsNames`** Vector of names corresponding to rows of loadings. By default the rownames of loadings will be used
**`pattern_name`** the column name of the loadings by which the features will be weighted
**`pvalue`** Determines the significance of the confidence interval to be calculated between the difference of means. Default 1e-5
**`display`** Boolean. Whether or not to plot the estimates of significant features. Default = T
**`normalize_pattern`** Boolean. Whether or not to normalize the average feature weight. Default = T
**`mode`** ‘CI’ or ‘PV’. Specifies whether to run projectionDriveR in confidence interval mode or to generate p values. Default = “CI”

### 7.1.2 Output

The output of `projectionDriveR` in confidence interval mode (‘CI’) is a list of length six `mean_ci` holds the confidence intervals for the difference in means for all features, `weighted_mean_ci` holds the confidence intervals for the weighted difference in means for all features, and `normalized_weights` are the weights themselves. In addition, `sig_genes` is a list of three vectors of gene names that are significantly different at the threshold provided generated from the mean confidence intervals (`unweighted_sig_genes`), the weighted mean confidence intervals (`weighted_sig_genes`) and genes shared between the two (`significant_shared_genes`) . `plotted_ci` returns the ggplot figure of the confidence intervals, see `plotConfidenceIntervals` for documentation. `meta_data` contains matrix names and pvalue thresholds. The output of `projectionDriveR` in p value mode (‘PV’) is a list of length nine. `meta_data`, `sig_genes` and `normalized_weights` are similar between modes. `mean_stats` and `weighted_mean_stats` contains summary information for welch t-tests. `difexpgenes` and `weighted_difexpgenes` are filtered dataframes containing differentially expressed genes at a FC and pvalue cut off of 0.2 and 1e-5 respectively. `fgseavecs` contain unweighted and weighted named vectors of welch-t test estimates that can be used with fgsea. `plt` returns the volcano ggplot figure. See `pdVolcano` for documentation. FC and pvalue can be manually altered by calling pdVolcano on projectionDriveR result.

### 7.1.3 Identifying differential features associated with learned patterns

```
options(width = 60)
library(dplyr, warn.conflicts = F)

#size-normed, log expression
data("microglial_counts")

#size-normed, log expression
data("glial_counts")

#5 pattern cogaps object generated on microglial_counts
data("cr_microglial")
microglial_fl <- cr_microglial@featureLoadings

#the features by which to weight the difference in expression
pattern_to_weight <- "Pattern_1"
drivers_ci <- projectionDriveR(microglial_counts, #expression matrix
                                       glial_counts, #expression matrix
                                       loadings = microglial_fl, #feature x pattern dataframe
                                       loadingsNames = NULL,
                                       pattern_name = pattern_to_weight, #column name
                                       pvalue = 1e-5, #pvalue before bonferroni correction
                                       display = T,
                                       normalize_pattern = T, #normalize feature weights
                                       mode = "CI") #confidence interval mode
```

![](data:image/png;base64...)

```
conf_intervals <- drivers_ci$mean_ci[drivers_ci$sig_genes$significant_shared_genes,]

str(conf_intervals)
```

```
## 'data.frame':    330 obs. of  3 variables:
##  $ low : num  -1.009 0.102 1.86 -2.089 -0.791 ...
##  $ high: num  -0.35 0.356 2.039 -1.359 -0.28 ...
##  $ gene: chr  "ENSMUSG00000067879" "ENSMUSG00000026158" "ENSMUSG00000026126" "ENSMUSG00000060424" ...
```

```
drivers_pv <- projectionDriveR(microglial_counts, #expression matrix
                                       glial_counts, #expression matrix
                                       loadings = microglial_fl, #feature x pattern dataframe
                                       loadingsNames = NULL,
                                       pattern_name = pattern_to_weight, #column name
                                       pvalue = 1e-5, #pvalue before bonferroni correction
                                       display = T,
                                       normalize_pattern = T, #normalize feature weights
                                       mode = "PV") #confidence interval mode
```

![](data:image/png;base64...)

```
difexp <- drivers_pv$difexpgenes
str(difexp)
```

```
## 'data.frame':    440 obs. of  10 variables:
##  $ ref_mean    : num  0.3193 0.7124 0.108 0.0145 1.9462 ...
##  $ test_mean   : num  0.0127 0.0331 0.3367 1.964 0.2223 ...
##  $ mean_diff   : num  -0.307 -0.679 0.229 1.949 -1.724 ...
##  $ estimate    : num  -27.46 -35.77 7.81 41.72 -51.84 ...
##  $ welch_pvalue: num  1.45e-150 2.97e-234 4.14e-14 1.06e-150 3.99e-253 ...
##  $ welch_padj  : num  4.36e-147 8.91e-231 1.24e-10 3.17e-147 1.20e-249 ...
##  $ gene        : chr  "ENSMUSG00000002459" "ENSMUSG00000067879" "ENSMUSG00000026158" "ENSMUSG00000026126" ...
##  $ Color       : Factor w/ 3 levels "NS or FC < 0.2",..: 2 2 3 3 2 2 3 2 2 2 ...
##  $ invert_P    : num  -44.87 -156.26 2.26 285.6 -429.14 ...
##  $ label       : chr  NA NA NA NA ...
```

## 7.2 plotConfidenceIntervals

### 7.2.1 Input

The arguments for plotConfidenceIntervals are:

**`confidence_intervals`** A dataframe of features x estimates
**`interval_name`** names of columns that contain the low and high estimates, respectively. (default: c(“low”,“high”))
**`pattern_name`** string to use as the title for the plots
**`sort`** Boolean. Whether or not to sort genes by their estimates (default = T)
**`genes`** a vector with names of genes to include in plot. If sort=F, estimates will be plotted in this order (default = NULL will include all genes.)
**`weights`** weights of features to include as annotation (default = NULL will not include heatmap)
**`weights_clip`** quantile of data to clip color scale for improved visualization (default: 0.99)
**`weights_vis_norm`** Which processed version of weights to visualize as a heatmap. One of c(“none”, “quantile”). default = “none”
**`weighted`** Boolean. Specifies whether confidence intervals are weighted by a pattern or not. Default = “F”

### 7.2.2 Output

A list of the length three that includes confidence interval plots and relevant info. `ci_estimates_plot` is the point-range plot for the provided estimates. If called from within `projectionDriveR`, the unweighted estimates are used. `feature_order` is the vector of gene names in the order shown in the figure. `weights_heatmap` is a heatmap annotation of the gene loadings, in the same order as above.

### 7.2.3 Customize plotting of confidence intervals

```
suppressWarnings(library(cowplot))
#order in ascending order of estimates
conf_intervals <- conf_intervals %>% mutate(mid = (high+low)/2) %>% arrange(mid)
gene_order <- rownames(conf_intervals)

#add text labels for top and bottom n genes
conf_intervals$label_name <- NA_character_
n <- 2
idx <- c(1:n, (dim(conf_intervals)[1]-(n-1)):dim(conf_intervals)[1])
gene_ids <- gene_order[idx]
conf_intervals$label_name[idx] <- gene_ids

#the labels above can now be used as ggplot aesthetics
plots_list <- plotConfidenceIntervals(conf_intervals, #mean difference in expression confidence intervals
                                      sort = F, #should genes be sorted by estimates
                                      weights = drivers_ci$normalized_weights[rownames(conf_intervals)],
                                      pattern_name = pattern_to_weight,
                                      weights_clip = 0.99,
                                      weights_vis_norm = "none")

pl1 <- plots_list[["ci_estimates_plot"]] +
  ggrepel::geom_label_repel(aes(label = label_name), max.overlaps = 20, force = 50)

pl2 <- plots_list[["weights_heatmap"]]

#now plot the weighted differences
weighted_conf_intervals <- drivers_ci$weighted_mean_ci[gene_order,]
plots_list_weighted <- plotConfidenceIntervals(weighted_conf_intervals,
                                               sort = F,
                                               weighted = T)

pl3 <- plots_list_weighted[["ci_estimates_plot"]] +
  xlab("Difference in weighted group means") +
  theme(axis.title.y = element_blank(), axis.ticks.y = element_blank(), axis.text.y = element_blank())

cowplot::plot_grid(pl1, pl2, pl3, align = "h", rel_widths = c(1,.4, 1), ncol = 3)
```

```
## Warning: Removed 326 rows containing missing values or values
## outside the scale range (`geom_label_repel()`).
```

![](data:image/png;base64...)
##pdVolcano

### 7.2.4 Input

The arguments for pdVolcano are:

**`result`** Output from projectionDriveR function with PV mode selected
**`FC`** fold change threshold, default at 0.2
**`pvalue`** significance threshold, default set to pvalue stored in projectionDriveR output
**`subset`** optional vector of gene names to subset the result by
**`filter.inf`** Boolean. If TRUE will remove genes that have pvalues below machine double minimum value
**`label.num`** number of genes to label on either end of volcano plot, default to 5 (10 total)
**`display`** Boolean. Default TRUE, will print volcano plots using cowplot grid\_arrange

### 7.2.5 Output

Generates the same output as projectionDriveR. Allows manual updates to pvalue and FC thresholds and can accept gene lists of interest to subset results.

### 7.2.6 Customize volcano plot and run FGSEA

```
suppressWarnings(library(cowplot))
library(fgsea)
library(msigdbr)
#manually change FC and pvalue threshold from defaults 0.2, 1e-5
drivers_pv_mod <- pdVolcano(drivers_pv, FC = 0.5, pvalue = 1e-7)
```

```
## Updating sig_genes...
```

![](data:image/png;base64...)

```
difexp_mod <- drivers_pv_mod$difexpgenes
str(difexp_mod)
```

```
## 'data.frame':    213 obs. of  10 variables:
##  $ ref_mean    : num  0.7124 0.0145 1.9462 0.6037 0.742 ...
##  $ test_mean   : num  0.0331 1.964 0.2223 0.0681 0.1416 ...
##  $ mean_diff   : num  -0.679 1.949 -1.724 -0.536 -0.6 ...
##  $ estimate    : num  -35.8 41.7 -51.8 -28.8 -23.5 ...
##  $ welch_pvalue: num  2.97e-234 1.06e-150 3.99e-253 5.10e-139 5.41e-92 ...
##  $ welch_padj  : num  8.91e-231 3.17e-147 1.20e-249 1.53e-135 1.62e-88 ...
##  $ gene        : chr  "ENSMUSG00000067879" "ENSMUSG00000026126" "ENSMUSG00000060424" "ENSMUSG00000045515" ...
##  $ Color       : Factor w/ 3 levels "NS or FC < 0.5",..: 2 3 2 2 2 3 2 2 2 2 ...
##  $ invert_P    : num  -156.3 285.6 -429.1 -72.2 -52.7 ...
##  $ label       : chr  NA NA NA NA ...
```

```
#fgsea application

#extract unweighted fgsea vector
fgseavec <- drivers_pv$fgseavecs$unweightedvec
#split into enrichment groups, negative estimates are enriched in the reference matrix (glial), positive are enriched in the test matrix (microglial), take abs value
glial_fgsea_vec <- abs(fgseavec[which(fgseavec < 0)])
microglial_fgsea_vec <- abs(fgseavec[which(fgseavec > 0)])

#get FGSEA pathways - selecting subcategory C8 for cell types
msigdbr_list =  msigdbr::msigdbr(species = "Mus musculus", category = "C8")
```

```
## Using human MSigDB with ortholog mapping to mouse. Use `db_species = "MM"` for mouse-native gene sets.
## This message is displayed once per session.
```

```
## Warning: The `category` argument of `msigdbr()` is deprecated as of
## msigdbr 10.0.0.
## ℹ Please use the `collection` argument instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where
## this warning was generated.
```

```
pathways = split(x = msigdbr_list$ensembl_gene, f = msigdbr_list$gs_name)

#run fgsea scoreType positive, all values will be positive
glial_fgsea <- fgsea::fgsea(pathways, glial_fgsea_vec, scoreType = "pos")
#tidy
glial_fgseaResTidy <- glial_fgsea %>%
  subset(padj <= 0.05 & size >= 10 & size <= 500) %>%
    as_tibble() %>%
    dplyr::arrange(desc(size))
#plot
glial_EnrichmentPlot <- ggplot2::ggplot(glial_fgseaResTidy,
                                        ggplot2::aes(reorder(pathway, NES), NES)) +
  ggplot2::geom_point(aes(size=size, color = padj)) +
  coord_flip() +
  labs(x="Pathway", y="Normalized Enrichment Score", title="Pathway NES from GSEA") +
  theme_minimal()
glial_EnrichmentPlot
```

![](data:image/png;base64...)

```
microglial_fgsea <- fgsea::fgsea(pathways, microglial_fgsea_vec, scoreType = "pos")
#tidy
microglial_fgseaResTidy <- microglial_fgsea %>%
  subset(padj <= 0.05 & size >= 10 & size <= 500) %>%
    as_tibble() %>%
    dplyr::arrange(desc(size))

microglial_EnrichmentPlot <- ggplot2::ggplot(microglial_fgseaResTidy,
                                             ggplot2::aes(reorder(pathway, NES), NES)) +
  ggplot2::geom_point(aes(size=size, color = padj)) +
  coord_flip() +
  labs(x="Pathway", y="Normalized Enrichment Score", title="Pathway NES from GSEA") +
  theme_minimal()
microglial_EnrichmentPlot
```

![](data:image/png;base64...)
##multivariateAnalysisR

This function performs multivariate analysis on different clusters within a dataset, which in this case is restricted to Seurat Object. Clusters are identified as those satisfying the conditions specified in their corresponding dictionaries. `multivariateAnalysisR` performs two tests: Analysis of Variance (ANOVA) and Confidence Interval (CI) evaluations. ANOVA is performed to understand the general differentiation between clusters through the lens of a specified pattern. CI is to visualize pair-wise differential expressions between two clusters for each pattern. Researchers can visually understand both the macroscopic and microscopic differential uses of each pattern across different clusters through this function.

```
multivariateAnalysisR <- function(significanceLevel = 0.05, patternKeys, seuratobj,
                                  dictionaries, customNames = NULL, exclusive = TRUE,
                                  exportFolder = "", ANOVAwidth = 1000,
                                  ANOVAheight = 1000, CIwidth = 1000, CIheight = 1000,
                                  CIspacing = 1)
```

### 7.2.7 Input Arguments

The required inputs are `patternKeys` (list of strings indicating the patterns to be evaluated), `seuratobj` (the Seurat Object data containing both clusters and patterns), and `dictionaries` (list of dictionary where each dictionary indicates the conditions each corresponding cluster has to satisfy).

The arguments for `multivariateAnalysisR` are:

**`significanceLevel`** Double value for testing significance in ANOVA test.
**`patternKeys`** List of strings indicating pattern subsets from seuratobj to be analyzed.
**`seuratobj`** Seurat Object Data containing patternKeys in meta.data.
**`dictionaries`** List of dictionaries indicating clusters to be compared.
**`customNames`** List of custom names for clusters in corresponding order.
**`exclusive`** Boolean value for determining interpolation between params in clusters.
**`exportFolder`** Name of folder to store exported graphs and CSV files.
**`ANOVAwidth`** Width of ANOVA png.
**`ANOVAheight`** Height of ANOVA png.
**`CIwidth`** Width of CI png.
**`CIheight`** Height of CI png.
**`CIspacing`** Spacing between each CI in CI graph.

### 7.2.8 Output

`multivariateAnalysisR` returns a sorted list of the generated ANOVA and CI values. It also exports two pairs of exported PNG/CSV files: one for ANOVA analysis, another for CI. From the ANOVA analysis, researchers can see the general ranking of differential uses of patterns across the specified clusters. From the CI analysis, researchers can identify the specific differential use cases between every pair of clusters.

### 7.2.9 Comparing differential uses of patterns across different clusters

Demonstrative example will be added soon.

# References

Barbakh, Wesam Ashour, Ying Wu, and Colin Fyfe. 2009. “Review of Linear Projection Methods.” In *Non-Standard Parameter Adaptation for Exploratory Data Analysis*, 29–48. Berlin, Heidelberg: Springer Berlin Heidelberg.

Sibisi, Sibusiso, and John Skilling. 1997. “Prior Distributions on Measure Space.” *Journal of the Royal Statistical Society: Series B (Statistical Methodology)* 59 (1): 217–35. <https://doi.org/10.1111/1467-9868.00065>.

Wang, Guoli, Andrew V. Kossenkov, and Michael F. Ochs. 2006. “LS-Nmf: A Modified Non-Negative Matrix Factorization Algorithm Utilizing Uncertainty Estimates.” *BMC Bioinformatics* 7 (1): 175. <https://doi.org/10.1186/1471-2105-7-175>.