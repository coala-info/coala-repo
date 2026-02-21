Code

* Show All Code
* Hide All Code

# Introduction to spatialDE

Davide Corso1\*, Milan Malfait2\*\* and Lambda Moses3\*\*\*

1University of Padova
2Ghent University
3California Institute of Technology

\*davide.corso.2@phd.unipd.it
\*\*milan.malfait94@gmail.com
\*\*\*dlu2@caltech.edu

#### 30 October 2025

# 1 Introduction

[SpatialDE](https://github.com/Teichlab/SpatialDE) by [Svensson et al., 2018](https://www.nature.com/articles/nmeth.4636), is a method to identify spatially variable genes (SVGs) in spatially resolved transcriptomics data.

# 2 Installation

You can install *[spatialDE](https://bioconductor.org/packages/3.22/spatialDE)* from *Bioconductor* with the
following code:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("spatialDE")
```

# 3 Example: [Mouse Olfactory Bulb](https://github.com/Teichlab/SpatialDE/tree/master/Analysis/MouseOB)

Reproducing the
[example analysis](https://github.com/Teichlab/SpatialDE#spatialde-significance-test-example-use) from the original [SpatialDE](https://pypi.org/project/SpatialDE) Python package.

```
library(spatialDE)
library(ggplot2)
```

## 3.1 Load data

Files originally retrieved from SpatialDE GitHub repository from the following links:
<https://github.com/Teichlab/SpatialDE/blob/master/Analysis/MouseOB/data/Rep11_MOB_0.csv>
<https://github.com/Teichlab/SpatialDE/blob/master/Analysis/MouseOB/MOB_sample_info.csv>

```
# Expression file used in python SpatialDE.
data("Rep11_MOB_0")

# Sample Info file used in python SpatialDE
data("MOB_sample_info")
```

The `Rep11_MOB_0` object contains spatial expression data for
16218 genes on 262 spots, with genes as rows
and spots as columns.

```
Rep11_MOB_0[1:5, 1:5]
#>         16.92x9.015 16.945x11.075 16.97x10.118 16.939x12.132 16.949x13.055
#> Nrf1              1             0            0             1             0
#> Zbtb5             1             0            1             0             0
#> Ccnl1             1             3            1             1             0
#> Lrrfip1           2             2            0             0             3
#> Bbs1              1             2            0             4             0
dim(Rep11_MOB_0)
#> [1] 16218   262
```

The `MOB_sample_info` object contains a `data.frame` with coordinates for each
spot.

```
head(MOB_sample_info)
```

### 3.1.1 Filter out pratically unobserved genes

```
Rep11_MOB_0 <- Rep11_MOB_0[rowSums(Rep11_MOB_0) >= 3, ]
```

### 3.1.2 Get total\_counts for every spot

```
Rep11_MOB_0 <- Rep11_MOB_0[, row.names(MOB_sample_info)]
MOB_sample_info$total_counts <- colSums(Rep11_MOB_0)
head(MOB_sample_info)
```

### 3.1.3 Get coordinates from `MOB_sample_info`

```
X <- MOB_sample_info[, c("x", "y")]
head(X)
```

## 3.2 `stabilize`

The SpatialDE method assumes normally distributed data, so we stabilize the variance of the negative binomial distributed counts data using Anscombe’s approximation.
The `stabilize()` function takes as input a `data.frame` of expression values with samples in columns and genes in rows. Thus, in this case, we have to transpose the data.

```
norm_expr <- stabilize(Rep11_MOB_0)
#> Using Python: /home/biocbuild/.pyenv/versions/3.11.14/bin/python3.11
#> Creating virtual environment '/var/cache/basilisk/1.22.0/spatialDE/1.16.0/env' ...
#> + /home/biocbuild/.pyenv/versions/3.11.14/bin/python3.11 -m venv /var/cache/basilisk/1.22.0/spatialDE/1.16.0/env
#> Done!
#> Installing packages: pip, wheel, setuptools
#> + /var/cache/basilisk/1.22.0/spatialDE/1.16.0/env/bin/python -m pip install --upgrade pip wheel setuptools
#> Installing packages: 'numpy==1.26.4', 'scipy==1.11.4', 'patsy==1.0.1', 'pandas==1.5.3', 'SpatialDE==1.1.3', 'NaiveDE==1.2.0'
#> + /var/cache/basilisk/1.22.0/spatialDE/1.16.0/env/bin/python -m pip install --upgrade --no-user 'numpy==1.26.4' 'scipy==1.11.4' 'patsy==1.0.1' 'pandas==1.5.3' 'SpatialDE==1.1.3' 'NaiveDE==1.2.0'
#> Virtual environment '/var/cache/basilisk/1.22.0/spatialDE/1.16.0/env' successfully created.
norm_expr[1:5, 1:5]
#>         16.92x9.015 16.945x11.075 16.97x10.118 16.939x12.132 16.949x13.055
#> Nrf1       1.227749     0.8810934    0.8810934     1.2277491     0.8810934
#> Zbtb5      1.227749     0.8810934    1.2277491     0.8810934     0.8810934
#> Ccnl1      1.227749     1.6889027    1.2277491     1.2277491     0.8810934
#> Lrrfip1    1.484676     1.4846765    0.8810934     0.8810934     1.6889027
#> Bbs1       1.227749     1.4846765    0.8810934     1.8584110     0.8810934
```

## 3.3 `regress_out`

Next, we account for differences in library size between the samples by regressing out the effect of the total counts for each gene using linear regression.

```
resid_expr <- regress_out(norm_expr, sample_info = MOB_sample_info)
resid_expr[1:5, 1:5]
#>         16.92x9.015 16.945x11.075 16.97x10.118 16.939x12.132 16.949x13.055
#> Nrf1    -0.75226761    -1.2352000   -1.0164479    -0.7903289    -1.0973214
#> Zbtb5    0.09242373    -0.3323719    0.1397144    -0.2760560    -0.2533134
#> Ccnl1   -2.77597164    -2.5903783   -2.6092013    -2.8529340    -3.1193883
#> Lrrfip1 -1.92331333    -2.1578718   -2.3849405    -2.5924072    -1.7163300
#> Bbs1    -1.12186064    -1.0266476   -1.3706460    -0.5363646    -1.4666155
```

## 3.4 `run`

To reduce running time, the SpatialDE test is run on a subset of 1000 genes.
Running it on the complete data set takes about 10 minutes.

```
# For this example, run spatialDE on the first 1000 genes
sample_resid_expr <- head(resid_expr, 1000)

results <- spatialDE::run(sample_resid_expr, coordinates = X)
head(results[order(results$qval), ])
```

## 3.5 `model_search`

Finally, we can classify the DE genes to interpetable DE classes using the `model_search` function.
We apply the model search on filtered DE results, using a threshold of 0.05 for the Q-values.

```
de_results <- results[results$qval < 0.05, ]

ms_results <- model_search(
    sample_resid_expr,
    coordinates = X,
    de_results = de_results
)

# To show ms_results sorted on qvalue, uncomment the following line
# head(ms_results[order(ms_results$qval), ])

head(ms_results)
```

## 3.6 `spatial_patterns`

Furthermore, we can group spatially variable genes (SVGs) into spatial patterns using automatic expression histology (AEH).

```
sp <- spatial_patterns(
    sample_resid_expr,
    coordinates = X,
    de_results = de_results,
    n_patterns = 4L, length = 1.5
)
sp$pattern_results
```

## 3.7 Plots

Visualizing one of the most significant genes.

```
gene <- "Pcp4"

ggplot(data = MOB_sample_info, aes(x = x, y = y, color = norm_expr[gene, ])) +
    geom_point(size = 7) +
    ggtitle(gene) +
    scale_color_viridis_c() +
    labs(color = gene)
```

![](data:image/png;base64...)

### 3.7.1 Plot Spatial Patterns of Multiple Genes

As an alternative to the previous figure, we can plot multiple genes using the
normalized expression values.

```
ordered_de_results <- de_results[order(de_results$qval), ]

multiGenePlots(norm_expr,
    coordinates = X,
    ordered_de_results[1:6, ]$g,
    point_size = 4,
    viridis_option = "D",
    dark_theme = FALSE
)
```

![](data:image/png;base64...)

## 3.8 Plot Fraction Spatial Variance vs Q-value

```
FSV_sig(results, ms_results)
#> Warning: ggrepel: 8 unlabeled data points (too many overlaps). Consider
#> increasing max.overlaps
```

![](data:image/png;base64...)

# 4 SpatialExperiment integration

The SpatialDE workflow can also be executed with a
*[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* object as input.

```
library(SpatialExperiment)

# For SpatialExperiment object, we neeed to transpose the counts matrix in order
# to have genes on rows and spot on columns.
# For this example, run spatialDE on the first 1000 genes

partial_counts <- head(Rep11_MOB_0, 1000)

spe <- SpatialExperiment(
  assays = list(counts = partial_counts),
  spatialData = DataFrame(MOB_sample_info[, c("x", "y")]),
  spatialCoordsNames = c("x", "y")
)

out <- spatialDE(spe, assay_type = "counts", verbose = FALSE)
head(out[order(out$qval), ])
```

## 4.1 Plot Spatial Patterns of Multiple Genes (using SpatialExperiment object)

We can plot spatial patterns of multiples genes using the `spe` object.

```
spe_results <- out[out$qval < 0.05, ]

ordered_spe_results <- spe_results[order(spe_results$qval), ]

multiGenePlots(spe,
    assay_type = "counts",
    ordered_spe_results[1:6, ]$g,
    point_size = 4,
    viridis_option = "D",
    dark_theme = FALSE
)
```

![](data:image/png;base64...)

## 4.2 Classify spatially variable genes with `model_search` and `spatial_patterns`

```
msearch <- modelSearch(spe,
    de_results = out, qval_thresh = 0.05,
    verbose = FALSE
)

head(msearch)
```

```
spatterns <- spatialPatterns(spe,
    de_results = de_results, qval_thresh = 0.05,
    n_patterns = 4L, length = 1.5, verbose = FALSE
)

spatterns$pattern_results
```

# `sessionInfo`

Session info

```
#> [1] "2025-10-30 02:41:01 EDT"
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
#>  [1] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] ggplot2_4.0.0               spatialDE_1.16.0
#> [15] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        dir.expiry_1.18.0   rjson_0.2.23
#>  [4] xfun_0.53           bslib_0.9.0         ggrepel_0.9.6
#>  [7] lattice_0.22-7      vctrs_0.6.5         tools_4.5.1
#> [10] parallel_4.5.1      tibble_3.3.0        pkgconfig_2.0.3
#> [13] Matrix_1.7-4        checkmate_2.3.3     RColorBrewer_1.1-3
#> [16] S7_0.2.0            lifecycle_1.0.4     compiler_4.5.1
#> [19] farver_2.1.2        tinytex_0.57        htmltools_0.5.8.1
#> [22] sass_0.4.10         yaml_2.3.10         pillar_1.11.1
#> [25] jquerylib_0.1.4     cachem_1.1.0        DelayedArray_0.36.0
#> [28] magick_2.9.0        abind_1.4-8         basilisk_1.22.0
#> [31] tidyselect_1.2.1    digest_0.6.37       dplyr_1.1.4
#> [34] bookdown_0.45       labeling_0.4.3      fastmap_1.2.0
#> [37] grid_4.5.1          cli_3.6.5           SparseArray_1.10.0
#> [40] magrittr_2.0.4      S4Arrays_1.10.0     dichromat_2.0-0.1
#> [43] withr_3.0.2         filelock_1.0.3      scales_1.4.0
#> [46] backports_1.5.0     rappdirs_0.3.3      rmarkdown_2.30
#> [49] XVector_0.50.0      reticulate_1.44.0   gridExtra_2.3
#> [52] png_0.1-8           evaluate_1.0.5      knitr_1.50
#> [55] viridisLite_0.4.2   rlang_1.1.6         Rcpp_1.1.0
#> [58] glue_1.8.0          BiocManager_1.30.26 jsonlite_2.0.0
#> [61] R6_2.6.1
```