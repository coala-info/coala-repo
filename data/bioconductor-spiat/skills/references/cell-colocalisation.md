# Quantifying cell colocalisation with SPIAT

Yuzhou Feng

#### 2026-02-03

#### Package

SPIAT 1.12.1

```
library(SPIAT)
```

With SPIAT we can quantify cell colocalisation, which refers to how much
two cell types are colocalising and thus potentially interacting.

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

# 1 Cells In Neighbourhood (CIN)

We can calculate the average percentage of cells of one cell type
(target) within a radius of another cell type (reference) using
`average_percentage_of_cells_within_radius()`.

```
average_percentage_of_cells_within_radius(spe_object = formatted_image,
                                          reference_celltype = "Immune1",
                                          target_celltype = "Immune2",
                                          radius=100, feature_colname="Cell.Type")
```

```
## [1] 4.768123
```

Alternatively, this analysis can also be performed based on marker
intensities rather than cell types. Here, we use
`average_marker_intensity_within_radius()` to calculate the average
intensity of the target\_marker within a radius from the cells positive
for the reference marker. Note that it pools all cells with the target
marker that are within the specific radius of any reference cell.
Results represent the average intensities within a radius.

```
average_marker_intensity_within_radius(spe_object = formatted_image,
                                       reference_marker ="Immune_marker3",
                                       target_marker = "Immune_marker2",
                                       radius=30)
```

```
## [1] 0.5995357
```

To help identify suitable radii for
`average_percentage_of_cells_within_radius()` and
`average_marker_intensity_within_radius()` users can use
`plot_average_intensity()`. This function calculates the average intensity
of a target marker for a number of user-supplied radii values, and plots
the intensity level at each specified radius as a line graph. The radius
unit is microns.

```
plot_average_intensity(spe_object=formatted_image, reference_marker="Immune_marker3",
                       target_marker="Immune_marker2", radii=c(30, 35, 40, 45, 50, 75, 100))
```

![](data:image/png;base64...)

This plot shows low levels of Immune\_marker3 were observed in cells near
Immune\_marker2+ cells and these levels increased at larger radii. This
suggests Immune\_marker2+ and Immune\_marker3+ cells may not be closely
interacting and are actually repelled.

# 2 Mixing Score (MS) and Normalised Mixing Score (NMS)

This score was originally defined as the number of immune-tumour
interactions divided by the number of immune-immune interactions
(Keren et al. [2018](#ref-keren2018structured)). SPIAT generalises this method for any
user-defined pair of cell types. `mixing_score_summary()` returns the
mixing score between a reference cell type and a target cell type. This
mixing score is defined as the number of target-reference
interactions/number of reference-reference interactions within a
specified radius. The higher the score the greater the mixing of the two
cell types. The normalised score is normalised for the number of target
and reference cells in the image.

```
mixing_score_summary(spe_object = formatted_image, reference_celltype = "Immune1",
                     target_celltype = "Immune2", radius=100, feature_colname ="Cell.Type")
```

```
##   Reference  Target Number_of_reference_cells Number_of_target_cells
## 2   Immune1 Immune2                       338                    178
##   Reference_target_interaction Reference_reference_interaction Mixing_score
## 2                          583                             592    0.9847973
##   Normalised_mixing_score
## 2               0.9322379
```

# 3 Cross K function

Cross K function calculates the number of target cell types across a
range of radii from a reference cell type, and compares the behaviour of
the input image with an image of randomly distributed points using a
Poisson point process. There are four patterns that can be distinguished
from K-cross function, as illustrated in the plots below. (taken from
[here](https://blog.jlevente.com/understanding-the-cross-k-function/) in
April 2021).

![](data:image/jpeg;base64...)

Here, the black line represents the input image, the red line represents
a randomly distributed point pattern.

* 1st plot: The red line and black line are close to each other,
  meaning the two types of points are randomly independently
  distributed.
* 2nd plot: The red line is under the black line, with a large
  difference in the middle of the plot, meaning the points are mixed
  and split into clusters.
* 3rd plot: With the increase of radius, the black line diverges
  further from the red line, meaning that there is one mixed cluster
  of two types of points.
* 4th plot: The red line is above the black line, meaning that the two
  types of points form separated clusters.

We can calculate the cross K-function using SPIAT. Here, we need to
define which are the cell types of interest. In this example, we are
using Tumour cells as the reference population, and Immune3 cells as the
target population.

```
df_cross <- calculate_cross_functions(formatted_image, method = "Kcross",
                                      cell_types_of_interest = c("Tumour","Immune2"),
                                      feature_colname ="Cell.Type",
                                      dist = 100)
```

![](data:image/png;base64...)

The results shows similar pattern as the 4th plot in the cross K
diagram. This means “Tumour” cells and “Immune2” cells are not
colocalised (or form separate clusters).

We can calculate the area under the curve (AUC) of the cross K-function.
In general, this tells us the two types of cells are:

* negative values: separate clusters
* positive values: mixing of cell types

```
AUC_of_cross_function(df_cross)
```

```
## [1] -0.2836735
```

The AUC score is close to zero so this tells us that the two types of
cells either do not have a relationship or they form a ring surrounding
a cluster.

# 4 Cross-K Intersection (CKI)

There is another pattern in cross K curve which has not been previously
appreciated, which is when there is a “ring” of one cell type, generally
immune cells, surrounding the area of another cell type, generally
tumour cells. For this pattern, the observed and expected curves in
cross K function cross or intersect, such as the cross K plot above.

We note that crossing is not exclusively present in cases where there is
an immune ring. When separate clusters of two cell types are close,
there can be a crossing at a small radius. In images with infiltration,
crossing may also happen at an extremely low distances due to
randomness. To use the CKI to detect a ring pattern, users need to
determine a threshold for when there is a true immune ring. Based on
our tests, these generally fall within at a quarter to half of the
image size, but users are encouraged to experiment with their datasets.

Here we use the colocalisation of “Tumour” and “Immune3” cells as an
example. Let’s revisit the example image.

![](data:image/png;base64...)

Compute the cross K function between “Tumour” and “Immune3”:

```
df_cross <- calculate_cross_functions(formatted_image, method = "Kcross",
                                      cell_types_of_interest = c("Tumour","Immune3"),
                                      feature_colname ="Cell.Type",
                                      dist = 100)
```

![](data:image/png;base64...)

Then find the intersection of the observed and expected cross K curves.

```
crossing_of_crossK(df_cross)
```

```
## [1] "Crossing of cross K function is detected for this image, indicating a potential immune ring."
## [1] "The crossing happens at the 50% of the specified distance."
```

```
## [1] 0.5
```

The result shows that the crossing happens at 50% of the specified
distance (100) of the cross K function, which is very close to the edge
of the tumour cluster. This means that the crossing is not due to the
randomness in cell distribution, nor due to two close located immune and
tumour clusters. This result aligns with the observation that there is
an immune ring surrounding the tumour cluster.

# 5 You can access the vignettes for other modules of SPIAT here:

* [Overview of SPIAT](SPIAT.html)
* [Data reading and formatting](data_reading-formatting.html)
* [Quality control and visualisation](quality-control_visualisation.html)
* [Basic analysis](basic_analysis.html)
* [Spatial heterogeneity](spatial-heterogeneity.html)
* [Tissue structure](tissue-structure.html)
* [Cellular neighborhood](neighborhood.html)

# 6 Reproducibility

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
##  [1] tidyselect_1.2.1       viridisLite_0.4.2      dplyr_1.2.0
##  [4] farver_2.1.2           S7_0.2.1               fastmap_1.2.0
##  [7] pracma_2.4.6           spatstat.geom_3.7-0    spatstat.explore_3.7-0
## [10] RANN_2.6.2             digest_0.6.39          lifecycle_1.0.5
## [13] spatstat.data_3.1-9    dbscan_1.2.4           magrittr_2.0.4
## [16] compiler_4.5.2         rlang_1.1.7            sass_0.4.10
## [19] tools_4.5.2            yaml_2.3.12            knitr_1.51
## [22] S4Arrays_1.10.1        labeling_0.4.3         DelayedArray_0.36.0
## [25] plyr_1.8.9             RColorBrewer_1.1-3     abind_1.4-8
## [28] withr_3.0.2            grid_4.5.2             polyclip_1.10-7
## [31] ggplot2_4.0.2          gtools_3.9.5           scales_1.4.0
## [34] spatstat.utils_3.2-1   dichromat_2.0-0.1      tinytex_0.58
## [37] cli_3.6.5              rmarkdown_2.30         otel_0.2.0
## [40] reshape2_1.4.5         rjson_0.2.23           cachem_1.1.0
## [43] stringr_1.6.0          BiocManager_1.30.27    XVector_0.50.0
## [46] vctrs_0.7.1            Matrix_1.7-4           jsonlite_2.0.0
## [49] bookdown_0.46          tensor_1.5.1           magick_2.9.0
## [52] spatstat.univar_3.1-6  jquerylib_0.1.4        goftest_1.2-3
## [55] glue_1.8.0             spatstat.random_3.4-4  stringi_1.8.7
## [58] gtable_0.3.6           deldir_2.0-4           tibble_3.3.1
## [61] pillar_1.11.1          htmltools_0.5.9        R6_2.6.1
## [64] evaluate_1.0.5         lattice_0.22-7         apcluster_1.4.14
## [67] bslib_0.10.0           Rcpp_1.1.1             gridExtra_2.3
## [70] SparseArray_1.10.8     nlme_3.1-168           spatstat.sparse_3.1-0
## [73] xfun_0.56              pkgconfig_2.0.3
```

# 7 Author Contributions

AT, YF, TY, ML, JZ, VO, MD are authors of the package code. MD and YF
wrote the vignette. AT, YF and TY designed the package.

Keren, Leeat, Marc Bosse, Diana Marquez, Roshan Angoshtari, Samir Jain, Sushama Varma, Soo-Ryum Yang, et al. 2018. “A Structured Tumor-Immune Microenvironment in Triple Negative Breast Cancer Revealed by Multiplexed Ion Beam Imaging.” *Cell* 174 (6): 1373–87.