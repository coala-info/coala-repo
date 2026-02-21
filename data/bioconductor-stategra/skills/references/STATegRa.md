# STATegRa User’s Guide

The STATegra Consortium

#### 2018-04-04

# Contents

* [1 Introduction](#introduction)
* [2 Getting Started](#getting-started)
* [3 Omics Component Analysis](#omics-component-analysis)
  + [3.1 Overview](#overview)
  + [3.2 Usage](#usage)
  + [3.3 Worked example](#worked-example)
    - [3.3.1 Load data](#load-data)
    - [3.3.2 Model Selection](#model-selection)
    - [3.3.3 Component Analysis](#component-analysis)
    - [3.3.4 Plot results](#plot-results)
* [4 Omics Clustering](#omics-clustering)
  + [4.1 Overview](#overview-1)
    - [4.1.1 The Problem](#the-problem)
    - [4.1.2 The OmicsClustering Approach](#the-omicsclustering-approach)
  + [4.2 Usage](#usage-1)
    - [4.2.1 Loading the data](#loading-the-data)
    - [4.2.2 Computing the distance between genes by using mRNA data: the bioDistclass class](#computing-the-distance-between-genes-by-using-mrna-data-the-biodistclass-class)
    - [4.2.3 Loading the map between miRNA and genes: the bioMap class](#loading-the-map-between-mirna-and-genes-the-biomap-class)
    - [4.2.4 miRNA-Surrogate gene Distances: the bioDist function](#mirna-surrogate-gene-distances-the-biodist-function)
    - [4.2.5 Computing weighted distances: the bioDistW function](#computing-weighted-distances-the-biodistw-function)
  + [4.3 Plots](#plots)
    - [4.3.1 Plotting the feature distance of each weighted combination](#plotting-the-feature-distance-of-each-weighted-combination)
    - [4.3.2 Plotting associated features](#plotting-associated-features)
    - [4.3.3 OmicsClustering Requirements](#omicsclustering-requirements)
* [5 omicsNPC](#omicsnpc)
  + [5.1 Overview](#overview-2)
    - [5.1.1 The Problem](#the-problem-1)
    - [5.1.2 The NPC Approach](#the-npc-approach)
  + [5.2 Usage](#usage-2)
    - [5.2.1 Loading the data](#loading-the-data-1)
    - [5.2.2 Setting the dataTypes variable](#setting-the-datatypes-variable)
    - [5.2.3 Setting the combMethods variable](#setting-the-combmethods-variable)
    - [5.2.4 Setting the numPerms, numCores and verbose variables](#setting-the-numperms-numcores-and-verbose-variables)
    - [5.2.5 Run omicsNPC analysis.](#run-omicsnpc-analysis.)
* [References](#references)

# 1 Introduction

Recent developments in high-throughput technologies for studying biological systems enables the researcher to simultaneously obtain several different types of data (“omics”) over the course of an experiment. There exist many techniques for analysing the behaviour of these omics individually, but combining multiple classes of omics data can be used to give a better understanding of the biological system in question; the whole is greater than the sum of its parts. Integration of different types of omics data is an increasingly important technique for studying biological systems.

The first step in this kind of integration analysis is to identify patterns in data shared by all the omics classes, and use these patterns to identify outliers. The most common techniques for this sort of analysis are clustering and principal components analysis.

The `STATegRa` package provides several different techniques for the evaluation of reproducibility among samples and across experimental conditions by combining the information contained in multiple omics datasets. This is intended as a starting point for further integration analysis of any multi-omics dataset.

The `STATegRa` package implements two main utilities for this purpose: component analysis and clustering.

[Component Analysis](#omics-component-analysis)
:   Three different techniques for analysing the common and distinctive variability between two different, multi-omics datasets are provided, along with various utility functions and plotting tools to evaluate the results.

[Clustering](#omics-clustering)
:   Methods are provided to cluster together features across different omics types, with a view to finding interesting similarities between features (rather than similarities between samples).

Furthermore, the next important step is the identification of genes, which are differential expressed between the experimental conditions under study, according to the different data types considered as a whole. The `STATegRa` package provides the possibility to identify genes which are differential expressed in one or more data types. One main utility is implemented for this purpose: omicsNPC.

[omicsNPC](#omicsNPC)
:   omicsNPC is specifically devised for identifying differentially expressed genes by ‘holistically’ combining different omics data. It applies the NonParametric Combination (NPC) methodology (Pesarin and Salmaso [2010](#ref-Pesarin2010)) in order to combine all available information by taking into account possible between-datasets correlations.

This guide provides an overview of the different techniques included in the package, some worked examples of using the tools and some guidance on interpretation of the results obtained.

# 2 Getting Started

The *[STATegRa](https://bioconductor.org/packages/3.22/STATegRa)* package can be obtained from the [Bioconductor repository](http://www.bioconductor.org/).

Load the `STATegRa` package into an `R` session by typing:

```
library(STATegRa) # Load STATegRa package
```

General information about usage of the package and the algorithms used can be found in the package vignette. In addition, every public function in the package is documented and help can be found in the normal R fashion:

```
help(package="STATegRa") ## Package help
?omicsCompAnalysis ## Specific function help
```

# 3 Omics Component Analysis

## 3.1 Overview

The joint analysis of multiple omic datasets, both containing different classes of data and from different experimental conditions, could provide a “global” view on the biological system of interest. The major challenge in this type of analysis is to distinguish between the underlying mechanisms affecting all datasets, and the particular mechanisms which affect each omic dataset separately. Three different methods are provided to this end: *DISCO-SCA* (Van Deun et al. [2012](#ref-van2012disco); Schouteden et al. [2013](#ref-schouteden2013sca), [2014](#ref-schouteden2014performing)), *JIVE* (Lock et al. [2013](#ref-lock2013joint)) and *O2PLS* (Trygg and Wold [2003](#ref-trygg2003o2)). Each method provides the user with a decomposition of the variability of the composite data into common and distinctive variability. All of them are based on singular value decomposition (SVD) of the data matrix, however they use different models to accomplish this.

The *DISCO-SCA* (Van Deun et al. [2012](#ref-van2012disco)) approach consists of two steps. First a Simultaneous Components Analysis (SCA) is performed, then the scores obtained are rotated into a *DIS*tinctive and *CO*mmon structure (hence, *DISCO*). Therefore, by applying SCA approach, each block of data \(X\_k\) of size \(I\times J\_k\) becomes

\[X\_k=TP\_k^T+E\_k\]

with \(T\) the \(I\times R\) matrix of components scores that is shared between all blocks and \(P\_k\) the \(J\_k\times R\) matrix of components loadings for block \(k\). Then, a rotation criterion is used where the target is the rotation which specifies distinctive components as components having zero scores in the positions that correspond to the data blocks the component does not underlie, and the remaining entries are arbitrary. The rotation matrix \(B\) is found by minimizing \(min(B)||W \circ (P\_{target}-[P\_1^TP\_2^T]B)||^2 \mbox{ such that } B^TB=I=BB^T\), where \(W\) is a binary matrix having ones in the positions of the entries in the target and zero elsewhere.

The *JIVE* approach (Lock et al. [2013](#ref-lock2013joint)) model is as following: Let \(X\_1,X\_2\) be two blocks of data and \(X=[X\_1,X\_2]\) represent the joint data, then the JIVE decomposition is defined as:

\[X\_i=J\_i+A\_i+\epsilon\_i \mbox{, }i=1,2\]

where \(J=[J\_1,J\_2]\) is the \(p\times n\) matrix of rank \(r<rank(X)\) representing the joint structure, \(A\_i\) is the \(p\_i\times n\) matrix of rank \(r\_i<rank(X\_i)\) representing the individual structure of \(X\_i\) and \(\epsilon\_i\) are \(p\_i\times n\) error matrices of independent entries.

Finally, the *O2PLS* (Trygg and Wold [2003](#ref-trygg2003o2)) approach uses multiple linear regression to estimate the pure constituent profiles and divides the systematic part into two, one common to both blocks and one not. The *O2PLS* model can be written as a factor analysis where some factors are common between both blocks.

\[\mbox{X model: } X=TW^T+T\_{Y-ortho}P^T\_{Y-ortho}+E \\ \mbox{Y model: } Y=UC^T+U\_{X-ortho}P^T\_{X-ortho}+F \\ \mbox{Inner relation: } U=T+H\]

In this section, the different techniques for the analysis of the variability among different samples and conditions are explained. In addition, a worked example with an explanation of the interpretation of the graphical outputs is provided.

## 3.2 Usage

The typical workflow for component analysis is shown below.

![](data:image/png;base64...)

Main steps in components analysis

Firstly, the number of common and distinctive components must be determined. The `modelSelection()` function (see [Model Selection](#model-selection)) provides a heuristic for this if the numbers are not known.

The main analysis is done by running the `omicsCompAnalysis()` function (see [Component Analysis](#component-analysis)). The input data is a list of `ExpressionSet` objects, one for each block of data. These `ExpressionSet` objects can be created from a typical data matrix by using the `createOmicsExpressionSet()` function. An object describing the experiment design can also be added, which is used to appropriately format plots of the results. The `omicsCompAnalysis()` function allows the user to preprocess the input data by scaling and centering each block and/or weighting blocks together (to avoid the effects of blocks having different sizes). After the selected preprocessing is done, the analysis with the selected method is applied. The results are provided in a `caClass` object. This class contains the common and distinctive scores/loadings, as well as the initial data and the selected configuration for the analysis.

Finally, results can be plotted by using several plot functions on a `caClass` object (see [Plot results](#plot-results)).

## 3.3 Worked example

### 3.3.1 Load data

The dataset used for this section is based on the one used in OmicsClustering (`STATegRa_S1`), but is modified in a second step to obtain a dataset with a fixed number of common components by using the process described in (Van Deun et al. [2012](#ref-van2012disco)). The initial dataset comprises \(23,293\) genes and 534 miRNAs, but for the example presented here, 600 genes and 300 miRNAs are selecting according their significance in an ANOVA analysis comparing tumor subtypes111 Analysis done using the `limma` (Smyth [2005](#ref-limma)) R-package from Bioconductor.

Data can be loaded by typing:

```
data("STATegRa_S3")
ls()
```

```
## [1] "Block1.PCA" "Block2.PCA" "ed.PCA"     "g_legend"
```

The loaded data consists of two matrices (`Block1.PCA`, `Block2.PCA`) corresponding to gene and microRNA expression data respectively. Also, another matrix (`ed.PCA`) indicating the experimental design of the data is provided. This experimental design matrix is a one-column matrix indicating which subtype of tumour corresponds to each sample. For the main analysis, the input consists of a list of expression sets. These matrices could be easily converted in `ExpressionSet` objects by using `createOmicsExpressionSet()` function as follows:

```
# Block1 - gene expression data
B1 <- createOmicsExpressionSet(Data=Block1.PCA, pData=ed.PCA,
                               pDataDescr=c("classname"))

# Block2 - miRNA expression data
B2 <- createOmicsExpressionSet(Data=Block2.PCA, pData=ed.PCA,
                               pDataDescr=c("classname"))
```

### 3.3.2 Model Selection

To perform component analysis, it is required to find the number of common and distinctive components that the dataset is expected to contain. This step is optional; if you know how many common and distinctive components are expected, this can be used as input to the next step.

Model selection is done by using the `modelSelection()` function. This function first calculates the optimal number of common components. Then, the optimal number of individual components is found by subtracting the optimal number of individual components and the optimal number of common components calculated before. This individual components selection could be done by a cross-validation of the individual PCA results222 This option is not avaliable yet, but can be done using other R packages such as *[pcaMethods](https://bioconductor.org/packages/3.22/pcaMethods)* or *[missMDA](https://CRAN.R-project.org/package%3DmissMDA)*, or by some other criteria.

For common components estimation, the Simultaneous Component Analysis (SCA) is applied. The idea is that the scores for both blocks should have a similar behavior if the components are in a common mode. That is, the estimation of the original data by using \(\hat{X}=T\_XP'\_X\) and \(\hat{X}\_Y=T\_YP'\_X\) should give similar results. If not, the scores were calculated using uncommon factors and are not common components. To evaluate if a component is common or not, the ratios between the explained variances (SSQ) of each block and its estimation (\(SSQ\_X/SSQ\_{X\_Y}\) and \(SSQ\_Y/SSQ\_{Y\_X}\)) are used. The highest component having its ratios between \(0.8\) and \(1.5\) is selected as the optimal number of common components. The SSQ can be shown as plots.

For distinctive components, function allows the user to select the optimal number of distinctive components depending on the percentage of accumulated variance explained, the individual explained variance of each component, the absolute value of its variability or just a fixed number of components.

Preprocessing of data can be done using this function, and should be specified by using the parameters `center`, `scale` and `weight`. If these parameters are not provided, preprocessing is not applied by default. Centering and scaling is applied independently to each block of data, while weight is applied to both blocks together. Weighting between blocks should be applied when the size of datasets is different.

```
ms <- modelSelection(Input=list(B1, B2), Rmax=3, fac.sel="single%",
                     varthreshold=0.03, center=TRUE, scale=TRUE,
                     weight=TRUE, plot_common=FALSE, plot_dist=FALSE)
```

```
## Common components
## [1] 2
##
## Distinctive components
## [[1]]
## [1] 2
##
## [[2]]
## [1] 2
```

```
grid.arrange(ms$common$pssq, ms$common$pratios, ncol=2) #switching plot_common=TRUE gives automaticaly these plots
```

![](data:image/png;base64...)

This function automatically calculates the optimal number of common (allowing the visualization of SSQs) and individual components depending on the maximal number of common components and the individual components selection criteria provided by the user. The result is a list with the common and distinctive component analysis.

### 3.3.3 Component Analysis

Component Analysis is done using `omicsCompAnalysis()` function, where the method (DISCO, JIVE or O2PLS) to be applied is indicated via the `method` parameter. Preprocessing of data can be done using this function, and should be specified by using the parameters `center`, `scale` and `weight`, in the same way as `modelSelection()` function. If these parameters are not provided, preprocessing is not applied by default. Centering and scaling is applied independently to each block of data, while weight is applied to both blocks together. Weighting between blocks should be applied when the size of datasets is different. To use this function you have to specify the number of common and distinctive components (see [Model Selection](#model-selection)). Finally, the `convThres` and `maxIter` parameters are stop criteria for the DISCO-SCA and JIVE approaches.

```
discoRes <- omicsCompAnalysis(Input=list(B1, B2), Names=c("expr", "mirna"),
                              method="DISCOSCA", Rcommon=2, Rspecific=c(2, 2),
                              center=TRUE, scale=TRUE, weight=TRUE)
jiveRes <- omicsCompAnalysis(Input=list(B1, B2), Names=c("expr", "mirna"),
                             method="JIVE", Rcommon=2, Rspecific=c(2, 2),
                             center=TRUE, scale=TRUE, weight=TRUE)
o2plsRes <- omicsCompAnalysis(Input=list(B1, B2),Names=c("expr", "mirna"),
                              method="O2PLS", Rcommon=2, Rspecific=c(2, 2),
                              center=TRUE, scale=TRUE, weight=TRUE)
```

The results obtained are in a `caClass` object.

```
slotNames(discoRes)
```

```
##  [1] "InitialData"   "Names"         "preprocessing" "preproData"
##  [5] "caMethod"      "commonComps"   "distComps"     "scores"
##  [9] "loadings"      "VAF"           "others"
```

Most of the slots in this class provide information about the input parameters/data of the function. The `InitialData` slot stores the input list of `ExpressionSet` objects and `Names` the specified names of the omics data sets. The `preprocessing` slot is a vector indicating the preprocessing applied to the data and `preproData` contains the so-processed data. The `caMethod` slot is a character indicating which components analysis method was applied to the data. The slots named `commonComps` and `distComps` indicate the number of common and distinctive components provided. Finally, the slots associated with the results of the analysis are `scores`, `loadings` and `VAF`. Finally, the `others` slot stores extra information specific to each different method.

These slots are accessible via accessor functions. All these functions allow the user to choose which part of the information in the slot is to be retrieved (e.g. the block of data whose information is retrieved can be specified in almost all accession functions). To access the initial data the `getInitialData()` and `getMethodInfo()` functions should be used. The first of these retrieves the initial data used for the component analysis and second one retrieves the method employed for the analysis as well as the number of common and distinctive components. The `getPreprocessing()` function allows the access to preprocessing information and preprocessed data. The results of the analysis can be displayed by using `getScores()`, `getLoadings()` and `getVAF()` functions. These functions allow the user to choose between common or individual results, as well as the block of data whose results are to be displayed.

The structure of scores and loadings data from DISCO-SCA and JIVE analyses are the same. Scores associated to common components are represented in a matrix with samples in the rows and as many columns as common components are selected. For O2PLS, these scores are instead divided into two matrices with the same structure, one associated to the contribution of the common components to one block and one associated to the other block. Scores associated to distinctive components are also represented by two matrices, one associated to each block, where rows represent samples and the number of columns depends of the number of distinctive components associated to each block. The loadings structure is the same for all methods. Two loadings matrices for the common part and two for the distinctive part, one associated to each block, are also provided.

```
# Exploring DISCO-SCA (or JIVE) score structure
getScores(discoRes, part="common")
getScores(discoRes, part="distinctive", block="1")
getScores(discoRes, part="distinctive", block="2")

# Exploring O2PLS score structure
getScores(o2plsRes, part="common", block="expr")
getScores(o2plsRes, part="common", block="mirna")
getScores(o2plsRes, part="distinctive", block="1")
getScores(o2plsRes, part="distinctive", block="2")
```

The variance explained for (VAF) each component is given in the `VAF` slot, as a list containing the VAF for common and distinctive components. In the case of O2PLS, VAF cannot be calculated, because the components are not orthogonal. VAF can be plotted by using the `plotVAF()` function. The structure of plots produced for a DISCO-SCA and JIVE result are different. In the case of DISCO-SCA, components of individual blocks have an associated error due to errors in the rotation. This is because the DISCO-SCA distinctive components have VAF in the other block. This VAF not associated to the corresponding block could be interpreted as the error for not having a perfect rotation333 See (Van Deun et al. [2012](#ref-van2012disco)) for more details..

Example code and output for both approaches is shown below.

```
# DISCO-SCA plotVAF
getVAF(discoRes)
```

```
## $common
##           Comp.1    Comp.2
## Block1 0.5474045 0.1743694
## Block2 0.6189477 0.0927475
##
## $dist
## $dist$Block1
##     Comp.1     Comp.2
## 0.19867673 0.07953539
##
## $dist$Block2
##    Comp.1    Comp.2
## 0.1632240 0.1249985
##
## $dist$cross
##              Comp.1       Comp.2
## Block1 9.023048e-08 2.675035e-07
## Block2 1.273925e-07 4.562889e-07
```

```
plotVAF(discoRes)
```

![](data:image/png;base64...)

```
# JIVE plotVAF
getVAF(jiveRes)
```

```
## $common
##      common
## 1 0.8136602
## 2 0.1863398
##
## $dist
## $dist$Block1
##   distintive
## 1  0.7141268
## 2  0.2858732
##
## $dist$Block2
##   distintive
## 1  0.5662978
## 2  0.4337022
```

```
plotVAF(jiveRes)
```

![](data:image/png;base64...)

### 3.3.4 Plot results

Plotting the results obtained from `omicsCompAnalysis()` can be done by using `plotRes()` function. `plotRes()` allows plotting of scores, loadings or both, for common and distinctive parts, as well as combined plots of both parts together.

The most important parameters for `plotRes()` are:

`object`
:   `caClass` object, usually a result from `omicsCompAnalysis()` function.
:   `comps`, components to plot. If `combined=FALSE`, it indicates the x and y components of the `type` and `block` chosen. If `combined=TRUE`, it indicates the component to plot for the first block of information and the component for the second block of information to plot together. By default the components are set to `c(1,2)` if `combined=FALSE` and to `c(1,1)` if `combined=TRUE`.
:   `what=c("scores", "loadings","both")`, Are scores, loadings or both had to be represented?
:   `type=c("common", "individual", "both")`. Are common or individual components had to be represented? If both a common and individual componanent are represented.
:   `combined`. Logical indicating if the plot is a simple plot representing two components from the same block of information, or a combined representation. The effect of the variable depends also on the values given for `comps`, `block` and `type`.
:   `block` indicates which block has to be represented. It can be specified by a numeric value (1 or 2) or a character (name of the block in the input data provided to the `omicsCompAnalysis()` analysis)

The DISCO-SCA and JIVE approaches calculate the common components in the joined matrix, so samples can be represented using a scatterplot of the score variables associated to the common components.

```
# Scatterplot of scores variables associated to common components

# DISCO-SCA
plotRes(object=discoRes, comps=c(1, 2), what="scores", type="common",
        combined=FALSE, block=NULL, color="classname", shape=NULL, labels=NULL,
        background=TRUE, palette=NULL, pointSize=4, labelSize=NULL,
        axisSize=NULL, titleSize=NULL)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the STATegRa package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

```
# JIVE
plotRes(object=jiveRes, comps=c(1, 2), what="scores", type="common",
        combined=FALSE, block=NULL, color="classname", shape=NULL, labels=NULL,
        background=TRUE, palette=NULL, pointSize=4, labelSize=NULL,
        axisSize=NULL, titleSize=NULL)
```

![](data:image/png;base64...)

In the case of the O2PLS approach, scores associated to the common components are calculated separately for each block of data. So a scatter plot of common components can be plotted independently for each block of data or together in a combined plot using the scores associated to a selected component in both blocks of data444 The function `g_legend()` used in these examples the commonly-used utility for sharing a legend between multiple plots. The source can be found [here](https://github.com/hadley/ggplot2/wiki/Share-a-legend-between-two-ggplot2-graphs)..

```
# O2PLS
# Scatterplot of scores variables associated to common components

# Associated to first block
p1 <- plotRes(object=o2plsRes, comps=c(1, 2), what="scores", type="common",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
# Associated to second block
p2 <- plotRes(object=o2plsRes, comps=c(1, 2), what="scores", type="common",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
# Combine both plots
# g_legend function from
# https://github.com/hadley/ggplot2/wiki/Share-a-legend-between-two-ggplot2-graphs
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))
```

![](data:image/png;base64...)

```
# Combined plot of scores variables assocaited to common components
plotRes(object=o2plsRes, comps=c(1, 1), what="scores", type="common",
        combined=TRUE, block=NULL, color="classname", shape=NULL,
        labels=NULL, background=TRUE, palette=NULL, pointSize=4,
        labelSize=NULL, axisSize=NULL, titleSize=NULL)
```

![](data:image/png;base64...)

The scores plot associated to individual components can be plotted using an scatterplot for each block of data in the same way that common components scores are for the O2PLS approach. A combined plot representing the components of each block of data together can be plotted, too.

```
# DISCO-SCA scores scatterplot associated to individual components

# Associated to first block
p1 <- plotRes(object=discoRes, comps=c(1, 2), what="scores", type="individual",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
# Associated to second block
p2 <- plotRes(object=discoRes, comps=c(1, 2), what="scores", type="individual",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
# Combine plots
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))
```

![](data:image/png;base64...)

```
# DISCO-SCA scores combined plot for individual components
plotRes(object=discoRes, comps=c(1, 1), what="scores", type="individual",
        combined=TRUE, block=NULL, color="classname", shape=NULL,
        labels=NULL, background=TRUE, palette=NULL, pointSize=4,
        labelSize=NULL, axisSize=NULL, titleSize=NULL)
```

![](data:image/png;base64...)

Combined plots of scores for common and individual components together can be plotted with the results of all methods. In the case of the DISCO-SCA and JIVE approaches the components associated to the common part is the same in both plots but in the case of the O2PLS approach the common component represented is the one associated to each block of data.

```
# DISCO-SCA plot of scores for common and individual components
p1 <- plotRes(object=discoRes, comps=c(1, 1), what="scores", type="both",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
p2 <- plotRes(object=discoRes, comps=c(1, 1), what="scores", type="both",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))
```

![](data:image/png;base64...)

```
# O2PLS plot of scores for common and individual components
p1 <- plotRes(object=o2plsRes, comps=c(1, 1), what="scores", type="both",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
p2 <- plotRes(object=o2plsRes, comps=c(1, 1), what="scores", type="both",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))
```

![](data:image/png;base64...)

For the loadings representation, the plots provided by `plotRes()` function are the same than scores representation. In the case of loadings the plots associated to all methods are the same, so only plots associated to DISCO-SCA approach are shown.

The scatterplot of loadings are represented separated for each block. No joint representation is allowed.

```
# Loadings plot for common components

# Separately for each block
p1 <- plotRes(object=discoRes, comps=c(1, 2), what="loadings", type="common",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
p2 <- plotRes(object=discoRes, comps=c(1, 2), what="loadings", type="common",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             heights=c(6/7, 1/7))
```

![](data:image/png;base64...)

In the case of individual components the plots can be represented, too.

```
# Loadings plot for individual components

# Separately for each block
p1 <- plotRes(object=discoRes, comps=c(1, 2), what="loadings", type="individual",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
p2 <- plotRes(object=discoRes, comps=c(1, 2), what="loadings", type="individual",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             heights=c(6/7, 1/7))
```

![](data:image/png;base64...)

Moreover, the loadings associated to common and individual components can be plotted together using a combined plot for each block.

```
p1 <- plotRes(object=discoRes, comps=c(1, 1), what="loadings", type="both",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
p2 <- plotRes(object=discoRes, comps=c(1, 1), what="loadings", type="both",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             heights=c(6/7, 1/7))
```

![](data:image/png;base64...)

Finally, a joint plot with scores and loading for each block can be represented setting `what="both"`.

```
# Scores and loading plot for common part. DISCO-SCA
p1 <- plotRes(object=discoRes, comps=c(1, 2), what="both", type="common",
          combined=FALSE, block="expr", color="classname", shape=NULL,
          labels=NULL, background=TRUE, palette=NULL, pointSize=4,
          labelSize=NULL, axisSize=NULL, titleSize=NULL,
          sizeValues=c(2, 2), shapeValues=c(17, 0))
p2 <- plotRes(object=discoRes, comps=c(1, 2), what="both", type="common",
          combined=FALSE, block="mirna", color="classname", shape=NULL,
          labels=NULL, background=TRUE, palette=NULL, pointSize=4,
          labelSize=NULL, axisSize=NULL, titleSize=NULL,
          sizeValues=c(2, 2), shapeValues=c(17, 0))
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))
```

![](data:image/png;base64...)

```
# Scores and loadings plot for common part. O2PLS
p1 <- plotRes(object=o2plsRes, comps=c(1, 2), what="both", type="common",
          combined=FALSE, block="expr", color="classname", shape=NULL,
          labels=NULL, background=TRUE, palette=NULL, pointSize=4,
          labelSize=NULL, axisSize=NULL, titleSize=NULL,
          sizeValues=c(2, 2), shapeValues=c(17, 0))
p2 <- plotRes(object=o2plsRes, comps=c(1, 2), what="both", type="common",
          combined=FALSE, block="mirna", color="classname", shape=NULL,
          labels=NULL, background=TRUE, palette=NULL, pointSize=4,
          labelSize=NULL, axisSize=NULL, titleSize=NULL,
          sizeValues=c(2, 2), shapeValues=c(17, 0))
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))
```

![](data:image/png;base64...)

```
# Scores and loadings plot for distinctive part. O2PLS
p1 <- plotRes(object=o2plsRes, comps=c(1, 2), what="both", type="individual",
          combined=FALSE, block="expr", color="classname", shape=NULL,
          labels=NULL, background=TRUE, palette=NULL, pointSize=4,
          labelSize=NULL, axisSize=NULL, titleSize=NULL,
          sizeValues=c(2, 2), shapeValues=c(17, 0))
p2 <- plotRes(object=o2plsRes, comps=c(1, 2), what="both", type="individual",
          combined=FALSE, block="mirna", color="classname", shape=NULL,
          labels=NULL, background=TRUE, palette=NULL, pointSize=4,
          labelSize=NULL, axisSize=NULL, titleSize=NULL,
          sizeValues=c(2, 2), shapeValues=c(17, 0))
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))
```

![](data:image/png;base64...)

# 4 Omics Clustering

## 4.1 Overview

### 4.1.1 The Problem

Clustering can be briefly described as the task of grouping features (such as genes) based on a measure of similarity or closeness.
Probably the most commonly used clustering methodologies are hierarchical clustering and k-means, however distribution models and density models are starting to gain traction in the bioinformatic community. A common characteristic is that all those methodologies were conceived for the grouping of variables given a single type of underlying data.

If we consider the problem of clustering based on the mRNA expression and proteomic expression of 100 individuals we may consider two clustering situations. The first is the clustering of samples which has been studied in the existing literature; see (Pandey et al. [2010](#ref-Pandey2010)) as an example . We will not address this problem in the present guide, however the methodologies proposed here can be adapted to solve this problem instead (ie cluster samples instead of features). The second is the clustering of features, that is the clustering of genes and/or proteins (or any other omic features), both with other features of the same type and features of different types. Network-based methodologies do exist that aim to the identification of modules (clusters) in multi-omic networks; an example is (Rivera, Vakil, and Bader [2010](#ref-Rivera2010)). However in the case of feature-based multi-omic clustering we consider necessary to discuss in detail the following aspects:

Normalization
:   the levels of protein and mRNA may not be measured over the same ranges. For centroid-based models such as k-means this would affect the distance measurements. In connectivity-based models such as hierarchical clustering the effect would be different, but large differences of normalisation in different data types will still be problematic.
    Mapping
:   we may also consider using genes and proteins as a single feature type by mapping each protein to the associated gene. In this case we may opt to map proteins to corresponding genes; the mapping and the subsequent analytical steps will need to handle the cases where (1) a protein does not map to any profiled gene or (2) a gene maps to more than one protein among others. Once the mapping is clear, how the original and mapped profiles are to be used needs to be defined.

The challenge of mapping and the use of the mapping becomes more complex when we consider the combination of omics such as:

* miRNA and mRNA: no direct mapping exists, however a miRNA to gene regulation mappings is available. We may consider the use of existing data-bases such as those described in RNACentral (Bateman et al. [2011](#ref-Bateman2011); Pritchard, Cheng, and Tewari [2012](#ref-Pritchard2012)).
* DNA Methylation and mRNA: no direct mapping exists, however a mapping can be computed by considering the *cpg-to-the-closest-gene*, or any other distance-based assumptions (Jones [2012](#ref-Jones2012)).

Following those ideas and challenges we have defined a flexible integrative framework to cluster several omics being the mapping between the mapping the unique requirement. The methodology developed is flexible enough to answer many different questions such as (1) the integrative clustering, (2) comparative clustering, (3) the quantitative comparison of the effect of the different omics in the feature regulation and (4) omic-weighted distance between features of interest among others.

### 4.1.2 The OmicsClustering Approach

![](data:image/jpeg;base64...)

The OmicsClustering approach

For cluster analysis of multiple omics datasets the typical workflow is shown above. This example has only two data types; mRNA and miRNA, but the methodology can handle more types of data, providing some mapping can be defined between them.

For this example, genes are considered the **reference feature**, and in **Part A** distances between genes are computed by using mRNA data. In **Part B** distances between genes are computed by using miRNA data and a mapping between miRNA and genes. Finally, combinations of those distances are used in the analysis of single features (for which functions are included in `STATegRa`) or for clustering (using existing R functions such as `hclust` or `kmeans`).

A worked example for these data types with code and figures is given below.

## 4.2 Usage

### 4.2.1 Loading the data

For this example we made used of an existing TCGA555 The Cancer Genome Atlas, <http://cancergenome.nih.gov> data-set. The dataset used for this section was obtained from the dataset described in (Van Deun et al. [2012](#ref-van2012disco)) and is available from TCGA processed data.

We extracted the [classification](https://tcga-data.nci.nih.gov/docs/publications/gbm_exp/TCGA_unified_CORE_ClaNC840.txt) and the [unified gene expression](https://tcga-data.nci.nih.gov/docs/publications/gbm_exp/unifiedScaledFiltered.txt) from TCGA. The miRNA was downloaded from TCGA directly. The full dataset can be loaded by typing:

```
data("STATegRa_S1")
ls()
```

```
## [1] "Block1" "Block2" "ed"
```

`Block1` includes mRNA data and `Block2` includes miRNA data.

### 4.2.2 Computing the distance between genes by using mRNA data: the bioDistclass class

Firstly, we generate an `ExpressionSet` object for both the miRNA and mRNA data.

```
# Block1 - Expression data
mRNA.ds <- createOmicsExpressionSet(Data=Block1, pData=ed, pDataDescr=c("classname"))
# Block2 - miRNA expression data
miRNA.ds <- createOmicsExpressionSet(Data=Block2, pData=ed, pDataDescr=c("classname"))
```

Secondly, we compute the distance between all genes in `Block1` (mRNA data) using Spearman correlation.

```
# Create Gene-gene distance computed through mRNA data
bioDistmRNA <- bioDistclass(name="mRNAbymRNA",
                            distance=cor(t(exprs(mRNA.ds)),
                                         method="spearman"),
                            map.name="id",
                            map.metadata=list(),
                            params=list())
```

The `bioDistmRNA` object, generated with the `bioDistclass` function, is a `bioDistclass` object that contains both the original data and the computed distance between features.

### 4.2.3 Loading the map between miRNA and genes: the bioMap class

In this section we load and store the map between miRNA and mRNA. Data file (`STATegRa_S2`) contains, as a processed matrix, the information available from TargetScan (Csardi, [n.d.](#ref-targetscan)), which provided a set of miRNA target predictions for humans.

```
data(STATegRa_S2)
ls()
```

```
## [1] "Block1"      "Block2"      "bioDistmRNA" "ed"          "mRNA.ds"
## [6] "mapdata"     "miRNA.ds"
```

This data is stored in a `bioMap` class object generated through the `bioMap` function as follows:

```
MAP.SYMBOL <- bioMap(name = "Symbol-miRNA",
                     metadata = list(type_v1="Gene", type_v2="miRNA",
                                     source_database="targetscan.Hs.eg.db",
                                     data_extraction="July2014"),
                     map=mapdata)
```

### 4.2.4 miRNA-Surrogate gene Distances: the bioDist function

The `bioDist` function returns a `bioDistclass` object. The input is a reference feature list (genes in this example), surrogate data (miRNA, in `Block2`) and the bioMap object between reference and surrogate features.

```
bioDistmiRNA <- bioDist(referenceFeatures=rownames(Block1),
                        reference="Var1",
                        mapping=MAP.SYMBOL,
                        surrogateData=miRNA.ds,
                        referenceData=mRNA.ds,
                        maxitems=2,
                        selectionRule="sd",
                        expfac=NULL,
                        aggregation="sum",
                        distance="spearman",
                        noMappingDist=0,
                        filtering=NULL,
                        name="mRNAbymiRNA")
```

### 4.2.5 Computing weighted distances: the bioDistW function

Having `bioDistmiRNA` and `bioDistmRNA` `bioDistclass` objects containing distances between genes, we aim to use weighted combinations of them to compute an single distance matrix.

First we make a list of `bioDistclass` objects:

```
bioDistList <- list(bioDistmRNA, bioDistmiRNA)
```

Secondly we make a matrix listing containing the weighted combinations to be generated. Each row is interpreted as a combination to generate, with the elements of the row interpreted as the weight for each of the input omics.

```
sample.weights <- matrix(0, 4, 2)
sample.weights[, 1] <- c(0, 0.33, 0.67, 1)
sample.weights[, 2] <- c(1, 0.67, 0.33, 0)
sample.weights
```

```
##      [,1] [,2]
## [1,] 0.00 1.00
## [2,] 0.33 0.67
## [3,] 0.67 0.33
## [4,] 1.00 0.00
```

This matrix corresponds to generating four combinations, with the first consisting of \(0\times mRNA + 1\times miRNA\) and so on.

Finally, the `bioDistW` function computes the weighted combinations in the weights matrix and stores it into a `bioDistWclass` list.

```
bioDistWList <- bioDistW(referenceFeatures=rownames(Block1),
                         bioDistList=bioDistList,
                         weights=sample.weights)
length(bioDistWList)
```

```
## [1] 4
```

## 4.3 Plots

### 4.3.1 Plotting the feature distance of each weighted combination

Each `bioDistWclass` object contains a distance matrix computed through a weighted combination of distances derived from different omics. By considering the distances between these distance matrices we can project in two dimensions using Multi-Dimensional Scaling. By this approach we can visualize the effect of the different weights on the feature-to-feature distance structure.

To generate such a plot:

```
bioDistWPlot(referenceFeatures=rownames(Block1),
             listDistW=bioDistWList,
             method.cor="spearman")
```

![](data:image/png;base64...)

### 4.3.2 Plotting associated features

The purpose of this analysis is to generate an overall distance measure between features, so it follows that given a feature of interest we will want to find other features that are near it. For this example we use the gene IDH1, which was shown to be of relevance in the original data analysis.

In order to find all other genes for which at least one weighted combination has a correlation greater than \(0.7\), we do:

```
IDH1.F <- bioDistFeature(Feature="IDH1",
                         listDistW=bioDistWList,
                         threshold.cor=0.7)
```

The `bioDistFeature` function generates a matrix of associated genes (columns) depending on weighted combinations (rows); rows are named by the `bioDistWclass`’s name slot.

The `IDH1.F` matrix can be plotted with the `bioDistFeaturePlot` function, as shown below. (This function is a wrapper around `heatmap.2` from *[gplots](https://CRAN.R-project.org/package%3Dgplots)* with appropriate options, but `IDH1.F` is a normal R matrix and can be used with most other matrix-plotting tools).

```
bioDistFeaturePlot(data=IDH1.F)
```

![](data:image/png;base64...)

### 4.3.3 OmicsClustering Requirements

The requirements for running OmicsClustering are minimal. The data considered has to be compatible with the distance measure selected. The relevant aspect is that the mapping between features needs to be `informative enough`. We do not consider the use of OmicsClustering when the mapping between features involves less than 15-25% of the reference set of features; this number was obtained from preliminary analysis over few data sets however further investigation is being conducted.

# 5 omicsNPC

## 5.1 Overview

### 5.1.1 The Problem

Recent advancements in omics technologies allow to measure several data modalities, e.g., RNA-sequencing, protein levels, etc., on the same biological samples. In such settings an interesting task is the identification of genes that, according to all modalities considered as a whole, are either deregulated or associated to an outcome of interest.

### 5.1.2 The NPC Approach

*omicsNPC* implements the Non Parametric Combination (NPC) methodology (Pesarin and Salmaso [2010](#ref-Pesarin2010)) in a way that is specifically tailored for the idiosyncrasies of omics data. First, each data type is analyzed independently. Currently, *omicsNPC* uses the package *[limma](https://bioconductor.org/packages/3.22/limma)* for computing deregulation / association statistics and p-values; count data, e.g., RNAseq, are first transformed using the voom function. The user can also specify custom functions for computing relevant statistics in each dataset. The resulting p-values are combined by employing appropriate combining functions. The Tippett combining function returns findings which are supported by at least one omics modality. The Liptak function returns findings which are supportd by most modalities. The Fisher function has an intermediate behavior between those of Tippett and Liptak.

Several important features make the use of omicsNPC appealing.

* *omicsNPC* makes **minimal assumptions**: as permutation is employed throughout the process, no parametric form is assumed for the null distribution of the statistical tests, and the main requirement is samples to be freely exchangeable under the null-hypothesis.
* It provides **global p-values** for assessing the overall contribution of all data modalities.
* It is characterized by **great flexibility**: it can address study designs with multiple factors, as well as partially overlapping measurements / samples.
* It frees the researcher from the need of defining and **modeling between-datasets dependencies** (Pesarin and Salmaso [2010](#ref-Pesarin2010)).

A worked example with code is given below.

## 5.2 Usage

### 5.2.1 Loading the data

For this example we use an existing TCGA666 The Cancer Genome Atlas, <http://cancergenome.nih.gov> data-set. We downloaded sixteen tumour samples and the sixteen matching normal, for Breast invasive carcinoma, BRCA, batch 93. We used three types of data modalities, “RNAseq”, “RNAseqV2” and “Expression-Gene”. `RNAseq` corresponds to RNA sequensing data, *IlluminaHiSeq-RNASeq* platform, `RNAseqV2` corresponds to RNA sequencing data, *IlluminaHiSeq-RNASeqV2* platform and `Expression-Gene` corresponds to array based expression data, *AgilentG4502A-07-3* platform. For `RNAseq` and `RNAseqV2` data we keep the “raw counts”. For each data type, we pooled all data to one matrix, where rows corresponded to genes and columns to samples. We selected 100 genes to be used in this example. Finally, each matrix was converted to an `ExpressionSet` object and the resulting objects were saved in a `list`.

The datasets can be loaded by typing:

```
data("TCGA_BRCA_Batch_93")
ls()
```

```
## [1] "TCGA_BRCA_Data"
```

`TCGA_BRCA_Data` is a list, which includes three objects of the `ExpressionSet` class. The matrices containing the expression values can be visualized by typing:

```
exprs(TCGA_BRCA_Data$RNAseq) # displays the RNAseq data
exprs(TCGA_BRCA_Data$RNAseqV2) # displays the RNAseqV2 data
exprs(TCGA_BRCA_Data$Microarray) # displays the Exp-Gene data
```

Each row corresponds to a gene and each column to a sample. Samples are subdivided between “tumour” and “normal”.

The class of each sample can be visualized by typing

```
pData(TCGA_BRCA_Data$RNAseq) # class of RNAseq samples
pData(TCGA_BRCA_Data$RNAseqV2) # class of RNAseqV2 samples
pData(TCGA_BRCA_Data$Microarray) # class of Exp-Gene samples
```

Please note that each dataset could have different design matrices; *omicsNPC* only assumes that the last column of each design matrix contains the factor whose association with each gene should be assessed. This factor can be either continuous (e.g., IG50 values), or categorical (tumour / normal) as in the present example.

### 5.2.2 Setting the dataTypes variable

The `dataTypes` vector specifies the type of data in input and consequently the method for computing the association between each measurement and the factor of interest. If given as a character vector, possible values for `dataTypes` are `'count'` and `'continuous'`. The first value requires the data to be transormed with the voom function (from `limma`) before being analyzed, while the latter directly apply limma moderated t-statistics. Alternatively, the user can specify a list of custom functions.

```
dataTypes <- c("count", "count", "continuous")
```

### 5.2.3 Setting the combMethods variable

The `combMethods` variable is a character vector with possible values: `'Fisher', 'Liptak', 'Tippett'`. All combining functions can be used simultaneously.

```
combMethods <- c("Fisher", "Liptak", "Tippett")
```

### 5.2.4 Setting the numPerms, numCores and verbose variables

`numPerms` is the number of permutations to perform. The number of permutations can be adjusted depending on the number of available samples. In general 1000 permutation is usually a good point to start.

```
numPerms <- 1000
```

*omicsNPC* can perform the desired permutations in parallel, and `numCores` specifies the number of cores to be used. By default, one single core is used.

```
numCores <- 1
```

`verbose` is a logical. If it is set to `TRUE`, *omicsNPC* prints out the steps that it performs.

```
verbose <- TRUE
```

### 5.2.5 Run omicsNPC analysis.

One main function is available for running *omicsNPC* analysis:

```
results <- omicsNPC(dataInput=TCGA_BRCA_Data, dataTypes=dataTypes,
                    combMethods=combMethods, numPerms=numPerms,
                    numCores=numCores, verbose=verbose)
```

```
## Compute initial statistics on data
```

```
## Building NULL distributions by permuting data
```

```
## Compute pseudo p-values based on NULL distributions...
```

```
## NPC p-values calculation...
```

`results` is a list containing `pvalues0` and `pvaluesNPC`.
+ `pvalues0` is a matrix having one column for each data modality. Each column contains the p-values assessing the association of each measurement with the factor of interest corrected for the other factors present in the study design (pheno data).
+ `pvaluesNPC` is a matrix having one column for each combination function. Each column provides the global p-values obtained by combining single-datasets p-values with the corresponding combination function.

# References

Bateman, Alex, Shipra Agrawal, Ewan Birney, Elspeth A Bruford, Janusz M Bujnicki, G U Y Cochrane, James R Cole, et al. 2011. “RNAcentral : A Vision for an International Database of Rna Sequences Rnacentral : A Vision for an International Database of Rna Sequences.” *RNA* 17 (11).

Csardi, Gabor. n.d. *Targetscan.Hs.eg.db: TargetScan miRNA Target Predictions for Human*.

Jones, Peter a. 2012. “Functions of Dna Methylation: Islands, Start Sites, Gene Bodies and Beyond.” *Nature Reviews Genetics*.

Lock, Eric F, Katherine A Hoadley, JS Marron, and Andrew B Nobel. 2013. “Joint and Individual Variation Explained (Jive) for Integrated Analysis of Multiple Data Types.” *The Annals of Applied Statistics* 7 (1): 523.

Pandey, Gaurav, Bin Zhang, Aaron N Chang, Chad L Myers, Jun Zhu, and Vipin Kumar. 2010. “An Integrative Multi-Network and Multi-Classifier Approach to Predict Genetic Interactions.” *PLoS Computational Biology* 6 (9).

Pesarin, Fortunato, and Luigi Salmaso. 2010. *Permutation Tests for Complex Data*. Chichester, UK: John Wiley & Sons, Ltd. <https://doi.org/10.1002/9780470689516>.

Pritchard, Colin C, Heather H Cheng, and Muneesh Tewari. 2012. “MicroRNA Profiling: Approaches and Considerations.” *Nature Reviews Genetics* 13 (5): 358–69.

Rivera, Corban G, Rachit Vakil, and Joel S Bader. 2010. “NeMo: Network Module Identification in Cytoscape.” *BMC Bioinformatics* 11 Suppl 1: S61.

Schouteden, Martijn, Katrijn Van Deun, Sven Pattyn, and Iven Van Mechelen. 2013. “SCA with Rotation to Distinguish Common and Distinctive Information in Linked Data.” *Behavior Research Methods* 45 (3): 822–33.

Schouteden, Martijn, Katrijn Van Deun, Tom F Wilderjans, and Iven Van Mechelen. 2014. “Performing Disco-Sca to Search for Distinctive and Common Information in Linked Data.” *Behavior Research Methods* 46 (2): 576–87.

Smyth, Gordon K. 2005. “Limma: Linear Models for Microarray Data.” In *Bioinformatics and Computational Biology Solutions Using R and Bioconductor*, edited by R. Gentleman, V. Carey, S. Dudoit, R. Irizarry, and W. Huber, 397–420. New York: Springer.

Trygg, Johan, and Svante Wold. 2003. “O2-Pls, a Two-Block (X–Y) Latent Variable Regression (Lvr) Method with an Integral Osc Filter.” *Journal of Chemometrics* 17 (1): 53–64.

Van Deun, Katrijn, Iven Van Mechelen, Lieven Thorrez, Martijn Schouteden, Bart De Moor, Mariet J van der Werf, Lieven De Lathauwer, Age K Smilde, and Henk AL Kiers. 2012. “DISCO-Sca and Properly Applied Gsvd as Swinging Methods to Find Common and Distinctive Processes.” *PloS One* 7 (5): e37840.