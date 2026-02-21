# spatialSimGP Tutorial

Kinnary H. Shah1, Boyi Guo1 and Stephanie C. Hicks1

1Johns Hopkins Bloomberg School of Public Health, Baltimore, MD, USA

#### 30 October 2025

#### Package

spatialSimGP 1.4.0

# 1 Introduction

`spatialSimGP` is a simulation tool that generates spatial
transcriptomics data. The purpose of this package is to use a Gaussian
Process for each gene to simulate data with spatial variation. We use
the Poisson distribution to simulate the values on the raw counts
scale. The mean and variance are tied together in the Poisson
distribution, so we simulate the mean-variance relationship with our
function. The mean-variance relationship is a bias in real spatial
transcriptomics data, so we must make sure it is a feature of in
silico data as well. `spatialSimGP` provides the option to simulate
data with a fixed or unique length scale for each gene. The simulated
data can be used to evaluate the performance of spatial
transcriptomics analysis methods.

Bioconductor houses the infrastructure to store and analyze spatially
resolved transcriptomics data for R users, including many SVG
detection methods. This simulation framework can be used to benchmark
SVG detection methods and to develop new methods for spatially
resolved transcriptomics data. Additionally, this package interfaces
with the widely used `SpatialExperiment` class from Bioconductor.

# 2 Installation

The following code will install the latest release version of the
`spatialSimGP` package from Bioconductor. Additional details are shown
on the [Bioconductor](https://bioconductor.org/packages/spatialSimGP)
page.

```
install.packages("BiocManager")
BiocManager::install("spatialSimGP")
```

The latest development version can also be installed from the `devel`
version of Bioconductor or from
[GitHub](https://github.com/kinnaryshah/spatialSimGP).

# 3 Simulation Framework

The simulation framework is as follows:

\[\boldsymbol{c(s)}|\lambda(\boldsymbol{s}) \sim Poisson (\lambda(\boldsymbol{s})); \lambda(\boldsymbol{s})= exp(\boldsymbol{\beta} + \boldsymbol{C}(\sigma^2))\]

* \(\boldsymbol{s}\): spatial locations
* \(\boldsymbol{\beta}\): vector of means per gene
* \(\sigma^2\): spatial component of variance
* \(\boldsymbol{C}\): covariance function using a Matern kernel with
  squared exponential distance

The exponential covariance function is as follows:

\[(C\_{ij}(\boldsymbol{\theta})) = \sigma^2\exp(\frac{-||\boldsymbol{s\_i}-\boldsymbol{s\_j}||}{l})\]

* \(\boldsymbol{\theta} = (\sigma^2, l)\)
* \(l\): length scale parameter
  + sets how quickly spatial correlation decays with distance
* \(||\boldsymbol{s\_i}-\boldsymbol{s\_j}||\): Euclidean distance
  between spatial locations

We calculate the covariance matrix using the exponential covariance
function. Using mean \(\boldsymbol{0}\) and covariance
\(C(\boldsymbol{\theta})\) in the multivariate Normal distribution, we
simulate a Gaussian Process per gene. We use the Gaussian process and
\(\beta\) to calculate \(\lambda\) and then use the Poisson distribution
to simulate the gene expression levels for each spot.

# 4 Tutorial

**Load packages and data**

```
library(MASS)
library(SpatialExperiment)
```

```
## Loading required package: SingleCellExperiment
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: MatrixGenerics
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'MatrixGenerics'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
##     colWeightedMeans, colWeightedMedians, colWeightedSds,
##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
##     rowWeightedSds, rowWeightedVars
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
## Attaching package: 'Biobase'
```

```
## The following object is masked from 'package:MatrixGenerics':
##
##     rowMedians
```

```
## The following objects are masked from 'package:matrixStats':
##
##     anyMissing, rowMedians
```

```
library(STexampleData)
```

```
## Loading required package: ExperimentHub
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
##
## Attaching package: 'AnnotationHub'
```

```
## The following object is masked from 'package:Biobase':
##
##     cache
```

```
library(ggplot2)
library(spatialSimGP)
```

**Simulating Data with Prior Coordinates Matrix**

One way to simulate data is to provide a matrix of coordinates. In
this example, we use a subset of spots from
`STexampleData::Visium_mouseCoronal()`, which is available from
Bioconductor.

```
spe_demo <- Visium_mouseCoronal()
```

```
## see ?STexampleData and browseVignettes('STexampleData') for documentation
```

```
## loading from cache
```

```
colData(spe_demo)$subset <- ifelse(
   colData(spe_demo)$array_row > 20 &
   colData(spe_demo)$array_row < 65 &
   colData(spe_demo)$array_col > 30 &
   colData(spe_demo)$array_col < 65,
   TRUE, FALSE
 )
spe_demo <- spe_demo[, colData(spe_demo)$subset]
coords <- spatialCoords(spe_demo)
```

We also have to define our remaining parameters before simulating the
data.

* `n_genes` is the total number of genes to simulate. In this
  example, we simulate 5 genes.
* `proportion` is the proportion of genes that will have no
  spatially varying patterns. In other words, these genes will just
  have random noise. In this example, 40% of the genes will have no
  spatial patterns.
* `range_sigma.sq` is the range of the spatial variance parameter.
  In this example, the spatial variance parameter will range from
  1.5 to 3.
* `range_beta` is the range of the mean expression value. In this
  example, the mean parameter will range from 3 to 7.

```
n_genes <- 5
proportion <- 0.4
range_sigma.sq <- c(1.5, 3)
range_beta <- c(3, 7)
```

**(A) Simulating Data with Fixed Length Scale**

We first simulate 5 genes with a fixed length scale parameter. The
length scale parameter determines how quickly the correlation decays
with distance. Larger length scale parameters simulate larger spatial
patterns. The `simulate` function returns a `SpatialExperiment` object
with the simulated data. Remember to set the seed for reproducibility.

```
length_scale <- 60

set.seed(16)
spe <- spatial_simulate(n_genes, proportion, coords,
                        range_sigma.sq, range_beta,
                        length_scale, length_scale_option = "fixed")
```

```
## Simulating gene 1
```

```
## Simulating gene 2
```

```
## Simulating gene 3
```

```
## Simulating gene 4
```

```
## Simulating gene 5
```

We can visualize the first gene in the simulated data below:

```
df <- as.data.frame(cbind(spatialCoords(spe), expr = counts(spe)[1, ]))

ggplot(df, aes(x = pxl_col_in_fullres, y = pxl_row_in_fullres,
               color = expr)) +
  geom_point(size = 2.2) +
  coord_fixed() +
  scale_y_reverse() +
  scale_color_gradient(low = "gray90", high = "blue",
                       trans = "sqrt", breaks = range(df$expr),
                       name = "counts") +
  theme_bw() +
  theme(plot.title = element_text(face = "italic"),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
```

![](data:image/png;base64...)

**(B) Simulating Data with Unique Length Scale**

We can also simulate data with a unique length scale for each gene.
This process is slower than simulating data with a fixed length scale,
but it allows for more flexibility in the spatial patterns of each
gene. Each gene has a unique length scale parameter, so the Gaussian
Process kernel must be calculated for each gene, slowing down the
simulation process.

```
length_scale <- c(60, 40, 20, 80, 100)

set.seed(1)
spe <- spatial_simulate(n_genes, proportion, coords,
                        range_sigma.sq, range_beta,
                        length_scale, length_scale_option = "unique")
```

```
## Simulating gene 1
```

```
## Simulating gene 2
```

```
## Simulating gene 3
```

```
## Simulating gene 4
```

```
## Simulating gene 5
```

**Simulating Data with User-Created Coordinates Matrix**

If you have your own coordinates matrix, you can use that to simulate
data. We have included an example below.

```
# 20 spots per side
n_side <- 20

# x and y coordinates for the grid
x_coords <- rep(1:n_side, each = n_side)
y_coords <- rep(1:n_side, times = n_side)

# combine into a matrix
coords <- cbind(x_coords, y_coords)
colnames(coords) <- c("pxl_col_in_fullres", "pxl_row_in_fullres")

# run the simulation
set.seed(1)
length_scale <- 60
spe <- spatial_simulate(n_genes, proportion, coords,
                        range_sigma.sq, range_beta,
                        length_scale, length_scale_option = "fixed")
```

```
## Simulating gene 1
```

```
## Simulating gene 2
```

```
## Simulating gene 3
```

```
## Simulating gene 4
```

```
## Simulating gene 5
```

We can visualize the first gene in the simulated data below:

```
df <- as.data.frame(cbind(spatialCoords(spe), expr = counts(spe)[1, ]))

ggplot(df, aes(x = pxl_col_in_fullres, y = pxl_row_in_fullres,
               color = expr)) +
  geom_point(size = 5) +
  coord_fixed() +
  scale_y_reverse() +
  scale_color_gradient(low = "gray90", high = "blue",
                       trans = "sqrt", breaks = range(df$expr),
                       name = "counts") +
  theme_bw() +
  theme(plot.title = element_text(face = "italic"),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
```

![](data:image/png;base64...)

Note: If you want to have complete control over each simulated gene,
you can set `n_genes` = 1, `proportion` = 0, `range_sigma.sq` =
c(a,a), and `range_beta` = c(b,b). This will allow you to simulate one
gene at a time at the exact spatial variance and mean expression level
desired. You could loop through this process to simulate multiple
genes with different parameters.

```
set.seed(123)
n_genes <- 1
proportion <- 0
range_sigma.sq <- c(1, 1)
range_beta <- c(3, 3)
length_scale <- 60

spe <- spatial_simulate(n_genes, proportion, coords,
                        range_sigma.sq, range_beta,
                        length_scale, length_scale_option = "fixed")
```

```
## Simulating gene 1
```

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
##  [1] spatialSimGP_1.4.0          ggplot2_4.0.0
##  [3] STexampleData_1.17.1        ExperimentHub_3.0.0
##  [5] AnnotationHub_4.0.0         BiocFileCache_3.0.0
##  [7] dbplyr_2.5.1                SpatialExperiment_1.20.0
##  [9] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           MASS_7.3-65
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1     dplyr_1.1.4          farver_2.1.2
##  [4] blob_1.2.4           filelock_1.0.3       Biostrings_2.78.0
##  [7] S7_0.2.0             fastmap_1.2.0        digest_0.6.37
## [10] lifecycle_1.0.4      KEGGREST_1.50.0      RSQLite_2.4.3
## [13] magrittr_2.0.4       compiler_4.5.1       rlang_1.1.6
## [16] sass_0.4.10          tools_4.5.1          yaml_2.3.10
## [19] knitr_1.50           S4Arrays_1.10.0      labeling_0.4.3
## [22] bit_4.6.0            curl_7.0.0           DelayedArray_0.36.0
## [25] RColorBrewer_1.1-3   abind_1.4-8          withr_3.0.2
## [28] purrr_1.1.0          grid_4.5.1           scales_1.4.0
## [31] tinytex_0.57         dichromat_2.0-0.1    cli_3.6.5
## [34] rmarkdown_2.30       crayon_1.5.3         httr_1.4.7
## [37] rjson_0.2.23         DBI_1.2.3            cachem_1.1.0
## [40] AnnotationDbi_1.72.0 BiocManager_1.30.26  XVector_0.50.0
## [43] vctrs_0.6.5          Matrix_1.7-4         jsonlite_2.0.0
## [46] bookdown_0.45        bit64_4.6.0-1        magick_2.9.0
## [49] jquerylib_0.1.4      glue_1.8.0           gtable_0.3.6
## [52] BiocVersion_3.22.0   tibble_3.3.0         pillar_1.11.1
## [55] rappdirs_0.3.3       htmltools_0.5.8.1    R6_2.6.1
## [58] httr2_1.2.1          evaluate_1.0.5       lattice_0.22-7
## [61] png_0.1-8            memoise_2.0.1        bslib_0.9.0
## [64] Rcpp_1.1.0           SparseArray_1.10.0   xfun_0.53
## [67] pkgconfig_2.0.3
```