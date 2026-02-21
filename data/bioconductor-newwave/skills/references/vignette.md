# Dimensionality reduction and batch effect removal using NewWave

* [Installation](#installation)
* [Introduction](#introduction)
* [NewWave](#newwave)
  + [Standard usage](#standard-usage)
  + [Commonwise dispersion and minibatch approaches](#commonwise-dispersion-and-minibatch-approaches)
  + [Genewise dispersion mini-batch](#genewise-dispersion-mini-batch)
* [Session Information](#session-information)

# Installation

First of all we need to install NewWave:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("NewWave")
```

```
suppressPackageStartupMessages(
  {library(SingleCellExperiment)
library(splatter)
library(irlba)
library(Rtsne)
library(ggplot2)
library(mclust)
library(NewWave)}
)
```

# Introduction

NewWave is a new package that assumes a Negative Binomial distributions for dimensionality reduction and batch effect removal. In order to reduce the memory consumption it uses a PSOCK cluster combined with the R package SharedObject that allow to share a matrix between different cores without memory duplication. Thanks to that we can massively parallelize the estimation process with huge benefit in terms of time consumption. We can reduce even more the time consumption using some minibatch approaches on the different steps of the optimization.

I am going to show how to use NewWave with example data generated with Splatter.

```
params <- newSplatParams()
N=500
set.seed(1234)
data <- splatSimulateGroups(params,batchCells=c(N/2,N/2),
                           group.prob = rep(0.1,10),
                           de.prob = 0.2,
                           verbose = FALSE)
```

Now we have a dataset with 500 cells and 10000 genes, I will use only the 500 most variable genes. NewWave takes as input raw data, not normalized.

```
set.seed(12359)
hvg <- rowVars(counts(data))
names(hvg) <- rownames(counts(data))
data <- data[names(sort(hvg,decreasing=TRUE))[1:500],]
```

As you can see there is a variable called batch in the colData section.

```
colData(data)
#> DataFrame with 500 rows and 4 columns
#>                Cell       Batch    Group ExpLibSize
#>         <character> <character> <factor>  <numeric>
#> Cell1         Cell1      Batch1  Group6     60505.9
#> Cell2         Cell2      Batch1  Group8     83417.7
#> Cell3         Cell3      Batch1  Group10    59819.5
#> Cell4         Cell4      Batch1  Group4     61737.5
#> Cell5         Cell5      Batch1  Group9     57098.0
#> ...             ...         ...      ...        ...
#> Cell496     Cell496      Batch2  Group4     44253.8
#> Cell497     Cell497      Batch2  Group5     76451.1
#> Cell498     Cell498      Batch2  Group10    55887.0
#> Cell499     Cell499      Batch2  Group7     60975.4
#> Cell500     Cell500      Batch2  Group3     39330.4
```

**IMPORTANT:** For batch effecr removal the batch variable must be a factor

```
data$Batch <- as.factor(data$Batch)
```

We also have a variable called Group that represent the cell type labels.

We can see the how the cells are distributed between group and batch

```
pca <- prcomp_irlba(t(counts(data)),n=10)
plot_data <-data.frame(Rtsne(pca$x)$Y)
```

```
plot_data$batch <- data$Batch
plot_data$group <- data$Group
```

```
ggplot(plot_data, aes(x=X1,y=X2,col=group, shape=batch))+ geom_point()
```

![](data:image/png;base64...)

There is a clear batch effect between the cells.

Let’s try to correct it.

# NewWave

I am going to show different implementation and the suggested way to use them with the given hardware.

Some advise:

* Verbose option has default FALSE, in this vignette I will change it for explanatory intentions, don’t do it with big dataset because it can sensibly slower the computation
* There are no concern about the dimension of mini-batches, I always used the 10% of the observations

## Standard usage

This is the way to insert the batch variable, in the same manner can be inserted other cell-related variable and if you need some gene related variable those can be inserted in V.

```
res <- newWave(data,X = "~Batch", K=10, verbose = TRUE)
#> Time of setup
#>    user  system elapsed
#>   0.007   0.003   0.346
#> Time of initialization
#>    user  system elapsed
#>   0.068   0.008   0.625
#> Iteration 1
#> penalized log-likelihood = -1293635.45974089
#> Time of dispersion optimization
#>    user  system elapsed
#>   0.786   0.033   0.820
#> after optimize dispersion = -1055587.73116427
#> Time of right optimization
#>    user  system elapsed
#>   0.001   0.000   8.207
#> after right optimization= -1054861.48759679
#> after orthogonalization = -1054861.45926985
#> Time of left optimization
#>    user  system elapsed
#>   0.001   0.000   7.215
#> after left optimization= -1054511.50191077
#> after orthogonalization = -1054511.49839777
#> Iteration 2
#> penalized log-likelihood = -1054511.49839777
#> Time of dispersion optimization
#>    user  system elapsed
#>   0.835   0.006   0.841
#> after optimize dispersion = -1054504.49817446
#> Time of right optimization
#>    user  system elapsed
#>   0.001   0.001   6.788
#> after right optimization= -1054467.22841251
#> after orthogonalization = -1054467.22572187
#> Time of left optimization
#>    user  system elapsed
#>   0.001   0.000   5.663
#> after left optimization= -1054454.79556159
#> after orthogonalization = -1054454.79549876
```

In order to make it faster you can increase the number of cores using “children” parameter:

```
res2 <- newWave(data,X = "~Batch", K=10, verbose = TRUE, children=2)
#> Time of setup
#>    user  system elapsed
#>   0.009   0.005   0.355
#> Time of initialization
#>    user  system elapsed
#>   0.040   0.004   0.437
#> Iteration 1
#> penalized log-likelihood = -1293635.4598092
#> Time of dispersion optimization
#>    user  system elapsed
#>   0.780   0.031   0.810
#> after optimize dispersion = -1055587.73050395
#> Time of right optimization
#>    user  system elapsed
#>   0.001   0.000   4.426
#> after right optimization= -1054861.53754465
#> after orthogonalization = -1054861.50922987
#> Time of left optimization
#>    user  system elapsed
#>   0.001   0.000   3.713
#> after left optimization= -1054511.56957854
#> after orthogonalization = -1054511.56605648
#> Iteration 2
#> penalized log-likelihood = -1054511.56605648
#> Time of dispersion optimization
#>    user  system elapsed
#>   0.867   0.035   0.903
#> after optimize dispersion = -1054504.56576977
#> Time of right optimization
#>    user  system elapsed
#>   0.001   0.000   3.596
#> after right optimization= -1054467.23819035
#> after orthogonalization = -1054467.23549864
#> Time of left optimization
#>    user  system elapsed
#>   0.001   0.000   2.949
#> after left optimization= -1054454.69433455
#> after orthogonalization = -1054454.69427628
```

## Commonwise dispersion and minibatch approaches

If you do not have an high number of cores to run newWave this is the fastest way to run. The optimization process is done by three process itereated until convercence.

* Optimization of the dispersion parameters
* Optimization of the gene related parameters
* Optimization of the cell related parameters

Each of these three steps can be accelerated using mini batch, the number of observation is settled with these parameters:

* n\_gene\_disp : Number of genes to use in the dispersion optimization
* n\_cell\_par : Number of cells to use in the cells related parameters optimization
* n\_gene\_par : Number of genes to use in the genes related parameters optimization

```
res3 <- newWave(data,X = "~Batch", verbose = TRUE,K=10, children=2,
                n_gene_disp = 100, n_gene_par = 100, n_cell_par = 100)
#> Time of setup
#>    user  system elapsed
#>   0.011   0.004   0.349
#> Time of initialization
#>    user  system elapsed
#>   0.046   0.007   0.404
#> Iteration 1
#> penalized log-likelihood = -1293635.45974249
#> Time of dispersion optimization
#>    user  system elapsed
#>   0.778   0.025   0.803
#> after optimize dispersion = -1055587.73002721
#> Time of right optimization
#>    user  system elapsed
#>   0.001   0.000   4.195
#> after right optimization= -1054861.48446618
#> after orthogonalization = -1054861.45614201
#> Time of left optimization
#>    user  system elapsed
#>   0.001   0.001   3.708
#> after left optimization= -1054511.54281145
#> after orthogonalization = -1054511.53932077
#> Iteration 2
#> penalized log-likelihood = -1054511.53932077
#> Time of dispersion optimization
#>    user  system elapsed
#>   0.272   0.009   0.281
#> after optimize dispersion = -1054511.53932077
#> Time of right optimization
#>    user  system elapsed
#>   0.001   0.001   0.785
#> after right optimization= -1054503.7368237
#> after orthogonalization = -1054503.7361842
#> Time of left optimization
#>    user  system elapsed
#>   0.001   0.000   0.438
#> after left optimization= -1054503.35025313
#> after orthogonalization = -1054503.350193
```

## Genewise dispersion mini-batch

If you have a lot of core disposable or you want to estimate a genewise dispersion parameter this is the fastes configuration:

```
res3 <- newWave(data,X = "~Batch", verbose = TRUE,K=10, children=2,
                n_gene_par = 100, n_cell_par = 100, commondispersion = FALSE)
#> Time of setup
#>    user  system elapsed
#>   0.008   0.005   0.349
#> Time of initialization
#>    user  system elapsed
#>   0.059   0.007   0.421
#> Iteration 1
#> penalized log-likelihood = -1293635.45990226
#> Time of dispersion optimization
#>    user  system elapsed
#>   0.787   0.017   0.804
#> after optimize dispersion = -1055587.73106585
#> Time of right optimization
#>    user  system elapsed
#>   0.001   0.000   4.206
#> after right optimization= -1054861.48692892
#> after orthogonalization = -1054861.45860848
#> Time of left optimization
#>    user  system elapsed
#>   0.000   0.001   3.705
#> after left optimization= -1054511.51443731
#> after orthogonalization = -1054511.51091728
#> Iteration 2
#> penalized log-likelihood = -1054511.51091728
#> Time of dispersion optimization
#>    user  system elapsed
#>   0.063   0.001   0.635
#> after optimize dispersion = -1050709.50730709
#> Time of right optimization
#>    user  system elapsed
#>   0.001   0.000   0.702
#> after right optimization= -1050702.57964432
#> after orthogonalization = -1050702.57790283
#> Time of left optimization
#>    user  system elapsed
#>   0.001   0.000   0.733
#> after left optimization= -1050673.13205389
#> after orthogonalization = -1050673.13131247
#> Iteration 3
#> penalized log-likelihood = -1050673.13131247
#> Time of dispersion optimization
#>    user  system elapsed
#>   0.063   0.000   0.252
#> after optimize dispersion = -1050673.14746163
#> Time of right optimization
#>    user  system elapsed
#>   0.001   0.000   0.663
#> after right optimization= -1050667.29700769
#> after orthogonalization = -1050667.29645896
#> Time of left optimization
#>    user  system elapsed
#>   0.000   0.001   0.658
#> after left optimization= -1050644.69784062
#> after orthogonalization = -1050644.69722011
```

NB: do not use n\_gene\_disp in this case, it will slower the computation.

Now I can use the latent dimension rapresentation for visualization purpose:

```
latent <- reducedDim(res)

tsne_latent <- data.frame(Rtsne(latent)$Y)
tsne_latent$batch <- data$Batch
tsne_latent$group <- data$Group
```

```
ggplot(tsne_latent, aes(x=X1,y=X2,col=group, shape=batch))+ geom_point()
```

![](data:image/png;base64...)

or for clustering:

```
cluster <- kmeans(latent, 10)

adjustedRandIndex(cluster$cluster, data$Group)
#> [1] 0.4848337
```

# Session Information

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
#>  [1] NewWave_1.20.0              mclust_6.1.1
#>  [3] ggplot2_4.0.0               Rtsne_0.17
#>  [5] irlba_2.3.5.1               Matrix_1.7-4
#>  [7] splatter_1.34.0             SingleCellExperiment_1.32.0
#>  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [11] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [13] IRanges_2.44.0              S4Vectors_0.48.0
#> [15] BiocGenerics_0.56.0         generics_0.1.4
#> [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
#>  [4] lattice_0.22-7      vctrs_0.6.5         tools_4.5.1
#>  [7] parallel_4.5.1      tibble_3.3.0        pkgconfig_2.0.3
#> [10] SharedObject_1.24.0 checkmate_2.3.3     RColorBrewer_1.1-3
#> [13] S7_0.2.0            lifecycle_1.0.4     compiler_4.5.1
#> [16] farver_2.1.2        codetools_0.2-20    htmltools_0.5.8.1
#> [19] sass_0.4.10         yaml_2.3.10         pillar_1.11.1
#> [22] jquerylib_0.1.4     BiocParallel_1.44.0 DelayedArray_0.36.0
#> [25] cachem_1.1.0        abind_1.4-8         rsvd_1.0.5
#> [28] tidyselect_1.2.1    locfit_1.5-9.12     digest_0.6.37
#> [31] BiocSingular_1.26.0 dplyr_1.1.4         labeling_0.4.3
#> [34] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
#> [37] SparseArray_1.10.0  magrittr_2.0.4      S4Arrays_1.10.0
#> [40] dichromat_2.0-0.1   withr_3.0.2         scales_1.4.0
#> [43] backports_1.5.0     rmarkdown_2.30      XVector_0.50.0
#> [46] beachmat_2.26.0     ScaledMatrix_1.18.0 evaluate_1.0.5
#> [49] knitr_1.50          rlang_1.1.6         Rcpp_1.1.0
#> [52] glue_1.8.0          jsonlite_2.0.0      R6_2.6.1
```