# Oncomix Vignette

#### Daniel G. Piqué

#### 2025-10-30

## 1. Introduction

### 1.1 Motivation for Developing Oncomix

The advent of large, well-curated databases, such as the [genomic data commons](https://gdc.cancer.gov/), that contain RNA sequencing data from hundreds of patient tumors has made it possible to identify oncogene candidates solely based off of patterns present in mRNA expression data. Oncomix is the first method developed to identify oncogenes in a visually-interpretable manner from RNA-sequencing data in large cohorts of patients.

Oncomix is an R package for identifying oncogene candidates based off of 2-component Gaussian mixture models. It estimates parameters using the expectation maximization procedure as implemented in the R package mclust. This tutorial will demonstrate how to identify oncogene candidates from a set of mRNA sequencing data. We start by loading the package:

```
#devtools::install_github("dpique/oncomix", build_vignettes=T)
library(oncomix)
```

### 1.2 Distribution of Oncogene mRNA Expression

We first explore the idea of what the distribution of gene expression values for a oncogene should look like. It is known that oncogenes such as *ERBB2* are overexpressed in 15-20% of all breast cancer patients. In addition, oncogenes should not be expressed in normal tissue. Based on this line of reasoning, we formulate a model for the distribution of oncogene mRNA expression values in a population of both tumor (teal curves) and normal (red-orange curves) tissue:

```
library(ggplot2)
oncoMixIdeal()
```

![](data:image/png;base64...)

The x-axis represents mRNA expression values, with lower values toward the left and larger values (i.e. higher expression) toward the right. The y axis represents density. The teal curves represent the best-fitting Gaussian probability distribution (PD) over expression values from a single gene obtained from multiple tumor samples. The red-orange curves represent the PD over expression values from the same gene obtained from multiple adjacent normal tissue samples. This mixture model is applied once to the tumor data and again (separately) to the adjacent normal data, hence the 4 curves.

The advantage of applying a 2-component mixture model is that we are able to capture biologically-relevant clusters of gene expression that may naturally exist in the data. Otherwise, we might represent our data with just a single curve sitting in the middle of what really are 2 distinct clusters. Visually, we see that for a theoretical oncogene, there is a *subgroup* of tumors that overexpresses this gene relative to normal tissue.

### 1.3 Comparison of Oncomix to Existing Differential Expression Methods

We now conceptually compare oncomix to the techniques employed by traditional differential expression analysis (e.g. Student’s t-test, as employed by [limma](https://www.ncbi.nlm.nih.gov/pubmed/25605792), or [DESeq2](https://www.ncbi.nlm.nih.gov/pubmed/25516281)). These existing approaches make strong assumptions – namely, that the data from a particular group are well-described by distributions with mass concentrated around a central value (such as a ‘mean’). If we were to use one of these approaches on a large dataset, our assumption would be that oncogenes are overexpressed in *every* tumor sample compared to normal tissue. This assumption can be visualized below:

```
oncoMixTraditionalDE()
```

![](data:image/png;base64...)

The red-orange curve represents the gene expression values from the adjacent normal data, and the teal curve represents the gene expression values from the tumor data. Note, however, that the goal for a DE analysis using existing methods (such as limma) would be to find genes that maximize the difference between these two curves. This approach does not represent our knowledge of how oncogenes are expressed in a population of individuals – that is, highly expressed in a subset of patient tumors, and lowly expressed in adjacent normal tissue.

## 2. Identifying Oncogene Candidates

### 2.1 Loading Example Data and Exploring the `mixModelParams` Object

Now, we will load an example dataset that contains expression values for 700 mRNA isoforms obtained from paired samples of breast tumor (`exprTumIsof`) and adjacent normal(`exprNmlIsof`) breast tissue from 113 patients in the [Genomic Data Commons](https://gdc.cancer.gov/). We will fit the mixture model using the oncomix function `mixModelParams`, which takes dataframes that contain patients as rows and mRNA isoforms/genes as columns. The number of columns (genes) should be the same between both dataframes, though the number of rows can vary.

```
data(exprNmlIsof, exprTumIsof, package="oncomix")

##look at the matrix of mRNA expression data from adjacent normal samples
dim(exprNmlIsof)
```

```
## [1] 700 113
```

```
exprNmlIsof[1:5, 1:5]
```

```
##            TCGA-A7-A0CE-11A TCGA-A7-A0CH-11A TCGA-A7-A0D9-11A TCGA-A7-A0DB-11A
## uc001qoa.2         1.972887        2.4877508         1.534429         2.787777
## uc002jyg.1         1.488236        0.9886728         3.363712         3.301014
## uc011lsc.1         5.939032        6.7117641         5.210523         5.664385
## uc004cpd.1         1.816706        1.6479322         1.295284         1.537309
## uc011mgy.1         1.573477        1.3371375         2.027953         2.070035
##            TCGA-A7-A0DC-11A
## uc001qoa.2         1.821897
## uc002jyg.1         3.127924
## uc011lsc.1         5.433401
## uc004cpd.1         1.533831
## uc011mgy.1         2.431077
```

```
##look at the matrix of mRNA expression data from tumors
dim(exprTumIsof)
```

```
## [1] 700 113
```

```
exprTumIsof[1:5, 1:5]
```

```
##            TCGA-A7-A0CE-01A TCGA-A7-A0CH-01A TCGA-A7-A0D9-01A TCGA-A7-A0DB-01A
## uc001qoa.2        1.2399803         1.780444         1.704665         2.390934
## uc002jyg.1        3.1547083         3.503748         2.432818         2.638793
## uc011lsc.1        5.2938539         5.622610         9.029952         6.077302
## uc004cpd.1        0.8499161         1.803169         2.518515         1.735324
## uc011mgy.1        0.6849480         2.081580         3.343087         1.546985
##            TCGA-A7-A0DC-01A
## uc001qoa.2         2.310899
## uc002jyg.1         1.893164
## uc011lsc.1         7.636221
## uc004cpd.1         1.882874
## uc011mgy.1         2.415372
```

```
##fits the mixture models, will take a few minutes
mmParams <- mixModelParams(exprNmlIsof, exprTumIsof)
head(mmParams)
```

```
##                   nMu1       nMu2        nVar      nPi1      tMu1     tMu2
## uc002jxc.2 1.250068025 1.83147135 0.116400229 0.7967701 1.7371897 4.285259
## uc001jrg.2 0.006952803 0.01324544 0.005531848 0.5003037 0.1113493 1.625321
## uc003aab.2 0.985454390 1.59242262 0.087878646 0.4896663 2.0035574 4.522943
## uc004cmb.2 0.385483412 0.87309050 0.046609881 0.6731112 1.1691973 3.389940
## uc002jfu.2 0.382007855 0.45789679 0.558312339 0.5189438 0.5591093 2.645615
## uc001lcs.1 0.600357282 1.45153880 0.178300764 0.6373414 0.3463322 2.934114
##                 tVar      tPi1 deltaMu2   deltaMu1        SI     score
## uc002jxc.2 0.4368186 0.5943046 2.453788  0.4871217 1.0000000 1.4134475
## uc001jrg.2 0.1074420 0.7913964 1.612076  0.1043965 1.0000000 1.3947057
## uc003aab.2 0.6200912 0.7359520 2.930521  1.0181030 1.0000000 1.2044477
## uc004cmb.2 0.5000264 0.7992164 2.516849  0.7837139 1.0000000 1.1864992
## uc002jfu.2 0.3309116 0.6385413 2.187718  0.1771014 0.9911504 1.1114688
## uc001lcs.1 0.5330532 0.5976110 1.482575 -0.2540251 0.8849558 0.9072978
```

The object returned by `mixModelParams` is a dataframe with rows corresponding to genes and 12 columns containing mixture model parameters. The rows are sorted according to the `score` column, with the first row containing the highest oncomix score (defined below). The meaning of the dataframe columns are described below:

* `nMu1` = the mean (\(\mu\)) of the Gaussian curve with the smaller mean fit to the adjacent normal expression data (referred to as Mode 1).
* `nMu2` = the mean (\(\mu\)) of the Gaussian curve with the larger mean fit to the adjacent normal expression data (referred to as Mode 2).
* `nVar` = the variance (\(\sigma\)) of the two Gaussian curves fit to the adjacent normal expression data (fixed to be equal between the two curves)
* `nPi1` = the proportion of adjacent normal samples assigned to the Gaussian curve with mean `nMu1`
* `tMu1` = the mean (\(\mu\)) of the Gaussian curve with the smaller mean fit to the tumor expression data (referred to as Mode 1).
* `tMu2` = the mean (\(\mu\)) of the Gaussian curve with the larger mean fit to the tumor expression data (referred to as Mode 2).
* `tVar` = the variance (\(\sigma\)) of the two Gaussian curves fit to the tumor expression data (fixed to be equal between the two curves).
* `tPi1` = the proportion of tumor samples assigned to the Gaussian curve with mean `tMu1`.
* `deltaMu2` = the difference between the means of the two curves between groups. `tMu2` - `nMu2`. May be negative or positive.
* `deltaMu1` = the difference between the means of the two curves between groups. `tMu1` - `nMu1`. May be negative or positive.
* `SI` = the selectivity index, or the proportion of adjacent normal samples with expression values less than the boundary defined by `tMu2` - `tMu1`. The selectivity index for the ith gene is computed as:

\[SI\_i = \frac{1}{N}\sum\_{j=1}^N \Bigg\{ \begin{array}{ll} 1,~ if~x\_{ij} <
\frac{\mu\_{iLT}+\mu\_{iHT}}{2} \\
0, ~ otherwise
\end{array},
\]

* where \(N\) is the number of adjacent normal samples, and \(x\_{ij}\) is the expression value of the ith gene in the jth adjacent normal sample. \(\mu\_{iHT}\) is the mean of higher/larger Gaussian from the ith gene in tumor samples, and \(\mu\_{iLT}\) is the mean of the smaller/lower Gaussian from the ith gene in the tumor samples.
* `score` = The score for the \(i^{th}\) gene is calculated as follows: \[score\_i = SI \* [(\Delta\mu\_{2i} - \Delta\mu\_{1i}) - (var\_{Ni} -
  var\_{Ti})] ~~~~~, \]
* where \(SI\) is the selectivity index described above, \(\Delta\mu\_{2i}\) and \(\Delta\mu\_{1i}\) are as described above (equivalent to `deltaMu2` and `deltaMu1`), \(var\_{Ni}\) is the common variance across the adjacent normal samples (equivalent to `n.var`), and \(var\_{Ti}\) is the common variance across the tumor samples (equivalent to `tVar`).

### 2.2 Selecting Genes that Appear Most Like the Idealized Oncogene

We can now use the `mmParams` dataframe to figure out which of our isoforms in our gene set are most similar in terms of their distribution to our ideal oncogene candidate.

For example, lets say that we wanted to select a subset of gene isoforms that most resembled the theoretically ideal oncogene. We can capture all of the genes meeting or exceeding specified thresholds using the `topGeneQuant` function. Here, we want to maximize `deltMu2`, minimize `deltMu1`, and maximize the `SI`.

```
topGeneQuant <- topGeneQuants(mmParams, deltMu2Thr=99,
    deltMu1Thr=10, siThr=.99)
print(topGeneQuant)
```

```
##                 nMu1      nMu2       nVar      nPi1     tMu1     tMu2      tVar
## uc002jxc.2 1.2500680 1.8314714 0.11640023 0.7967701 1.737190 4.285259 0.4368186
## uc004cmb.2 0.3854834 0.8730905 0.04660988 0.6731112 1.169197 3.389940 0.5000264
##                 tPi1 deltaMu2  deltaMu1 SI    score
## uc002jxc.2 0.5943046 2.453788 0.4871217  1 1.413447
## uc004cmb.2 0.7992164 2.516849 0.7837139  1 1.186499
```

The results of the `topGeneQuants` function is to return a subsetted dataframe containing only those isoforms that met or exceeded the specified threshold. Here, there were 2 isoforms.

We can also select the top \(N\) genes that most closely resemble the oncogene candidate by simply selecting the first \(N\) rows from the `mmParams` object (e.g. `mmParams[1:N,]`). This is because the `mixModelParams` function returns a dataframe sorted by the score, with the 1st row containing the isoform with the highest score. There is an explanation of how the score is calculated above.

```
mmParamsTop10 <- mmParams[1:10,]
print(mmParamsTop10)
```

```
##                   nMu1       nMu2        nVar      nPi1       tMu1      tMu2
## uc002jxc.2 1.250068025 1.83147135 0.116400229 0.7967701  1.7371897  4.285259
## uc001jrg.2 0.006952803 0.01324544 0.005531848 0.5003037  0.1113493  1.625321
## uc003aab.2 0.985454390 1.59242262 0.087878646 0.4896663  2.0035574  4.522943
## uc004cmb.2 0.385483412 0.87309050 0.046609881 0.6731112  1.1691973  3.389940
## uc002jfu.2 0.382007855 0.45789679 0.558312339 0.5189438  0.5591093  2.645615
## uc001lcs.1 0.600357282 1.45153880 0.178300764 0.6373414  0.3463322  2.934114
## uc010tgs.1 0.893283005 1.05416810 0.179040709 0.5385148  1.3478455  2.959714
## uc003yqc.1 4.208205968 4.27383134 0.051540764 0.5289734  4.7150533  5.678098
## uc002dwc.2 9.293023652 9.41161776 0.183687289 0.4974137 10.1034656 11.302811
## uc001guh.2 1.430670482 1.92416525 0.110274426 0.4216897  1.9201509  3.423634
##                 tVar      tPi1 deltaMu2   deltaMu1        SI     score
## uc002jxc.2 0.4368186 0.5943046 2.453788  0.4871217 1.0000000 1.4134475
## uc001jrg.2 0.1074420 0.7913964 1.612076  0.1043965 1.0000000 1.3947057
## uc003aab.2 0.6200912 0.7359520 2.930521  1.0181030 1.0000000 1.2044477
## uc004cmb.2 0.5000264 0.7992164 2.516849  0.7837139 1.0000000 1.1864992
## uc002jfu.2 0.3309116 0.6385413 2.187718  0.1771014 0.9911504 1.1114688
## uc001lcs.1 0.5330532 0.5976110 1.482575 -0.2540251 0.8849558 0.9072978
## uc010tgs.1 0.4029768 0.7233166 1.905546  0.4545625 0.9911504 0.8612763
## uc003yqc.1 0.1911460 0.6652337 1.404266  0.5068473 1.0000000 0.6547324
## uc002dwc.2 0.3124464 0.7678767 1.891193  0.8104420 0.9911504 0.5794439
## uc001guh.2 0.3555573 0.7444933 1.499468  0.4894804 0.9911504 0.5393407
```

## 3. Visualize the Output

### 3.1 Visualize Isoforms with a High SI & Oncomix Score

Now, we will visualize the distribution of gene expression values for a particular isoform. Specifically, we will create a overlapping histogram of an single isoform’s expression values across both tumor (teal) and adjacent normal (red) samples with the best-fitting Gaussian curves superimposed. The isoform that we want to visualize here, uc002jxc.2, is one of the isoforms in the output from `topGeneQuant` function. It also ranks highly in terms of its oncomix score, so it should have a distributional profile that is more similar to our theoretical oncogene that most other isoforms in this dataset.

```
isof = "uc002jxc.2"
plotGeneHist(mmParams, exprNmlIsof, exprTumIsof, isof)
```

![](data:image/png;base64...)

Next, we will create a scatterplot with the axes corresponding to the differences between component means. Our oncogene candidates will be those genes that appear in the upper right quadrant of this scatterplot. The x axis corresponds to the difference between the means of the curves with the larger Gaussians (`deltaMu2`), and the y axis corresponds to the difference between the means of the curves with the smaller Gaussians (`deltaMu1`) between the two treatments.

Here, \(\alpha\) (in the title) is a term that is present in the denominator of the value of the y-axis and functions as an automatic scaling parameter to set the range of the y-axis to be approximately equal to the range of the x-axis.

```
scatterMixPlot(mmParams)
```

![](data:image/png;base64...)

We would expect isoforms that maximize `deltaMu1` and minimize `deltaMu2` to be most visually similar to the theoretical oncogene candidate, and thus to be present within the upper right quadrant of this histogram. However, due to the large variance displayed by some of these isoforms, not all isoforms in the upper right quadrant appear like the theoreticaly ideal oncogene. We developed an index, termed the selectivity index (SI), that helps highlight genes that follow our ideal profile. The SI ranges from 0 to 1, and genes with a larger selectivity index will follow more closely the ideal oncogene. Now, we will highlight the isoforms with a selectivity index greater than .99 using the `selIndThresh` argument to narrow our search.

```
scatterMixPlot(mmParams, selIndThresh=.99)
```

![](data:image/png;base64...)

We can also highlight where the top 10 isoforms with the highest score fall in the scatterplot.

```
scatterMixPlot(mmParams=mmParams, geneLabels=rownames(mmParamsTop10))
```

![](data:image/png;base64...)

### 3.2 Visualize the Distribution of Isoforms that Map to Known Oncogenes

We can check the distribution of the isoforms that map to known human oncogenes. To do this, we will use genes classified as oncogenes from the [ONGene database](http://ongene.bioinfo-minzhao.org/), which is first literature-curated database of oncogenes. The [paper](https://www.ncbi.nlm.nih.gov/pubmed/28162959) associated with the ONGene database was published in 2017.

We mapped the oncogenes in the ONGene database (which are in gene symbols) to ucsc isoforms, which is the gene format that we have in our original datasets, using an R interface to the public UCSC MySQL database (queried in Sept 2017). The ouput from this mapping is stored as `queryRes` object and is available as part of this package. We’ll show where the top 5 isoforms mapping to oncogenes in the ONGene database land on the scatterplot shown above.

```
##The code that follows was used to generate the `queryRes` object
##in September 2017.
##
##install.packages("RMySQL")
##library(RMySQL)
##
##read in a table of known human oncogenes from the ONGene database
##ongene <- read.table("http://ongene.bioinfo-minzhao.org/ongene_human.txt",
##    header=TRUE, sep="\t", quote="", stringsAsFactors=FALSE, row.names=NULL)
##
##send a sql query to UCSC to map the human oncogenes to ucsc isoform ids
##ucscGenome <- dbConnect(MySQL(), user="genome",
##    host="genome-mysql.cse.ucsc.edu", db='hg19')
##createGeneQuery <- function(name){ #name is a character vector
##    p1 <- paste(name, collapse='\',\'')
##    p2 <- paste('(\'',p1, '\')',sep="")
##    return(p2)
##}
##geneQ <- createGeneQuery(ongene$OncogeneName)
##queryRes <- dbGetQuery(ucscGenome,
##    paste0("SELECT kgID, geneSymbol FROM kgXref WHERE geneSymbol IN ",
##        geneQ, " ;"))
##dbDisconnect(ucscGenome)

##The database mapping ucsc symbols to gene symbols is loaded below,
##without needing to access the internet.
data(queryRes, package="oncomix")

##Merge the queryRes & mmParams dataframes
queryRes$kgIDs <- substr(queryRes$kgID, 1, 8)
mmParams$kgIDs <- substr(rownames(mmParams), 1, 8)
mmParams$kgID <- rownames(mmParams)
mmParamsMg <- merge(mmParams, queryRes, by="kgIDs", all.x=TRUE)
rownames(mmParamsMg) <- mmParamsMg$kgID.x

## Show the top 5 isoforms with the highest score
## in our dataset that map to known oncogenes
mmParamsMg <- mmParamsMg[with(mmParamsMg, order(-score)), ]
mmParamsMgSbst <- subset(mmParamsMg, !is.na(geneSymbol))[1:5,]
print(mmParamsMgSbst)
```

```
##               kgIDs      nMu1      nMu2       nVar      nPi1      tMu1
## uc003oup.2 uc003oup 1.7562421 2.3786388 0.12487674 0.7730556 1.9883747
## uc002xxh.1 uc002xxh 0.4560398 1.4892669 0.24518796 0.4194020 0.9404896
## uc002bls.2 uc002bls 0.2984879 0.6211827 0.01947533 0.7187925 0.3545541
## uc001gmi.3 uc001gmi 0.1444637 1.4093875 0.09445765 0.6551238 0.1805888
## uc001fmq.2 uc001fmq 4.1282249 4.2659677 0.22455842 0.4735916 3.9730294
##                 tMu2       tVar      tPi1  deltaMu2    deltaMu1        SI
## uc003oup.2 3.3428559 0.28818297 0.7293117 0.9642171  0.23213265 0.9380531
## uc002xxh.1 3.1973170 0.79205319 0.2116396 1.7080501  0.48444982 0.9115044
## uc002bls.2 0.8321796 0.02351133 0.7950209 0.2109969  0.05606616 0.8318584
## uc001gmi.3 1.8023104 0.13572157 0.7174308 0.3929229  0.03612517 0.7079646
## uc001fmq.2 4.7407613 0.31292535 0.5434014 0.4747936 -0.15519546 0.6371681
##                 score     kgID.x     kgID.y geneSymbol
## uc003oup.2 0.29926211 uc003oup.2 uc003oup.3      DNPH1
## uc002xxh.1 0.16986716 uc002xxh.1 uc002xxh.1      AURKA
## uc002bls.2 0.09312160 uc002bls.2 uc002bls.4     AKAP13
## uc001gmi.3 0.08964142 uc001gmi.3 uc001gmi.4       ABL2
## uc001fmq.2 0.05894143 uc001fmq.2 uc001fmq.2    ARHGEF2
```

```
scatterMixPlot(mmParams=mmParams, geneLabels=rownames(mmParamsMgSbst))
```

![](data:image/png;base64...)

If you are interested in a particular oncogene, then you can plug the name of that gene (as long as it is in your original dataset) into the `geneLabels` argument of the `scatterMixPlot` function, which will highlight those genes entered into the `geneLabels` argument on the scatterplot.

Note: Not all well-characterized oncogenes fall into or near the upper right quadrant of this scatterplot (explored more in the analysis below). This is expected because oncogenes can arise via a variety of mechanisms, such as via mutational activation (eg BRAF V600E), which may not be associated with increased expression of the gene. mRNA overexpresion is one of several ways that an oncogene can drive tumor behavior, and it is this class of oncogenes that our method seeks to detect.

### 3.3 Visualize the Distribution of the Oncomix Score

We will now check the distribution of the oncomix `score` across all gene isoforms. The histograms are superimposed and are colored by whether the isoform maps to a gene in the ONGene database (orange, n = 22) or not (purple, n = 678).

```
library(RColorBrewer)
col <- brewer.pal(3, "Dark2")
ggplot(mmParamsMg, aes(x=score, y=..density.., fill=is.na(geneSymbol))) +
    geom_histogram(data=subset(mmParamsMg, is.na(geneSymbol)),
        fill=col[2], alpha=0.5) +
    geom_histogram(data=subset(mmParamsMg, !is.na(geneSymbol)),
        fill=col[3], alpha=0.5) +
    theme_classic() + xlab("OncoMix Score") + theme_classic()
```

![](data:image/png;base64...)

The distribution of the oncomix scores looks equivalent between isoforms in the ONGene database versus those not in the ONGene database. However, the short right tail of this distribution, which contains isoforms with high scores, also preferentially consists of isoforms that map to genes in the ONGene database. The few isoforms that are not in the ONGene database and that have high scores may represent oncogenes that are yet to be discovered.

## 4. Session Info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] RColorBrewer_1.1-3 ggplot2_4.0.0      oncomix_1.32.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 generics_0.1.4
##  [3] SparseArray_1.10.0          lattice_0.22-7
##  [5] digest_0.6.37               magrittr_2.0.4
##  [7] evaluate_1.0.5              grid_4.5.1
##  [9] fastmap_1.2.0               jsonlite_2.0.0
## [11] Matrix_1.7-4                ggrepel_0.9.6
## [13] mclust_6.1.1                scales_1.4.0
## [15] jquerylib_0.1.4             abind_1.4-8
## [17] cli_3.6.5                   rlang_1.1.6
## [19] XVector_0.50.0              Biobase_2.70.0
## [21] withr_3.0.2                 cachem_1.1.0
## [23] DelayedArray_0.36.0         yaml_2.3.10
## [25] S4Arrays_1.10.0             tools_4.5.1
## [27] dplyr_1.1.4                 SummarizedExperiment_1.40.0
## [29] BiocGenerics_0.56.0         vctrs_0.6.5
## [31] R6_2.6.1                    matrixStats_1.5.0
## [33] stats4_4.5.1                lifecycle_1.0.4
## [35] Seqinfo_1.0.0               S4Vectors_0.48.0
## [37] IRanges_2.44.0              pkgconfig_2.0.3
## [39] pillar_1.11.1               bslib_0.9.0
## [41] gtable_0.3.6                glue_1.8.0
## [43] Rcpp_1.1.0                  xfun_0.53
## [45] tibble_3.3.0                GenomicRanges_1.62.0
## [47] tidyselect_1.2.1            MatrixGenerics_1.22.0
## [49] knitr_1.50                  dichromat_2.0-0.1
## [51] farver_2.1.2                htmltools_0.5.8.1
## [53] labeling_0.4.3              rmarkdown_2.30
## [55] compiler_4.5.1              S7_0.2.0
```

Please email me at daniel.pique@med.einstein.yu.edu with any suggestions, questions, or comments. Thank you!