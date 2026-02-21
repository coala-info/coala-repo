# Introduction to Multivariate Analysis of Gene Expression Data using MADE4

Aedin Culhane1

1Department of Data Science, Dana-Farber Cancer Institute, Department of Biostatistics, Harvard TH Chan School of Public Health

#### 30 October 2025

#### Abstract

Vignette introduction function in the made4 package. This package is old and was originally designed for the analysis of microarray data. However most of the functions, such as bga, cia etc can be applied to any ’omics data. Some of these functions are avaialble in omicade4, mogsa and corral, and I am migrating this package into Bioconductor compliant package ;-) If you have found functions in made4 useful, and would like to assist, in updating it, please let me know. I’d be delighted.

#### Package

BiocStyle 2.38.0

# 1 Introduction

```
library(ade4)
library(made4)
```

```
## Loading required package: RColorBrewer
```

```
## Loading required package: gplots
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
## Loading required package: scatterplot3d
```

```
## Loading required package: Biobase
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following object is masked from 'package:ade4':
##
##     score
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: MatrixGenerics
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'matrixStats'
```

```
## The following objects are masked from 'package:Biobase':
##
##     anyMissing, rowMedians
```

```
##
## Attaching package: 'MatrixGenerics'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
##     colWeightedMeans, colWeightedMedians, colWeightedSds,
##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
##     rowWeightedSds, rowWeightedVars
```

```
## The following object is masked from 'package:Biobase':
##
##     rowMedians
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:gplots':
##
##     space
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
library(scatterplot3d)
```

The package *made4* facilitates multivariate analysis of microarray gene expression data. The package provides a set of
functions that utilise and extend multivariate statistical and graphical functions available in ade4, (Thioulouse et al. [1997](#ref-thioulouse_ade-4_1997)) .
*made4* accepts gene expression data is a variety of input formats, including Bioconductor formats,
- SummarizedExperiment
- ExpressionSet
- data.frame
- matrix
and older microarray formats; ExpressionSet, marrayRaw

# 2 Installation

*made4* requires the R package *ade4*. It should be installed automatically when you install *made4*. To install *made4* from bioconductor

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("made4")
```

# 3 Further help

The package *made4* is described in more detail in the RNews newletter, December 2006.

Culhane AC and Thioulouse J. (2006) A multivariate approach to integrating datasets using made4 and ade4.**R News**, *6(5)* 54-58.
[pdf](http://cran.r-project.org/doc/Rnews/Rnews_2006-5.pdf)

Extensive tutorials, examples and documentation on multivariate statistical methods are available from [the ade4 website]
(<http://pbil.univ-lyon1.fr/ADE-4>) and *ade4* user support
is available through the ADE4 mailing list.

This tutorial assumes a basic knowledge of R, but we have found that Emmanuel Paradis’s *R for Beginners* is a
very good guide to those unfamiliar with R. This is [available at] (<http://cran.r-project.org/doc/contrib/Paradis-rdebuts_en.pdf>).

This documents assumes that data is normalized and preprocessed.

# 4 Citing

We are delighted if you use this package. Please do email us if you find a bug or have a suggestion. We would be very grateful if you could cite:

Culhane AC, Thioulouse J, Perriere G, Higgins DG.(2005) MADE4: an R package for multivariate analysis of gene expression data. **Bioinformatics** *21(11):* 2789-90.

# 5 Quickstart

We will very briefly demonstrate some of the functions in *made4*. To do this
we will use a small dataset that is available in *made4*. This dataset **Khan** contains gene expression profiles of four types of small round blue cell tumours of childhood (SRBCT) published by Khan et al. (2001). This is a subset of the published dataset. It contains gene expression levels for 306 genes for 64 patient samples. Load the necessary R packages and dataset.

```
 library(made4)
 library(ade4)
 data(khan)
```

This experiment studied gene expression in patient with four types of SRBCT. These were neuroblastoma (NB), rhabdomyosarcoma (RMS), Burkitt lymphoma, a subset of non-Hodgkin lymphoma (BL), and the Ewing family of tumours (EWS). Gene expression profiles from both tumour biopsy and cell line samples were obtained and are contained in this dataset. In this study data were divided into a training set of 64 samples, and a blind test dataset. These 2 dataset are called khan$train and khan$test. Have a look at the data. For this example we will just example the training dataset.

```
names(khan)
```

```
## [1] "train"                "test"                 "train.classes"
## [4] "test.classes"         "annotation"           "gene.labels.imagesID"
## [7] "cellType"
```

```
k.data<-khan$train
k.class<-khan$train.classes
```

## 5.1 Overview

The *made4* function **overview()** provides a quick way to get an overview or feel for data. **overview()** will draw a boxplot, histogram and dendrogram of a hierarchical analysis. Hierarchical clustering is produced using average linkage clustering with a Pearson correlation measure of similarity (Eisen et al. [1998](#ref-eisen_cluster_1998))
This gives a quick first glance at the data.

```
overview(k.data)
```

Often its useful to label the samples using a class vector or covariate of interest, in this case, the tumour type (EWS, BL, NB or RMS).

```
overview(k.data, labels=k.class)
```

![\label{fig:fig1}Overview of Khan data.](data:image/png;base64...)

Figure 1: Overview of Khan data

Figure 1: A) dendrogram showing results of average linkage clustering, B) boxplot and C) histrogram.

Often one will known classes in the data (eg Normal v Treatment, or different tumor types). We can insert a class colourbar under the dendrogram, and colour the boxplot.

```
overview(k.data, classvec=k.class, labels=k.class)
```

![\label{fig:fig2}Overview of Khan data.](data:image/png;base64...)

Figure 2: Overview of Khan data

1. dendrogram showing results of average linkage clustering, B) boxplot and C) histrogram. In this case we have added a vector of class (classvec) to color the overview by class membership.

# 6 Prinipcal Component, Correspondence Analysis

The function **ord** simplifies the running of ordination methods such as principal component, correspondence or non-symmetric correspondence analysis. It provides a wrapper which can call each of these methods in *ade4*. To run a correspondence analysis (Fellenberg et al. [2001](#ref-fellenberg_correspondence_2001)) on this dataset.

```
k.coa<- ord(k.data, type="coa")
```

Output from **ord** is a list of length 2, containing the ordination results ($ord) and a factor ($fac) if input. The ordination results
(k.coa$ord) contain a list of results (of length 12) which includes the eigenvalues ($eig) and the new column coordinates ($co) and the row (line) coordinatein $li. Hence we can visualise the projected coordinations of the genes ($li, 306 genes) and array samples ($co, 64 microarray samples).

```
names(k.coa)
```

```
## [1] "ord" "fac"
```

```
summary(k.coa$ord)
```

```
## Class: coa dudi
## Call: dudi.coa(df = data.tr, scannf = FALSE, nf = ord.nf)
##
## Total inertia: 1.011
##
## Eigenvalues:
##     Ax1     Ax2     Ax3     Ax4     Ax5
## 0.17130 0.13831 0.10317 0.05995 0.04965
##
## Projected inertia (%):
##     Ax1     Ax2     Ax3     Ax4     Ax5
##  16.947  13.683  10.207   5.931   4.912
##
## Cumulative projected inertia (%):
##     Ax1   Ax1:2   Ax1:3   Ax1:4   Ax1:5
##   16.95   30.63   40.84   46.77   51.68
##
## (Only 5 dimensions (out of 63) are shown)
```

## 6.1 Visualising Results

There are many functions in *ade4* and *made4* for visualising results from ordination analysis. The simplest way
to view the results produced by **ord** is to use **plot**. **plot(k.ord)** will draw a plot of the eigenvalues, along with plots of the variables (genes) and a plot of the cases (microarray samples). In this example Microarray samples are colour-coded using the **classvec** **khan$train.classes** which is saved as **k.class**.

```
k.class
```

```
##  [1] EWS    EWS    EWS    EWS    EWS    EWS    EWS    EWS    EWS    EWS
## [11] EWS    EWS    EWS    EWS    EWS    EWS    EWS    EWS    EWS    EWS
## [21] EWS    EWS    EWS    BL-NHL BL-NHL BL-NHL BL-NHL BL-NHL BL-NHL BL-NHL
## [31] BL-NHL NB     NB     NB     NB     NB     NB     NB     NB     NB
## [41] NB     NB     NB     RMS    RMS    RMS    RMS    RMS    RMS    RMS
## [51] RMS    RMS    RMS    RMS    RMS    RMS    RMS    RMS    RMS    RMS
## [61] RMS    RMS    RMS    RMS
## Levels: EWS BL-NHL NB RMS
```

```
plot(k.coa, classvec=k.class, genecol="grey3")
```

![](data:image/png;base64...)
*Figure 2* Correspondence analysis of Khan dataset. A. plot of the eigenvalues, B. projection of microarray samples from patient with tumour types EWS (red), BL(blue), NB (green) or RMS (brown), C. projection of genes (gray filled circles) and D. biplot showing both genes and samples. Samples and genes with a strong associated are projected in the same direction from the origin. The greater
the distance from the origin the stronger the association.

Genes and array projections can also be plotted using **plotgenes** and **plotarrays**. The function **s.groups** required a character vector or factor that indicates the groupings or classes (classvec) and allowed groups to be coloured in different colours. For example, to plot microarray samples (cases),

```
plotgenes(k.coa)
```

To plot microarray samples, colour by group (tumour type) as specified by khan$train.classes

```
plotarrays(k.coa, arraylabels=k.class)
```

```
## [1] "Need to specify groups"
```

![](data:image/png;base64...)

Alternative you can run these analysis and give a class vector to **ord** and it will automatically colour samples by this class vector

```
k.coa2<-ord(k.data, classvec=k.class)
plot(k.coa2)
```

![](data:image/png;base64...)

Plot gene projections without labels (clab=0). Typically there are a large number of genes, thus it is not feasible to label all of these.
The function plotgenes is more useful to use if you wish to add labels when there are lots of variables (genes)

The gene projections can be also visualised with **plotgenes**. The number of genes that are labelled
at the end of the axis can be defined. The default is 10.

```
plotgenes(k.coa, n=5, col="red")
```

![](data:image/png;base64...)

By default the variables (genes) are labelled with the rownames of the matrix. Typically these are spot IDs or Affymetrix accession numbers which are not very easy to interpret. But these can be easily labeled by your own labels. For example its often useful to labels using HUGO gene symbols. We find the Bioconductor *annotate* or *biomaRt* annotation packages are useful for this.

In this example we provide annotation from the Source database in khan$annotation. The gene symbol are in the vector khan$annotation$Symbol. (In this case its a factor)

```
gene.symbs<- khan$annotation$Symbol
gene.symbs[1:4]
```

```
## [1] FDFT1 LYN   CKS2  MT1X
## 1944 Levels:  101F6 182-FIP 7h3 A2LP AADAC AAMP ABCC3 ABCE1 ABCF1 ABCF2 ... ZWINT
```

```
plotgenes(k.coa, n=10, col="red", genelabels=gene.symbs)
```

![](data:image/png;base64...)
*Figure 3* Projection of genes (filled circles) in Correspondence analysis of Khan dataset. The genes at the ends of each of the axes are labelled with HUGO gene symbols.

To get a list of variables at the end of an axes, use **topgenes**. For example, to get a list of the 5 genes at the negative and postive end of axes 1.

```
topgenes(k.coa, axis = 1, n=5)
```

To only the a list of the genes (default 10 genes) at the negative end of the first axes

```
topgenes(k.coa, labels=gene.symbs, end="neg")
```

```
##  [1] "PTPN13"  "OLFM1"   "TNFAIP6" "GYG2"    "CAV1"    "MYC"     "FVT1"
##  [8] "FCGRT"   "TUBB5"   "MYC"
```

Two character vectors can be compared using (the very poorly named function) **comparelists**

To visualise the arrays (or genes) in 3D either use **do3d** or **html3d**. **do3d** is a wrapper for **scatterplot3d**,
but is modified so that groups can be coloured.

```
do3d(k.coa$ord$co, classvec=k.class, cex.symbols=3)
```

![](data:image/png;base64...)

**html3d** produces a “pdb” output which can be visualised using rasmol or chime, a free interface for colour, rotating, zooming 3D graphs. The output from Output from **html3D** can be rotated and visualised on web browsers that can support chime (or a pdb viewer)

```
html3D(k.coa$ord$co, k.class, writehtml=TRUE)
```

![Output from html3D](data:image/png;base64...)

Figure 3: Output from html3D

## 6.2 explor

It is also worth exploring the package *explor* which provides a nice R Shiny interface for browsing results from *made4* and *ade4*.
It is available from CRAN or from [juba.github.io](https://juba.github.io/explor/)

## 6.3 Classification and Class Prediction using Between Group Analysis

Between Group Analysis (BGA) is a supervised PCA method (Dolédec and Chessel [1987](#ref-doledec_rythmes_1987)) for classification/prediction. The basis of BGA is to ordinate the groups rather than the individual samples.

In tests on two microarray gene expression datasets, BGA performed comparably to supervised classification methods, including support vector machines and artifical neural networks (Culhane et al. [2002](#ref-culhane_between-group_2002)). To train a dataset, use **bga**, the projection of test data can be assessed using **suppl**. One leave out cross validation can be performed using **bga.jackknife**. See the BGA vignette for more details on this method.

```
k.bga<-bga(k.data, type="coa", classvec=k.class)
```

```
plot(k.bga, genelabels=gene.symbs) # Use the gene symbols earlier
```

![](data:image/png;base64...)
*Figure 5* Between group analysis of Khan dataset. A. Between.graph
of the microarray samples, showing their separation on the discriminating BGA axes, B. Scatterplot of the first 2 axes of microarray samples, coloured by their class, C. graph of positions of genes on the same axis. Genes at the ends of the axis are most discriminating for that group

Sometimes its useful to visualise 1 axes of an analysis. To do this use **graph1D** or **between.graph**. The latter function is specifically for visualising results from a bga as it shows the separation of classes achieved.

```
between.graph(k.bga, ax=1)  # Show the separation on the first axes(ax)
```

![](data:image/png;base64...)

## 6.4 Meta-analysis of microarray gene expression

Coinertia analysis **cia** (Dolédec S and Chessel D [1994](#ref-doledec_s_co-inertia_1994)) has been successfully applied to the cross-platform comparison of microarray gene expression datasets (Culhane, Perrière, and Higgins [2003](#ref-culhane_cross-platform_2003), @meng\_multivariate\_2014, @meng\_integrative\_2016, @meng\_dimension\_2016), . CIA is a multivariate method that identifies trends or co-structure in the variance of multiple datasets which contain the same samples. That is either the rows or the columns of a matrix must be “matchable”. CIA can be applied to datasets where
the number of variables (genes) far exceeds the number of samples (arrays) such is the case with microarray analyses.
**cia** calls **coinertia** in the *ade4* package. See the CIA vignette for more details on this method.

There are extended version of CIA in the Bioconducor packages **mogsa** and **omicade4** (Meng et al. [2014](#ref-meng_multivariate_2014), @meng\_integrative\_2016, @meng\_dimension\_2016)

```
# Example data are "G1_Ross_1375.txt" and "G5_Affy_1517.txt"
data(NCI60)
coin <- cia(NCI60$Ross, NCI60$Affy)
names(coin)
```

```
## [1] "call"      "coinertia" "coa1"      "coa2"
```

```
coin$coinertia$RV
```

```
## [1] 0.7859656
```

The RV coefficient $RV which is 0.786 in this instance, is a measure of global similarity between the datasets.

```
plot(coin, classvec=NCI60$classes[,2], clab=0, cpoint=3)
```

![](data:image/png;base64...)

*Figure 6* Coinertia analysis of NCI 60 cell line Spotted and Affymetrix gene expression dataset. The same 60 cell lines were analysed by two different labs on a spotted cDNA array (Ross) and an affymetrix array (Affy). The Ross dataset contains 1375 genes, and the affy dataset contains 1517. There is little overlap betwen the genes represented on these platforms. CIA allows visualisation of genes with similar expression patterns across platforms. A) shows
a plot of the 60 microarray samples projected onto the one space. The 60 circles represent dataset 1 (Ross) and the 60 arrows represent dataset 2 (affy). Each circle and arrow are joined by a line, the length of which is proportional to the divergence between that samples in the two datasets. The samples are coloured by cell type. B) The gene projections from datasets 1 (Ross), C) the gene projections from
dataset 2 (Affy). Genes and samples projected in the same direction from the origin show genes that are expressed in those samples. See vingette for more help on interpreting these plots.

# 7 Functions in made4

## 7.1 Data Input

| function | description |
| --- | --- |
| isDataFrame | converts matrix, data.frame, ExpressionSet, |
|  | SummarizedExperiment, marrayRaw, microarray or |
|  | RNAseq gene expression or any matrix data input |
|  | into a data frame suitable for analysis in ADE4. |
|  | The rows and columns are expected to contain the |
|  | variables (genes) and cases (array samples) |
| overview | Draw boxplot, histogram and hierarchical tree of gene |
|  | expression data. This is useful only for a *first glance* |
|  | at data. |

## 7.2 Example datasets provides with made4

| function | description |
| --- | --- |
| khan | Microarray gene expression dataset from Khan et al., 2001 |
| NCI60 | Microarray gene expression profiles of NCI 60 cell lines |

## 7.3 Classification and class prediction using Between Group Analysis

| function | description |
| --- | --- |
| bga | Between group analysis |
| bga.jackknife | Jackknife between group analysis |
| randomiser | Randomly reassign training and test samples |
| bga.suppl | Between group analysis with supplementary data projection |
| suppl | Projection of supplementary data onto axes from |
|  | a between group analysis |
| plot.bga | Plot results of between group analysis |
| between.graph | Plot 1D graph of results from between group analysis |

## 7.4 Meta analysis of two or more datasets using Coinertia Analysis

| function | description |
| --- | --- |
| cia | Coinertia analysis: Explore the covariance between two datasets |
| plot.cia | Plot results of coinertia analysis |

## 7.5 Graphical Visualisation of results: 1D Visualisation

| function | description |
| --- | --- |
| graph1D | Plot 1D graph of axis from multivariate analysis |
| between.graph | Plot 1D graph of results from between group analysis |
| commonMap | Highlight common points between two 1D plots |
| heatplot | Draws heatmap with dendrograms (of eigenvalues) |

## 7.6 Graphical Visualisation of results: 2D Visualisation

| function | description |
| --- | --- |
| plotgenes | Graph xy plot of variable (gene) projections from PCA or COA. Only label variables at ends of axes |
| plotarrays | Graph xy plot of case (samples) projections from PCA or COA,and colour by group |
| plot.bga | Plot results of between group analysis using plotgenes, s.groups and s.var |
| plot.cia | Plot results of coinertia analysis showing s.match.col, and plotgenes |
| s.var | Use plotarrays instead. Graph xy plot of variables (genes or arrays). Derived from ADE4 graphics module s.label. |
| s.groups | Use plotarrays instead. Graph xy plot of groups of variables (genes or arrays) and colour by group. Derived from ADE4 graphics module s.class |
| s.match.col | Use plotarrays instead. Graph xy plot of 2 sets of variables (normally genes) from CIA. Derived from ADE4 graphics module s.match |

## 7.7 Graphical Visualisation of results: 3D Visualisation

| function | description |
| --- | --- |
| do3d | Generate a 3D xyz graph using scatterplot3d |
| rotate3d | Generate multiple 3D graphs using do3d in which each graph is rotated |
| html3D | Produce web page with a 3D graph that can be viewed using Chime web browser plug-in, and/or a pdb file that can be viewed using Rasmol |

## 7.8 Interpretation of results

| function | description |
| --- | --- |
| topgenes | Returns a list of variables at the ends (positive, negative or both) of an axis |
| sumstats | Summary statistics on xy co-ordinates, returns the slopes and distance from origin of each co-ordinate |
| comparelists | Return the intersect, difference and union between 2 vectors (poorly named. it does not work on a list object) |
| print.comparelists | Prints the results of comparelists |

# References

Culhane, Aedín C, Guy Perrière, Elizabeth C Considine, Thomas G Cotter, and Desmond G Higgins. 2002. “Between-Group Analysis of Microarray Data.” *Bioinformatics (Oxford, England)* 18 (12): 1600–1608. <http://www.ncbi.nlm.nih.gov.ezp-prod1.hul.harvard.edu/pubmed/12490444>.

Culhane, Aedín C, Guy Perrière, and Desmond G Higgins. 2003. “Cross-Platform Comparison and Visualisation of Gene Expression Data Using Co-Inertia Analysis.” *BMC Bioinformatics* 4 (November): 59. <https://doi.org/10.1186/1471-2105-4-59>.

Dolédec, Sylvain, and Daniel Chessel. 1987. “Rythmes Saisonniers et Composantes Stationnelles En Milieu Aquatique. I: Description d’un Plan d’observation Complet Par Projection de Variables.” In.

Dolédec S, and Chessel D. 1994. “Co-Inertia Analysis: An Alternative Method for Studying Species-Environment Relationships.” *Freshwater Biology* 31: 277–94.

Eisen, Michael B., Paul T. Spellman, Patrick O. Brown, and David Botstein. 1998. “Cluster Analysis and Display of Genome-Wide Expression Patterns.” *Proceedings of the National Academy of Sciences* 95 (25): 14863–8. <https://www.pnas.org/content/95/25/14863>.

Fellenberg, K, N C Hauser, B Brors, A Neutzner, J D Hoheisel, and M Vingron. 2001. “Correspondence Analysis Applied to Microarray Data.” *Proceedings of the National Academy of Sciences of the United States of America* 98 (19): 10781–6. <https://doi.org/10.1073/pnas.181597298>.

Meng, Chen, and Aedin Culhane. 2016. “Integrative Exploratory Analysis of Two or More Genomic Datasets.” *Methods in Molecular Biology (Clifton, N.J.)* 1418: 19–38. <https://doi.org/10.1007/978-1-4939-3578-9_2>.

Meng, Chen, Bernhard Kuster, Aedín C. Culhane, and Amin Moghaddas Gholami. 2014. “A Multivariate Approach to the Integration of Multi-Omics Datasets.” *BMC Bioinformatics* 15 (May): 162. <https://doi.org/10.1186/1471-2105-15-162>.

Meng, Chen, Oana A. Zeleznik, Gerhard G. Thallinger, Bernhard Kuster, Amin M. Gholami, and Aedín C. Culhane. 2016. “Dimension Reduction Techniques for the Integrative Analysis of Multi-Omics Data.” *Briefings in Bioinformatics* 17 (4): 628–41. <https://doi.org/10.1093/bib/bbv108>.

Thioulouse, Jean, Daniel Chessel, Sylvain Dole´dec, and Jean-Michel Olivier. 1997. “ADE-4: A Multivariate Analysis and Graphical Display Software.” *Statistics and Computing* 7 (1): 75–83. [https://doi.org/10.1023/A:1018513530268](https://doi.org/10.1023/A%3A1018513530268).