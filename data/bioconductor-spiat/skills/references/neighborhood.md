# Identifying cellular neighborhood with SPIAT

Yuzhou Feng

#### 2026-02-03

#### Package

SPIAT 1.12.1

```
library(SPIAT)
```

# 1 Cellular neighborhood

The aggregation of cells can result in ‘cellular neighbourhoods’. A
neighbourhood is defined as a group of cells that cluster together.
These can be homotypic, containing cells of a single class (e.g. immune
cells), or heterotypic (e.g. a mixture of tumour and immune cells).

Function `identify_neighborhoods()` identifies cellular neighbourhoods.
Users can select a subset of cell types of interest if desired. SPIAT includes
three algorithms for the detection of neighbourhoods.

* *Hierarchical Clustering algorithm*: Euclidean distances between
  cells are calculated, and pairs of cells with a distance less than a
  specified radius are considered to be ‘interacting’, with the rest
  being ‘non-interacting’. Hierarchical clustering is then used to
  separate the clusters. Larger radii will result in the merging of
  individual clusters.
* [*dbscan*](https://cran.r-project.org/web/packages/dbscan/index.html)
* [*phenograph*](https://github.com/JinmiaoChenLab/Rphenograph) (Note: While this option cannot be run directly in package, the code is available and commented out in `/SPIAT/R/identify_neighborhoods.R`. This is due to Bioconductor dependency restrictions.

For *Hierarchical Clustering algorithm* and *dbscan*, users need to
specify a radius that defines the distance for an interaction. We
suggest users to test different radii and select the one that generates
intuitive clusters upon visualisation. Cells not assigned to clusters
are assigned as `Cluster_NA` in the output table. The argument
`min_neighborhood_size` specifies the threshold of a neighborhood size
to be considered as a neighborhood. Smaller neighbourhoods will be
outputted, but will not be assigned a number.

*Rphenograph* uses the number of nearest neighbours to detect clusters.
This number should be specified by `min_neighborhood_size` argument. We
also encourage users to test different values.

For this part of the tutorial, we will use the image `image_no_markers`
simulated with the `spaSim` package. This image contains “Tumour”,
“Immune”, “Immune1” and “Immune2” cells without marker intensities.

```
data("image_no_markers")

plot_cell_categories(
  image_no_markers, c("Tumour", "Immune","Immune1","Immune2","Others"),
  c("red","blue","darkgreen", "brown","lightgray"), "Cell.Type")
```

![](data:image/png;base64...)

Users are recommended to test out different radii and then visualise the
clustering results. To aid in this process, users can use the
`average_minimum_distance()` function, which calculates the average
minimum distance between all cells in an image, and can be used as a
starting point.

```
average_minimum_distance(image_no_markers)
```

```
## [1] 17.01336
```

We then identify the cellular neighbourhoods using our hierarchical
algorithm with a radius of 50, and with a minimum neighbourhood size of
100. Cells assigned to neighbourhoods smaller than 100 will be assigned
to the “Cluster\_NA” neighbourhood.

```
clusters <- identify_neighborhoods(
  image_no_markers, method = "hierarchical", min_neighborhood_size = 100,
  cell_types_of_interest = c("Immune", "Immune1", "Immune2"), radius = 50,
  feature_colname = "Cell.Type")
```

![](data:image/png;base64...)

This plot shows clusters of “Immune”, “Immune1” and “Immune2” cells. Each
number and colour corresponds to a distinct cluster. Black cells
correspond to ‘free’, un-clustered cells.

We can visualise the cell composition of neighborhoods. To do this, we
can use `composition_of_neighborhoods()` to obtain the percentages of
cells with a specific marker within each neighborhood and the number of
cells in the neighborhood.

In this example we select cellular neighbourhoods with at least 5 cells.

```
neighorhoods_vis <-
  composition_of_neighborhoods(clusters, feature_colname = "Cell.Type")
neighorhoods_vis <-
  neighorhoods_vis[neighorhoods_vis$Total_number_of_cells >=5,]
```

Finally, we can use `plot_composition_heatmap()` to produce a heatmap
showing the marker percentages within each cluster, which can be used to
classify the derived neighbourhoods.

```
plot_composition_heatmap(neighorhoods_vis, feature_colname="Cell.Type")
```

![](data:image/png;base64...)

This plot shows that Cluster\_1 and Cluster\_2 contain all three types of
immune cells. Cluster\_3 does not have Immune1 cells. Cluster\_1 and
Cluster\_2 are more similar to the free cells (cells not assigned to
clusters) in their composition than Cluster\_3.

# 2 Average Nearest Neighbour Index (ANNI)

We can test for the presence of neighbourhoods using ANNI. We can
calculate the ANNI with the function `average_nearest_neighbor_index()`,
which takes one cell type of interest (e.g. `Cluster_1` under
`Neighborhood` column of `clusters` object) or a combinations of cell
types (e.g. `Immune1` and `Immune2` cells under `Cell.Type` column of
`image_no_markers` object) and outputs whether there is a clear
neighbourhood (clustered) or unclear (dispersed/random), along with a P
value for the estimate.

Here show the examples for both one cell type and multiple cell types.

```
average_nearest_neighbor_index(clusters, reference_celltypes=c("Cluster_1"),
                               feature_colname="Neighborhood", p_val = 0.05)
```

```
## $ANN_index
## [1] 0.3225717
##
## $pattern
## [1] "Clustered"
##
## $`p-value`
## [1] 4.616213e-110
```

```
average_nearest_neighbor_index(
  image_no_markers, reference_celltypes=c("Immune", "Immune1" , "Immune2"),
  feature_colname="Cell.Type", p_val = 0.05)
```

```
## $ANN_index
## [1] 0.9968575
##
## $pattern
## [1] "Random"
##
## $`p-value`
## [1] 0.4000806
```

`p_val` is the cutoff to determine if a pattern is significant or not.
If the p value of ANNI is larger than the threshold, the pattern will be
“Random”. Although we give a default p value cutoff of 5e-6, we suggest
the users to define their own cutoff based on the images and how they
define the patterns “Clustered” and “Dispersed”.

# 3 You can access the vignettes for other modules of SPIAT here:

* [Overview of SPIAT](SPIAT.html)
* [Data reading and formatting](data_reading-formatting.html)
* [Quality control and visualisation](quality-control_visualisation.html)
* [Basic analysis](basic_analysis.html)
* [Cell colocalisation](cell-colocalisation.html)
* [Spatial heterogeneity](spatial-heterogeneity.html)
* [Tissue structure](tissue-structure.html)

# 4 Reproducibility

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
##  [25] tinytex_0.58           bit_4.6.0              xfun_0.56
##  [28] cachem_1.1.0           jsonlite_2.0.0         goftest_1.2-3
##  [31] DelayedArray_0.36.0    spatstat.utils_3.2-1   cluster_2.1.8.1
##  [34] parallel_4.5.2         R6_2.6.1               bslib_0.10.0
##  [37] stringi_1.8.7          RColorBrewer_1.1-3     spatstat.data_3.1-9
##  [40] spatstat.univar_3.1-6  jquerylib_0.1.4        iterators_1.0.14
##  [43] Rcpp_1.1.1             bookdown_0.46          knitr_1.51
##  [46] tensor_1.5.1           Matrix_1.7-4           tidyselect_1.2.1
##  [49] dichromat_2.0-0.1      abind_1.4-8            yaml_2.3.12
##  [52] codetools_0.2-20       doParallel_1.0.17      spatstat.random_3.4-4
##  [55] spatstat.explore_3.7-0 lattice_0.22-7         tibble_3.3.1
##  [58] plyr_1.8.9             withr_3.0.2            S7_0.2.1
##  [61] evaluate_1.0.5         polyclip_1.10-7        circlize_0.4.17
##  [64] pillar_1.11.1          BiocManager_1.30.27    foreach_1.5.2
##  [67] dbscan_1.2.4           vroom_1.7.0            ggplot2_4.0.2
##  [70] scales_1.4.0           gtools_3.9.5           apcluster_1.4.14
##  [73] glue_1.8.0             pheatmap_1.0.13        tools_4.5.2
##  [76] dittoSeq_1.22.0        RANN_2.6.2             Cairo_1.7-0
##  [79] cowplot_1.2.0          grid_4.5.2             colorspace_2.1-2
##  [82] nlme_3.1-168           mmand_1.6.3            cli_3.6.5
##  [85] spatstat.sparse_3.1-0  S4Arrays_1.10.1        viridisLite_0.4.2
##  [88] ComplexHeatmap_2.26.1  dplyr_1.2.0            gtable_0.3.6
##  [91] sass_0.4.10            digest_0.6.39          SparseArray_1.10.8
##  [94] ggrepel_0.9.6          rjson_0.2.23           farver_2.1.2
##  [97] htmltools_0.5.9        lifecycle_1.0.5        GlobalOptions_0.1.3
## [100] bit64_4.6.0-1
```

# 5 Author Contributions

AT, YF, TY, ML, JZ, VO, MD are authors of the package code. MD and YF
wrote the vignette. AT, YF and TY designed the package.