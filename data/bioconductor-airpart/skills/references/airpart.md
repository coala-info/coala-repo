# Differential cell-type-specific allelic imbalance with airpart

#### Wancen Mu, Hirak Sarkar, Avi Srivastava, Kwangbom Choi, Rob Patro, Michael I. Love

#### 10/29/2025

Abstract

Airpart identifies sets of genes displaying differential cell-type-specific allelic imbalance across cell types or states, utilizing single-cell allelic counts. It makes use of a generalized fused lasso with binomial observations of allelic counts to partition cell types by their allelic imbalance. Alternatively, a nonparametric method for partitioning cell types is offered. The package includes a number of visualizations and quality control functions for examining single cell allelic imbalance datasets.

# Real data example

Vignette on Larsson 2019 data can be found [here](https://htmlpreview.github.io/?https://github.com/Wancen/airpartpaper/blob/main/Larsson2019/Larsson2019.html), which has allelic single-cell RNA-seq with 4 cell states.

# Simulated data example I

The *airpart* package takes input data of counts from each of two alleles across genes (rows) and cells (columns) from a single-cell RNA-seq experiment.

For demonstration in the package vignette, we will simulate some data using `makeSimulatedData` function provided within the *airpart* package. We will examine the allelic counts and then perform QC steps before analyzing the data for allelic imbalance across groups of cells.

## Simulation set-up

The simulated example dataset has 3 gene clusters with differential allelic imbalance (DAI):

* the first cluster has pairs of cell types with same allelic ratio with 0.2 and 0.8 (larger DAI)
* the second cluster has balanced allelic ratio
* the third cluster has pairs of cell types with same allelic ratio with 0.7 and 0.9 (smaller DAI)

Below we specify a number of simulation settings as arguments to the simulation function:

* the “noisy” cell count is 2
* the normal cell count is 10
* 4 cell types
* 20 cells within each cell type
* 25 genes within each gene cluster
* overdispersion parameter `theta` in `rbetabinom` is 20 (higher is less dispersion)

```
library(airpart)
suppressPackageStartupMessages(library(SingleCellExperiment))
p.vec <- rep(c(0.2, 0.8, 0.5, 0.5, 0.7, 0.9), each = 2)
set.seed(2021)
sce <- makeSimulatedData(
  mu1 = 2, mu2 = 10, nct = 4, n = 20,
  ngenecl = 25, theta = 20, ncl = 3,
  p.vec = p.vec
)
```

```
unique(rowData(sce)) # the true underlying allelic ratios
```

```
## DataFrame with 3 rows and 4 columns
##              ct1       ct2       ct3       ct4
##        <numeric> <numeric> <numeric> <numeric>
## gene1        0.2       0.2       0.8       0.8
## gene26       0.5       0.5       0.5       0.5
## gene51       0.7       0.7       0.9       0.9
```

```
table(sce$x) # counts of each cell type
```

```
##
## ct1 ct2 ct3 ct4
##  20  20  20  20
```

```
assays(sce)[["a1"]][1:5, 1:5] # allelic counts for the effect allele
```

```
##       cell1 cell2 cell3 cell4 cell5
## gene1     0     2     0     1     0
## gene2     0     1     0     0     2
## gene3     0     0     1     0     0
## gene4     0     2     0     0     0
## gene5     0     1     0     1     0
```

## Required input data

In summary, *airpart* expects a *SingleCellExperiment* object with:

* discrete cell types recorded as a variable `x` in the `colData(sce)`
* effect and non-effect allelic counts as assays `a1` and `a2`

The allelic ratio is calculated as `a1 / (a1 + a2)`.

Note: We assume that the cell types have been either provided by the experiment, or identified based on total count. We assume the allelic ratio was not used in determining the cell groupings in `x`.

```
assayNames(sce)
```

```
## [1] "a1" "a2"
```

```
sce$x
```

```
##  [1] ct1 ct1 ct1 ct1 ct1 ct1 ct1 ct1 ct1 ct1 ct1 ct1 ct1 ct1 ct1 ct1 ct1 ct1 ct1
## [20] ct1 ct2 ct2 ct2 ct2 ct2 ct2 ct2 ct2 ct2 ct2 ct2 ct2 ct2 ct2 ct2 ct2 ct2 ct2
## [39] ct2 ct2 ct3 ct3 ct3 ct3 ct3 ct3 ct3 ct3 ct3 ct3 ct3 ct3 ct3 ct3 ct3 ct3 ct3
## [58] ct3 ct3 ct3 ct4 ct4 ct4 ct4 ct4 ct4 ct4 ct4 ct4 ct4 ct4 ct4 ct4 ct4 ct4 ct4
## [77] ct4 ct4 ct4 ct4
## Levels: ct1 ct2 ct3 ct4
```

# Create allelic ratio matrix

In the `preprocess` step, we add a pseudo-count for gene clustering and visualization (not used for inference later on allelic imbalance though, which uses original allelic counts). From the heatmap, we can clearly identify the three gene clusters (across rows), and we also see cell type differences (across columns). Within each cell type, there are some cells with noisier estimates (lower total count) than others. Again, the allelic ratio tells us how much more of the `a1` allele is expressed, with 1 indicating all of the expression coming from the `a1` allele and 0 indicating all of the expression coming from the `a2` allele.

```
sce <- preprocess(sce)
makeHeatmap(sce)
```

![](data:image/png;base64...)

# Quality control steps

## QC on cells

We recommend both QC on cells and on genes. We begin with cell allelic ratio quality control. For details on these metrics, see `?cellQC`.

```
cellQCmetrics <- cellQC(sce, mad_detected = 4)
cellQCmetrics
```

```
## DataFrame with 80 rows and 7 columns
##               x       sum  detected spikePercent filter_sum filter_detected
##        <factor> <numeric> <numeric>    <numeric>  <logical>       <logical>
## cell1       ct1   2.19590        61            0       TRUE            TRUE
## cell2       ct1   2.23045        64            0       TRUE            TRUE
## cell3       ct1   2.09342        57            0       TRUE            TRUE
## cell4       ct1   2.18184        59            0       TRUE            TRUE
## cell5       ct1   2.19590        63            0       TRUE            TRUE
## ...         ...       ...       ...          ...        ...             ...
## cell76      ct4   2.88309        75            0       TRUE            TRUE
## cell77      ct4   2.83187        73            0       TRUE            TRUE
## cell78      ct4   2.86153        75            0       TRUE            TRUE
## cell79      ct4   2.89763        74            0       TRUE            TRUE
## cell80      ct4   2.83123        73            0       TRUE            TRUE
##        filter_spike
##           <logical>
## cell1          TRUE
## cell2          TRUE
## cell3          TRUE
## cell4          TRUE
## cell5          TRUE
## ...             ...
## cell76         TRUE
## cell77         TRUE
## cell78         TRUE
## cell79         TRUE
## cell80         TRUE
```

Now define cell filtering automatically or users can manually filter out based on `sum`,`detected` and `spikePercent`.

```
keep_cell <- (
  cellQCmetrics$filter_sum | # sufficient features (genes)
    cellQCmetrics$filter_detected | # sufficient molecules counted
    # sufficient features expressed compared to spike genes,
    # high quality cells
    cellQCmetrics$filter_spike
)
sce <- sce[, keep_cell]
```

## QC on genes

We also recommend QC on genes for allelic ratio analysis. Note that we require genes to be expressed in at least 25% of cells within each cell type and the genes to have high allelic imbalance variation across cell types. The following code chunk is recommended (not evaluated here though). If users want to estimate homogeneous cell type allelic imbalance, they can set `sd = 0` and examine the below summary step to find interesting gene clusters with weighted mean deviating from 0.5.

```
featureQCmetric <- featureQC(sce)
keep_feature <- (featureQCmetric$filter_celltype &
  featureQCmetric$filter_sd &
  featureQCmetric$filter_spike)
sce <- sce[keep_feature, ]
```

# Gene clustering

*airpart* provides a function to cluster genes by their allelic imbalance profile across cells (not using cell grouping information, e.g. `sce$x`). We then recommend providing genes within a cluster to the partition function. Clustering genes increases power for detecting cell type partitions, and improves speed as it reduces the number of times the partition must be estimated.

We provide two methods for gene clustering.

1. Gaussian Mixture modeling

Gaussian mixture modeling is the default method for gene clustering. The scatter plot is shown based on top 2 PCs of the smoothed allelic ratio data. The argument `plot=FALSE` can be used to avoid showing the plot.

```
sce <- geneCluster(sce, G = 1:4)
```

```
## model-based optimal number of clusters: 3
```

![](data:image/png;base64...)

```
metadata(sce)$geneCluster
```

```
## [1] 25 25 25
```

2. Hierarchical clustering

```
sce.hc <- geneCluster(sce, method = "hierarchical")
```

![](data:image/png;base64...)

```
metadata(sce.hc)$geneCluster
```

```
## [1] 25 25 25
```

In this simulated dataset case, the clustering is very similar, but on allelic scRNA-seq datasets, we have found improved clustering with the Gaussian mixture model approach (more similar genes within cluster, based on visual inspection of PCA plot and of allelic ratio heatmaps).

# Running airpart for allelic imbalance across groups of cells

## Simple summary table of allelic ratio

We first quickly look at the weighted mean of allelic ratio for each gene cluster. From this step we will identify the interesting gene clusters. The mean is calculated, weighting the information from each gene x cell element of the matrices by the total count.

```
summary <- summaryAllelicRatio(sce)
summary
```

```
## $`gene cluster 1 with 25 genes`
##     x weighted.mean      mean        var
## 1 ct1     0.2084022 0.2056936 0.06355708
## 2 ct2     0.1981464 0.1879503 0.05634768
## 3 ct3     0.8133540 0.8090369 0.05572735
## 4 ct4     0.8054237 0.8136062 0.05143953
##
## $`gene cluster 2 with 25 genes`
##     x weighted.mean      mean        var
## 1 ct1     0.5119248 0.5096426 0.09555925
## 2 ct2     0.4949174 0.5000794 0.09566643
## 3 ct3     0.4961165 0.5135395 0.09642713
## 4 ct4     0.5048356 0.4883957 0.08759873
##
## $`gene cluster 3 with 25 genes`
##     x weighted.mean      mean        var
## 1 ct1     0.7085658 0.7216087 0.07258102
## 2 ct2     0.6942398 0.6803795 0.08580046
## 3 ct3     0.9117748 0.8952586 0.03821103
## 4 ct4     0.8956159 0.9017706 0.02942587
```

The following step is a complement of the QC on genes step. We recommend users only run *airpart* when the largest ordered allelic ratio difference > 0.05 for speed concerns. We find that the allelic ratio of most of the gene clusters in such cases (small absolute allelic ratio differences) won’t provide enough evidence to detect differential allelic imbalance.

```
sapply(1:length(summary), function(i) {
  inst <- summary[[i]]
  inst_order <- inst[order(inst$weighted.mean), ]
  max(diff(inst_order$weighted.mean)) > 0.05
})
```

```
## [1]  TRUE FALSE  TRUE
```

## Experiment-wide beta-binomial over-dispersion

We recommend examining the experiment-wide beta-binomial over-dispersion, which helps to inform whether to use a binomial likelihood or a nonparametric approach to partitioning the cell types by allelic imbalance.

We focus on the first gene cluster (if a gene cluster is not provided, `estDisp` will choose the largest cluster).

The blue trend line gives the typical values of over-dispersion across all the genes in the cluster, and across all the cell types (accounting for differences across the cell types in the expected ratio).

```
estDisp(sce, genecluster = 1)
```

```
## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

![](data:image/png;base64...)

## Modeling using fused lasso with binomial likelihood

*airpart* offers a method for partitioning cell types using the generalized fused lasso with binomial likelihood, as implemented in the *smurf* package. Cell types are merged based on their similarity of allelic ratios, accounting for excess variance on the ratio from low counts. The penalization is determined using deviance on held-out data, with a 1 SE cross-validation rule for favoring smaller models (more fused cell types).

The fusion step can also taken into account both cell-level and gene-level baseline effects, through the use of a `formula` (see `?fusedLasso` for example).

```
sce_sub <- fusedLasso(sce,
  model = "binomial",
  genecluster = 1, ncores = 1,
  niter = 2
)
```

The partition groups and the penalty \(\lambda\) from the fused lasso are stored in the metadata:

```
knitr::kable(metadata(sce_sub)$partition, row.names = FALSE)
```

| part1 | part2 | x | coef1 | coef2 |
| --- | --- | --- | --- | --- |
| 1 | 1 | ct1 | -1.366500 | -1.366500 |
| 1 | 1 | ct2 | -1.366500 | -1.366500 |
| 2 | 2 | ct3 | 1.447169 | 1.447169 |
| 2 | 2 | ct4 | 1.447169 | 1.447169 |

```
metadata(sce_sub)$lambda
```

```
##     part1     part2
## 0.2053138 0.2053138
```

Above, `ncores` is the number of CPU used for parallelization. As a guide, one can specify `niter=5` when the `cts` weighted allelic ratio difference is smaller than 0.1, in order to provide additional estimator robustness.

### Consensus partition

If you run `niter` > 1, you can use our consensus partition function to derive the final partition. This function makes use of ensemble consensus clustering via the *clue* package.

```
sce_sub <- consensusPart(sce_sub)
knitr::kable(metadata(sce_sub)$partition, row.names = FALSE)
```

| part | x |
| --- | --- |
| 1 | ct1 |
| 1 | ct2 |
| 2 | ct3 |
| 2 | ct4 |

## Modeling using pairwise Mann-Whitney-Wilcoxon extension

An alternative to the fused lasso with binomial likelihood is an extension we have implemented wherein all pairs cell types are compared with Mann-Whitney-Wilcoxon rank sum tests. In practice, we find that when the allelic counts deviates strongly from a binomial (e.g. large over-dispersion, small values of `theta`), the `wilcoxExt` function can offer improved performance, in terms of recovery of the true partition of cell types by allelic imbalance. The partition is decided based on a loss function motivated by the Bayesian Information Criteria.

```
thrs <- 10^seq(from = -2, to = -0.4, by = 0.2)
sce_sub_w <- wilcoxExt(sce, genecluster = 1, threshold = thrs)
knitr::kable(metadata(sce_sub_w)$partition, row.names = FALSE)
```

| part | x |
| --- | --- |
| 1 | ct1 |
| 1 | ct2 |
| 2 | ct3 |
| 2 | ct4 |

```
metadata(sce_sub_w)$threshold
```

```
## [1] 0.01
```

## Calculating allelic ratio estimates via beta-binomial model

After *airpart* determines a partition of cell types either by the fused lasso with binomial likelihood or the nonparametric approach described above, it uses those fused lasso estimates or weighted means as the center of a Cauchy prior for posterior estimation of allelic ratios per cell type and per gene. Posterior mean and credible intervals are provided. The posterior inference makes use of a beta-binomial likelihood, and a moderated estimate of the over-dispersion. The prior from the partition and the moderated estimate of over-dispersion are provided to the `apeglm` function from the Bioconductor package of the same name.

Note that the estimates and credible intervals are not equal for cell types in the same partition and for genes, because in this step we re-estimate the conditional cell type means per cell type (not per partition) and account for each gene’s moderated estimate of over-dispersion.

```
sce_sub <- allelicRatio(sce_sub, DAItest = TRUE)
makeForest(sce_sub, showtext = TRUE)
```

```
## svalue shown in columns per cell type
```

![](data:image/png;base64...)

Allelic ratio estimates (`ar`) as well as `svalue` and credible interval (`lower` and `upper`) are stored in `rowData`. Can use `extractResult` function to derive them.

```
genepoi <- paste0("gene", seq_len(5))
ar <- extractResult(sce_sub)
knitr::kable(ar[genepoi,])
```

|  | ct1 | ct2 | ct3 | ct4 |
| --- | --- | --- | --- | --- |
| gene1 | 0.253 | 0.253 | 0.758 | 0.758 |
| gene2 | 0.186 | 0.186 | 0.790 | 0.790 |
| gene3 | 0.241 | 0.241 | 0.801 | 0.801 |
| gene4 | 0.289 | 0.289 | 0.816 | 0.816 |
| gene5 | 0.210 | 0.210 | 0.815 | 0.815 |

```
makeStep(sce_sub[genepoi,])
```

![](data:image/png;base64...)

### Derive statistical inference

To derive statistical inference of allelic imbalance(AI), we suggest a low aggregate probability of false-sign-or-small (FSOS) events (s-value < .005) or examine credible intervals not overlapping an allelic ratio of 0.5. Here all selected 5 genes demonstrated AI on each cell type.

```
s <- extractResult(sce_sub, "svalue")
apply(s[genepoi,],2, function(s){s<0.005})
```

```
##        ct1  ct2  ct3  ct4
## gene1 TRUE TRUE TRUE TRUE
## gene2 TRUE TRUE TRUE TRUE
## gene3 TRUE TRUE TRUE TRUE
## gene4 TRUE TRUE TRUE TRUE
## gene5 TRUE TRUE TRUE TRUE
```

To derive statistical inference of dynamic AI(DAI), raw p values from likelihood ratio test(LRT) and Benjamini-Hochberg (BH) corrected p value are stored in `p.value` and `adj.p.value`, respectively. Here all 25 genes demonstrated DAI across cells.

```
adj.p <- mcols(sce_sub)$adj.p.value
adj.p < 0.05
```

```
##  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [16] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
```

# Allelic ratio partition and posterior inference, example II

To demonstrate showing partition results on a heatmap, let’s make a more complex simulation, with 8 cell types, in 3 true groups by allelic ratio. In the code below, we construct the more complex simulation, run preprocessing, and examine the allelic ratio heatmap.

```
nct <- 8
p.vec <- (rep(c(
  -3, 0, -3, 3,
  rep(0, nct / 2),
  2, 3, 4, 2
), each = 2) + 5) / 10
sce <- makeSimulatedData(
  mu1 = 2, mu2 = 10, nct = nct, n = 30,
  ngenecl = 50, theta = 20, ncl = 3, p.vec = p.vec
)
sce <- preprocess(sce)

cellQCmetrics <- cellQC(sce, mad_detected = 4)
keep_cell <- (
  cellQCmetrics$filter_sum | # sufficient features (genes)
    cellQCmetrics$filter_detected | # sufficient molecules counted
    # sufficient features expressed compared to spike genes,
    # high quality cells
    cellQCmetrics$filter_spike
)
sce <- sce[, keep_cell]

featureQCmetric <- featureQC(sce)
keep_feature <- (featureQCmetric$filter_celltype &
  featureQCmetric$filter_sd &
  featureQCmetric$filter_spike)
sce <- sce[keep_feature, ]

makeHeatmap(sce)
```

![](data:image/png;base64...)

We can then perform gene clustering:

```
sce <- geneCluster(sce, G = 1:4)
```

```
## model-based optimal number of clusters: 3
```

![](data:image/png;base64...)

```
table(mcols(sce)$cluster)
```

```
##
##  1  2  3
## 50 16 50
```

We check for experiment-wide beta-binomial over-dispersion. Note that larger `theta` (y-axis) corresponds to *less* over-dispersion.

We focus on the first gene cluster (if a gene cluster is not provided, `estDisp` will choose the largest cluster).

```
estDisp(sce, genecluster = 1)
```

```
## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

![](data:image/png;base64...)

We identify an interesting gene cluster and run the fused lasso.

```
sce_sub <- fusedLasso(sce,
  model = "binomial",
  genecluster = 1, ncores = 1
)
```

```
knitr::kable(metadata(sce_sub)$partition, row.names = FALSE)
```

| part | x | coef |
| --- | --- | --- |
| 1 | ct1 | -1.3883646 |
| 1 | ct2 | -1.3883646 |
| 2 | ct3 | -0.0226667 |
| 2 | ct4 | -0.0226667 |
| 1 | ct5 | -1.3883646 |
| 1 | ct6 | -1.3883646 |
| 3 | ct7 | 1.4140601 |
| 3 | ct8 | 1.4140601 |

Next we estimate allelic ratios per cell type and per gene, with credible intervals. For demonstration, we subset to the first 10 genes.

```
sce_sub2 <- sce_sub[1:10, ]
sce_sub2 <- allelicRatio(sce_sub2)
```

We plot all cell types together, but one can set `ctpoi=c(1,3,7)` to limit the cell types to be plotted when there are too many cell types. And one can set `genepoi=c(1,3,7)` or `genepoi=c("gene1","gene3","gene7")` to only plot selected genes.

```
makeForest(sce_sub2)
```

```
## svalue shown in columns per cell type
```

![](data:image/png;base64...)

```
ar <- extractResult(sce_sub2)
knitr::kable(ar)
```

|  | ct1 | ct2 | ct3 | ct4 | ct5 | ct6 | ct7 | ct8 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| gene1 | 0.194 | 0.194 | 0.510 | 0.510 | 0.194 | 0.194 | 0.814 | 0.814 |
| gene2 | 0.215 | 0.215 | 0.520 | 0.520 | 0.215 | 0.215 | 0.794 | 0.794 |
| gene3 | 0.213 | 0.213 | 0.502 | 0.502 | 0.213 | 0.213 | 0.808 | 0.808 |
| gene4 | 0.215 | 0.215 | 0.524 | 0.524 | 0.215 | 0.215 | 0.808 | 0.808 |
| gene5 | 0.217 | 0.217 | 0.498 | 0.498 | 0.217 | 0.217 | 0.789 | 0.789 |
| gene6 | 0.203 | 0.203 | 0.456 | 0.456 | 0.203 | 0.203 | 0.784 | 0.784 |
| gene7 | 0.180 | 0.180 | 0.490 | 0.490 | 0.180 | 0.180 | 0.875 | 0.875 |
| gene8 | 0.228 | 0.228 | 0.483 | 0.483 | 0.228 | 0.228 | 0.781 | 0.781 |
| gene9 | 0.189 | 0.189 | 0.543 | 0.543 | 0.189 | 0.189 | 0.812 | 0.812 |
| gene10 | 0.190 | 0.190 | 0.499 | 0.499 | 0.190 | 0.190 | 0.823 | 0.823 |

A violin plot with posterior mean allelic ratios (one estimate per gene) on the y-axis:

```
makeViolin(sce_sub2)
```

```
## Joining with `by = join_by(x)`
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the airpart package.
##   Please report the issue at <https://github.com/Wancen/airpart/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Finally, a heatmap as before, but now with the cell types grouped according to the partition:

```
makeHeatmap(sce_sub2)
```

![](data:image/png;base64...)

The heatmap can also be shown ordered by cell type.

```
makeHeatmap(sce_sub2, order_by_group = FALSE)
```

![](data:image/png;base64...)

# Session Info

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
##  [1] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           airpart_1.18.0
##
## loaded via a namespace (and not attached):
##   [1] pbapply_1.7-4         gridExtra_2.3         rlang_1.1.6
##   [4] magrittr_2.0.4        clue_0.3-66           GetoptLong_1.0.5
##   [7] smurf_1.1.8           scater_1.38.0         compiler_4.5.1
##  [10] mgcv_1.9-3            png_0.1-8             vctrs_0.6.5
##  [13] pkgconfig_2.0.3       shape_1.4.6.1         crayon_1.5.3
##  [16] fastmap_1.2.0         magick_2.9.0          backports_1.5.0
##  [19] XVector_0.50.0        labeling_0.4.3        scuttle_1.20.0
##  [22] rmarkdown_2.30        forestplot_3.1.7      ggbeeswarm_0.7.2
##  [25] purrr_1.1.0           catdata_1.2.4         xfun_0.53
##  [28] glmnet_4.1-10         cachem_1.1.0          beachmat_2.26.0
##  [31] jsonlite_2.0.0        DelayedArray_0.36.0   BiocParallel_1.44.0
##  [34] irlba_2.3.5.1         parallel_4.5.1        cluster_2.1.8.1
##  [37] R6_2.6.1              bslib_0.9.0           RColorBrewer_1.1-3
##  [40] jquerylib_0.1.4       numDeriv_2016.8-1.1   Rcpp_1.1.0
##  [43] iterators_1.0.14      knitr_1.50            Matrix_1.7-4
##  [46] splines_4.5.1         tidyselect_1.2.1      viridis_0.6.5
##  [49] dichromat_2.0-0.1     abind_1.4-8           yaml_2.3.10
##  [52] doParallel_1.0.17     codetools_0.2-20      lattice_0.22-7
##  [55] tibble_3.3.0          plyr_1.8.9            withr_3.0.2
##  [58] S7_0.2.0              coda_0.19-4.1         evaluate_1.0.5
##  [61] survival_3.8-3        lpSolve_5.6.23        circlize_0.4.16
##  [64] mclust_6.1.1          pillar_1.11.1         checkmate_2.3.3
##  [67] foreach_1.5.2         emdbook_1.3.14        ggplot2_4.0.0
##  [70] scales_1.4.0          glue_1.8.0            tools_4.5.1
##  [73] apeglm_1.32.0         BiocNeighbors_2.4.0   ScaledMatrix_1.18.0
##  [76] mvtnorm_1.3-3         Cairo_1.7-0           grid_4.5.1
##  [79] tidyr_1.3.1           bbmle_1.0.25.1        bdsmatrix_1.3-7
##  [82] colorspace_2.1-2      nlme_3.1-168          beeswarm_0.4.0
##  [85] BiocSingular_1.26.0   vipor_0.4.7           cli_3.6.5
##  [88] rsvd_1.0.5            viridisLite_0.4.2     S4Arrays_1.10.0
##  [91] ComplexHeatmap_2.26.0 dplyr_1.1.4           gtable_0.3.6
##  [94] dynamicTreeCut_1.63-1 sass_0.4.10           digest_0.6.37
##  [97] ggrepel_0.9.6         SparseArray_1.10.0    rjson_0.2.23
## [100] farver_2.1.2          htmltools_0.5.8.1     lifecycle_1.0.4
## [103] GlobalOptions_0.1.2   MASS_7.3-65
```