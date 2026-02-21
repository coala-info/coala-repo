# *coseq* package: Quick-start guide

Andrea Rau, Antoine Godichon-Baggioni, and Cathy Maugis-Rabusseau

#### 2025-10-29

#### Package

coseq 1.34.0

![](data:image/png;base64...)

*coseq* is a package to perform clustering analysis of sequencing data
(e.g., co-expression analysis of RNA-seq data), using transformed profiles rather than the raw counts directly. The package implements two distinct strategies in conjunction with transformations: 1) MacQueen’s *K*-means algorithm and 2) Gaussian mixture models. For both strategies model selection is provided using the slope heuristics approach and integrated completed likelihood (ICL) criterion, respectively. Note that for backwards compatibility, *coseq* also provides a wrapper for the Poisson mixture model originally proposed in Rau et al. (2015) and implemented in the *HTSCluster* package.

The methods implemented in this package are described in detail in the following three publications.

* Godichon-Baggioni, A., Maugis-Rabusseau, C. and Rau, A. (2018) Clustering transformed compositional data using K-means,
  with applications in gene expression and bicycle sharing system data. *Journal of Applied Statistics*, doi:10.1080/02664763.2018.1454894.
  [Paper that introduced the use of the K-means algorithm for RNA-seq profiles after transformation
  via the centered log ratio (CLR) or log centered log ratio (logCLR) transformation.]
* Rau, A. and Maugis-Rabusseau, C. (2018) Transformation and model choice for co-expression analayis of RNA-seq data. *Briefings in Bioinformatics*, 19(3)-425-436.
  [Paper that introduced the idea of clustering profiles for RNA-seq co-expression, and suggested
  using Gaussian mixture models in conjunction with either the arcsine or logit transformation.]
* Rau, A., Maugis-Rabusseau, C., Martin-Magniette, M.-L., Celeux, G. (2015) Co-expression analysis of high-throughput transcriptome sequencing data with Poisson mixture models. *Bioinformatics*, 31(9): 1420-1427. [link](https://www.ncbi.nlm.nih.gov/pubmed/25563332)
  [Paper that introduced the use of Poisson mixture models for RNA-seq counts.]

Below, we provide a quick-start guide using a subset of RNA-seq data to illustrate
the functionalities of the *coseq* package. In this document, we focus on the methods described in Rau and Maugis-Rabusseau (2018) and Godichon-Baggioni et al. (2018). For more information about the method described in Rau et al. (2015), see the [HTSCluster](https://CRAN.R-project.org/package%3DHTSCluster) vignette.

# 1 Quick start (tl;dr)

A standard *coseq* analysis takes the following form, where `counts` represents a matrix or data.frame of gene-level counts arising from an RNA-seq experiment (of dimension *n* x *d* for *n* genes and *d* samples). Results, exported in the form of a `coseqResults` S4 object, can easily be examined using standard `summary` and `plot` functions (see below and the User’s Guide for examples of plots that may be obtained):

```
run <- coseq(counts, K=2:25)
summary(run)
plot(run)
```

The cluster labels for the selected model obtained from the `coseq` clustering may easily be obtained using the `clusters` function:

```
clusters(run)
```

Similarly, the conditional probabilities of cluster membership for each gene in the selected `coseq` clustering model may be obtained using the `assay` accessor function:

```
assay(run)
```

Note that unless otherwise specified by the user, *coseq* uses the following default parameters:

* *K*-means algorithm
* Log centered log transformation (logclr) on profiles
* Library size normalization via the Trimmed Mean of M-values (TMM) approach
* Model selection (choice of the number of clusters) via the slope heuristics approach
* No parallelization.

Note that rerunning *coseq* may lead to different results (both for the number of chosen clusters as well as the cluster assignments) due to differences in initialization. For reproducible results, make sure to use the `seed` argument to fix the seed of the random number generator:

```
run <- coseq(counts, K=2:25, seed=12345)
```

# 2 Co-expression analysis with *coseq*

For the remainder of this vignette, we make use of the mouse neocortex RNA-seq data from [Fietz et al. (2012)](https://www.ncbi.nlm.nih.gov/pubmed/22753484) (available at <https://perso.math.univ-toulouse.fr/maugis/mixstatseq/packages> and as an ExpressionSet object called `fietz` in *coseq*). The aim in this study was to investigate the expansion of the neocortex in five embryonic (day 14.5) mice by analyzing the transcriptome of three regions: the ventricular zone (VZ), subventricular zone (SVZ) and cortical place (CP).

We begin by first loading the necessary R packages as well as the data.

```
library(coseq)
library(Biobase)
library(corrplot)

data("fietz")
counts <- exprs(fietz)
conds <- pData(fietz)$tissue

## Equivalent to the following:
## counts <- read.table("http://www.math.univ-toulouse.fr/~maugis/coseq/Fietz_mouse_counts.txt",
##                       header=TRUE)
## conds <- c(rep("CP",5),rep("SVZ",5),rep("VZ",5))
```

The *coseq* package fits either a Gaussian mixture model (Rau and Maugis-Rabusseau, 2018) or uses the K-means algorithm (Godichon-Baggioni et al., 2018) to cluster transformed normalized expression profiles of RNA-seq data. Normalized expression profiles correspond to the proportion of normalized reads observed for gene *i* with respect to the total observed for gene *i* across all samples:
\[
p\_{ij} = \frac{y\_{ij}/s\_{j} +1}{\sum\_{j'} y\_{ij'}/s\_{j'} +1},
\]
where \(s\_j\) are normalization scaling factors (e.g., after applying [TMM](https://genomebiology.biomedcentral.com/articles/10.1186/gb-2010-11-3-r25) normalization to library sizes) and \(y\_{ij}\) represents the raw count for gene \(i\) in sample \(j\).

## 2.1 Transformations for normalized profiles with the Gaussian mixture model

Since the coordinates of \(\mathbf{p}\_i\) are linearly dependent (causing estimation problems for a Gaussian mixture distribution), weconsider either the arcsine or logit transformation of the normalized profiles \(p\_{ij}\):
\[g\_{\text{arcsin}}(p\_{ij}) = \text{arcsin}\left( \sqrt{ p\_{ij} } \right) \in [0, \pi/2], \text{ and}\]
\[g\_{\text{logit}}(p\_{ij}) = \text{log}\_2 \left( \frac{p\_{ij}}{1-p\_{ij}} \right) \in (-\infty, \infty).\]

Then the distribution of the transformed normalized expression profiles is modeled by a general multidimensional Gaussian mixture

\[f(.|\theta\_K) = \sum\_{k=1}^K \pi\_k \phi(.|\mu\_k,\Sigma\_k)\]

where \(\theta\_K=(\pi\_1,\ldots,\pi\_{K-1},\mu\_1,\ldots,\mu\_K,\Sigma\_1,\ldots,\Sigma\_K)\), \(\pi=(\pi\_1,\ldots,\pi\_K)\) are the mixing proportions and \(\phi(.|\mu\_k,\Sigma\_k)\) is the \(q\)-dimensional Gaussian density function with mean \(\mu\_k\) and covariance matrix \(\Sigma\_k\). To estimate mixture parameters \(\theta\_K\) by computing the maximum likelihood estimate (MLE), an Expectation-Maximization (EM) algorithm is used via the [Rmixmod](https://CRAN.R-project.org/package%3DRmixmod) package. Finally, let \(\hat t\_{ik}\) be the conditional probability that observation \(i\) arises from the \(k\)th component of the mixture \(f(.|\hat \theta\_{\hat K})\). Each observation \(i\) is assigned to the component maximizing the conditional probability \(\hat t\_{ik}\) i.e., using the so-called maximum a posteriori (MAP) rule.

## 2.2 Transformations for normalized profiles with *K*-means

For the *K*-means algorithm, we consider three separate transformations of the profiles \(p\_{i}\) that are well adapted to compositional data (see Godichon-Baggioni et al., 2017 for more details):

* Identity (i.e., no transformation)
* Centered log ratio (CLR) transformation
* Log centered log ratio (logCLR) transformation

Then, the aim is to minimize the sum of squared errors (SSE), defined for each set of clustering \(\mathcal{C}^{(K)}=\left( C\_{1},...,C\_{k}\right)\) by
\[\begin{equation\*}
\text{SSE} \left( \mathcal{C}^{(K)}\right) := \sum\_{k=1}^{K}\sum\_{i \in C\_{k}} \left\| h \left( y\_{i}\right) - \mu\_{k,h} \right\|\_{2}^{2} ,
\end{equation\*}\]
with \(i \in C\_{k}\) if \(\left\| h\left( y\_{i}\right) - \mu\_{k,h} \right\|\_{2} = \min\_{k'=1,\ldots,K} \left\| y\_{i}- \mu\_{k',h} \right\|\_{2}\), and
\[
\mu\_{k,h}= \frac{1}{|C\_{k} |}\sum\_{i \in C\_{k}}h \left( y\_{i} \right),
\]
and \(h\) is the chosen transformation. In order to minimize the SSE, we use the well-known MacQueen’s *K*-means algorithm.

## 2.3 Model selection

Because the number of clusters \(K\) is not known a priori, we fit a collection of models (here \(K\) = 2, …, 25) and use either the Integrated Completed Likelihood (ICL) criterion (in the case of the Gaussian mixture model) or the slope heuristics (in the case of the *K*-means algorithm) to select the best model in terms of fit, complexity, and cluster separation.

## 2.4 Other options

If desired, we can set a filtering cutoff on the mean normalized counts via the `meanFilterCutoff` argument to remove very weakly expressed genes from the co-expression analysis; in the interest of faster computation for this vignette, in this example we filter all genes with mean normalized expression less than 200 (for the Gaussian mixture model) or less than 50 (for the *K*-means algorithm).

Note that if desired, parallel execution using [BiocParallel](http://bioconductor.org/packages/release/bioc/html/BiocParallel.html) can be specified via the `parallel` argument:

```
run <- coseq(..., parallel=TRUE)
```

# 3 Running *coseq*

The collection of co-expression models for the logCLR-transformed profiles using the *K*-means algorithm may be obtained as follows (note that we artificially set the number of maximum
allowed iterations and number of random starts to be low for faster computational time in this vignette):

```
runLogCLR <- coseq(counts, K=2:25, transformation="logclr",norm="TMM",
                      meanFilterCutoff=50, model="kmeans",
                   nstart=1, iter.max=10)
```

```
## ****************************************
## coseq analysis: kmeans approach & logclr transformation
## K = 2 to 25
## Use seed argument in coseq for reproducible results.
## ****************************************
## Running K = 2 ...
## Running K = 3 ...
## Running K = 4 ...
## Running K = 5 ...
## Running K = 6 ...
## Running K = 7 ...
## Running K = 8 ...
## Running K = 9 ...
## Running K = 10 ...
## Running K = 11 ...
## Running K = 12 ...
## Running K = 13 ...
## Running K = 14 ...
## Running K = 15 ...
## Running K = 16 ...
## Running K = 17 ...
## Running K = 18 ...
## Running K = 19 ...
## Running K = 20 ...
## Running K = 21 ...
## Running K = 22 ...
## Running K = 23 ...
## Running K = 24 ...
## Running K = 25 ...
```

The collection of Gaussian mixture models for the arcsine-transformed and logit-transformed profiles may be obtained as follows (as before, we set the number of iterations to be quite low for computational speed in this vignette):

```
runArcsin <- coseq(counts, K=2:20, model="Normal", transformation="arcsin",
                   meanFilterCutoff=200, iter=10)
```

```
## ****************************************
## coseq analysis: Normal approach & arcsin transformation
## K = 2 to 20
## Use seed argument in coseq for reproducible results.
## ****************************************
## Running K = 2 ...
## Running K = 3 ...
## Running K = 4 ...
## Running K = 5 ...
## Running K = 6 ...
## Running K = 7 ...
## Running K = 8 ...
## Running K = 9 ...
## Running K = 10 ...
## Running K = 11 ...
## Running K = 12 ...
## Running K = 13 ...
## Running K = 14 ...
## Running K = 15 ...
## Running K = 16 ...
## Running K = 17 ...
## Running K = 18 ...
## Running K = 19 ...
## Running K = 20 ...
```

```
runLogit <- coseq(counts, K=2:20, model="Normal", transformation="logit",
                  meanFilterCutoff=200, verbose=FALSE, iter=10)
```

```
## ****************************************
## coseq analysis: Normal approach & logit transformation
## K = 2 to 20
## Use seed argument in coseq for reproducible results.
## ****************************************
```

In all cases, the resulting output of a call to `coseq` is an S4 object of class `coseqResults`.

```
class(runArcsin)
```

```
## [1] "coseqResults"
## attr(,"package")
## [1] "coseq"
```

```
runArcsin
```

```
## An object of class coseqResults
##  4230 features by 15 samples.
##  Models fit: K = 2 ... 20
##  Chosen clustering model: K = 9
```

To choose the most appropriate transformation to use (arcsine versus logit) in a Gaussian mixture model, we may use the corrected ICL, where the minimum value corresponds to the selected model. Note that this feature is not available for the *K*-means algorithm.

```
compareICL(list(runArcsin, runLogit))
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the coseq package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

This indicates that the preferred transformation is the arcsine, and the selected model has K = 9 clusters. We can additionally explore how similar the models with K = 8 to 12 are using the adjusted Rand index (ARI) via the `compareARI` function. Values close to 1 indicate perfect agreement, while values close to 0 indicate near random partitions.

```
compareARI(runArcsin, K=8:12)
```

![](data:image/png;base64...)

```
##      K=8  K=9 K=10 K=11 K=12
## K=8    1 0.35  0.4 0.46 0.52
## K=9         1 0.48 0.51 0.38
## K=10             1 0.44 0.37
## K=11                  1  0.4
## K=12                       1
```

Note that because the results of `coseq` depend on the initialization point, results from one run to another may vary; as such, in practice, it is typically a good idea to re-estimate the same collection of models a few times (e.g., 5) to avoid problems linked to initialization.

## 3.1 Exploring *coseq* results

Results from a *coseq* analysis can be explored and summarized in a variety of ways. First, a call to the `summary` function provides the number of clusters selected for the ICL model selection approach, number of genes assigned to each cluster, and if desired the per-gene cluster means.

```
summary(runArcsin)
```

```
## *************************************************
## Model: Gaussian_pk_Lk_Ck
## Transformation: arcsin
## *************************************************
## Clusters fit: 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
## Clusters with errors: ---
## Selected number of clusters via ICL: 9
## ICL of selected model: -365334.3
## *************************************************
## Number of clusters = 9
## ICL = -365334.3
## *************************************************
## Cluster sizes:
## Cluster 1 Cluster 2 Cluster 3 Cluster 4 Cluster 5 Cluster 6 Cluster 7 Cluster 8
##       699       357       245       472      1125       398       161       191
## Cluster 9
##       582
##
## Number of observations with MAP > 0.90 (% of total):
## 3121 (73.78%)
##
## Number of observations with MAP > 0.90 per cluster (% of total per cluster):
##  Cluster 1 Cluster 2 Cluster 3 Cluster 4 Cluster 5 Cluster 6 Cluster 7
##  396       315       232       361       787       323       150
##  (56.65%)  (88.24%)  (94.69%)  (76.48%)  (69.96%)  (81.16%)  (93.17%)
##  Cluster 8 Cluster 9
##  173       384
##  (90.58%)  (65.98%)
```

Next, a variety of plots may be explored using the `plot` function:

* `logLike` (log-likelihood plotted versus number of clusters),
* `ICL` (ICL plotted versus number of clusters),
* `profiles`(line plots of profiles in each cluster),
* `boxplots` (boxplots of profiles in each cluster),
* `probapost_boxplots` (boxplots of maximum conditional probabilities per cluster),
* `probapost_barplots` (number of observations with a maximum conditional probability greater than a given threshold per cluster),
* `probapost_histogram` (histogram of maximum conditional probabilities over all clusters).

By default, all of these plots are produced simultaneously unless specific graphics are requested via the `graphs` argument. In addition, a variety of options are available to specify the number of graphs per row/column in a grid layout, whether profiles should be averaged or summed over conditions (`collapse_reps`), whether condition labels should be used, whether clusters should be ordered according to their similarity, etc. The mean lines that are superimposed on boxplots of profiles in each cluster can optionally be removed using `add_lines=FALSE`. Note that the histogram of maximum conditional probabilities of cluster membership for all genes (`probapost_histogram`), and boxplots and barplots of maximum conditional probabilities of cluster membership for the genes assigned to each cluster (`probapost_boxplots`, `probapost_barplots`) help to evaluate the degree of certitude accorded by the model in assigning genes to clusters, as well as whether some clusters are attribued a greater degree of uncertainty than others.

```
## To obtain all plots
## plot(runArcsin)
plot(runArcsin, graphs="boxplots")
```

```
## $boxplots
```

![](data:image/png;base64...)

```
plot(runArcsin, graphs="boxplots", add_lines = FALSE)
```

```
## $boxplots
```

![](data:image/png;base64...)

```
plot(runArcsin, graphs="boxplots", conds=conds)
```

```
## $boxplots
```

![](data:image/png;base64...)

```
plot(runArcsin, graphs="boxplots", conds=conds, collapse_reps = "sum")
```

```
## $boxplots
```

![](data:image/png;base64...)

```
plot(runArcsin, graphs="profiles")
```

```
## $profiles
```

![](data:image/png;base64...)

```
plot(runArcsin, graphs="probapost_boxplots")
```

```
## $probapost_boxplots
```

![](data:image/png;base64...)

```
plot(runArcsin, graphs="probapost_histogram")
```

```
## $probapost_histogram
```

![](data:image/png;base64...)

If desired the per-cluster correlation matrices estimated in the Gaussian mixture model may be obtained by calling `NormMixParam`. These matrices may easily be visualized using the `corrplot` package.

```
rho <- NormMixParam(runArcsin)$rho
## Covariance matrix for cluster 1
rho1 <- rho[,,1]
colnames(rho1) <- rownames(rho1) <- paste0(colnames(rho1), "\n", conds)
corrplot(rho1)
```

![](data:image/png;base64...)

Finally, cluster labels and conditional probabilities of cluster membership (as well as a variety of other information) are easily accessible via a set of accessor functions.

```
labels <- clusters(runArcsin)
table(labels)
```

```
## labels
##    1    2    3    4    5    6    7    8    9
##  699  357  245  472 1125  398  161  191  582
```

```
probapost <- assay(runArcsin)
head(probapost)
```

```
##        Cluster_1 Cluster_2 Cluster_3 Cluster_4 Cluster_5 Cluster_6 Cluster_7
## Gene1      0.000         0     0.000     0.000     0.999     0.001         0
## Gene4      0.433         0     0.000     0.567     0.000     0.000         0
## Gene10     0.000         0     0.000     0.000     0.978     0.000         0
## Gene14     0.304         0     0.000     0.000     0.689     0.000         0
## Gene16     0.000         0     0.000     0.000     0.981     0.019         0
## Gene17     0.000         0     0.017     0.000     0.000     0.971         0
##        Cluster_8 Cluster_9
## Gene1      0.000     0.000
## Gene4      0.000     0.000
## Gene10     0.000     0.022
## Gene14     0.000     0.007
## Gene16     0.000     0.000
## Gene17     0.012     0.000
```

```
metadata(runArcsin)
```

```
## $nbCluster
##  K=2  K=3  K=4  K=5  K=6  K=7  K=8  K=9 K=10 K=11 K=12 K=13 K=14 K=15 K=16 K=17
##    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17
## K=18 K=19 K=20
##   18   19   20
##
## $logLike
##      K=2      K=3      K=4      K=5      K=6      K=7      K=8      K=9
## 179205.9 181871.4 183747.6 185385.4 186580.7 187282.6 187882.0 188641.6
##     K=10     K=11     K=12     K=13     K=14     K=15     K=16     K=17
## 188896.9 189254.0 190190.4 190114.2 190639.0 190971.4 191499.9 191683.0
##     K=18     K=19     K=20
## 192088.9 192285.4      0.0
##
## $ICL
##        K=2        K=3        K=4        K=5        K=6        K=7        K=8
## -355745.13 -359621.93 -362085.85 -364320.86 -365152.93 -365019.19 -365205.07
##        K=9       K=10       K=11       K=12       K=13       K=14       K=15
## -365334.27 -364896.04 -364327.73 -365016.58 -363881.93 -363557.34 -363096.22
##       K=16       K=17       K=18       K=19       K=20
## -363161.94 -362298.52 -361867.01 -361122.59   22703.53
##
## $nbClusterError
## integer(0)
##
## $GaussianModel
## [1] "Gaussian_pk_Lk_Ck"
```

```
likelihood(runArcsin)
```

```
##      K=2      K=3      K=4      K=5      K=6      K=7      K=8      K=9
## 179205.9 181871.4 183747.6 185385.4 186580.7 187282.6 187882.0 188641.6
##     K=10     K=11     K=12     K=13     K=14     K=15     K=16     K=17
## 188896.9 189254.0 190190.4 190114.2 190639.0 190971.4 191499.9 191683.0
##     K=18     K=19     K=20
## 192088.9 192285.4      0.0
```

```
nbCluster(runArcsin)
```

```
##  K=2  K=3  K=4  K=5  K=6  K=7  K=8  K=9 K=10 K=11 K=12 K=13 K=14 K=15 K=16 K=17
##    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17
## K=18 K=19 K=20
##   18   19   20
```

```
ICL(runArcsin)
```

```
##        K=2        K=3        K=4        K=5        K=6        K=7        K=8
## -355745.13 -359621.93 -362085.85 -364320.86 -365152.93 -365019.19 -365205.07
##        K=9       K=10       K=11       K=12       K=13       K=14       K=15
## -365334.27 -364896.04 -364327.73 -365016.58 -363881.93 -363557.34 -363096.22
##       K=16       K=17       K=18       K=19       K=20
## -363161.94 -362298.52 -361867.01 -361122.59   22703.53
```

```
model(runArcsin)
```

```
## [1] "Normal"
```

```
transformationType(runArcsin)
```

```
## [1] "arcsin"
```

The data used to fit the mixture model (transformed normalized profiles) as well as the normalized profiles themselves are stored as `DataFrame` objects that may be accessed with the corresponding functions:

```
## arcsine-transformed normalized profiles
tcounts(runArcsin)
```

```
## DataFrame with 4230 rows and 15 columns
##                 CP      CP.1      CP.2      CP.3      CP.4       SVZ     SVZ.1
##          <numeric> <numeric> <numeric> <numeric> <numeric> <numeric> <numeric>
## Gene1     0.236598  0.228105  0.241289  0.247308  0.248983  0.262926  0.255119
## Gene4     0.284826  0.293177  0.311891  0.288275  0.286415  0.273257  0.270222
## Gene10    0.253392  0.263880  0.253060  0.263255  0.260619  0.256239  0.260183
## Gene14    0.249871  0.241841  0.253633  0.258939  0.260336  0.277088  0.268473
## Gene16    0.230003  0.235796  0.249497  0.238360  0.245337  0.253128  0.222894
## ...            ...       ...       ...       ...       ...       ...       ...
## Gene8946  0.107454 0.0319221 0.0502666 0.0247498 0.0581115  0.125936  0.106439
## Gene8948  0.222996 0.2181115 0.2481816 0.2432824 0.2522842  0.268210  0.253219
## Gene8950  0.230433 0.2196406 0.2668969 0.2393975 0.2197826  0.255853  0.239209
## Gene8951  0.168093 0.1325089 0.1523621 0.1602128 0.2203650  0.227986  0.204112
## Gene8952  0.323131 0.3235151 0.3650935 0.3393813 0.3225634  0.255759  0.265896
##              SVZ.2     SVZ.3     SVZ.4        VZ      VZ.1      VZ.2      VZ.3
##          <numeric> <numeric> <numeric> <numeric> <numeric> <numeric> <numeric>
## Gene1     0.264225  0.254177  0.282872  0.269561  0.268584  0.279656  0.291505
## Gene4     0.264529  0.277584  0.270684  0.214741  0.201503  0.214770  0.230972
## Gene10    0.255290  0.256092  0.262937  0.266352  0.262020  0.273577  0.262905
## Gene14    0.287667  0.266348  0.284220  0.242278  0.257732  0.245792  0.270709
## Gene16    0.258246  0.252938  0.259801  0.272837  0.290480  0.298819  0.310846
## ...            ...       ...       ...       ...       ...       ...       ...
## Gene8946  0.137822  0.150038  0.135824  0.402965  0.466937  0.433534  0.459187
## Gene8948  0.287114  0.286051  0.301975  0.245651  0.252177  0.264103  0.297958
## Gene8950  0.294898  0.284185  0.295018  0.256683  0.259462  0.287688  0.294167
## Gene8951  0.238430  0.252019  0.257212  0.332098  0.334501  0.358867  0.372642
## Gene8952  0.284487  0.261110  0.253660  0.157132  0.163402  0.154286  0.135452
##               VZ.4
##          <numeric>
## Gene1     0.278312
## Gene4     0.202353
## Gene10    0.266790
## Gene14    0.247194
## Gene16    0.282039
## ...            ...
## Gene8946  0.418326
## Gene8948  0.261060
## Gene8950  0.256566
## Gene8951  0.343575
## Gene8952  0.159030
```

```
## normalized profiles
profiles(runArcsin)
```

```
## DataFrame with 4230 rows and 15 columns
##                 CP       CP.1       CP.2       CP.3       CP.4       SVZ
##          <numeric>  <numeric>  <numeric>  <numeric>  <numeric> <numeric>
## Gene1    0.0549419  0.0511356  0.0570991  0.0599245  0.0607218 0.0675517
## Gene4    0.0789557  0.0835180  0.0941622  0.0808260  0.0798148 0.0728293
## Gene10   0.0628450  0.0680313  0.0626839  0.0677172  0.0663983 0.0642339
## Gene14   0.0611469  0.0573557  0.0629621  0.0655642  0.0662575 0.0748328
## Gene16   0.0519750  0.0545771  0.0609678  0.0557474  0.0589921 0.0627168
## ...            ...        ...        ...        ...        ...       ...
## Gene8946 0.0115019 0.00101868 0.00252461 0.00061243 0.00337314 0.0157762
## Gene8948 0.0489084 0.04682299 0.06033983 0.05802782 0.06230838 0.0702283
## Gene8950 0.0521663 0.04747119 0.06955849 0.05622463 0.04753159 0.0640447
## Gene8951 0.0279902 0.01745608 0.02303514 0.02544928 0.04777977 0.0510832
## Gene8952 0.1008297 0.10106122 0.12747513 0.11082493 0.10048824 0.0639990
##              SVZ.1     SVZ.2     SVZ.3     SVZ.4        VZ      VZ.1      VZ.2
##          <numeric> <numeric> <numeric> <numeric> <numeric> <numeric> <numeric>
## Gene1    0.0636858 0.0682053 0.0632264 0.0779050 0.0709199 0.0704194 0.0761899
## Gene4    0.0712597 0.0683586 0.0750939 0.0714975 0.0454093 0.0400569 0.0454211
## Gene10   0.0661811 0.0637693 0.0641619 0.0675574 0.0692818 0.0670976 0.0729958
## Gene14   0.0703627 0.0804946 0.0692795 0.0786294 0.0575589 0.0649677 0.0592068
## Gene16   0.0488645 0.0652213 0.0626246 0.0659915 0.0726114 0.0820317 0.0866668
## ...            ...       ...       ...       ...       ...       ...       ...
## Gene8946 0.0112866 0.0188751 0.0223430 0.0183350 0.1537798 0.2026382 0.1764679
## Gene8948 0.0627610 0.0801939 0.0796174 0.0884509 0.0591403 0.0622565 0.0681439
## Gene8950 0.0561380 0.0844730 0.0786102 0.0845397 0.0644519 0.0658233 0.0805061
## Gene8951 0.0410865 0.0557797 0.0621805 0.0647118 0.1062936 0.1077794 0.1233510
## Gene8952 0.0690502 0.0787731 0.0666429 0.0629750 0.0244879 0.0264634 0.0236160
##               VZ.3      VZ.4
##          <numeric> <numeric>
## Gene1    0.0825954 0.0754783
## Gene4    0.0524061 0.0403909
## Gene10   0.0675413 0.0695042
## Gene14   0.0715107 0.0598705
## Gene16   0.0935531 0.0774588
## ...            ...       ...
## Gene8946 0.1964434 0.1650241
## Gene8948 0.0861825 0.0666179
## Gene8950 0.0840666 0.0643944
## Gene8951 0.1325522 0.1134716
## Gene8952 0.0182353 0.0250779
```

Finally, if the results (e.g., the conditional probabilities of cluster membership) for a model in the collection other than that chosen by ICL/slope heuristics are desired, they may be accessed in the form of a list using the `coseqFullResults` function.

```
fullres <- coseqFullResults(runArcsin)
class(fullres)
```

```
## [1] "list"
```

```
length(fullres)
```

```
## [1] 19
```

```
names(fullres)
```

```
##  [1] "K=2"  "K=3"  "K=4"  "K=5"  "K=6"  "K=7"  "K=8"  "K=9"  "K=10" "K=11"
## [11] "K=12" "K=13" "K=14" "K=15" "K=16" "K=17" "K=18" "K=19" "K=20"
```

## 3.2 Running coseq on a *DESeq2* or *edgeR* results object

In many cases, it is of interest to run a co-expression analysis on the subset of genes identified as differentially expressed in a prior analysis. To facilitate this, `coseq` may be directly inserted into a *DESeq2* analysis pipeline as follows:

```
library(DESeq2)
dds <- DESeqDataSetFromMatrix(counts, DataFrame(group=factor(conds)), ~group)
dds <- DESeq(dds, test="LRT", reduced = ~1)
res <- results(dds)
summary(res)
```

```
##
## out of 8962 with nonzero total read count
## adjusted p-value < 0.1
## LFC > 0 (up)       : 3910, 44%
## LFC < 0 (down)     : 3902, 44%
## outliers [1]       : 13, 0.15%
## low counts [2]     : 0, 0%
## (mean count < 45)
## [1] see 'cooksCutoff' argument of ?results
## [2] see 'independentFiltering' argument of ?results
```

```
## By default, alpha = 0.10
run <- coseq(dds, K=2:15, verbose=FALSE)
```

```
## ****************************************
## Co-expression analysis on DESeq2 output:
## 7812 DE genes at p-adj < 0.1
## ****************************************
## coseq analysis: kmeans approach & logclr transformation
## K = 2 to 15
## Use seed argument in coseq for reproducible results.
## ****************************************
## Running K = 2 ...
## Running K = 3 ...
## Running K = 4 ...
## Running K = 5 ...
## Running K = 6 ...
## Running K = 7 ...
## Running K = 8 ...
## Running K = 9 ...
## Running K = 10 ...
## Running K = 11 ...
## Running K = 12 ...
## Running K = 13 ...
## Running K = 14 ...
## Running K = 15 ...
```

```
## The following two lines provide identical results
run <- coseq(dds, K=2:15, alpha=0.05)
```

```
## ****************************************
## Co-expression analysis on DESeq2 output:
## 7535 DE genes at p-adj < 0.05
## ****************************************
## coseq analysis: kmeans approach & logclr transformation
## K = 2 to 15
## Use seed argument in coseq for reproducible results.
## ****************************************
## Running K = 2 ...
## Running K = 3 ...
## Running K = 4 ...
## Running K = 5 ...
## Running K = 6 ...
## Running K = 7 ...
## Running K = 8 ...
## Running K = 9 ...
## Running K = 10 ...
## Running K = 11 ...
## Running K = 12 ...
## Running K = 13 ...
## Running K = 14 ...
## Running K = 15 ...
```

```
run <- coseq(dds, K=2:15, subset=results(dds, alpha=0.05))
```

```
## ****************************************
## Co-expression analysis on DESeq2 output:
## 7812 DE genes at p-adj < 0.1
## ****************************************
## coseq analysis: kmeans approach & logclr transformation
## K = 2 to 15
## Use seed argument in coseq for reproducible results.
## ****************************************
## Running K = 2 ...
## Running K = 3 ...
## Running K = 4 ...
## Running K = 5 ...
## Running K = 6 ...
## Running K = 7 ...
## Running K = 8 ...
## Running K = 9 ...
## Running K = 10 ...
## Running K = 11 ...
## Running K = 12 ...
## Running K = 13 ...
## Running K = 14 ...
## Running K = 15 ...
```

A co-expression analysis following the *edgeR* analysis pipeline may be done in a similar way, depending on whether the quasi-likelihood or likelihood ratio test is used:

```
library(edgeR)
y <- DGEList(counts=counts, group=factor(conds))
y <- calcNormFactors(y)
design <- model.matrix(~conds)
y <- estimateDisp(y, design)

## edgeR: QLF test
fit <- glmQLFit(y, design)
qlf <- glmQLFTest(fit, coef=2)

## edgeR: LRT test
fit <- glmFit(y,design)
lrt <- glmLRT(fit,coef=2)

run <- coseq(counts, K=2:15, subset=lrt, alpha=0.1)
```

```
## ****************************************
## Co-expression analysis on edgeR output:
## 5777 DE genes at p-adj < 0.1
## ****************************************
## coseq analysis: kmeans approach & logclr transformation
## K = 2 to 15
## Use seed argument in coseq for reproducible results.
## ****************************************
## Running K = 2 ...
## Running K = 3 ...
## Running K = 4 ...
## Running K = 5 ...
## Running K = 6 ...
## Running K = 7 ...
## Running K = 8 ...
## Running K = 9 ...
## Running K = 10 ...
## Running K = 11 ...
## Running K = 12 ...
## Running K = 13 ...
## Running K = 14 ...
## Running K = 15 ...
```

```
run <- coseq(counts, K=2:15, subset=qlf, alpha=0.1)
```

```
## ****************************************
## Co-expression analysis on edgeR output:
## 5744 DE genes at p-adj < 0.1
## ****************************************
## coseq analysis: kmeans approach & logclr transformation
## K = 2 to 15
## Use seed argument in coseq for reproducible results.
## ****************************************
## Running K = 2 ...
## Running K = 3 ...
## Running K = 4 ...
## Running K = 5 ...
## Running K = 6 ...
## Running K = 7 ...
## Running K = 8 ...
## Running K = 9 ...
## Running K = 10 ...
## Running K = 11 ...
## Running K = 12 ...
## Running K = 13 ...
## Running K = 14 ...
## Running K = 15 ...
```

In both cases, library size normalization factors included in the *DESeq2* or *edgeR* object are used for the subsequent *coseq* analysis.

## 3.3 Customizing *coseq* graphical outputs

Because the plots produced by the `plot` function are produced using the *ggplot2* package, many plot customizations can be directly performed by the user by adding on additional layers, themes, or color scales. Note that because the output of the *coseq* `plot` function is a list of `ggplot` objects, the *coseq* plot object must be subsetted using `$` by the name of the desired plot (see below).

To illustrate, we show a few examples of a customized boxplot using a small simulated dataset. We have used the `profiles_order` parameter to modify the order in which clusters are plotted, and we have used the `n_row` and `n_col` parameters to adjust the number of rows and columns of the plot.

```
## Simulate toy data, n = 300 observations
set.seed(12345)
countmat <- matrix(runif(300*10, min=0, max=500), nrow=300, ncol=10)
countmat <- countmat[which(rowSums(countmat) > 0),]
conds <- c(rep("A", 4), rep("B", 3), rep("D", 3))

## Run coseq
coexp <- coseq(object=countmat, K=2:15, iter=5, transformation="logclr",
                    model="kmeans", seed=12345)
```

```
## ****************************************
## coseq analysis: kmeans approach & logclr transformation
## K = 2 to 15
## Use seed argument in coseq for reproducible results.
## ****************************************
## Running K = 2 ...
## Running K = 3 ...
## Running K = 4 ...
## Running K = 5 ...
## Running K = 6 ...
## Running K = 7 ...
## Running K = 8 ...
## Running K = 9 ...
## Running K = 10 ...
## Running K = 11 ...
## Running K = 12 ...
## Running K = 13 ...
## Running K = 14 ...
## Running K = 15 ...
```

```
## Original boxplot
p <- plot(coexp, graphs = "boxplots", conds = conds,
     profiles_order = sort(unique(clusters(coexp)), decreasing=TRUE),
     collapse_reps = "average",
     n_row = 3, n_col = 4)
p$boxplots
```

![](data:image/png;base64...)

We now illustrate an example where we (1) change the theme to black-and-white; (2) set the aspect ratio of y/x to be equal to 20; (3) change the widths of the axis ticks and lines; (4) change the size of the text labels; and (5) change the color scheme. Remember to load the *ggplot2* package prior to adding customization!

```
library(ggplot2)
p$boxplot +
  theme_bw() +
  coord_fixed(ratio = 20) +
  theme(axis.ticks = element_line(color="black", size=1.5),
        axis.line = element_line(color="black", size=1.5),
        text = element_text(size = 15)) +
  scale_fill_brewer(type = "qual")
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Scale for fill is already present.
## Adding another scale for fill, which will replace the existing scale.
```

![](data:image/png;base64...)

# 4 *coseq* FAQs

1. Should I use the Gaussian mixture model (`model="Normal"`) or the K-means (`model="kmeans"`) approach for my co-expression analysis? And what about the Poisson mixture model?

The Gaussian mixture model is more time-intensive but enables the estimation of per-cluster correlation structures among samples. The K-means algorithm has a much smaller computational cost, at the expense of assuming a diagonal per-cluster covariance structures. Generally speaking, we feel that the K-means approach is a good first approach to use, although this can be somewhat context-dependent. Finally, although we feel the Poisson mixture model was a good first approach for RNA-seq co-expression, we now recommend either the Gaussian mixture model or K-means approach instead.

2. There are a lot of proposed transformations in the package. Which one should I use?

In our experience, when using the Gaussian mixture model approach the arcsine transformation performs well. When using the *K*-means algorithm, if highly specific profiles should be highlighted (e.g., genes expressed in a single tissue), the logCLR transformation performs well; if on the other hand the user wishes to distinguish the fine differences among genes with generally equal expression across conditions (e.g., non-differentially expressed genes), the CLR transformation performs well.

3. Why do I get different results when I rerun the analysis?

Because the results of `coseq` depend on the initialization point, results from one run to another may vary; as such, in practice, it is typically a good idea to re-estimate the same collection of models a few times (e.g., 5) to avoid problems linked to initialization.

4. How do I output the clustering results?

Use the `clusters(...)` command for cluster labels, and the `assay(...)` command for conditional probabilities of cluster membership.

5. How can I check whether all models converged?

Look at the `nbClusterError` slot of the `coseqResults` metadata using `metadata(...)$nbClusterError` to examine the models that did not converge.

6. Can I run `coseq` on normalized profiles that have already been pre-computed?

Yes, you should just specify `normFactors = "none"` and `transformation = "none"` when using `coseq`.

7. Does it matter if I have an unbalanced experimental design?

Condition labels are not used in the actual clustering implemented by *coseq*, and in fact are only used when visualizing clusters using the `plot` command if `collapse_rows = c("sum", "average")`. As such, the clustering itself should not be unduly influenced by unbalanced designs.

8. Why did I get an error message about the singular covariance matrices for the form of Gaussian mixture model I used?

Occasionally, the default form of Gaussian mixture model (`Gaussian_pk_Lk_CK`, which is the most general form available with per-cluster proportions, volumes, shapes, and orientations for covariance matrices) used in `coseq` is not estimable (via the `Rmixmod` package used by `coseq`) due to non-invertible per-cluster covariance matrices. The error message thus suggests using a slightly more restrictive form of Gaussian mixture model, such as the `Gaussian_pk_Lk_Bk` (which imposes spherical covariance matrices) or `Gaussian_pk_Lk_I` (which imposes diagonal covariance matrices). See `?Rmixmod::mixmodGaussianModel` for more details about the nomenclature and possible forms of Gaussian mixture models.

9. How can I plot cluster profiles in individual figures (i.e., as many plots as clusters)?

One way to go about doing this is to use the the `facet_wrap_paginate()` function
in the *ggforce* package. For example, if `coexp` is a `coseqResults` object, you
could plot each profile to an individual page using

```
## Plot and summarize results
p <- plot(coexp, graph = "boxplots")$boxplots
library(ggforce)
pdf("coseq_boxplots_by_page.pdf")
for(k in seq_len(ncol(assay(coexp))))
    print(p + facet_wrap_paginate(~labels, page = k, nrow = 1, ncol = 1))
dev.off()
```

10. The order of conditions in the profile and boxplot graphs is not the same
    when individual samples are plotted (`collapse_reps = "none"`) and when replicates
    are collapsed within conditions (`collapse_reps = "average"` or `collapse_reps = "sum"`).
    How can I fix this?

This inconsistency in visualization occurs when individual samples in the count
matrix are not sorted according to the alphabetical order of the conditions factor.
There are two potential solutions: (1) create a new plot by extracting the
data from the `ggplot` object created by collapsing replciates, and re-order
the condition factor (and adjust condition colors) as desired; or (2) simply
order samples by condition in the count matrix prior to running coseq. Code illustrating
each of these solutions may be found below.

```
## Reproducible example
set.seed(12345)
countmat <- matrix(runif(300*8, min=0, max=500), nrow=300, ncol=8)
countmat <- countmat[which(rowSums(countmat) > 0),]
conds <- rep(c("A","C","B","D"), each=2)
colnames(countmat) <- factor(1:8)
run <- coseq(object=countmat, K=2:4, iter=5, model = "Normal",
             transformation = "arcsin")
```

```
## ****************************************
## coseq analysis: Normal approach & arcsin transformation
## K = 2 to 4
## Use seed argument in coseq for reproducible results.
## ****************************************
## Running K = 2 ...
## Running K = 3 ...
## Running K = 4 ...
```

```
## Problem: Conditions B and C are not in the same order in these graphics
p1 <- plot(run, graph = "boxplots", conds = conds)$boxplots
p2 <- plot(run, graph = "boxplots", conds = conds,
           collapse_reps = "average")$boxplots

## Solution 1 ------------------------------------------------------
## Create a new plot
dat_adjust <- p2$data
dat_adjust$conds <- factor(dat_adjust$conds, levels = c("A", "C", "B", "D"))
gg_color <- function(n) {
    hues = seq(15, 375, length = n + 1)
    hcl(h = hues, l = 65, c = 100)[1:n]
}
## p3 and p1 have conditions in the same order now
p3 <- ggplot(dat_adjust, aes(x=conds, y=y_prof)) +
    geom_boxplot(aes(fill = conds)) +
    scale_fill_manual(name = "Conditions",
                        values = gg_color(4)[c(1,3,2,4)]) +
    stat_summary(fun=mean, geom="line", aes(group=1), colour="red")  +
    stat_summary(fun=mean, geom="point", colour="red") +
    scale_y_continuous(name="Average expression profiles") +
    scale_x_discrete(name="Conditions") +
    facet_wrap(~labels)

## Solution 2 -------------------------------------------------------
## Order samples by conditions in the count matrix before running coseq

countmat_order <- countmat[,order(conds)]
conds_order <- conds[order(conds)]
run_order <- coseq(object=countmat_order, K=2:4, iter=5, model = "Normal",
             transformation = "arcsin")
```

```
## ****************************************
## coseq analysis: Normal approach & arcsin transformation
## K = 2 to 4
## Use seed argument in coseq for reproducible results.
## ****************************************
## Running K = 2 ...
## Running K = 3 ...
## Running K = 4 ...
```

```
## p4 and p5 have conditions in the same order too
p4 <- plot(run_order, graph = "boxplots", conds = conds_order)$boxplots
p5 <- plot(run_order, graph = "boxplots", conds = conds_order,
           collapse_reps = "average")$boxplots
```

11. How do I run *coseq* on multi-contrast *edgeR* or *DESeq2* DE results?

There are two possible approaches if your *coseq* analysis should be based on DE
results arising from multiple contrasts (e.g. a multifactorial design, or
a factor with more than two levels), depending on your study goals:
(1) for *coseq* analyses based on
the union of all genes identified as DE in at least one of several contrasts,
the most straightforward solution is to subset the count matrix using the
appropriate indices and the `subset` argument in *coseq*. If doing this, make
sure to use `sort.by="none"` in the `topTags` function of *edgeR* (by default
genes are sorted by p-value). For this solution, it is a good idea to provide
*edgeR* normalization factors to *coseq* rather than recalculating them.
(2) Alternatively, a likelihood ratio test could be used to compare a full
model to a simplified model. This amounts to testing whether there is any
arbitrary differential expression in any combination of factors as compared to
a baseline. Code illustrating each of these solutions may be found below.

```
# Simulate toy data, n = 300 observations, factorial 2x2 design ---------------
set.seed(12345)
counts <- round(matrix(runif(300*8, min=0, max=500), nrow=300, ncol=8))
factor_1 <- rep(c("A","B"), each=4)
factor_2 <- rep(c("C", "D"), times=4)
## Create some "differential expression" for each factor
counts[1:50, 1:4] <- 10*counts[1:50, 1:4]
counts[51:100, c(1,3,5,7)] <- 10*counts[51:100, c(1,3,5,7)]
design <- model.matrix(~factor_1 + factor_2)

## Option 1: edgeR analysis (here with the QLF test) with several contrasts-----
y <- DGEList(counts=counts)
y <- calcNormFactors(y)
y <- estimateDisp(y, design)
fit <- glmQLFit(y, design)
## Test of significance for factor_1
qlf_1 <- glmQLFTest(fit, coef=2)
## Test of significance for factor_2
qlf_2 <- glmQLFTest(fit, coef=3)
## Make sure to use sort.by = "none" in topTags so that the indices are in the
##   same order! Also only keep unique indices
de_indices <- c(unique(
    which(topTags(qlf_1, sort.by = "none", n=Inf)$table$FDR < 0.05),
    which(topTags(qlf_2, sort.by = "none", n=Inf)$table$FDR < 0.05)
))
## Now run coseq on the subset of DE genes, using prev normalization factors
run <- coseq(counts, K=2:25,
             normFactors = y$samples$norm.factors,
             subset = de_indices)
```

```
## ****************************************
## coseq analysis: kmeans approach & logclr transformation
## K = 2 to 25
## Use seed argument in coseq for reproducible results.
## ****************************************
## Running K = 2 ...
## Running K = 3 ...
## Running K = 4 ...
## Running K = 5 ...
## Running K = 6 ...
## Running K = 7 ...
## Running K = 8 ...
## Running K = 9 ...
## Running K = 10 ...
## Running K = 11 ...
## Running K = 12 ...
## Running K = 13 ...
## Running K = 14 ...
## Running K = 15 ...
## Running K = 16 ...
## Running K = 17 ...
## Running K = 18 ...
## Running K = 19 ...
## Running K = 20 ...
## Running K = 21 ...
## Running K = 22 ...
## Running K = 23 ...
## Running K = 24 ...
## Running K = 25 ...
```

```
## Option 2: edgeR analysis with overall LRT test-------------------------------
y <- DGEList(counts=counts)
y <- calcNormFactors(y)
y <- estimateDisp(y, design)
fit <- glmQLFit(y, design)
qlf_any <- glmQLFTest(fit, coef=2:3)
##  Now run coseq directly on the edgeR output
run2 <- coseq(counts, K=2:25, subset=qlf_any, alpha=0.05)
```

```
## ****************************************
## Co-expression analysis on edgeR output:
## 85 DE genes at p-adj < 0.05
## ****************************************
## coseq analysis: kmeans approach & logclr transformation
## K = 2 to 25
## Use seed argument in coseq for reproducible results.
## ****************************************
## Running K = 2 ...
## Running K = 3 ...
## Running K = 4 ...
## Running K = 5 ...
## Running K = 6 ...
## Running K = 7 ...
## Running K = 8 ...
## Running K = 9 ...
## Running K = 10 ...
## Running K = 11 ...
## Running K = 12 ...
## Running K = 13 ...
## Running K = 14 ...
## Running K = 15 ...
## Running K = 16 ...
## Running K = 17 ...
## Running K = 18 ...
## Running K = 19 ...
## Running K = 20 ...
## Running K = 21 ...
## Running K = 22 ...
## Running K = 23 ...
## Running K = 24 ...
## Running K = 25 ...
```