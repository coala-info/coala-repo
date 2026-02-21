# The FEAST User’s Guide

Kenong Su\* and Hao Wu\*\*

\*kenong.su@emory.edu
\*\*hao.wu@emory.edu

#### 29 October 2025

#### Abstract

This vignette introduces the usage of the Bioconductor package FEAST (FEAture SelecTion for scRNA-seq data), which is specifically designed for selecting most representative genes before performing the core of clustering. It is demonstrated an improved clustering accuracy when recruting the featured genes selected by FEAST.

#### Package

FEAST 1.18.0

# 1 Installation and help

## 1.1 Install FEAST

To install this package, start R (version > “4.0”) and enter:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("FEAST")
```

## 1.2 Help for FEAST

If you have any FEAST-related questions, please post to the GitHub Issue section of FEAST at <https://github.com/suke18/FEAST/issues>, which will be helpful for the construction of FEAST.

# 2 Introduction

## 2.1 Background

Cell clustering is one of the most important and commonly performed tasks in single-cell RNA sequencing (scRNA-seq) data analysis. An important step in cell clustering is to select a subset of genes (referred to as “features”), whose expression patterns will then be used for downstream clustering. A good set of features should include the ones that distinguish different cell types, and the quality of such set could have significant impact on the clustering accuracy. All existing scRNA-seq clustering tools include a feature selection step relying on some simple unsupervised feature selection methods, mostly based on the statistical moments of gene-wise expression distributions. In this work, we develop a feature selection algorithm named FEAture SelecTion (FEAST), which provides more representative features.

## 2.2 Citation

* For consensus clustering, cite Strehl and Ghosh ([2002](#ref-strehl2002cluster)).
* For using (**FEAST**) feature selection procedure, Su, Yu, and Wu ([2021](#ref-su2021accurate))

## 2.3 Quick start

We use `Yan` dataset(Yan et al. [2013](#ref-yan2013single)) for the demonstration. This `Yan` dataset includes 6 cell types about human preimplantation embryos and embryonic stem cells. The users can run the **FEAST** or **FEAST\_fast** function to obtain the gene rankings (from the most significant to the least significant genes) of These featured genes are deemed to better contribute to the clustering accuracy. Here, we demonstrate that some of the top 9 selected genes are very informative (or known as marker genes e.g., CYYR1 ).

```
library(FEAST)
data(Yan)
k = length(unique(trueclass))
Y = process_Y(Y, thre = 2)
# The core function.
ixs = FEAST(Y, k=k)
# look at the features
Ynorm = Norm_Y(Y)
par(mfrow = c(3,3))
for (i in 1:9){
  tmp_ix = ixs[i]
  tmp_gene = rownames(Ynorm)[tmp_ix]
  boxplot(as.numeric(Ynorm[tmp_ix, ])~trueclass, main = tmp_gene, xlab="", ylab="", las=2)
}
```

![](data:image/png;base64...)

# 3 Using FEAST for scRNA-seq clustering analysis

FEAST requires a count expression matrix with rows representing the genes and columns representing the cells. To preprocess the count matrix, FEAST filters out the genes depending on the dropout rates (sometimes known as zero-expression rates). Alternatively, the users can input the normalized matrix (usually log transformed of relative abundance expression matrix (scaled by average sequencing depth)). Here, we use one template `Yan` (Yan et al. [2013](#ref-yan2013single)) dataset. It is important to note that FEAST requires the number of clusters (**k**) as an input, which can be obtained by the prior knowledge of the cell types.

## 3.1 Load the data

The `Yan` dataset is loaded with two objects including the count expression matrix (Y) and corresponding cell type information (trueclass). Other sample datasets can be downloaded at <https://drive.google.com/drive/u/0/folders/1SRT7mrX7ziJoSjuFLLkK8kjnUsJrabVM>. If the users want to use one Deng dataset(Deng et al. [2014](#ref-deng2014single)), the users can load the data and access the phenotype information by using `colData(Deng)` function, and the count expression matrix by using `assay(Deng,"counts")` function from the SummarizedExperiment Bioconductor package.

```
data(Yan)
dim(Y)
#> [1] 19304   124
table(trueclass)
#> trueclass
#>  2-cell  4-cell  8-cell    Late Morulae  Oocyte  Zygote    hESC
#>       6      12      20      30      16       3       3      34
```

## 3.2 Consensus clustering

To preprocess the count expression matrix (`Y`), FEAST filters out the genes based on the dropout rate (sometimes known as zero-expression rate). This consensus clustering step will output the initial clustering labels based on a modified CSPA algorithm. It will find the cells that tightly clustered together and possibly filter out the cells that are less correlated to the initial clustering centers.

```
Y = process_Y(Y, thre = 2) # preprocess the data if needed
con_res = Consensus(Y, k=k)
```

## 3.3 Calculate the gene-level significance

After the consensus clustering step, FEAST will generate the initial clustering labels with confidence. Based on the initial clustering outcomes, FEAST further infers the gene-level significance by using F-statistics followed by the ranking of the full list of genes.

```
F_res = cal_F2(Y, con_res$cluster)
ixs = order(F_res$F_scores, decreasing = TRUE) # order the features
```

## 3.4 Clustering and validation

After ranking the genes by F-statistics, FEAST curates a series of top number of features (genes). Then, FEAST input these top (by default `top = 500, 1000, 2000`) features into some established clustering algorithm such as SC3 (Kiselev et al. [2017](#ref-kiselev2017sc3)), which is regarded as the most accurate scRNA-seq clustering algorithm (Duò, Robinson, and Soneson [2018](#ref-duo2018systematic)). It is worth noting that one needs to confirm the **k** to be the same for every iteration.

After the clustering steps, with the case of unknown cell types, FEAST evaluates the quality of the feature set by computing the average distance between each cell and the clustering centers, which is the same as the MSE. It is noting that FEAST uses all the features (genes) for distance calculation for the purpose of fair comparisons. The clustering centers are obtained by using previous clustering step.

It is noted that FEAST is not limited to SC3 clustering. It also shows superior performance on other clustering methods such as TSCAN. The code for running SC3 and TSCAN are embedded in FEAST package, which can be access by **SC3\_Clust** and **TSCAN\_Clust**.

```
## clustering step
tops = c(500, 1000, 2000)
cluster_res = NULL
for (top in tops){
    tmp_ixs = ixs[1:top]
    tmp_markers = rownames(Y)[tmp_ixs]
    tmp_res = TSCAN_Clust(Y, k = k, input_markers = tmp_markers)
    #tmp_res = SC3_Clust(Y, k = k, input_markers = tmp_markers)
    cluster_res[[toString(top)]] = tmp_res
}
## validation step
Ynorm = Norm_Y(Y)
mse_res = NULL
for (top in names(cluster_res)){
    tmp_res = cluster_res[[top]]
    tmp_cluster = tmp_res$cluster
    tmp_mse = cal_MSE(Ynorm = Ynorm, cluster = tmp_cluster)
    mse_res = c(mse_res, tmp_mse)
}
names(mse_res) = names(cluster_res)
```

## 3.5 Compare to the real cell type labels

### 3.5.1 Benchmark with the original SC3

After the validation step, the feature set associated with the smallest MSE value will be recommended for the further analysis. Here, we demonstrate that an improved clustering accuracy by specifying the optimal feature set. The benchmark comparison is the original setting of established clustering algorithm (e.g. SC3).

```
original = TSCAN_Clust(Y, k=k)
id = which.min(mse_res)
eval_Cluster(original$cluster, trueclass)
eval_Cluster(cluster_res[[id]]$cluster, trueclass)
```

### 3.5.2 Show the clustering improvement by using figures

As demonstrated in the figure below, the first panel includes the PCA illustration of the cell types. The second panel shows the clustering result by the original SC3, in which some cells (inside the gray circle) are mixed. The third panel shows the improved clustering outcomes by inputing the optimized feature set into SC3. This is an example for the `Deng` dataset.
![](data:image/png;base64...)

# 4 Quick use step-by-step

The users can run the `Consensus` function and then run the `Select_Model_short_SC3` function; however, `Consensus` step could take a while especially for the large dataset (sample size is greater than 2000).

```
data(Yan)
Y = process_Y(Y, thre = 2) # preprocess the data if needed
con_res = Consensus(Y, k=k)
mod_res = Select_Model_short_TSCAN(Y, cluster = con_res$cluster, top = c(200, 500, 1000, 2000))
# mod_res = Select_Model_short_SC3(Y, cluster = con_res$cluster, top = c(200, 500, 1000, 2000))
# to visualize the result, one needs to load ggpubr library.
library(ggpubr)
PP = Visual_Rslt(model_cv_res = mod_res, trueclass = trueclass)
#> Warning in .f(y = .l[[1L]][[i]], data = .l[[2L]][[i]], x = .l[[3L]][[i]], : The
#> 'size' parameter for lines is deprecated in ggplot2 3.4.0+. Please use
#> 'linewidth' instead to avoid this warning in future versions.
print(PP$ggobj) # show the visualization plot.
```

![](data:image/png;base64...)
The result figure shows that the MSE validation process is concordant with the clustering accuracy trend. It demonstrated that using top 1000 featured genes can result in the highest clustering accuracy with improvement than the original setting.

# 5 Quick use by the wrapper function

To quickly obtain the ranking orders of the features, the users can directly apply `FEAST` function, which works perfectly fun on small dataset. For the large dataset, the users can consider change the dimention reduction method to *irlba* by specifying `dim_reduce="irlba"`. Moreover, the users can resort to `FEAST_fast` function for fast calculation on the large datasets. For extreme large dataset (sample size >5000), it will split the dataset equally into chucks and apply FEAST algorithm in parallel on individual splitted datasets. In this case, the users need to specify two parameters `split = TRUE`, and `batch_size = 1000` corresponding to the splitted size.

```
ixs = FEAST(Y, k=k)
#ixs = FEAST_fast(Y, k=k)
#ixs = FEAST_fast(Y, k=k, split=TRUE, batch_size = 1000)
```

# 6 Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] ggpubr_0.6.2                ggplot2_4.0.0
#>  [3] FEAST_1.18.0                SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0               IRanges_2.44.0
#>  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [11] generics_0.1.4              MatrixGenerics_1.22.0
#> [13] matrixStats_1.5.0           BiocParallel_1.44.0
#> [15] mclust_6.1.1                BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] bitops_1.0-9                rlang_1.1.6
#>   [3] magrittr_2.0.4              otel_0.2.0
#>   [5] e1071_1.7-16                compiler_4.5.1
#>   [7] mgcv_1.9-3                  vctrs_0.6.5
#>   [9] combinat_0.0-8              pkgconfig_2.0.3
#>  [11] fastmap_1.2.0               backports_1.5.0
#>  [13] magick_2.9.0                XVector_0.50.0
#>  [15] labeling_0.4.3              caTools_1.18.3
#>  [17] promises_1.4.0              rmarkdown_2.30
#>  [19] TSCAN_1.48.0                purrr_1.1.0
#>  [21] tinytex_0.57                xfun_0.53
#>  [23] WriteXLS_6.8.0              cachem_1.1.0
#>  [25] jsonlite_2.0.0              later_1.4.4
#>  [27] DelayedArray_0.36.0         broom_1.0.10
#>  [29] irlba_2.3.5.1               parallel_4.5.1
#>  [31] cluster_2.1.8.1             R6_2.6.1
#>  [33] bslib_0.9.0                 RColorBrewer_1.1-3
#>  [35] car_3.1-3                   rrcov_1.7-7
#>  [37] jquerylib_0.1.4             Rcpp_1.1.0
#>  [39] bookdown_0.45               iterators_1.0.14
#>  [41] knitr_1.50                  httpuv_1.6.16
#>  [43] Matrix_1.7-4                splines_4.5.1
#>  [45] igraph_2.2.1                tidyselect_1.2.1
#>  [47] dichromat_2.0-0.1           abind_1.4-8
#>  [49] yaml_2.3.10                 doParallel_1.0.17
#>  [51] gplots_3.2.0                codetools_0.2-20
#>  [53] doRNG_1.8.6.2               lattice_0.22-7
#>  [55] tibble_3.3.0                plyr_1.8.9
#>  [57] withr_3.0.2                 shiny_1.11.1
#>  [59] S7_0.2.0                    ROCR_1.0-11
#>  [61] evaluate_1.0.5              proxy_0.4-27
#>  [63] TrajectoryUtils_1.18.0      pillar_1.11.1
#>  [65] BiocManager_1.30.26         carData_3.0-5
#>  [67] rngtools_1.5.2              SC3_1.38.0
#>  [69] KernSmooth_2.23-26          foreach_1.5.2
#>  [71] pcaPP_2.0-5                 scales_1.4.0
#>  [73] fastICA_1.2-7               gtools_3.9.5
#>  [75] xtable_1.8-4                class_7.3-23
#>  [77] glue_1.8.0                  pheatmap_1.0.13
#>  [79] tools_4.5.1                 robustbase_0.99-6
#>  [81] ggsignif_0.6.4              mvtnorm_1.3-3
#>  [83] cowplot_1.2.0               grid_4.5.1
#>  [85] tidyr_1.3.1                 SingleCellExperiment_1.32.0
#>  [87] nlme_3.1-168                Formula_1.2-5
#>  [89] cli_3.6.5                   S4Arrays_1.10.0
#>  [91] dplyr_1.1.4                 gtable_0.3.6
#>  [93] DEoptimR_1.1-4              ggsci_4.1.0
#>  [95] rstatix_0.7.3               sass_0.4.10
#>  [97] digest_0.6.37               SparseArray_1.10.0
#>  [99] farver_2.1.2                htmltools_0.5.8.1
#> [101] lifecycle_1.0.4             mime_0.13
```

# Reference

Deng, Qiaolin, Daniel Ramsköld, Björn Reinius, and Rickard Sandberg. 2014. “Single-Cell Rna-Seq Reveals Dynamic, Random Monoallelic Gene Expression in Mammalian Cells.” *Science* 343 (6167): 193–96.

Duò, Angelo, Mark D Robinson, and Charlotte Soneson. 2018. “A Systematic Performance Evaluation of Clustering Methods for Single-Cell Rna-Seq Data.” *F1000Research* 7.

Kiselev, Vladimir Yu, Kristina Kirschner, Michael T Schaub, Tallulah Andrews, Andrew Yiu, Tamir Chandra, Kedar N Natarajan, et al. 2017. “SC3: Consensus Clustering of Single-Cell Rna-Seq Data.” *Nature Methods* 14 (5): 483–86.

Strehl, Alexander, and Joydeep Ghosh. 2002. “Cluster Ensembles—a Knowledge Reuse Framework for Combining Multiple Partitions.” *Journal of Machine Learning Research* 3 (Dec): 583–617.

Su, Kenong, Tianwei Yu, and Hao Wu. 2021. “Accurate Feature Selection Improves Single-Cell Rna-Seq Cell Clustering.” *Briefings in Bioinformatics*.

Yan, Liying, Mingyu Yang, Hongshan Guo, Lu Yang, Jun Wu, Rong Li, Ping Liu, et al. 2013. “Single-Cell Rna-Seq Profiling of Human Preimplantation Embryos and Embryonic Stem Cells.” *Nature Structural & Molecular Biology* 20 (9): 1131.