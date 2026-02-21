# Introduction to MCbiclust

Robert Bentham1\*

1Cell and Developmental Biology, University College London

\*robert.bentham.11@ucl.ac.uk

#### 2018-06-04

#### Abstract

MCbiclust is a R package for running massively correlating biclustering analysis. MCbiclust aims to find large scale biclusters with selected features being highly correlated with each other over a subset of samples. MCbiclust was particularly designed for the application of studying gene expression data, finding and understanding biclusters that are related to large scale co-regulation of genes.

#### Package

MCbiclust 1.3.3
Report issues on <https://github.com/rbentham/MCbiclust/issues>

# 1 Introduction

MCbiclust is a R package for running massively correlating biclustering analysis. MCbiclust aims to find large scale biclusters with selected features being highly correlated with each other over a subset of samples. MCbiclust was particularly designed for the application of studying gene expression data, finding and understanding biclusters that are related to large scale co-regulation of genes.

Report issues on <https://github.com/rbentham/MCbiclust/issues>

# 2 Getting started

Once installed MCbiclust can be loaded with the following command:

```
library(MCbiclust)
```

MCbiclust also makes sure that the packages BiocParallel, cluster, stats, GGally, ggplot2 and scales are all installed. It is also advised that the packages ggplot2 and gplots are separately installed and loaded.

```
library(ggplot2)
library(gplots)
library(dplyr)
library(gProfileR)
library(MASS)
library(devtools)
```

# 3 Example of a single run

## 3.1 Loading Cancer Cell Line Encyclopedia (CCLE) and MitoCarta data sets

For this example analysis we will be seeking to find biclusters related to mitochondrial function in the cancer cell line encyclopedia (Barretina et al. ([2012](#ref-barretina2012cancer))). For this two datasets are needed, both of which are available on the MCbiclust package. The first in `CCLE_small` that contains a subset of the gene expression values found in the entire CCLE data set (the full dataset is avaliable at <https://portals.broadinstitute.org/ccle/home>), the second, `Mitochondrial_genes`, is a list of mitochondrial genes that can be found from MitoCarta1.0 (Pagliarini et al. ([2008](#ref-pagliarini2008mitochondrial))).

```
data(CCLE_small)
data(Mitochondrial_genes)
```

It is a simple procedure to create a new matrix `CCLE.mito` only containing the mitochondrial genes. While there are \(1023\) known mitochondrial genes, not all of these are measured in `CCLE_data`.

```
mito.loc <- which(row.names(CCLE_small) %in% Mitochondrial_genes)
CCLE.mito <- CCLE_small[mito.loc,]
```

## 3.2 Finding a bicluster seed

The first step in using MCbiclust is to find a subset of samples that have the most highly correlating genes in the chosen gene expression matrix. This is done by, calculating the associated correlation matrix and then calculating the absolute mean of the correlations, as a correlation score.

Mathematically for a gene expression dataset measuring multiple gene probes across multiple samples, let
\[\begin{equation}
X = \textrm{Set of all probes, } Y = \textrm{Set of all samples}
\end{equation}\]
Then define two subsets of \(X\) and \(Y\), \(I\) and \(J\) repectively
\[\begin{equation}
I \subset X \textrm{ and } J \subset Y
\end{equation}\]
Subsets \(I\) and \(J\) form a bicluster on sets \(X\) and \(Y\), and the strength of this bicluster measured is based on measuring the correlations between pairs of probes in set \(I\) across all samples in set \(J\).
The correlation between a probe \(i \in I\) to a probe \(k \in I\) across the samples in \(J\) is denoted as \(C\_{i,k}^J\).
Then the strength of the bicluster is measured as having a score \(\alpha\) based on these correlations, defined as:
\[\begin{equation}
\alpha\_I^J= \frac{1}{|I|^2}\sum\_{i \in I} \sum\_{k \in I} abs(C\_{i,k}^J)
\end{equation}\]
where the function \(abs()\) refers to the absolute value.
In words the score \(\alpha\) is the average of the absolute values of the gene-gene correlation matrix for gene-probe set \(I\) across the samples in sample set \(J\).

A high \(\alpha\_I^J\) value indicates that the probes in set \(I\) are being strongly co-regulated across the samples in set \(J\).
As \(\alpha\_I^J\) is calculating using the absolute values of \(C\_{i,k}^J\), these probes could be in either in correlation or anti-correlation with each other.

`MCbiclust` main aim is therefore to find sets of samples and genes that have a high \(\alpha\_I^J\) value. This is achieved by first finding a small sample “seed” containing relatively few samples but a very high \(\alpha\_I^J\) value,

This is achieved with function `FindSeed`, initially a random subset of samples is chosen and then at each iteration one sample is removed and replaced and if this results in a higher \(\alpha\_I^J\) value than this new subset is chosen. In this function the argument `gem` stands for gene expression matrix, `seed.size` indicates the size of the subset of samples that is sought. `iterations` indicates how many iterations of the algorithm to carry out before stopping. In general the higher the iterations the more optimal the solution in terms of maximising the strength of the correlation.

For reproducibility `set.seed` has been used to set R’s pseudo-random number generator. It should also be noted that the for `gem` the data matrix can not contain all the genes, since `FindSeed` involves the calculation of correlation matrices which are not computationally efficient to compute if they involve greater than ~1000 genes.

```
set.seed(102)
CCLE.seed <- FindSeed(gem = CCLE.mito,
                      seed.size = 10,
                      iterations = 10000,
                      messages = 1000)
```

`FindSeed` has one more additional options, `initial.seed` allows the user to specify the initial subsample to be tested, by default the initial sample subset is randomly chosen.

There is a function `CorScoreCalc` that can calculate the correlation score \(\alpha\_I^J\) directly, in general however you should not need to use it, unless you wish to manually check the chosen seed is an improvement on one that is randomly generated.

```
set.seed(103)
random.seed <- sample(seq(length = dim(CCLE.mito)[2]), 10)
CorScoreCalc(CCLE.mito,random.seed)
```

```
## [1] 0.2901273
```

```
CorScoreCalc(CCLE.mito,CCLE.seed)
```

```
## [1] 0.5781261
```

The results of `FindSeed` can also be visualised by examining the associated correlation matrix, and viewing the result as a heatmap. Again it is easy to see the difference between the random subsample and the one outputted from `FindSeed`.

```
CCLE.random.cor <- cor(t(CCLE.mito[,random.seed]))
heatmap.2(CCLE.random.cor,trace = "none")
```

![](data:image/png;base64...)

```
CCLE.mito.cor <- cor(t(CCLE.mito[,CCLE.seed]))
heatmap.2(CCLE.mito.cor,trace = "none")
```

![](data:image/png;base64...)

Note that when the genes are represented as the rows in a matrix, that matrix needs to be transposed before the calculation of the correlation matrix.

`heatmap.2` is a function from the `gplots` R package.

## 3.3 Selecting highly correlated genes

As can be clearly seen from the heat map, not all the mitochondrial genes are equally strongly correlated to each other. There is a function in `MCbiclust` which automatically selects those genes that are most strongly associated with the pattern. This function is `HclustGenesHiCor` and it works by using hierarchical clustering to select the genes into n different groups, and then discarding any of these groups that fail to have a correlation score greater than the correlation score from all the genes together.

```
CCLE.hicor.genes <- as.numeric(HclustGenesHiCor(CCLE.mito,
                                                CCLE.seed,
                                                cuts = 8))
CCLE.mito.cor2 <- cor(t(CCLE.mito[CCLE.hicor.genes, CCLE.seed]))
CCLE.heat <- heatmap.2(CCLE.mito.cor2,trace = "none")
```

![](data:image/png;base64...)

There are two groups of genes, strongly correlated to themselves and anti-correlated to each other. These can be extracted from the dendrogram:

```
CCLE.groups <- list(labels(CCLE.heat$rowDendrogram[[1]]),
                    labels(CCLE.heat$rowDendrogram[[2]]))
```

## 3.4 Calculate the correlation vector

In this example a distinct correlation pattern was found. However this was only examined for genes involved in mitochondrial function. Non-mitochondrial genes are likely also involved in this pattern and it is important to identify them.

All genes can be measured by how they match to this pattern by calculating what is called a correlation vector (CV). This is done in two steps:

1. The pattern is summarised by finding a subset of genes which all strongly correlate with each other, and calculating their average expression value. This is done by clustering the genes using hierarchical clustering and selecting the best group judged by that groups correlation score multiplied by the square root of the number of genes. This multiplication is done to remove the bias of selecting a group containing very few genes.
2. The correlation vector is calculated by finding the correlation of every gene to the average expression value of the chosen best group.

This process is all encapsulated in the function `CVEval` which takes 4 arguements. `gem.part` is the gene expression matrix for the chosen gene set of interest, e.g. mitochondrial genes, `gem.all` is the entire gene expression matrix, `seed` is the output from `FindSeed` and `splits` is the number of groups to split the chosen gene set into in order to select the best group.

```
CCLE.cor.vec <- CVEval(gem.part = CCLE.mito,
                        gem.all = CCLE_small,
                        seed = CCLE.seed, splits = 10)
```

## 3.5 Gene Set Enrichment

Using the calculated correlation vector, it is a relatively simple task to perform gene set enrichment. This can be done on any platform (e.g. DAVID, gprofiler, etc.) but MCbiclust comes with an inbuilt function for calculating GO enrichment values using the Mann-Whitney non-parametric test.

This is achieved with the `GOEnrichmentAnalysis` function which takes three inputs:

1. `gene.names`: The names of the genes in standard format.
2. `gene.values`: The correlation vector.
3. `sig.rate`: The value below which adjusted p-values are decided to be significant.

The output is a table with 7 columns:

1. `GOID`: ID for GO term.
2. `TERM`: Name of GO term.
3. `num.genes`: Number of genes in GO term.
4. `g.in.genelist`: Number of genes in GO term that were measured in the gene expression matrix.
5. `adj.p.value`: Adjusted p-value from Mann-Whitney test.
6. `CV.av.value`: Average value of CV for genes in GO term.
7. `phenotype`: +1 if `CV.av.value` is greater than the overall CV average, -1 if the `CV.av.value` is less then the overall CV average.

```
GSE.MW <- GOEnrichmentAnalysis(gene.names = row.names(CCLE_small),
                               gene.values = CCLE.cor.vec,
                               sig.rate = 0.05)
```

There are 76 significant terms and the top 10 most significant can be viewed below:

```
row.names(GSE.MW) <- NULL
pander::pandoc.table(GSE.MW[1:10,],row.names = FALSE)
```

Table continues below

| GOID | TERM | ONTOLOGY | num.genes |
| --- | --- | --- | --- |
| GO:0030529 | intracellular ribonucleoprotein complex | CC | 964 |
| GO:1990904 | ribonucleoprotein complex | CC | 965 |
| GO:0007005 | mitochondrion organization | BP | 819 |
| GO:0006414 | translational elongation | BP | 139 |
| GO:0005840 | ribosome | CC | 286 |
| GO:0032543 | mitochondrial translation | BP | 151 |
| GO:0070125 | mitochondrial translational elongation | BP | 86 |
| GO:0005743 | mitochondrial inner membrane | CC | 629 |
| GO:0019866 | organelle inner membrane | CC | 686 |
| GO:0003723 | RNA binding | MF | 2029 |

| g.in.genelist | adj.p.value | CV.av.value | phenotype |
| --- | --- | --- | --- |
| 66 | 2.917e-08 | 0.796 | 1 |
| 66 | 2.917e-08 | 0.796 | 1 |
| 144 | 6.14e-07 | 0.6753 | 1 |
| 46 | 1.675e-06 | 0.8433 | 1 |
| 44 | 2.292e-06 | 0.8447 | 1 |
| 50 | 5.694e-06 | 0.824 | 1 |
| 42 | 6.354e-06 | 0.8417 | 1 |
| 211 | 8.329e-06 | 0.619 | 1 |
| 213 | 9.259e-06 | 0.6154 | 1 |
| 111 | 1.01e-05 | 0.6448 | 1 |

Since `CCLE_small` is half made up of mitochondrial genes and we were seeking for mitochondrial related biclusters it is not surprising that mitochondrial terms dominate the gene set enrichment. If `MCbiclust` was run on the full CCLE gene expression data set it would be expected to see many more significant non-mitochondrial related terms.

An alternative to using the `GOEnrichmentAnalysis` function would be to use a separate gene set enrichment method such as `gprofiler`, this can be done by for instance selecting the top 200 genes with positive CV values:

```
top200 <- row.names(CCLE_small)[order(CCLE.cor.vec,
                                             decreasing = TRUE)[seq(200)]]

# top200.gprof <- gprofiler(top200)
# dim(top200.gprof)
```

```
# pander::pandoc.table(top200.gprof[seq(10),-c(1,2,7,8,11,14)],
#                     row.names = FALSE)
```

## 3.6 Sample ordering

Already all the genes in the data set have had the correlation calculated to the pattern found. One more task that can be readily done is to order the samples according to the strength of correlation. Function `FindSeed` found the initial \(n\) samples that had a very strong correlation with the gene set of interest, the \(n+1\) sample is to be selected as that sample which best maintains the correlation strength, this process can be simply repeated until all or the desired number of samples are ordered.

`SampleSort` is the function in `MCbiclust` that completes this procedure, it has \(4\) main inputs:

1. `gem`: the gene expression matrix with all the samples and the gene set of interest.
2. `seed`: the initial subsample found with `FindSeed`.
3. `num.cores`: Used for setting the number of cores used in calculation, default value is to use one core.
4. `sort.length`: Sets the number of samples to be ordered.

```
CCLE.samp.sort <- SampleSort(CCLE.mito[as.numeric(CCLE.hicor.genes),],
                             seed = CCLE.seed)
```

Note as before that these are long calculations, and may take some time.

Note that SampleSort is a very computationally expensive function and requires time to run. For a large dataset such as the CCLE data it is advisable to either calculate a partial ordering, which can be done with the `sort.length` arguement or submit the job of sorting the samples to a high performance computing facility.

## 3.7 PCA

Once the samples have been sorted it is possible to summarise the correlation pattern found using principal component analysis (PCA).

PCA is a method of dimensional reduction, and converts a data set to a new set of variables known as the principal components. These are designed to be completely uncorrelated or orthogonal to each other. In this way the principal components are new variables that capture the correlations between the old variables, and are in fact a linear combination of the old variables. The first principal component (PC1) is calculated as the one that explains the highest variance within the data, the second than is that which has the highest variance but is completely uncorrelated or orthogonal to the previous principal component. In this way additional principal components are calculated until all the variance in the data set is explained.

PC1 captures the highest variance within the data, so if PCA is run on the found bicluster with very strong correlations between the genes, PC1 will be a variable that summarises this correlation.

`PC1VecFun` is a function that calculates the PC1 values for all sorted samples. It takes three inputs:

1.`top.gem` is the gene expression matrix with only the most highly correlated genes but with all the sample data.

1. `seed.sort` is the sorting of the data samples found with function `SampleSort`
2. `n` is the number of samples used for initially calculating the weighting of PC1. If set to \(10\), the first \(10\) samples are used to calculate the weighting of PC1 and then the value of PC1 is calculated for all samples in the ordering.

```
top.mat <- CCLE.mito[as.numeric(CCLE.hicor.genes),]

pc1.vec <- PC1VecFun(top.gem = top.mat,
                     seed.sort = CCLE.samp.sort, n = 10)
```

## 3.8 Thresholding the bicluster and aligning PC1

So far MCbiclust outputs a ranked list of genes and samples. In many cases it is however necessary to determine which genes and samples are within the bicluster and which are not. This is done with the `ThresholdBic` function, which takes \(4\) arguements:

1. `cor.vec`: The correlation vector, output of `CVeval`.
2. `sort.order`: The sorted samples, output of `SampleSort`.
3. `pc1`: The PC1 vector, output of `PC1VecFun`
4. `samp.sig`: A numeric value between 0 and 1 that detemines the number of samples in the bicluster.

The genes in the bicluster are determined using kmeans clustering, and dividing the genes into two clusters based on the absolute value of the correlation vector, choosing one correlated and one uncorrelated groups.

The samples are however chosen based on the last 10% of the ranked samples, these samples are assumed to not belong to the bicluster and the first sample with a PC1 value between the \(0 + samp.sig/2\) and \(1 - samp.sig/2\) quantiles, and every sample after that is not in the bicluster.

```
CCLE.bic <- ThresholdBic(cor.vec = CCLE.cor.vec,
                         sort.order = CCLE.samp.sort,
                         pc1 = pc1.vec, samp.sig = 0.05)
```

Once this thresholded bicluster has been found it is important to properly align the PC1 vector and the correlation vector such that samples with a high PC1 values are those samples with up-regulated genes that have positive CV values. This is not strictly necessary to do, but makes the interpretation of MCbiclust simpler.

This is done with function `PC1Align` which if necessary times the pc1.vec by -1 to ensure that the correlation vector and PC1 vector are “aligned”.

```
pc1.vec <- PC1Align(gem = CCLE_small, pc1 = pc1.vec,
                    sort.order = CCLE.samp.sort,
                    cor.vec = CCLE.cor.vec, bic = CCLE.bic)
```

## 3.9 Alternative to PCA

As an alternative to calculating PC1, the user may want to calculate the average expression value of certain gene sets. This gives a better idea of the type of regulation occurring in the correlation pattern, as an abstract notion of a principal component does not have to be understood.

```
av.genes.group1 <- colMeans(CCLE.mito[CCLE.groups[[1]],
                                      CCLE.samp.sort])
av.genes.group2 <- colMeans(CCLE.mito[CCLE.groups[[2]],
                                      CCLE.samp.sort])
```

## 3.10 Plotting the forks

Once the samples have been ordered and PC1 and the average gene sets calculated it is a simple procedure to produce plots of these against the ordered samples.

One final additional thing that can be done is to classify the samples into belonging to the bicluster or not, and additionally whether a sample belongs to the Upper or Lower fork. This can be done with the function `ForkClassifier`

To produce the plots of the forks the `ggplot2` package is used.

```
CCLE.names <- colnames(CCLE_small)[CCLE.samp.sort]
fork.status <- ForkClassifier(pc1.vec, samp.num = length(CCLE.bic[[2]]))

CCLE.df <- data.frame(CCLE.name = CCLE.names,
                      PC1 = pc1.vec,
                      Fork = fork.status,
                      Average.Group1 = av.genes.group1,
                      Average.Group2 = av.genes.group2,
                      Order = seq(length = length(pc1.vec)))

ggplot(CCLE.df, aes(Order,PC1)) +
  geom_point(aes(colour = Fork)) + ylab("PC1")
```

![](data:image/png;base64...)

```
ggplot(CCLE.df, aes(Order,Average.Group1)) +
  geom_point(aes(colour = Fork)) + ylab("Average Group 1")
```

![](data:image/png;base64...)

```
ggplot(CCLE.df, aes(Order,Average.Group2)) +
  geom_point(aes(colour = Fork)) + ylab("Average Group 2")
```

![](data:image/png;base64...)

This by itself however is not particularly enlightening and to get additional information out of these plots supplementary information needs to be examined.

## 3.11 Comparing results with sample data

This section will deal with an addition data sets both of which are available in the MCbiclust package.

* CCLE sample information, a data set containing information for every sample in the data set, including gender of the patient the cell line was derived from, as well as the primary site it came from.

This section is meant as an example of the type of analysis that can be done with additional data set. Each new data set may have different additional data available with it and may be in formats that need some extra work to become compatible with the results from the `MCbiclust` analysis.

### 3.11.1 CCLE sample data

This data set is available within the `MCbiclust` package.

```
data(CCLE_samples)
```

In this case some samples have an additional “X” not present in some CCLE\_samples data so it is necessary to add it for consistency.

```
CCLE.samples.names <- as.character(CCLE_samples[,1])
CCLE.samples.names[c(1:15)] <- paste("X",CCLE.samples.names[c(1:15)],
                                     sep="")
CCLE_samples$CCLE.name <- CCLE.samples.names
```

The first step is to compare the column names of both data sets and to make sure we are dealing with the same correctly labeled samples.

```
rownames(CCLE_samples) <- as.character(CCLE_samples[,1])

CCLE.data.names <- colnames(CCLE_small)
CCLE_small_samples <- CCLE_samples[CCLE.data.names,]
```

Using the `dplyr` library, it is possible to join this new data set to the one we made for plotting the values of PC1 in the previous section. This can be easily done as both datasets share a column - the name of the samples. Once this is done, it is again simple to produce additional plots.

```
CCLE.df.samples <- inner_join(CCLE.df,CCLE_samples,by="CCLE.name")

ggplot(CCLE.df.samples, aes(Order,PC1)) +
  geom_point(aes(colour=factor(Site.Primary))) + ylab("PC1")
```

![](data:image/png;base64...)

In this case the figure is slightly confusing due to the number of factors. We can however rename factors that appear less than 30 times in total as “Other”.

```
rare.sites <- names(which(summary(CCLE.df.samples$Site.Primary) < 15))
CCLE.df.samples$Site.Primary2 <- as.character(CCLE.df.samples$Site.Primary)

rare.sites.loc <- which(CCLE.df.samples$Site.Primary2 %in% rare.sites)
CCLE.df.samples$Site.Primary2[rare.sites.loc] <- "Other"

ggplot(CCLE.df.samples, aes(Order,PC1)) +
  geom_point(aes(colour=factor(Site.Primary2))) + ylab("PC1")
```

![](data:image/png;base64...)

```
ggplot(CCLE.df.samples, aes(Order,PC1)) +
  geom_point(aes(colour=factor(Gender))) + ylab("PC1")
```

![](data:image/png;base64...)

Since in this case the data is categorical, it can be tested for significance using Pearson’s chi squared test.

```
library(MASS)

# create contingency tables
ctable.site <- table(CCLE.df.samples$Fork,
                     CCLE.df.samples$Site.Primary)

ctable.gender <- table(CCLE.df.samples$Fork,
                       CCLE.df.samples$Gender,
                       exclude = "U")

chisq.test(ctable.site)
```

```
## Warning in chisq.test(ctable.site): Chi-squared approximation may be incorrect
```

```
##
##  Pearson's Chi-squared test
##
## data:  ctable.site
## X-squared = 202.27, df = 46, p-value < 2.2e-16
```

```
chisq.test(ctable.gender)
```

```
## Warning in chisq.test(ctable.gender): Chi-squared approximation may be
## incorrect
```

```
##
##  Pearson's Chi-squared test
##
## data:  ctable.gender
## X-squared = 6.3603, df = 4, p-value = 0.1738
```

As was easily apparent from examining the plots, the primary site the cell line is derived from is highly significant, while gender is not.

# 4 Dealing with multiple runs

`MCbiclust` is a stochastic method so for best results it needs to be run multiple times, in practice this means using high-performance computing the run the algorithm on a computer cluster which will be dealt with in a later section. Here however the task of dealing with the results will be looked at. The algorithm will be run \(100\) times with only \(500\) iterations each. Typically more iterations are required, but for this demonstration it will be sufficient.

```
CCLE.multi.seed <- list()
initial.seed1 <- list()

for(i in seq(100)){
  set.seed(i)
  initial.seed1[[i]] <- sample(seq(length = dim(CCLE_small)[2]),10)
  CCLE.multi.seed[[i]] <- FindSeed(gem = CCLE_small[c(501:1000), ],
                                   seed.size = 10,
                                   iterations = 500,
                                   initial.seed = initial.seed1[[i]])
}
```

The associated correlation vector must also be calculated for each run and these correlation vectors can be put into a matrix.

```
CCLE.cor.vec.multi <- list()

for(i in seq(100)){
  CCLE.cor.vec.multi[[i]] <- CVEval(gem.part = CCLE_small[c(501:1000), ],
                                    gem.all = CCLE_small,
                                    seed = CCLE.multi.seed[[i]],
                                    splits = 10)

}
```

```
len.a <- length(CCLE.cor.vec.multi[[1]])
len.b <- length(CCLE.cor.vec.multi)
multi.run.cor.vec.mat <- matrix(0,len.a,len.b)
for(i in 1:100){
  multi.run.cor.vec.mat[,i] <- CCLE.cor.vec.multi[[i]]
}
rm(CCLE.cor.vec.multi)
```

A correlation matrix can be formed from the correlation vectors, and in this way they can be viewed as a heatmap.

```
CV.cor.mat1 <- abs(cor((multi.run.cor.vec.mat)))
cor.dist <- function(c){as.dist(1 - abs(c))}

routput.corvec.matrix.cor.heat <- heatmap.2(CV.cor.mat1,
                                            trace="none",
                                            distfun = cor.dist)
```

![](data:image/png;base64...)

It needs to be known how many distinct patterns have been found, this is done with clustering and particular silhouette coefficients to judge what number of clusters is optimum within the data. Function `SilhouetteClustGroups` achieves this and uses hierarchical clustering to split the patterns into clusters, for comparison a randomly generated correlation vector is also added to allow for the possibility that all patterns found are best grouped into a single cluster.

```
multi.clust.groups <- SilhouetteClustGroups(multi.run.cor.vec.mat,
                                            max.clusters = 20,
                                            plots = TRUE,rand.vec = FALSE)
```

![](data:image/png;base64...)

```
## NULL
```

![](data:image/png;base64...)

```
## NULL
```

Here two clusters were found, and we can visualise this pattern (and any additional others found) with the function `CVPlot`, which highlights a chosen gene set, in this case the mitochondrial genes.

```
gene.names <- row.names(CCLE_small)
av.corvec.fun <- function(x) rowMeans(multi.run.cor.vec.mat[,x])
average.corvec <- lapply(X = multi.clust.groups,
                         FUN = av.corvec.fun)

CVPlot(cv.df = as.data.frame(average.corvec),
        geneset.loc = mito.loc,
        geneset.name = "Mitochondrial",
        alpha1 = 0.1)
```

```
## Warning: `aes_()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`
## ℹ The deprecated feature was likely used in the MCbiclust package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

As before can also calculate the gene set enrichment.

```
GOfun <- function(x) GOEnrichmentAnalysis(gene.names = gene.names,
                                          gene.values = x,
                                          sig.rate = 0.05)
```

```
corvec.gsea <- lapply(X = average.corvec,
                      FUN = GOfun)
```

Before using `SampleSort` a special prep function, `MultiSampleSortPrep` is used to generate the gene expression matrix and top seed for each found bicluster. The gene expression matrix is composed of the top \(n\) genes in the correlation vector, and the seed is chosen as the calculated seed that has the maximum correlation score.

```
CCLE.samp.multi.sort <- list()
multi.prep <- MultiSampleSortPrep(gem = CCLE_small,
                                  av.corvec = average.corvec,
                                  top.genes.num = 750,
                                  groups = multi.clust.groups,
                                  initial.seeds =  CCLE.multi.seed)
```

```
CCLE.samp.multi.sort[[1]] <- SampleSort(gem = multi.prep[[1]][[1]],
                                        seed = multi.prep[[2]][[1]])

CCLE.samp.multi.sort[[2]] <- SampleSort(gem = multi.prep[[1]][[2]],
                                        seed = multi.prep[[2]][[2]])
```

Note as before that these are long calculations.

These two biclusters can now be analysed in the same way as the single bicluster before.

To calculate the PC1 values:

```
pc1.vec.multi <- list()

pc1.vec.multi[[1]] <- PC1VecFun(top.gem =  multi.prep[[1]][[1]],
                     seed.sort = CCLE.samp.multi.sort[[1]], n = 10)
pc1.vec.multi[[2]] <- PC1VecFun(top.gem =  multi.prep[[1]][[2]],
                     seed.sort = CCLE.samp.multi.sort[[2]], n = 10)
```

These new biclusters can also be thresholded as follows:

```
CCLE.bic.multi <- list()
CCLE.bic.multi[[1]] <- ThresholdBic(cor.vec = average.corvec[[1]],
                         sort.order = CCLE.samp.multi.sort[[1]],
                         pc1 = pc1.vec.multi[[1]], samp.sig = 0.05)
CCLE.bic.multi[[2]] <- ThresholdBic(cor.vec = average.corvec[[2]],
                         sort.order = CCLE.samp.multi.sort[[2]],
                         pc1 = pc1.vec.multi[[2]], samp.sig = 0.05)

pc1.vec.multi[[1]] <- PC1Align(gem = CCLE_small, pc1 = pc1.vec.multi[[1]],
                    sort.order = CCLE.samp.multi.sort[[1]],
                    cor.vec = average.corvec[[1]], bic = CCLE.bic.multi[[1]])

pc1.vec.multi[[2]] <- PC1Align(gem = CCLE_small, pc1 = pc1.vec.multi[[2]],
                    sort.order = CCLE.samp.multi.sort[[2]],
                    cor.vec = average.corvec[[2]], bic = CCLE.bic.multi[[2]])
```

In a similar way to before the forks for these new biclusters can be plotted:

```
CCLE.multi.df <- data.frame(CCLE.name = colnames(CCLE_small),
           Bic1.order = order(CCLE.samp.multi.sort[[1]]),
           Bic2.order = order(CCLE.samp.multi.sort[[2]]),
           Bic1.PC1 = pc1.vec.multi[[1]][order(CCLE.samp.multi.sort[[1]])],
           Bic2.PC1 = pc1.vec.multi[[2]][order(CCLE.samp.multi.sort[[2]])])

CCLE.multi.df.samples <- inner_join(CCLE.multi.df,CCLE_samples,by="CCLE.name")

rare.sites <- names(which(summary(CCLE.multi.df.samples$Site.Primary) < 15))
CCLE.multi.df.samples$Site.Primary2 <- as.character(CCLE.multi.df.samples$Site.Primary)

rare.sites.loc <- which(CCLE.multi.df.samples$Site.Primary2 %in% rare.sites)
CCLE.multi.df.samples $Site.Primary2[rare.sites.loc] <- "Other"

ggplot(CCLE.multi.df.samples, aes(Bic1.order,Bic1.PC1)) +
  geom_point(aes(colour=factor(Site.Primary2))) + ylab("Bic1 PC1")
```

![](data:image/png;base64...)

```
ggplot(CCLE.multi.df.samples, aes(Bic2.order,Bic2.PC1)) +
  geom_point(aes(colour=factor(Site.Primary2))) + ylab("Bic2 PC1")
```

![](data:image/png;base64...)

One final thing that can be done is to compare all 3 correlation vectors found

```
cv.df <- as.data.frame(average.corvec)
cv.df$Mito1 <- CCLE.cor.vec

CVPlot(cv.df,cnames = c("R1","R2","M1"),
        geneset.loc = mito.loc,
        geneset.name = "Mitochondrial",
        alpha1 = 0.1)
```

![](data:image/png;base64...)

It is immediately apparent that the one of the biclusters found from the random gene set is very similar to that of the mitochondrial based bicluster.

# 5 Identifying samples related to a known bicluster in different data sets

Once a bicluster has been identified it might be desired to find samples that have the same regulation pattern in different data sets. One option would be to run MCbiclust independently on these data sets and attempt to find a similar bicluster based on the correlation vector values. This however is not always practical, for example if the data set in question contains relatively few samples.

There are however a few possible methods to score samples based on a known correlation pattern which are described here.

## 5.1 PointScore

The PointScore can be calculated using the CCLE.mito data set as follow, this utilises the differently regulated group uncovered with `HclustGenesHiCor` and the dendrogram produced from using `heatmap.2`.

```
gene.loc1 <- which(row.names(CCLE.mito[CCLE.hicor.genes,]) %in% CCLE.groups[[1]])
gene.loc2 <- which(row.names(CCLE.mito[CCLE.hicor.genes,]) %in% CCLE.groups[[2]])

CCLE.ps <- PointScoreCalc(CCLE.mito[CCLE.hicor.genes,], gene.loc1, gene.loc2)
```

The PointScore can be directly compared with the PC1 values

```
CCLE.df$PointScore <- CCLE.ps[CCLE.samp.sort]

ggplot(CCLE.df, aes(Order,PC1)) +
  geom_point(aes(colour = Fork)) + ylab("PC1")
```

![](data:image/png;base64...)

```
ggplot(CCLE.df, aes(Order,PointScore)) +
  geom_point(aes(colour = Fork)) + ylab("PointScore")
```

![](data:image/png;base64...)

## 5.2 ssGSEA

For single samples an alternative method must be used. One described in literature is that of single sample GSEA or ssGSEA (Barbie et al. ([2009](#ref-barbie2009systematic))). This can be calculated with the R package `GSVA` (Hänzelmann, Castelo, and Guinney ([2013](#ref-hanzelmann2013gsva))), the ssGSEA score of the two gene sets can be calculated, the final ssGSEA of these two groups combines is the mean of the first group and the negative value of the second group.

```
# library(GSVA)
#
# ssGSEA.test <- gsva(expr = as.matrix(CCLE.mito[CCLE.hicor.genes,]),
#                     gset.idx.list = CCLE.groups,
#                     method = 'gsva',
#                     parallel.sz = 1)
# ssGSEA.test[2,] <- -ssGSEA.test[2,]
# CCLE.ssGSEA <- colMeans(ssGSEA.test)
```

Similarly to the PointScore it can be directly compared to the PC1 values.

```
# CCLE.df$ssGSEA <- CCLE.ssGSEA[CCLE.samp.sort]
#
# ggplot(CCLE.df, aes(Order, PC1)) +
#   geom_point(aes(colour = Fork)) + ylab("PC1")
# ggplot(CCLE.df, aes(Order, ssGSEA)) +
#   geom_point(aes(colour = Fork)) + ylab("ssGSEA")
```

Note that while the PointScore created a very clean fork, the ssGSEA was much noisier. In general the bigger the data set the more accurate the PointScore will be, while ssGSEA is useful for analysing very small datasets or even single samples.

# Session Info

```
devtools::session_info()
```

```
## ─ Session info ───────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.5.1 Patched (2025-08-23 r88802)
##  os       Ubuntu 24.04.3 LTS
##  system   x86_64, linux-gnu
##  ui       X11
##  language (EN)
##  collate  C
##  ctype    en_US.UTF-8
##  tz       America/New_York
##  date     2025-10-30
##  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
##  quarto   1.7.32 @ /usr/local/bin/quarto
##
## ─ Packages ───────────────────────────────────────────────────────────────────
##  package        * version date (UTC) lib source
##  AnnotationDbi    1.72.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  backports        1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
##  base64enc        0.1-3   2015-07-28 [2] CRAN (R 4.5.1)
##  Biobase          2.70.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocGenerics     0.56.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocManager      1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
##  BiocParallel     1.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocStyle      * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  Biostrings       2.78.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bit              4.6.0   2025-03-06 [2] CRAN (R 4.5.1)
##  bit64            4.6.0-1 2025-01-16 [2] CRAN (R 4.5.1)
##  bitops           1.0-9   2024-10-03 [2] CRAN (R 4.5.1)
##  blob             1.2.4   2023-03-17 [2] CRAN (R 4.5.1)
##  bookdown         0.45    2025-10-03 [2] CRAN (R 4.5.1)
##  bslib            0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
##  cachem           1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
##  caTools          1.18.3  2024-09-04 [2] CRAN (R 4.5.1)
##  checkmate        2.3.3   2025-08-18 [2] CRAN (R 4.5.1)
##  cli              3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
##  cluster          2.1.8.1 2025-03-12 [3] CRAN (R 4.5.1)
##  codetools        0.2-20  2024-03-31 [3] CRAN (R 4.5.1)
##  colorspace       2.1-2   2025-09-22 [2] CRAN (R 4.5.1)
##  crayon           1.5.3   2024-06-20 [2] CRAN (R 4.5.1)
##  data.table       1.17.8  2025-07-10 [2] CRAN (R 4.5.1)
##  DBI              1.2.3   2024-06-02 [2] CRAN (R 4.5.1)
##  devtools       * 2.4.6   2025-10-03 [2] CRAN (R 4.5.1)
##  dichromat        2.0-0.1 2022-05-02 [2] CRAN (R 4.5.1)
##  digest           0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
##  doParallel       1.0.17  2022-02-07 [2] CRAN (R 4.5.1)
##  dplyr          * 1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
##  dynamicTreeCut   1.63-1  2016-03-11 [2] CRAN (R 4.5.1)
##  ellipsis         0.3.2   2021-04-29 [2] CRAN (R 4.5.1)
##  evaluate         1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
##  farver           2.1.2   2024-05-13 [2] CRAN (R 4.5.1)
##  fastcluster      1.3.0   2025-05-07 [2] CRAN (R 4.5.1)
##  fastmap          1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
##  foreach          1.5.2   2022-02-02 [2] CRAN (R 4.5.1)
##  foreign          0.8-90  2025-03-31 [3] CRAN (R 4.5.1)
##  Formula          1.2-5   2023-02-24 [2] CRAN (R 4.5.1)
##  fs               1.6.6   2025-04-12 [2] CRAN (R 4.5.1)
##  generics         0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
##  GGally           2.4.0   2025-08-23 [2] CRAN (R 4.5.1)
##  ggplot2        * 4.0.0   2025-09-11 [2] CRAN (R 4.5.1)
##  ggstats          0.11.0  2025-09-15 [2] CRAN (R 4.5.1)
##  glue             1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
##  GO.db            3.22.0  2025-10-08 [2] Bioconductor
##  gplots         * 3.2.0   2024-10-05 [2] CRAN (R 4.5.1)
##  gProfileR      * 0.7.0   2019-11-04 [2] CRAN (R 4.5.1)
##  gridExtra        2.3     2017-09-09 [2] CRAN (R 4.5.1)
##  gtable           0.3.6   2024-10-25 [2] CRAN (R 4.5.1)
##  gtools           3.9.5   2023-11-20 [2] CRAN (R 4.5.1)
##  Hmisc            5.2-4   2025-10-05 [2] CRAN (R 4.5.1)
##  htmlTable        2.4.3   2024-07-21 [2] CRAN (R 4.5.1)
##  htmltools        0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
##  htmlwidgets      1.6.4   2023-12-06 [2] CRAN (R 4.5.1)
##  httr             1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
##  impute           1.84.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  IRanges          2.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  iterators        1.0.14  2022-02-05 [2] CRAN (R 4.5.1)
##  jquerylib        0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
##  jsonlite         2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
##  KEGGREST         1.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  KernSmooth       2.23-26 2025-01-01 [3] CRAN (R 4.5.1)
##  knitr            1.50    2025-03-16 [2] CRAN (R 4.5.1)
##  labeling         0.4.3   2023-08-29 [2] CRAN (R 4.5.1)
##  lattice          0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
##  lifecycle        1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
##  magick           2.9.0   2025-09-08 [2] CRAN (R 4.5.1)
##  magrittr         2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
##  MASS           * 7.3-65  2025-02-28 [3] CRAN (R 4.5.1)
##  Matrix           1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
##  matrixStats      1.5.0   2025-01-07 [2] CRAN (R 4.5.1)
##  MCbiclust      * 1.34.0  2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
##  memoise          2.0.1   2021-11-26 [2] CRAN (R 4.5.1)
##  nnet             7.3-20  2025-01-01 [3] CRAN (R 4.5.1)
##  org.Hs.eg.db     3.22.0  2025-10-08 [2] Bioconductor
##  pander           0.6.6   2025-03-01 [2] CRAN (R 4.5.1)
##  pillar           1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
##  pkgbuild         1.4.8   2025-05-26 [2] CRAN (R 4.5.1)
##  pkgconfig        2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
##  pkgload          1.4.1   2025-09-23 [2] CRAN (R 4.5.1)
##  png              0.1-8   2022-11-29 [2] CRAN (R 4.5.1)
##  preprocessCore   1.72.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  purrr            1.1.0   2025-07-10 [2] CRAN (R 4.5.1)
##  R6               2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
##  RColorBrewer     1.1-3   2022-04-03 [2] CRAN (R 4.5.1)
##  Rcpp             1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
##  remotes          2.5.0   2024-03-17 [2] CRAN (R 4.5.1)
##  rlang            1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
##  rmarkdown        2.30    2025-09-28 [2] CRAN (R 4.5.1)
##  rpart            4.1.24  2025-01-07 [3] CRAN (R 4.5.1)
##  RSQLite          2.4.3   2025-08-20 [2] CRAN (R 4.5.1)
##  rstudioapi       0.17.1  2024-10-22 [2] CRAN (R 4.5.1)
##  S4Vectors        0.48.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S7               0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
##  sass             0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
##  scales           1.4.0   2025-04-24 [2] CRAN (R 4.5.1)
##  Seqinfo          1.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  sessioninfo      1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
##  stringi          1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
##  stringr          1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
##  survival         3.8-3   2024-12-17 [3] CRAN (R 4.5.1)
##  tibble           3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
##  tidyr            1.3.1   2024-01-24 [2] CRAN (R 4.5.1)
##  tidyselect       1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
##  tinytex          0.57    2025-04-15 [2] CRAN (R 4.5.1)
##  usethis        * 3.2.1   2025-09-06 [2] CRAN (R 4.5.1)
##  vctrs            0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
##  WGCNA            1.73    2024-09-18 [2] CRAN (R 4.5.1)
##  withr            3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
##  xfun             0.53    2025-08-19 [2] CRAN (R 4.5.1)
##  XVector          0.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  yaml             2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
##
##  [1] /tmp/RtmpnGucN7/Rinst166fbb4c12e894
##  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
##  [3] /home/biocbuild/bbs-3.22-bioc/R/library
##  * ── Packages attached to the search path.
##
## ──────────────────────────────────────────────────────────────────────────────
```

# References

Barbie, David A, Pablo Tamayo, Jesse S Boehm, So Young Kim, Susan E Moody, Ian F Dunn, Anna C Schinzel, et al. 2009. “Systematic Rna Interference Reveals That Oncogenic Kras-Driven Cancers Require Tbk1.” *Nature* 462 (7269): 108.

Barretina, Jordi, Giordano Caponigro, Nicolas Stransky, Kavitha Venkatesan, Adam A Margolin, Sungjoon Kim, Christopher J Wilson, et al. 2012. “The Cancer Cell Line Encyclopedia Enables Predictive Modelling of Anticancer Drug Sensitivity.” *Nature* 483 (7391): 603–7.

Hänzelmann, Sonja, Robert Castelo, and Justin Guinney. 2013. “GSVA: Gene Set Variation Analysis for Microarray and Rna-Seq Data.” *BMC Bioinformatics* 14 (1): 7.

Pagliarini, David J, Sarah E Calvo, Betty Chang, Sunil A Sheth, Scott B Vafai, Shao-En Ong, Geoffrey A Walford, et al. 2008. “A Mitochondrial Protein Compendium Elucidates Complex I Disease Biology.” *Cell* 134 (1): 112–23.