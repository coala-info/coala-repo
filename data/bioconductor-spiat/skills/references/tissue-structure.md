# Characterising tissue structure with SPIAT

Yuzhou Feng

#### 2026-02-03

#### Package

SPIAT 1.12.1

```
library(SPIAT)
```

# 1 Characterising the distribution of the cells of interest in identified tissue regions

In certain analysis the focus is to understand the spatial distribution
of a certain type of cell populations relative to the tissue regions.

One example of this functionality is to characterise the immune population in
tumour structures. The following analysis will focus on the tumour/immune
example, including determining whether there is a clear tumour margin,
automatically identifying the tumour margin, and finally quantifying the
proportion of immune populations relative to the margin. **However, these analyses**
**can also be generalised to other tissue and cell types.**

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

## 1.1 Determining whether there is a clear tumour margin

In some instances tumour cells are distributed in such a way that there
are no clear tumour margins. While this can be derived intuitively in
most cases, SPIAT offers a way of quantifying the ‘quality’ of the
margin for downstream analyses. This is meant to be used to help flag
images with relatively poor margins, and therefore we do not offer a
cutoff value.

To determine if there is a clear tumour margin, SPIAT can calculate the
ratio of tumour bordering cells to tumour total cells (R-BT). This ratio
is high when there is a disproportional high number of tumour margin
cells compared to internal tumour cells.

```
R_BC(formatted_image, cell_type_of_interest = "Tumour", "Cell.Type")
```

![](data:image/png;base64...)

```
## [1] 0.2014652
```

The result is
0.2014652.
This low value means there are relatively low number of bordering cells
compared to total tumour cells, meaning that this image has clear tumour
margins.

## 1.2 Automatic identification of the tumour margin

We can identify margins with `identify_bordering_cells()`. This function
leverages off the alpha hull method (Pateiro-Lopez, Rodriguez-Casal, and. [2019](#ref-alphahull)) from the alpha hull
package. Here we use tumour cells (Tumour\_marker) as the reference to
identify the bordering cells but any cell type can be used.

```
formatted_border <- identify_bordering_cells(formatted_image,
                                             reference_cell = "Tumour",
                                             feature_colname="Cell.Type")
```

```
## [1] "The alpha of Polygon is: 63.24375"
```

![](data:image/png;base64...)

```
# Get the number of tumour clusters
attr(formatted_border, "n_of_clusters")
```

```
## [1] 3
```

There are 3 tumour clusters in the image.

## 1.3 Classification of cells based on their locations relative to the margin

We can then define four locations relative to the margin based on
distances: “Internal margin”, “External margin”, “Outside” and “Inside”.
Specifically, we define the area within a specified distance to the
margin as either “Internal margin” (bordering the margin, inside the
tumour area) and “External margin” (bordering the margin, surrounding the
tumour area). The areas located further away than the specified distance
from the margin are defined as “Inside” (i.e. the tumour area) and
“Outside” (i.e. the tumour area).

![](data:image/jpeg;base64...)

First, we calculate the distance of cells to the tumour margin.

```
formatted_distance <- calculate_distance_to_margin(formatted_border)
```

```
## [1] "Markers had been selected in minimum distance calculation: "
## [1] "Non-border" "Border"
```

Next, we classify cells based on their location. As a distance cutoff,
we use a distance of 5 cells from the tumour margin. The function first
calculates the average minimum distance between all pairs of nearest
cells and then multiples this number by 5. Users can change the number
of cell layers to increase/decrease the margin width.

```
names_of_immune_cells <- c("Immune1", "Immune2","Immune3")

formatted_structure <- define_structure(
  formatted_distance, cell_types_of_interest = names_of_immune_cells,
  feature_colname = "Cell.Type", n_margin_layers = 5)

categories <- unique(formatted_structure$Structure)
```

We can plot and colour these structure categories.

```
plot_cell_categories(formatted_structure, feature_colname = "Structure")
```

![](data:image/png;base64...)

We can also calculate the proportions of immune cells in each of the locations.

```
immune_proportions <- calculate_proportions_of_cells_in_structure(
  spe_object = formatted_structure,
  cell_types_of_interest = names_of_immune_cells, feature_colname ="Cell.Type")

immune_proportions
```

```
##                Cell.Type                            Relative_to
## 1                Immune1             All_cells_in_the_structure
## 2                Immune2             All_cells_in_the_structure
## 3                Immune3             All_cells_in_the_structure
## 4                Immune1 All_cells_of_interest_in_the_structure
## 5                Immune2 All_cells_of_interest_in_the_structure
## 6                Immune3 All_cells_of_interest_in_the_structure
## 7                Immune1  The_same_cell_type_in_the_whole_image
## 8                Immune2  The_same_cell_type_in_the_whole_image
## 9                Immune3  The_same_cell_type_in_the_whole_image
## 10 All_cells_of_interest             All_cells_in_the_structure
##    P.Infiltrated.CoI P.Internal.Margin.CoI P.External.Margin.CoI P.Stromal.CoI
## 1         0.00000000            0.00000000           0.001733102    0.09658928
## 2         0.00000000            0.00000000           0.001733102    0.05073087
## 3         0.12576687            0.08071749           0.681109185    0.04585841
## 4         0.00000000            0.00000000           0.002531646    0.50000000
## 5         0.00000000            0.00000000           0.002531646    0.26261128
## 6         1.00000000            1.00000000           0.994936709    0.23738872
## 7         0.00000000            0.00000000           0.002958580    0.99704142
## 8         0.00000000            0.00000000           0.005617978    0.99438202
## 9         0.06507937            0.05714286           0.623809524    0.25396825
## 10        0.12576687            0.08071749           0.684575390    0.19317856
```

Finally, we can calculate summaries of the distances for immune cells in
the tumour structure.

```
immune_distances <- calculate_summary_distances_of_cells_to_borders(
  spe_object = formatted_structure,
  cell_types_of_interest = names_of_immune_cells, feature_colname = "Cell.Type")

immune_distances
```

```
##                    Cell.Type               Area    Min_d    Max_d    Mean_d
## 1 All_cell_types_of_interest Within_border_area 10.93225 192.4094  86.20042
## 2 All_cell_types_of_interest             Stroma 10.02387 984.0509 218.11106
## 3                    Immune1 Within_border_area       NA       NA        NA
## 4                    Immune1             Stroma 84.20018 970.7749 346.14096
## 5                    Immune2 Within_border_area       NA       NA        NA
## 6                    Immune2             Stroma 79.42753 984.0509 333.26374
## 7                    Immune3 Within_border_area 10.93225 192.4094  86.20042
## 8                    Immune3             Stroma 10.02387 971.5638 102.79227
##    Median_d  St.dev_d
## 1  88.23299  45.27414
## 2 133.18220 199.87586
## 3        NA        NA
## 4 301.01535 187.04247
## 5        NA        NA
## 6 284.09062 185.67518
## 7  88.23299  45.27414
## 8  68.19218 131.32714
```

Note that for cell types that are not present in a tumour structure,
there will be NAs in the results.

# 2 You can access the vignettes for other modules of SPIAT here:

* [Overview of SPIAT](SPIAT.html)
* [Data reading and formatting](data_reading-formatting.html)
* [Quality control and visualisation](quality-control_visualisation.html)
* [Basic analysis](basic_analysis.html)
* [Cell colocalisation](cell-colocalisation.html)
* [Spatial heterogeneity](spatial-heterogeneity.html)
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
##   [1] RColorBrewer_1.1-3     jsonlite_2.0.0         shape_1.4.6.1
##   [4] magrittr_2.0.4         spatstat.utils_3.2-1   magick_2.9.0
##   [7] farver_2.1.2           rmarkdown_2.30         GlobalOptions_0.1.3
##  [10] vctrs_0.7.1            Cairo_1.7-0            spatstat.explore_3.7-0
##  [13] elsa_1.1-28            terra_1.8-93           tinytex_0.58
##  [16] htmltools_0.5.9        S4Arrays_1.10.1        raster_3.6-32
##  [19] SparseArray_1.10.8     sass_0.4.10            pracma_2.4.6
##  [22] bslib_0.10.0           htmlwidgets_1.6.4      mmand_1.6.3
##  [25] plyr_1.8.9             plotly_4.12.0          cachem_1.1.0
##  [28] lifecycle_1.0.5        iterators_1.0.14       pkgconfig_2.0.3
##  [31] Matrix_1.7-4           R6_2.6.1               fastmap_1.2.0
##  [34] clue_0.3-66            digest_0.6.39          colorspace_2.1-2
##  [37] tensor_1.5.1           crosstalk_1.2.2        labeling_0.4.3
##  [40] spatstat.sparse_3.1-0  httr_1.4.7             polyclip_1.10-7
##  [43] abind_1.4-8            compiler_4.5.2         splancs_2.01-45
##  [46] bit64_4.6.0-1          withr_3.0.2            doParallel_1.0.17
##  [49] S7_0.2.1               apcluster_1.4.14       R.utils_2.13.0
##  [52] DelayedArray_0.36.0    rjson_0.2.23           gtools_3.9.5
##  [55] tools_4.5.2            otel_0.2.0             goftest_1.2-3
##  [58] R.oo_1.27.1            glue_1.8.0             dbscan_1.2.4
##  [61] nlme_3.1-168           grid_4.5.2             Rtsne_0.17
##  [64] cluster_2.1.8.1        reshape2_1.4.5         gtable_0.3.6
##  [67] spatstat.data_3.1-9    tzdb_0.5.0             R.methodsS3_1.8.2
##  [70] tidyr_1.3.2            data.table_1.18.2.1    sp_2.2-0
##  [73] XVector_0.50.0         spatstat.geom_3.7-0    ggrepel_0.9.6
##  [76] RANN_2.6.2             foreach_1.5.2          pillar_1.11.1
##  [79] stringr_1.6.0          vroom_1.7.0            circlize_0.4.17
##  [82] dplyr_1.2.0            lattice_0.22-7         bit_4.6.0
##  [85] deldir_2.0-4           tidyselect_1.2.1       ComplexHeatmap_2.26.1
##  [88] knitr_1.51             gridExtra_2.3          bookdown_0.46
##  [91] xfun_0.56              dittoSeq_1.22.0        pheatmap_1.0.13
##  [94] stringi_1.8.7          lazyeval_0.2.2         yaml_2.3.12
##  [97] evaluate_1.0.5         codetools_0.2-20       interp_1.1-6
## [100] sgeostat_1.0-27        tibble_3.3.1           BiocManager_1.30.27
## [103] cli_3.6.5              alphahull_2.5          jquerylib_0.1.4
## [106] dichromat_2.0-0.1      Rcpp_1.1.1             spatstat.random_3.4-4
## [109] png_0.1-8              spatstat.univar_3.1-6  parallel_4.5.2
## [112] ggplot2_4.0.2          viridisLite_0.4.2      scales_1.4.0
## [115] ggridges_0.5.7         purrr_1.2.1            crayon_1.5.3
## [118] GetoptLong_1.1.0       rlang_1.1.7            cowplot_1.2.0
```

# 4 Author Contributions

AT, YF, TY, ML, JZ, VO, MD are authors of the package code. MD and YF
wrote the vignette. AT, YF and TY designed the package.

Pateiro-Lopez, Beatriz, Alberto Rodriguez-Casal, and. 2019. *Alphahull: Generalization of the Convex Hull of a Sample of Points in the Plane*. [https://CRAN.R-project.org/package=alphahull](https://CRAN.R-project.org/package%3Dalphahull).