# Introduction to snifter

Alan O'Callaghan\*

\*alan.ocallaghan@outlook.com

#### 30 October 2025

#### Package

snifter 1.20.0

# 1 Introduction

snifter provides an R wrapper for the [openTSNE](https://opentsne.readthedocs.io/en/latest/)
implementation of fast interpolated t-SNE (FI-tSNE).
It is based on *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* and *[reticulate](https://CRAN.R-project.org/package%3Dreticulate)*.
This vignette aims to provide a brief overview of typical use
when applied to scRNAseq data, but it does not provide a comprehensive
guide to the available options in the package.

It is highly advisable to review the documentation in snifter and the
[openTSNE documentation](https://opentsne.readthedocs.io/en/latest/)
to gain a full understanding of the available options.

# 2 Setting up the data

We will illustrate the use of snifter by generating some toy data.
First, we’ll load the needed libraries, and set a random seed to
ensure the simulated data are reproducible
(note: it is good practice to ensure that a t-SNE embedding is robust
by running the algorithm multiple times).

```
library("snifter")
library("ggplot2")
theme_set(theme_bw())
set.seed(42)

n_obs <- 500
n_feats <- 200
means_1 <- rnorm(n_feats)
means_2 <- rnorm(n_feats)
counts_a <- replicate(n_obs, rnorm(n_feats, means_1))
counts_b <- replicate(n_obs, rnorm(n_feats, means_2))
counts <- t(cbind(counts_a, counts_b))
label <- rep(c("A", "B"), each = n_obs)
```

# 3 Running t-SNE

The main functionality of the package lies in the `fitsne`
function. This function returns a matrix of t-SNE co-ordinates. In this case,
we pass in the 20 principal components computed based on the
log-normalised counts. We colour points based on the discrete
cell types identified by the authors.

```
fit <- fitsne(counts, random_state = 42L)
#> Using Python: /home/biocbuild/.pyenv/versions/3.12.10/bin/python3.12
#> Creating virtual environment '/var/cache/basilisk/1.22.0/snifter/1.20.0/fitsne' ...
#> Done!
#> Installing packages: pip, wheel, setuptools
#> Installing packages: 'opentsne==1.0.2', 'scikit-learn==1.7.0', 'scipy==1.16.0', 'numpy==2.3.1'
#> Virtual environment '/var/cache/basilisk/1.22.0/snifter/1.20.0/fitsne' successfully created.
ggplot() +
    aes(fit[, 1], fit[, 2], colour = label) +
    geom_point(pch = 19) +
    scale_colour_discrete(name = "Cluster") +
    labs(x = "t-SNE 1", y = "t-SNE 2")
```

![](data:image/png;base64...)

# 4 Projecting new data into an existing embedding

The openTNSE package, and by extension snifter,
also allows the embedding of new data into
an existing t-SNE embedding.
Here, we will split the data into “training”
and “test” sets. Following this, we generate a t-SNE embedding
using the training data, and project the test data into this embedding.

```
test_ind <- sample(nrow(counts), nrow(counts) / 2)
train_ind <- setdiff(seq_len(nrow(counts)), test_ind)
train_mat <- counts[train_ind, ]
test_mat <- counts[test_ind, ]

train_label <- label[train_ind]
test_label <- label[test_ind]

embedding <- fitsne(train_mat, random_state = 42L)
```

Once we have generated the embedding, we can now `project` the unseen test
data into this t-SNE embedding.

```
new_coords <- project(embedding, new = test_mat, old = train_mat)
ggplot() +
    geom_point(
        aes(embedding[, 1], embedding[, 2],
            colour = train_label,
            shape = "Train"
        )
    ) +
    geom_point(
        aes(new_coords[, 1], new_coords[, 2],
            colour = test_label,
            shape = "Test"
        )
    ) +
    scale_colour_discrete(name = "Cluster") +
    scale_shape_discrete(name = NULL) +
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
#> [1] ggplot2_4.0.0    snifter_1.20.0   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] Matrix_1.7-4        gtable_0.3.6        jsonlite_2.0.0
#>  [4] dplyr_1.1.4         compiler_4.5.1      BiocManager_1.30.26
#>  [7] filelock_1.0.3      tinytex_0.57        tidyselect_1.2.1
#> [10] Rcpp_1.1.0          magick_2.9.0        parallel_4.5.1
#> [13] dichromat_2.0-0.1   assertthat_0.2.1    jquerylib_0.1.4
#> [16] scales_1.4.0        png_0.1-8           yaml_2.3.10
#> [19] fastmap_1.2.0       reticulate_1.44.0   lattice_0.22-7
#> [22] R6_2.6.1            labeling_0.4.3      generics_0.1.4
#> [25] knitr_1.50          tibble_3.3.0        bookdown_0.45
#> [28] pillar_1.11.1       bslib_0.9.0         RColorBrewer_1.1-3
#> [31] rlang_1.1.6         cachem_1.1.0        dir.expiry_1.18.0
#> [34] xfun_0.53           sass_0.4.10         S7_0.2.0
#> [37] cli_3.6.5           withr_3.0.2         magrittr_2.0.4
#> [40] digest_0.6.37       grid_4.5.1          rappdirs_0.3.3
#> [43] basilisk_1.22.0     lifecycle_1.0.4     vctrs_0.6.5
#> [46] evaluate_1.0.5      glue_1.8.0          farver_2.1.2
#> [49] rmarkdown_2.30      pkgconfig_2.0.3     tools_4.5.1
#> [52] htmltools_0.5.8.1
```