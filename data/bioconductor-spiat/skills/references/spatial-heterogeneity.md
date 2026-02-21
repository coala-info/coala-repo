# Spatial heterogeneity with SPIAT

Yuzhou Feng

#### 2026-02-03

#### Package

SPIAT 1.12.1

```
library(SPIAT)
```

Cell colocalisation metrics allow capturing a dominant spatial pattern
in an image. However, patterns are unlikely to be distributed evenly in
a tissue, but rather there will be spatial heterogeneity of patterns.
To measure this, SPIAT splits the image into smaller images (either
using a grid or concentric circles around a reference cell population),
followed by calculation of a spatial metric of a pattern of interest
(e.g. cell colocalisation, entropy), and then measures the Prevalence
and Distinctiveness of the pattern.

In this vignette we will use an inForm data file that’s already been
formatted for SPIAT with `format_image_to_spe()`, which we can load with
`data()`. We will use `define_celltypes()` to define the cells with certain
combinations of markers.

```
data("simulated_image")

# define cell types
formatted_image <- define_celltypes(
    simulated_image,
    categories = c("Tumour_marker","Immune_marker1,Immune_marker2",
                   "Immune_marker1,Immune_marker3",
                   "Immune_marker1,Immune_marker2,Immune_marker4", "OTHER"),
    category_colname = "Phenotype",
    names = c("Tumour", "Immune1", "Immune2", "Immune3", "Others"),
    new_colname = "Cell.Type")
```

# 1 Localised Entropy

Entropy in spatial analysis refers to the balance in the number of cells
of distinct populations. An entropy score can be obtained for an entire
image. However, the entropy of one image does not provide us spatial
information of the image.

```
calculate_entropy(formatted_image, cell_types_of_interest = c("Immune1","Immune2"),
                  feature_colname = "Cell.Type")
```

```
## [1] 0.9294873
```

We therefore propose the concept of Localised Entropy which calculates
an entropy score for a predefined local region. These local regions can
be calculated as defined in the next two sections.

## 1.1 Fishnet grid

One approach to calculate localised metric is to split the image into
fishnet grid squares. For each grid square, `grid_metrics()` calculates
the metric for that square and visualise the raster image. Users can
choose any metric as the localised metric. Here we use entropy as an
example.

For cases where the localised metric is not symmetrical (requires
specifying a target and reference cell type), the first item in the
vector used for `cell_types_of_interest` marks the reference cells and
the second item the target cells. Here we are using Entropy, which is
symmetrical, so we can use any order of cell types in the input.

```
data("defined_image")
grid <- grid_metrics(defined_image, FUN = calculate_entropy, n_split = 20,
                     cell_types_of_interest=c("Tumour","Immune3"),
                     feature_colname = "Cell.Type")
```

![](data:image/png;base64...)

After calculating the localised entropy for each of the grid squares, we
can apply metrics like percentages of grid squares with patterns
(Prevalence) and Moran’s I (Distinctiveness).

For the Prevalence, we need to select a threshold over which grid
squares are considered ‘positive’ for the pattern. The selection of
threshold depends on the pattern and metric the user chooses to find the
localised pattern. Here we chose 0.75 for entropy because 0.75 is
roughly the entropy of two cell types when their ratio is 1:5 or 5:1.

```
calculate_percentage_of_grids(grid, threshold = 0.75, above = TRUE)
```

```
## [1] 13
```

```
calculate_spatial_autocorrelation(grid, metric = "globalmoran")
```

```
## [1] 0.2197134
```

## 1.2 Gradients (based on concentric circles)

We can use the `compute_gradient()` function to calculate metrics (entropy, mixing
score, percentage of cells within radius, marker intensity) for a range
of radii from reference cells. Here, an increasing circle is drawn
around each cell of the reference cell type and the desired score is
calculated for cells within each circle.

The first item in the vector used for `cell_types_of_interest` marks the
reference cells and the second item the target cells. Here, Immune1
cells are reference cells and Immune2 are target cells.

```
gradient_positions <- c(30, 50, 100)
gradient_entropy <-
  compute_gradient(defined_image, radii = gradient_positions,
                   FUN = calculate_entropy,  cell_types_of_interest = c("Immune1","Immune2"),
                   feature_colname = "Cell.Type")
length(gradient_entropy)
```

```
## [1] 3
```

```
head(gradient_entropy[[1]])
```

```
##         Cell.X.Position Cell.Y.Position Immune1 Immune2 total Immune1_log2
## Cell_15       109.67027        17.12956       1       0     1            0
## Cell_25       153.22795       128.29915       1       0     1            0
## Cell_30        57.29037        49.88533       1       0     1            0
## Cell_48        83.47798       295.75058       2       0     2            1
## Cell_56        35.24227       242.84862       1       0     1            0
## Cell_61       156.39943       349.08154       2       0     2            1
##         Immune2_log2 total_log2 Immune1ratio Immune1_entropy Immune2ratio
## Cell_15            0          0            1               0            0
## Cell_25            0          0            1               0            0
## Cell_30            0          0            1               0            0
## Cell_48            0          1            1               0            0
## Cell_56            0          0            1               0            0
## Cell_61            0          1            1               0            0
##         Immune2_entropy entropy
## Cell_15               0       0
## Cell_25               0       0
## Cell_30               0       0
## Cell_48               0       0
## Cell_56               0       0
## Cell_61               0       0
```

The `compute_gradient()` function outputs the numbers cells within each
radii for each reference cell. The output is formatted as a list of
data.frames, one for each specified radii. In each data.frame, the rows
show the reference cells. The last column of the data.frame is the
entropy calculated for cells in the circle of the reference cell. Users
can then an average score or another aggregation metric to report the
results.

An alternative approach is to combine the results of all the circles
(rather than have one for each individual reference cell). Here, for
each radii, we simultaneously identify all the cells in the circles
surrounding each reference cell, and calculate a single entropy score.
We have created a specific function for this -
`entropy_gradient_aggregated()`. The output of this function is an overall
entropy score for each radii.

```
gradient_pos <- seq(50, 500, 50) ##radii
gradient_results <- entropy_gradient_aggregated(defined_image, cell_types_of_interest = c("Immune3","Tumour"),
                                                feature_colname = "Cell.Type", radii = gradient_pos)
# plot the results
plot(1:10,gradient_results$gradient_df[1, 3:12])
```

![](data:image/png;base64...)

# 2 You can access the vignettes for other modules of SPIAT here:

* [Overview of SPIAT](SPIAT.html)
* [Data reading and formatting](data_reading-formatting.html)
* [Quality control and visualisation](quality-control_visualisation.html)
* [Basic analysis](basic_analysis.html)
* [Cell colocalisation](cell-colocalisation.html)
* [Tissue structure](tissue-structure.html)
* [Cellular neighborhood](neighborhood.html)

# 3 Reproducibility

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] SPIAT_1.12.1                SpatialExperiment_1.20.0
##  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.1
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] deldir_2.0-4           gridExtra_2.3          rlang_1.1.7
##   [4] magrittr_2.0.4         clue_0.3-66            GetoptLong_1.1.0
##   [7] otel_0.2.0             ggridges_0.5.7         compiler_4.5.2
##  [10] spatstat.geom_3.7-0    png_0.1-8              vctrs_0.7.1
##  [13] reshape2_1.4.5         stringr_1.6.0          shape_1.4.6.1
##  [16] pkgconfig_2.0.3        crayon_1.5.3           fastmap_1.2.0
##  [19] magick_2.9.0           XVector_0.50.0         labeling_0.4.3
##  [22] rmarkdown_2.30         tzdb_0.5.0             pracma_2.4.6
##  [25] purrr_1.2.1            tinytex_0.58           bit_4.6.0
##  [28] xfun_0.56              cachem_1.1.0           jsonlite_2.0.0
##  [31] goftest_1.2-3          DelayedArray_0.36.0    spatstat.utils_3.2-1
##  [34] terra_1.8-93           cluster_2.1.8.1        parallel_4.5.2
##  [37] R6_2.6.1               bslib_0.10.0           stringi_1.8.7
##  [40] RColorBrewer_1.1-3     spatstat.data_3.1-9    spatstat.univar_3.1-6
##  [43] jquerylib_0.1.4        iterators_1.0.14       Rcpp_1.1.1
##  [46] bookdown_0.46          knitr_1.51             tensor_1.5.1
##  [49] Matrix_1.7-4           tidyselect_1.2.1       dichromat_2.0-0.1
##  [52] abind_1.4-8            yaml_2.3.12            codetools_0.2-20
##  [55] doParallel_1.0.17      spatstat.random_3.4-4  spatstat.explore_3.7-0
##  [58] lattice_0.22-7         tibble_3.3.1           plyr_1.8.9
##  [61] withr_3.0.2            S7_0.2.1               Rtsne_0.17
##  [64] evaluate_1.0.5         polyclip_1.10-7        elsa_1.1-28
##  [67] circlize_0.4.17        pillar_1.11.1          BiocManager_1.30.27
##  [70] foreach_1.5.2          plotly_4.12.0          dbscan_1.2.4
##  [73] sp_2.2-0               vroom_1.7.0            ggplot2_4.0.2
##  [76] scales_1.4.0           gtools_3.9.5           apcluster_1.4.14
##  [79] glue_1.8.0             lazyeval_0.2.2         pheatmap_1.0.13
##  [82] tools_4.5.2            data.table_1.18.2.1    dittoSeq_1.22.0
##  [85] RANN_2.6.2             Cairo_1.7-0            cowplot_1.2.0
##  [88] grid_4.5.2             tidyr_1.3.2            crosstalk_1.2.2
##  [91] colorspace_2.1-2       nlme_3.1-168           raster_3.6-32
##  [94] mmand_1.6.3            cli_3.6.5              spatstat.sparse_3.1-0
##  [97] S4Arrays_1.10.1        viridisLite_0.4.2      ComplexHeatmap_2.26.1
## [100] dplyr_1.2.0            gtable_0.3.6           sass_0.4.10
## [103] digest_0.6.39          SparseArray_1.10.8     ggrepel_0.9.6
## [106] htmlwidgets_1.6.4      rjson_0.2.23           farver_2.1.2
## [109] htmltools_0.5.9        lifecycle_1.0.5        httr_1.4.7
## [112] GlobalOptions_0.1.3    bit64_4.6.0-1
```

# 4 Author Contributions

AT, YF, TY, ML, JZ, VO, MD are authors of the package code. MD and YF
wrote the vignette. AT, YF and TY designed the package.