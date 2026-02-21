# Introduction to densvis

Alan O'Callaghan\*

\*alan.ocallaghan@outlook.com

#### 4 November 2025

#### Package

densvis 1.20.1

# 1 Introduction

Non-linear dimensionality reduction techniques such as t-SNE (Maaten and Hinton [2008](#ref-Maaten2008))
and UMAP (McInnes, Healy, and Melville [2020](#ref-McInnes2020)) produce a low-dimensional embedding that summarises
the global structure of high-dimensional data. These techniques can be
particularly useful when visualising high-dimensional data in a biological
setting.
However, these embeddings may not accurately represent the local density
of data in the original space, resulting in misleading visualisations where
the space given to clusters of data does not represent the fraction of the
high dimensional space that they occupy.
`densvis` implements the density-preserving objective function described by
(Narayan, Berger, and Cho [2020](#ref-Narayan2020)) which aims to address this deficiency by including a
density-preserving term in the t-SNE and UMAP optimisation procedures.
This can enable the creation of visualisations that accurately capture
differing degrees of transcriptional heterogeneity within different cell
subpopulations in scRNAseq experiments, for example.

# 2 Setting up the data

We will illustrate the use of densvis
using simulated data.
We will first load the `densvis` and `Rtsne` libraries
and set a random seed to ensure the t-SNE visualisation is reproducible
(note: it is good practice to ensure that a t-SNE embedding is robust
by running the algorithm multiple times).

```
library("densvis")
library("Rtsne")
library("uwot")
library("ggplot2")
theme_set(theme_bw())
set.seed(14)
```

```
data <- data.frame(
    x = c(rnorm(1000, 5), rnorm(1000, 0, 0.2)),
    y = c(rnorm(1000, 5), rnorm(1000, 0, 0.2)),
    class = c(rep("Class 1", 1000), rep("Class 2", 1000))
)
ggplot() +
    aes(data[, 1], data[, 2], colour = data$class) +
    geom_point(pch = 19) +
    scale_colour_discrete(name = "Cluster") +
    ggtitle("Original co-ordinates")
```

![](data:image/png;base64...)

# 3 Running t-SNE

Density-preserving t-SNE can be generated using the `densne`
function. This function returns a matrix of t-SNE co-ordinates.
We set `dens_frac` (the fraction of optimisation steps that consider
the density preservation) and `dens_lambda` (the weight given to density
preservation relative to the standard t-SNE objective) each to 0.5.

```
fit1 <- densne(data[, 1:2], dens_frac = 0.5, dens_lambda = 0.5)
ggplot() +
    aes(fit1[, 1], fit1[, 2], colour = data$class) +
    geom_point(pch = 19) +
    scale_colour_discrete(name = "Class") +
    ggtitle("Density-preserving t-SNE") +
    labs(x = "t-SNE 1", y = "t-SNE 2")
```

![](data:image/png;base64...)

If we run t-SNE on the same data, we can see that the density-preserving
objective better represents the density of the data,

```
fit2 <- Rtsne(data[, 1:2])
ggplot() +
    aes(fit2$Y[, 1], fit2$Y[, 2], colour = data$class) +
    geom_point(pch = 19) +
    scale_colour_discrete(name = "Class") +
    ggtitle("Standard t-SNE") +
    labs(x = "t-SNE 1", y = "t-SNE 2")
```

![](data:image/png;base64...)

# 4 Running UMAP

A density-preserving UMAP embedding can be generated using the `densmap`
function. This function returns a matrix of UMAP co-ordinates. As with t-SNE,
we set `dens_frac` (the fraction of optimisation steps that consider
the density preservation) and `dens_lambda` (the weight given to density
preservation relative to the standard t-SNE objective) each to 0.5.

```
fit1 <- densmap(data[, 1:2], dens_frac = 0.5, dens_lambda = 0.5)
#> Using Python: /home/biocbuild/.pyenv/versions/3.12.10/bin/python3.12
#> Creating virtual environment '/var/cache/basilisk/1.22.0/densvis/1.20.1/densvis' ...
#> Done!
#> Installing packages: pip, wheel, setuptools
#> Installing packages: 'umap-learn==0.5.9.post2', 'scikit-learn==1.7.0', 'numba==0.62.0', 'pynndescent==0.5.13', 'scipy==1.16.0', 'numpy==2.3.4', 'llvmlite==0.45.0'
#> Virtual environment '/var/cache/basilisk/1.22.0/densvis/1.20.1/densvis' successfully created.
ggplot() +
    aes(fit1[, 1], fit1[, 2], colour = data$class) +
    geom_point(pch = 19) +
    scale_colour_discrete(name = "Class") +
    ggtitle("Density-preserving t-SNE") +
    labs(x = "t-SNE 1", y = "t-SNE 2")
```

![](data:image/png;base64...)

If we run UMAP on the same data, we can see that the density-preserving
objective better represents the density of the data,

```
fit2 <- umap(data[, 1:2])
ggplot() +
    aes(fit2[, 1], fit2[, 2], colour = data$class) +
    geom_point(pch = 19) +
    scale_colour_discrete(name = "Class") +
    ggtitle("Standard t-SNE") +
    labs(x = "t-SNE 1", y = "t-SNE 2")
```

![](data:image/png;base64...)

# Session information

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] ggplot2_4.0.0    uwot_0.2.3       Matrix_1.7-4     Rtsne_0.17
#> [5] densvis_1.20.1   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] rappdirs_0.3.3      sass_0.4.10         generics_0.1.4
#>  [4] lattice_0.22-7      digest_0.6.37       magrittr_2.0.4
#>  [7] evaluate_1.0.5      grid_4.5.1          RColorBrewer_1.1-3
#> [10] bookdown_0.45       fastmap_1.2.0       jsonlite_2.0.0
#> [13] tinytex_0.57        BiocManager_1.30.26 scales_1.4.0
#> [16] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
#> [19] withr_3.0.2         cachem_1.1.0        yaml_2.3.10
#> [22] FNN_1.1.4.1         tools_4.5.1         dir.expiry_1.18.0
#> [25] parallel_4.5.1      dplyr_1.1.4         filelock_1.0.3
#> [28] basilisk_1.22.0     reticulate_1.44.0   assertthat_0.2.1
#> [31] vctrs_0.6.5         R6_2.6.1            png_0.1-8
#> [34] lifecycle_1.0.4     magick_2.9.0        pkgconfig_2.0.3
#> [37] bslib_0.9.0         pillar_1.11.1       gtable_0.3.6
#> [40] glue_1.8.0          Rcpp_1.1.0          xfun_0.54
#> [43] tibble_3.3.0        tidyselect_1.2.1    knitr_1.50
#> [46] dichromat_2.0-0.1   farver_2.1.2        htmltools_0.5.8.1
#> [49] rmarkdown_2.30      labeling_0.4.3      compiler_4.5.1
#> [52] S7_0.2.0
```

Maaten, Laurens van der, and Geoffrey Hinton. 2008. “Visualizing Data Using T-Sne.” *Journal of Machine Learning Research* 9 (Nov): 2579–2605.

McInnes, Leland, John Healy, and James Melville. 2020. “UMAP: Uniform Manifold Approximation and Projection for Dimension Reduction.” <http://arxiv.org/abs/1802.03426>.

Narayan, Ashwin, Bonnie Berger, and Hyunghoon Cho. 2020. “Density-Preserving Data Visualization Unveils Dynamic Patterns of Single-Cell Transcriptomic Variability.” *bioRxiv*. <https://doi.org/10.1101/2020.05.12.077776>.