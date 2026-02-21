# Using scran to analyze single-cell RNA-seq data

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: 1 November 2019

#### Package

scran 1.38.0

# 1 Introduction

Single-cell RNA sequencing (scRNA-seq) is a widely used technique for profiling gene expression in individual cells.
This allows molecular biology to be studied at a resolution that cannot be matched by bulk sequencing of cell populations.
The *[scran](https://bioconductor.org/packages/3.22/scran)* package implements methods to perform low-level processing of scRNA-seq data,
including cell cycle phase assignment, variance modelling and testing for marker genes and gene-gene correlations.
This vignette provides brief descriptions of these methods and some toy examples to demonstrate their use.

**Note:** A more comprehensive description of the use of *[scran](https://bioconductor.org/packages/3.22/scran)* (along with other packages) in a scRNA-seq analysis workflow is available at <https://osca.bioconductor.org>.

# 2 Setting up the data

We start off with a count matrix where each row is a gene and each column is a cell.
These can be obtained by mapping read sequences to a reference genome, and then counting the number of reads mapped to the exons of each gene.
(See, for example, the *[Rsubread](https://bioconductor.org/packages/3.22/Rsubread)* package to do both of these tasks.)
Alternatively, pseudo-alignment methods can be used to quantify the abundance of each transcript in each cell.
For simplicity, we will pull out an existing dataset from the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package.

```
library(scRNAseq)
sce <- GrunPancreasData()
sce
```

```
## class: SingleCellExperiment
## dim: 20064 1728
## metadata(0):
## assays(1): counts
## rownames(20064): A1BG-AS1__chr19 A1BG__chr19 ... ZZEF1__chr17
##   ZZZ3__chr1
## rowData names(2): symbol chr
## colnames(1728): D2ex_1 D2ex_2 ... D17TGFB_95 D17TGFB_96
## colData names(2): donor sample
## reducedDimNames(0):
## mainExpName: endogenous
## altExpNames(1): ERCC
```

This particular dataset is taken from a study of the human pancreas with the CEL-seq protocol (Grun et al. [2016](#ref-grun2016denovo)).
It is provided as a `SingleCellExperiment` object (from the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* package), which contains the raw data and various annotations.
We perform some cursory quality control to remove cells with low total counts or high spike-in percentages:

```
library(scuttle)
qcstats <- perCellQCMetrics(sce)
qcfilter <- quickPerCellQC(qcstats, percent_subsets="altexps_ERCC_percent")
sce <- sce[,!qcfilter$discard]
summary(qcfilter$discard)
```

```
##    Mode   FALSE    TRUE
## logical    1291     437
```

Cell-specific biases are normalized using the `computeSumFactors` method, which implements the deconvolution strategy for scaling normalization (Lun, Bach, and Marioni [2016](#ref-lun2016pooling)).

```
library(scran)
clusters <- quickCluster(sce)
sce <- computeSumFactors(sce, clusters=clusters)
summary(sizeFactors(sce))
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
## 0.006722 0.442629 0.801312 1.000000 1.295809 9.227575
```

```
sce <- logNormCounts(sce)
```

# 3 Variance modelling

We identify genes that drive biological heterogeneity in the data set by modelling the per-gene variance.
By only using a subset of highly variable genes in downstream analyses like clustering, we improve resolution of biological structure by removing uninteresting genes driven by technical noise.
We decompose the total variance of each gene into its biological and technical components by fitting a trend to the endogenous variances (Lun, McCarthy, and Marioni [2016](#ref-lun2016step)).
The fitted value of the trend is used as an estimate of the technical component, and we subtract the fitted value from the total variance to obtain the biological component for each gene.

```
dec <- modelGeneVar(sce)
plot(dec$mean, dec$total, xlab="Mean log-expression", ylab="Variance")
curve(metadata(dec)$trend(x), col="blue", add=TRUE)
```

![](data:image/png;base64...)

If we have spike-ins, we can use them to fit the trend instead.
This provides a more direct estimate of the technical variance and avoids assuming that most genes do not exhibit biological variaility.

```
dec2 <- modelGeneVarWithSpikes(sce, 'ERCC')
plot(dec2$mean, dec2$total, xlab="Mean log-expression", ylab="Variance")
points(metadata(dec2)$mean, metadata(dec2)$var, col="red")
curve(metadata(dec2)$trend(x), col="blue", add=TRUE)
```

![](data:image/png;base64...)

If we have some uninteresting factors of variation, we can block on these using `block=`.
This will perform the trend fitting and decomposition within each block before combining the statistics across blocks for output.
Statistics for each individual block can also be extracted for further inspection.

```
# Turned off weighting to avoid overfitting for each donor.
dec3 <- modelGeneVar(sce, block=sce$donor, density.weights=FALSE)
per.block <- dec3$per.block
par(mfrow=c(3, 2))
for (i in seq_along(per.block)) {
    decX <- per.block[[i]]
    plot(decX$mean, decX$total, xlab="Mean log-expression",
        ylab="Variance", main=names(per.block)[i])
    curve(metadata(decX)$trend(x), col="blue", add=TRUE)
}
```

![](data:image/png;base64...)

We can then extract some top genes for use in downstream procedures using the `getTopHVGs()` function.
A variety of different strategies can be used to define a subset of interesting genes:

```
# Get the top 10% of genes.
top.hvgs <- getTopHVGs(dec, prop=0.1)

# Get the top 2000 genes.
top.hvgs2 <- getTopHVGs(dec, n=2000)

# Get all genes with positive biological components.
top.hvgs3 <- getTopHVGs(dec, var.threshold=0)

# Get all genes with FDR below 5%.
top.hvgs4 <- getTopHVGs(dec, fdr.threshold=0.05)
```

The selected subset of genes can then be passed to the `subset.row` argument (or equivalent) in downstream steps.
This process is demonstrated below for the PCA step:

```
sce <- fixedPCA(sce, subset.row=top.hvgs)
reducedDimNames(sce)
```

```
## [1] "PCA"
```

# 4 Automated PC choice

Principal components analysis is commonly performed to denoise and compact the data prior to downstream analysis.
A common question is how many PCs to retain; more PCs will capture more biological signal at the cost of retaining more noise and requiring more computational work.
One approach to choosing the number of PCs is to use the technical component estimates to determine the proportion of variance that should be retained.
This is implemented in `denoisePCA()`, which takes the estimates returned by `modelGeneVar()` or friends.
(For greater accuracy, we use the fit with the spikes; we also subset to only the top HVGs to remove noise.)

```
sced <- denoisePCA(sce, dec2, subset.row=getTopHVGs(dec2, prop=0.1))
ncol(reducedDim(sced, "PCA"))
```

```
## [1] 50
```

Another approach is based on the assumption that each subpopulation should be separated from each other on a different axis of variation.
Thus, we choose the number of PCs that is not less than the number of subpopulations (which are unknown, of course, so we use the number of clusters as a proxy).
It is then a simple matter to subset the dimensionality reduction result to the desired number of PCs.

```
output <- getClusteredPCs(reducedDim(sce))
npcs <- metadata(output)$chosen
reducedDim(sce, "PCAsub") <- reducedDim(sce, "PCA")[,1:npcs,drop=FALSE]
npcs
```

```
## [1] 14
```

# 5 Graph-based clustering

Clustering of scRNA-seq data is commonly performed with graph-based methods due to their relative scalability and robustness.
*[scran](https://bioconductor.org/packages/3.22/scran)* provides several graph construction methods based on shared nearest neighbors (Xu and Su [2015](#ref-xu2015identification)) through the `buildSNNGraph()` function.
This is most commonly generated from the selected PCs, after which community detection methods from the *[igraph](https://CRAN.R-project.org/package%3Digraph)* package can be used to explicitly identify clusters.

```
# In this case, using the PCs that we chose from getClusteredPCs().
g <- buildSNNGraph(sce, use.dimred="PCAsub")
cluster <- igraph::cluster_walktrap(g)$membership

# Assigning to the 'colLabels' of the 'sce'.
colLabels(sce) <- factor(cluster)
table(colLabels(sce))
```

```
##
##   1   2   3   4   5   6   7   8   9  10  11  12
##  79 285  64 170 166 164 124  32  57  63  63  24
```

By default, `buildSNNGraph()` uses the mode of shared neighbor weighting described by Xu and Su ([2015](#ref-xu2015identification)), but other weighting methods (e.g., the Jaccard index) are also available by setting `type=`.
An unweighted \(k\)-nearest neighbor graph can also be constructed with `buildKNNGraph()`.

We can then use methods from *[scater](https://bioconductor.org/packages/3.22/scater)* to visualize this clustering on a \(t\)-SNE plot.
Note that `colLabels()<-` will just add the cluster assignments to the `"label"` field of the `colData`;
however, any name can be used as long as downstream functions are adjusted appropriately.

```
library(scater)
sce <- runTSNE(sce, dimred="PCAsub")
plotTSNE(sce, colour_by="label", text_by="label")
```

![](data:image/png;base64...)

For graph-based methods, another diagnostic is to examine the ratio of observed to expected edge weights for each pair of clusters (closely related to the modularity score used in many `cluster_*` functions).
We would usually expect to see high observed weights between cells in the same cluster with minimal weights between clusters, indicating that the clusters are well-separated.
Off-diagonal entries indicate that some clusters are closely related, which is useful to know for checking that they are annotated consistently.

```
library(bluster)
ratio <- pairwiseModularity(g, cluster, as.ratio=TRUE)

library(pheatmap)
pheatmap(log10(ratio+1), cluster_cols=FALSE, cluster_rows=FALSE,
    col=rev(heat.colors(100)))
```

![](data:image/png;base64...)

A more general diagnostic involves bootstrapping to determine the stability of the partitions between clusters.
Given a clustering function, the `bootstrapCluster()` function uses bootstrapping to compute the co-assignment probability for each pair of original clusters, i.e., the probability that one randomly chosen cell from each cluster is assigned to the same cluster in the bootstrap replicate .
Larger probabilities indicate that the separation between those clusters is unstable to the extent that it is sensitive to sampling noise, and thus should not be used for downstream inferences.

```
ass.prob <- bootstrapStability(sce, FUN=function(x) {
    g <- buildSNNGraph(x, use.dimred="PCAsub")
    igraph::cluster_walktrap(g)$membership
}, clusters=sce$cluster)

pheatmap(ass.prob, cluster_cols=FALSE, cluster_rows=FALSE,
    col=colorRampPalette(c("white", "blue"))(100))
```

![](data:image/png;base64...)

If necessary, further subclustering can be performed conveniently using the `quickSubCluster()` wrapper function.
This splits the input `SingleCellExperiment` into several smaller objects containing cells from each cluster and performs another round of clustering within that cluster, using a freshly identified set of HVGs to improve resolution for internal structure.

```
subout <- quickSubCluster(sce, groups=colLabels(sce))
table(metadata(subout)$subcluster) # formatted as '<parent>.<subcluster>'
```

```
##
##  1.1  1.2 10.1 10.2 10.3 11.1 11.2   12  2.1  2.2  2.3  2.4  3.1  3.2  3.3  4.1
##   38   41   16   19   28   29   34   24   96   35   81   73   26   19   19   30
##  4.2  4.3  4.4  5.1  5.2  6.1  6.2  6.3  7.1  7.2  7.3    8  9.1  9.2
##   62   40   38   73   93   64   65   35   35   35   54   32   33   24
```

# 6 Identifying marker genes

The `scoreMarkers()` wrapper function will perform differential expression comparisons between pairs of clusters to identify potential marker genes.
For each pairwise comparison, we compute a variety of effect sizes to quantify the differences between those clusters.

* Cohen’s \(d\) is a standardized log-fold change, representing the number of standard deviations that separate the means of two groups.
  This is analogous to the \(t\)-statistic in Student’s \(t\)-test.
* The area under the curve (AUC) is the probability that a randomly chosen observation from one group is greater than a random observation from another group.
  This is proportional to the U-statistic from the Wilcoxon ranked sum test.
* We also compute the log-fold change in the proportion of cells with detectable (i.e., non-zero) expression.

For each cluster, we then summarize the effect sizes from all comparisons to other clusters.
Specifically, we compute the mean, median, minimum and maximum effect size across all comparisons.
This yields a series of statistics for each effect size and summary type, e.g., `mean.AUC`.

```
# Uses clustering information from 'colLabels(sce)' by default:
markers <- scoreMarkers(sce)
markers
```

```
## List of length 12
## names(12): 1 2 3 4 5 6 7 8 9 10 11 12
```

```
colnames(markers[[1]])
```

```
##  [1] "self.average"          "other.average"         "self.detected"
##  [4] "other.detected"        "mean.logFC.cohen"      "min.logFC.cohen"
##  [7] "median.logFC.cohen"    "max.logFC.cohen"       "rank.logFC.cohen"
## [10] "mean.AUC"              "min.AUC"               "median.AUC"
## [13] "max.AUC"               "rank.AUC"              "mean.logFC.detected"
## [16] "min.logFC.detected"    "median.logFC.detected" "max.logFC.detected"
## [19] "rank.logFC.detected"
```

The idea is to use this information to sort the `DataFrame` for each cluster based on one of these metrics to obtain a ranking of the strongest candidate markers.
A good default approach is to sort by either the mean AUC or Cohen’s \(d\) in decreasing order.
This focuses on marker genes that are upregulated in the cluster of interest compared to most other clusters (hopefully).
For example, we can get a quick summary of the best markers for cluster 1 using the code below:

```
# Just showing the first few columns for brevity.
markers[[1]][order(markers[[1]]$mean.AUC, decreasing=TRUE),1:4]
```

```
## DataFrame with 20064 rows and 4 columns
##                 self.average other.average self.detected other.detected
##                    <numeric>     <numeric>     <numeric>      <numeric>
## UGDH-AS1__chr4       7.95736       2.97892      1.000000       0.916095
## KCNQ1OT1__chr11      8.63439       3.86267      1.000000       0.977219
## PGM5P2__chr9         5.93842       1.37177      0.987342       0.629164
## MAB21L3__chr1        6.52394       2.07597      0.987342       0.808723
## FBLIM1__chr1         5.05717       1.39738      0.987342       0.700471
## ...                      ...           ...           ...            ...
## SKP1__chr5          0.526165       1.91257      0.329114       0.827098
## EIF1__chr17         1.453564       3.41013      0.506329       0.943458
## RPL3__chr22         1.606360       3.67678      0.544304       0.963845
## RPS25__chr11        1.400783       3.43745      0.493671       0.962767
## GNAS__chr20         1.295445       3.99483      0.493671       0.941651
```

The other summaries provide additional information about the comparisons to other clusters without requiring examination of all pairwise changes.
For example, a positive median AUC means that the gene is upregulated in this cluster against most (i.e., at least 50%) of the other clusters.
A positive minimum AUC means that the gene is upregulated against *all* other clusters, while a positive maximum AUC indicates upregulation against at least one other cluster.
It can be helpful to sort on the median instead, if the mean is too sensitive to outliers;
or to sort on the minimum, if we wish to identify genes that are truly unique to a particular cluster.

That said, if the full set of pairwise effects is desired, we can obtain them with `full.stats=TRUE`.
This yields a nested `DataFrame` containing the effects from each pairwise comparison to another cluster.

```
markers <- scoreMarkers(sce, full.stats=TRUE)
markers[[1]]$full.logFC.cohen
```

```
## DataFrame with 20064 rows and 11 columns
##                         2          3         4          5         6          7
##                 <numeric>  <numeric> <numeric>  <numeric> <numeric>  <numeric>
## A1BG-AS1__chr19  0.193192   0.193192  0.193192  0.1511082  0.193192  0.1931922
## A1BG__chr19     -0.383283  -0.810316  0.012951 -1.1128084  0.162714 -1.0253400
## A1CF__chr10     -0.150129  -0.553733  0.451479 -0.7289524  0.361270  0.1736118
## A2M-AS1__chr12   0.185977  -0.119582  0.277078  0.0826094  0.277078  0.0205016
## A2ML1__chr12     0.492297   0.348947  0.528591  0.5659760  0.554566  0.5659760
## ...                   ...        ...       ...        ...       ...        ...
## ZYG11A__chr1     0.618620  0.5733540  0.539024   0.644377  0.681953   0.681953
## ZYG11B__chr1     1.535652  1.1280983  1.391627   1.756829  1.601884   1.659232
## ZYX__chr7       -0.221250  0.2823101 -0.349240   0.238468 -0.589359   0.295469
## ZZEF1__chr17    -0.509875 -0.0383699 -0.375748  -0.388188 -0.394200  -0.640098
## ZZZ3__chr1      -0.433631 -0.2503621 -0.341861  -0.361327 -0.344299  -0.522964
##                         8          9        10         11        12
##                 <numeric>  <numeric> <numeric>  <numeric> <numeric>
## A1BG-AS1__chr19  0.193192 -0.0847779  0.193192  0.1931922  0.193192
## A1BG__chr19     -0.960358  0.2744821 -0.929347 -0.7301001 -1.356154
## A1CF__chr10     -0.327091  0.1862410  0.390848 -0.2785467  0.570966
## A2M-AS1__chr12   0.277078  0.2770778 -0.105477 -0.0741515  0.277078
## A2ML1__chr12     0.525356  0.4527881  0.493265  0.5659760  0.565976
## ...                   ...        ...       ...        ...       ...
## ZYG11A__chr1     0.681953  0.3991683  0.681953   0.616473  0.593276
## ZYG11B__chr1     1.714765  1.3265656  1.539204   1.579707  1.574035
## ZYX__chr7        0.329949  0.0333088  0.155112   0.299053 -1.385087
## ZZEF1__chr17    -0.380311 -0.1101065 -0.614079  -0.544608 -0.370839
## ZZZ3__chr1      -0.183771 -0.3009860 -0.440704  -0.433413 -0.321751
```

In addition, we report some basic descriptive statistics such as the mean log-expression in each cluster and the proportion of cells with detectable expression.
The grand mean of these values across all *other* clusters is also reported.
Note that, because we use a grand mean, we are unaffected by differences in the number of cells between clusters;
the same applies for our effect sizes as they are computed by summarizing pairwise comparisons rather than by aggregating cells from all other clusters into a single group.

# 7 Detecting correlated genes

Another useful procedure is to identify significant pairwise correlations between pairs of HVGs.
The idea is to distinguish between HVGs caused by random stochasticity, and those that are driving systematic heterogeneity, e.g., between subpopulations.
Correlations are computed by the `correlatePairs` method using a slightly modified version of Spearman’s rho,
tested against the null hypothesis of zero correlation using the same method in `cor.test()`.

```
# Using the first 200 HVs, which are the most interesting anyway.
of.interest <- top.hvgs[1:200]
cor.pairs <- correlatePairs(sce, subset.row=of.interest)
cor.pairs
```

```
## DataFrame with 19900 rows and 5 columns
##                 gene1          gene2          rho      p.value          FDR
##           <character>    <character>    <numeric>    <numeric>    <numeric>
## 1     KCNQ1OT1__chr11 UGDH-AS1__chr4     0.830625  0.00000e+00  0.00000e+00
## 2           CPE__chr4    SCG5__chr15     0.813664 6.05366e-306 6.02339e-302
## 3         CHGA__chr14    SCG5__chr15     0.808313 7.64265e-299 5.06963e-295
## 4           GCG__chr2     TTR__chr18     0.803692 6.86304e-293 3.41436e-289
## 5         CHGB__chr20      CPE__chr4     0.802498 2.23623e-291 8.90020e-288
## ...               ...            ...          ...          ...          ...
## 19896      ELF3__chr1 METTL21A__chr2  3.83996e-05     0.998900     0.999101
## 19897      EGR1__chr5    NPTX2__chr7 -2.94559e-05     0.999156     0.999307
## 19898     ODF2L__chr1      VGF__chr7 -2.25268e-05     0.999355     0.999455
## 19899 LOC90834__chr22  SLC30A8__chr8  1.99362e-05     0.999429     0.999479
## 19900       IL8__chr4    UGGT1__chr2  1.20185e-05     0.999656     0.999656
```

As with variance estimation, if uninteresting substructure is present, this should be blocked on using the `block=` argument.
This avoids strong correlations due to the blocking factor.

```
cor.pairs2 <- correlatePairs(sce, subset.row=of.interest, block=sce$donor)
```

The pairs can be used for choosing marker genes in experimental validation, and to construct gene-gene association networks.
In other situations, the pairs may not be of direct interest - rather, we just want to know whether a gene is correlated with any other gene.
This is often the case if we are to select a set of correlated HVGs for use in downstream steps like clustering or dimensionality reduction.
To do so, we use `correlateGenes()` to compute a single set of statistics for each gene, rather than for each pair.

```
cor.genes <- correlateGenes(cor.pairs)
cor.genes
```

```
## DataFrame with 200 rows and 4 columns
##                gene       rho      p.value          FDR
##         <character> <numeric>    <numeric>    <numeric>
## 1   KCNQ1OT1__chr11  0.830625  0.00000e+00  0.00000e+00
## 2         CPE__chr4  0.813664 1.20468e-303 6.02339e-302
## 3       CHGA__chr14  0.808313 1.52089e-296 6.08355e-295
## 4         GCG__chr2  0.803692 1.36575e-290 3.90213e-289
## 5       CHGB__chr20  0.802498 4.45010e-289 1.11252e-287
## ...             ...       ...          ...          ...
## 196     MT2A__chr16  0.500325  1.99987e-80  2.89836e-80
## 197     XBP1__chr22  0.480748  2.50500e-73  3.43151e-73
## 198    BCYRN1__chrX  0.190429  1.04363e-09  1.04363e-09
## 199  ZFP36L1__chr14  0.589179 3.38722e-119 6.45185e-119
## 200   ZNF793__chr19  0.389342  1.09851e-45  1.24831e-45
```

Significant correlations are defined at a false discovery rate (FDR) threshold of, e.g., 5%.
Note that the p-values are calculated by permutation and will have a lower bound.
If there were insufficient permutation iterations, a warning will be issued suggesting that more iterations be performed.

# 8 Converting to other formats

The `SingleCellExperiment` object can be easily converted into other formats using the `convertTo` method.
This allows analyses to be performed using other pipelines and packages.
For example, if DE analyses were to be performed using *[edgeR](https://bioconductor.org/packages/3.22/edgeR)*, the count data in `sce` could be used to construct a `DGEList`.

```
y <- convertTo(sce, type="edgeR")
```

By default, rows corresponding to spike-in transcripts are dropped when `get.spikes=FALSE`.
As such, the rows of `y` may not correspond directly to the rows of `sce` – users should match by row name to ensure correct cross-referencing between objects.
Normalization factors are also automatically computed from the size factors.

The same conversion strategy roughly applies to the other supported formats.
DE analyses can be performed using *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* by converting the object to a `DESeqDataSet`.
Cells can be ordered on pseudotime with *[monocle](https://bioconductor.org/packages/3.22/monocle)* by converting the object to a `CellDataSet` (in this case, normalized *unlogged* expression values are stored).

# 9 Getting help

Further information can be obtained by examining the documentation for each function (e.g., `?convertTo`);
reading the [Orchestrating Single Cell Analysis](https://osca.bioconductor.org) book;
or asking for help on the Bioconductor [support site](http://support.bioconductor.org) (please read the [posting guide](http://www.bioconductor.org/help/support/posting-guide) beforehand).

# 10 Session information

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
##  [1] pheatmap_1.0.13             bluster_1.20.0
##  [3] scater_1.38.0               ggplot2_4.0.0
##  [5] scRNAseq_2.23.1             BiocParallel_1.44.0
##  [7] scran_1.38.0                scuttle_1.20.0
##  [9] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           knitr_1.50
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       jsonlite_2.0.0           magrittr_2.0.4
##   [4] ggbeeswarm_0.7.2         magick_2.9.0             GenomicFeatures_1.62.0
##   [7] gypsum_1.6.0             farver_2.1.2             rmarkdown_2.30
##  [10] BiocIO_1.20.0            vctrs_0.6.5              memoise_2.0.1
##  [13] Rsamtools_2.26.0         RCurl_1.98-1.17          tinytex_0.57
##  [16] htmltools_0.5.8.1        S4Arrays_1.10.0          AnnotationHub_4.0.0
##  [19] curl_7.0.0               BiocNeighbors_2.4.0      Rhdf5lib_1.32.0
##  [22] SparseArray_1.10.0       rhdf5_2.54.0             sass_0.4.10
##  [25] alabaster.base_1.10.0    bslib_0.9.0              alabaster.sce_1.10.0
##  [28] httr2_1.2.1              cachem_1.1.0             GenomicAlignments_1.46.0
##  [31] igraph_2.2.1             lifecycle_1.0.4          pkgconfig_2.0.3
##  [34] rsvd_1.0.5               Matrix_1.7-4             R6_2.6.1
##  [37] fastmap_1.2.0            digest_0.6.37            AnnotationDbi_1.72.0
##  [40] dqrng_0.4.1              irlba_2.3.5.1            ExperimentHub_3.0.0
##  [43] RSQLite_2.4.3            beachmat_2.26.0          labeling_0.4.3
##  [46] filelock_1.0.3           httr_1.4.7               abind_1.4-8
##  [49] compiler_4.5.1           withr_3.0.2              bit64_4.6.0-1
##  [52] S7_0.2.0                 viridis_0.6.5            DBI_1.2.3
##  [55] HDF5Array_1.38.0         alabaster.ranges_1.10.0  alabaster.schemas_1.10.0
##  [58] rappdirs_0.3.3           DelayedArray_0.36.0      rjson_0.2.23
##  [61] tools_4.5.1              vipor_0.4.7              beeswarm_0.4.0
##  [64] glue_1.8.0               h5mread_1.2.0            restfulr_0.0.16
##  [67] rhdf5filters_1.22.0      grid_4.5.1               Rtsne_0.17
##  [70] cluster_2.1.8.1          gtable_0.3.6             ensembldb_2.34.0
##  [73] BiocSingular_1.26.0      ScaledMatrix_1.18.0      metapod_1.18.0
##  [76] XVector_0.50.0           ggrepel_0.9.6            BiocVersion_3.22.0
##  [79] pillar_1.11.1            limma_3.66.0             dplyr_1.1.4
##  [82] BiocFileCache_3.0.0      lattice_0.22-7           rtracklayer_1.70.0
##  [85] bit_4.6.0                tidyselect_1.2.1         locfit_1.5-9.12
##  [88] Biostrings_2.78.0        gridExtra_2.3            bookdown_0.45
##  [91] ProtGenerics_1.42.0      edgeR_4.8.0              xfun_0.53
##  [94] statmod_1.5.1            UCSC.utils_1.6.0         lazyeval_0.2.2
##  [97] yaml_2.3.10              evaluate_1.0.5           codetools_0.2-20
## [100] cigarillo_1.0.0          tibble_3.3.0             alabaster.matrix_1.10.0
## [103] BiocManager_1.30.26      cli_3.6.5                jquerylib_0.1.4
## [106] dichromat_2.0-0.1        Rcpp_1.1.0               GenomeInfoDb_1.46.0
## [109] dbplyr_2.5.1             png_0.1-8                XML_3.99-0.19
## [112] parallel_4.5.1           blob_1.2.4               AnnotationFilter_1.34.0
## [115] sparseMatrixStats_1.22.0 bitops_1.0-9             viridisLite_0.4.2
## [118] alabaster.se_1.10.0      scales_1.4.0             crayon_1.5.3
## [121] rlang_1.1.6              cowplot_1.2.0            KEGGREST_1.50.0
```

# References

Grun, D., M. J. Muraro, J. C. Boisset, K. Wiebrands, A. Lyubimova, G. Dharmadhikari, M. van den Born, et al. 2016. “De Novo Prediction of Stem Cell Identity using Single-Cell Transcriptome Data.” *Cell Stem Cell* 19 (2): 266–77.

Lun, A. T., K. Bach, and J. C. Marioni. 2016. “Pooling across cells to normalize single-cell RNA sequencing data with many zero counts.” *Genome Biol.* 17 (April): 75.

Lun, A. T., D. J. McCarthy, and J. C. Marioni. 2016. “A step-by-step workflow for low-level analysis of single-cell RNA-seq data with Bioconductor.” *F1000Res* 5: 2122.

Xu, C., and Z. Su. 2015. “Identification of cell types from single-cell transcriptomes using a novel clustering method.” *Bioinformatics* 31 (12): 1974–80.